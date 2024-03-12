package com.QueryHelper.QueryHelper.controller;

import com.QueryHelper.QueryHelper.pojo.dto.GenericResponse;
import com.QueryHelper.QueryHelper.pojo.dto.QueryRequest;
import com.QueryHelper.QueryHelper.service.AIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AIController {

    @Autowired
    private AIService aiService;

    @PostMapping("/query")
    public GenericResponse GenerateQuery(@RequestBody QueryRequest queryRequest) {
        return aiService.generateQuery(queryRequest);
    }

}
