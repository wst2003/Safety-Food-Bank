package cn.tju.sse.spring_backend.utils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ContentFilter {

    static String filterPath="敏感词.txt";
    public static String contentFilter(String content) throws IOException {
        List<String> sensitiveWords = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("敏感词.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                sensitiveWords.add(line.trim());
            }
        }
        for (String word : sensitiveWords) {
            if (word.isEmpty()) continue;
            String replacement = "*".repeat(word.length());
            content = content.replace(word, replacement);
        }
        System.out.println("过滤后的评论内容"+content);
        return content;

    }
}
