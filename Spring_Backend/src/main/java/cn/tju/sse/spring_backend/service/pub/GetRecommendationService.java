package cn.tju.sse.spring_backend.service.pub;

import cn.tju.sse.spring_backend.dto.pub.GetMessageResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.UserIDRequestDTO;
import cn.tju.sse.spring_backend.repository.obs.ObsOperationTool;
import cn.tju.sse.spring_backend.utils.ItemCFRecommendation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.file.Files;
import java.util.List;

@Service
public class GetRecommendationService {
    @Autowired
    private ItemCFRecommendation itemCFRecommendation ;
    public GetMessageResponseDTO getRecommendation(UserIDRequestDTO request) throws IOException {
        String userID=request.getUser_id();
        GetMessageResponseDTO response=new GetMessageResponseDTO();
        long startTime = System.currentTimeMillis();

        List<Integer> items=itemCFRecommendation.RecommendItems(Integer.parseInt(userID));
        String directoryPath = "ItemCF";
        File directory = new File(directoryPath);
        if (!directory.exists()) {
            directory.mkdirs(); // 如果目录不存在，则创建
        }
//        if(!ObsOperationTool.isObjectPathExist(directoryPath)){
//            ObsOperationTool.createFolder("",directoryPath);
//        }
        String fileName="recommendation"+userID+".txt";
        File localFile = new File(directory, fileName);
//        File tempFile = File.createTempFile("recommendation"+userID,".txt");
        try (OutputStream outputStream = new FileOutputStream(localFile)) {

            // 将文本内容写入临时文件
            for(int item:items) {
                byte[] bytes = Integer.toString(item).getBytes();
                outputStream.write(bytes);
                outputStream.write('\n');
            }

            System.out.println("用户推荐文件已保存在本地");
        } catch (IOException e) {
            e.printStackTrace();
        }
//        try (OutputStream outputStream = new FileOutputStream(tempFile)) {
//            // 将文本内容写入临时文件
//            for(int item:items) {
//                byte[] bytes = Integer.toString(item).getBytes();
//                outputStream.write(bytes);
//                outputStream.write('\n');
//            }
//            System.out.println("Text file has been created and written to temporary location: ");
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        if(ObsOperationTool.isObjectPathExist(directoryPath+"/"+fileName)){
//            ObsOperationTool.deleteObject(directoryPath,fileName,false);
//        }
//        boolean ifSuccess1=ObsOperationTool.uploadInputStream(directoryPath,fileName,new FileInputStream(tempFile));
//        if(!ifSuccess1){
//            response.setMessage("文件存储出现错误");
//            System.out.println(response.getMessage());
//            return response;
//        }



        long endTime = System.currentTimeMillis();
        long elapsedTime = endTime - startTime;
        System.out.println("函数执行时间： "+elapsedTime);
        response.setMessage("success");
        return response;
    }
}
