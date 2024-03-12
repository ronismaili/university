package com.QueryHelper.QueryHelper;

import com.QueryHelper.QueryHelper.pojo.dto.QueryRequest;
import com.QueryHelper.QueryHelper.service.AIService;
import com.QueryHelper.QueryHelper.service.SQLService;
import com.QueryHelper.QueryHelper.utils.ErrorUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Collections;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.when;

class AIServiceTest {

    @Mock
    private SQLService sqlService;

    @InjectMocks
    private AIService aiService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGenerateQueryFileError() {
        QueryRequest queryRequest = new QueryRequest();
        doThrow(new RuntimeException("File not found")).when(sqlService).queryDatabase(any());
        var result = aiService.generateQuery(queryRequest);
        assertEquals(ErrorUtils.fileError(new RuntimeException("File not found")), result);
    }

    @Test
    void testGenerateQueryOpenAIError() {
        QueryRequest queryRequest = new QueryRequest();
        when(sqlService.queryDatabase(any())).thenReturn(Collections.emptyList());
        doThrow(new RuntimeException("OpenAI error")).when(sqlService).queryDatabase(any());
        var result = aiService.generateQuery(queryRequest);
        assertEquals(ErrorUtils.openAIError(new RuntimeException("OpenAI error")), result);
    }

    @Test
    void testGenerateQueryInvalidResponseError() {
        QueryRequest queryRequest = new QueryRequest();
        when(sqlService.queryDatabase(any())).thenReturn(Collections.emptyList());
        doThrow(new RuntimeException("Invalid response error")).when(sqlService).queryDatabase(any());
        var result = aiService.generateQuery(queryRequest);
        assertEquals(ErrorUtils.invalidResponseError(new RuntimeException("Invalid response error")), result);
    }

    @Test
    void testGenerateQueryInvalidSQLError() {
        QueryRequest queryRequest = new QueryRequest();
        when(sqlService.queryDatabase(any())).thenReturn(Collections.emptyList());
        doThrow(new RuntimeException("Invalid SQL error")).when(sqlService).queryDatabase(any());
        var result = aiService.generateQuery(queryRequest);
        assertEquals(ErrorUtils.invalidSQLError(new RuntimeException("Invalid SQL error")), result);
    }

}
