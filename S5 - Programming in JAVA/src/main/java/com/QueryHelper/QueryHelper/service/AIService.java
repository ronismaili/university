package com.QueryHelper.QueryHelper.service;

import com.QueryHelper.QueryHelper.pojo.dto.QueryDataResponse;
import com.QueryHelper.QueryHelper.pojo.dto.GenericResponse;
import com.QueryHelper.QueryHelper.pojo.dto.QueryRequest;
import com.QueryHelper.QueryHelper.utils.ErrorUtils;
import com.QueryHelper.QueryHelper.utils.PromptUtils;
import dev.langchain4j.model.openai.OpenAiChatModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.google.gson.Gson;

@Service
public class AIService {

    @Autowired
    private SQLService sqlService;

    @Value("${OpenAI.key}")
    private String apiKey;
    @Value("${databaseDDL}")
    private String databaseDDL;
    @Value("${databaseSchema}")
    private String schema;

    public GenericResponse generateQuery(QueryRequest queryRequest) {

        Gson gson = new Gson();
        GenericResponse response = new GenericResponse();
        QueryDataResponse data = new QueryDataResponse();

        long startTime;
        long endTime;
        double elapsedTime;
        String query;
        String aiOutputStr;
        String prompt;

        OpenAiChatModel.OpenAiChatModelBuilder model = OpenAiChatModel
                .builder()
                .temperature(0.1)
                .apiKey(apiKey);

        try { // Check if the file with given name exists
            prompt = PromptUtils.queryPrompt(queryRequest, databaseDDL);
        } catch (Exception e) {
            return ErrorUtils.fileError(e);
        }

        try {  // Check if we have a properly set API key & that openAI services aren't down
            startTime = System.currentTimeMillis();
            aiOutputStr = model.build().generate(prompt);
            endTime = System.currentTimeMillis();
            elapsedTime = (endTime - startTime) / 1000.0;
        } catch (Exception e) {
            return ErrorUtils.openAIError(e);
        }

        try { // Check if the AI response can be converted to String
            QueryRequest aiOutputObj = gson.fromJson(aiOutputStr, QueryRequest.class);
            query = aiOutputObj.getQuery();
        } catch (Exception e) {
            return ErrorUtils.invalidResponseError(e);
        }

        try { // Check if the generated query can be executed in the database
            data.setRecords(sqlService.queryDatabase(query));
            data.setQuery(query);
            data.setSchema(schema);
            data.setResponseTime(elapsedTime);
        } catch (Exception e) {
            return ErrorUtils.invalidSQLError(e);
        }

        response.setData(data);
        response.setMessage("Query and records were retrieved successfully!");
        response.setStatusCode(200);
        return response;
    }

}