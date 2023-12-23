package cn.tju.sse.spring_backend.utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * @author lhx
 * @date 2023/12/22
 * @Description 本地文件操作类
 */
public class StorageFileReader {

    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 传入本地文件路径，读取文件
     * 用于读取推荐文件与地理位置排序文件
     */
    public static List<Integer> getStorage(String filepath) {
        List<Integer> list = new ArrayList<>();
//        String folderPath = ".\\locationSort";
//        String filePath = folderPath + File.separator + cus_id + ".txt";
//        System.out.println("The filePath: " + filePath);

        File directory = new File(filepath);
        if (directory.exists()) {
            try {
                List<String> readList = Files.readAllLines(Paths.get(filepath));
                for (String item : readList) {
                    try {
                        int number = Integer.parseInt(item);

                        list.add(number);
                    } catch (NumberFormatException e) {
                        System.out.println("Conversion failed");
                    }
                }
            } catch (IOException e) {
                System.out.println("Error reading the file: " + e.getMessage());
            }
        } else {
            System.out.println("Directory does not exist");
        }
        System.out.println("读取"+filepath+"成功");
        return list;
    }
}
