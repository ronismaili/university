package com.QueryHelper.QueryHelper.service;

import com.QueryHelper.QueryHelper.utils.RowMapperUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class SQLService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> queryDatabase(String query) {
        return jdbcTemplate.query(query, new RowMapperUtils());
    }

}
