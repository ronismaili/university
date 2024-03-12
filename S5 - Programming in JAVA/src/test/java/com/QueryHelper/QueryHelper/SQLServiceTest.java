package com.QueryHelper.QueryHelper;

import com.QueryHelper.QueryHelper.service.SQLService;
import com.QueryHelper.QueryHelper.utils.RowMapperUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@SpringBootTest
class SQLServiceTest {

    @Mock
    private JdbcTemplate jdbcTemplate;

    @InjectMocks
    private SQLService sqlService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testQueryDatabase_Success() {
        List<Map<String, Object>> expectedResult = new ArrayList<>();
        Map<String, Object> row = new HashMap<>();
        row.put("id", 1);
        row.put("name", "John");
        expectedResult.add(row);
        when(jdbcTemplate.query(any(String.class), any(RowMapperUtils.class))).thenReturn(expectedResult);

        String query = "SELECT * FROM users";
        List<Map<String, Object>> result = sqlService.queryDatabase(query);

        assertEquals(expectedResult, result);
    }

    @Test
    public void testQueryDatabase_Failure() {
        when(jdbcTemplate.query(any(String.class), any(RowMapperUtils.class))).thenThrow(new RuntimeException());
        String invalidQuery = "INVALID QUERY";
        try {
            sqlService.queryDatabase(invalidQuery);
            fail("Expected RuntimeException was not thrown");
        } catch (RuntimeException e) {
            assertNotNull(e);
        }
    }
}

