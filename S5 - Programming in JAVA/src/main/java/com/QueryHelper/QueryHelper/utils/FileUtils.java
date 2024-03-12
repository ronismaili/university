package com.QueryHelper.QueryHelper.utils;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.util.FileCopyUtils;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

public class FileUtils {

    public static String readDDLFromFile(String fileName) {
        try {
            Resource resource = new ClassPathResource("static/" + fileName);
            byte[] data = FileCopyUtils.copyToByteArray(resource.getInputStream());
            return new String(data, "UTF-8");
        } catch (Exception e) {
            throw new RuntimeException("Error reading SQL file: " + fileName, e);
        }
    }

    public static String readJsonFile() {
        try (InputStream inputStream = FileUtils.class.getClassLoader().getResourceAsStream("static/output_format.json");
             InputStreamReader reader = new InputStreamReader(inputStream, StandardCharsets.UTF_8)) {
            return new BufferedReader(reader).lines().collect(Collectors.joining("\n"));
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

}
