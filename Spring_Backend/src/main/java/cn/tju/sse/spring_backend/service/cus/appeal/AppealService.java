package cn.tju.sse.spring_backend.service.cus.appeal;

import cn.tju.sse.spring_backend.dto.cus.appeal.CreateAppealRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.appeal.MsgResponseDTO;
import cn.tju.sse.spring_backend.model.AppealEntity;
import cn.tju.sse.spring_backend.model.ScreenshotEntity;
import cn.tju.sse.spring_backend.repository.SeqNextvalRepository;
import cn.tju.sse.spring_backend.repository.cus.appeal.AppealRespository;
import cn.tju.sse.spring_backend.repository.cus.appeal.ScreenshotRepository;
import cn.tju.sse.spring_backend.repository.obs.ObsOperationTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.sql.Date;
import java.util.Base64;
import java.util.List;

@Service
public class AppealService {
    @Autowired
    SeqNextvalRepository seqNextvalRepository;

    @Autowired
    AppealRespository appealRespository;

    @Autowired
    ScreenshotRepository screenshotRepository;
    /**
     * @author lhx
     * @date 2023/12/23
     * @Description 创建申诉
     */

    @Transactional
    public MsgResponseDTO createAppeal(CreateAppealRequestDTO request) {
        MsgResponseDTO msgResponseDTO=new MsgResponseDTO();
        AppealEntity appealEntity=new AppealEntity();
        appealEntity.setAppMatters(request.getApp_matters());
        appealEntity.setAppContent(request.getApp_content());
        appealEntity.setAppUserid(request.getApp_userID());
        appealEntity.setComId(request.getCom_ID()==-1?null:request.getCom_ID());
        appealEntity.setCmtId(request.getCmt_ID()==-1?null:request.getCmt_ID());
        appealEntity.setUserId(request.getUser_ID()==-1?null:request.getUser_ID());
        long millis = System.currentTimeMillis();
        Date currentDate = new Date(millis);
        appealEntity.setAppTime(currentDate);
        Integer appeal_id= seqNextvalRepository.callSEQ_NEXTVAL("APPEAL_ID_SEQ");

        appealEntity.setAppId(appeal_id);
        appealEntity=appealRespository.save(appealEntity);
        if(appealEntity==null){
            throw new RuntimeException();
        }

        List<String> imgs=request.getSct_images();
        Integer imageCounter=0;
        for(String img:imgs){
            try {
                // 解码 Base64 字符串
                byte[] imageBytes = Base64.getDecoder().decode(img.split(",")[1]);
                String directoryPath = "appeal_image";
                if(!ObsOperationTool.isObjectPathExist(directoryPath)){
                    ObsOperationTool.createFolder("",directoryPath);
                }
                String appeal_id_path= String.valueOf(appeal_id);
                if(!ObsOperationTool.isObjectPathExist(directoryPath+"/"+appeal_id_path)){
                    ObsOperationTool.createFolder(directoryPath,appeal_id_path);
                }
                // 设置文件名
                String fileName = "appeal_image" + imageCounter + ".jpg";

                File tempFile = File.createTempFile("appeal_image" + imageCounter,".jpg");
                try (OutputStream outputStream = new FileOutputStream(tempFile)) {
                    // 将文本内容写入临时文件
                    outputStream.write(imageBytes);
                    System.out.println("Img file has been created and written to temporary location");
                } catch (IOException e) {
                    e.printStackTrace();
                }
                if(ObsOperationTool.isObjectPathExist(directoryPath+"/"+appeal_id_path+"/"+fileName)){
                    ObsOperationTool.deleteObject(directoryPath+"/"+appeal_id_path,fileName,false);
                }
                boolean ifSuccess1=ObsOperationTool.uploadInputStream(directoryPath+"/"+appeal_id_path,fileName,new FileInputStream(tempFile));
                if(!ifSuccess1){
                    msgResponseDTO.setMsg("文件存储出现错误");
                    System.out.println(msgResponseDTO.getMsg());
                    return msgResponseDTO;
                }

                System.out.println("Saved image: " + fileName);

                ScreenshotEntity screenshotEntity=new ScreenshotEntity();
                screenshotEntity.setAppId(appeal_id);
                screenshotEntity.setSctImage(directoryPath+"/"+appeal_id_path+"/"+fileName);
                screenshotEntity=screenshotRepository.save(screenshotEntity);
                if(screenshotEntity==null){
                    throw new RuntimeException();
                }
                imageCounter++;
            } catch (Exception e) {
                System.out.println("Error saving image: " + e.getMessage());
            }
        }

        msgResponseDTO.setMsg("成功创建");
        return msgResponseDTO;

    }
}
