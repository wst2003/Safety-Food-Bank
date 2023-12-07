package cn.tju.sse.spring_backend.service.pub;

import cn.tju.sse.spring_backend.dto.pub.UploadChatImageResponseDTO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Objects;

import static cn.tju.sse.spring_backend.repository.obs.ObsOperationTool.uploadInputStream;

@Service
public class UploadChatImageService {

    /**
     * 上传聊天图片
     * @Param image 上传的文件
     * @return UploadChatImageResponseDTO 响应对象
     */
    public UploadChatImageResponseDTO uploadChatImage(MultipartFile image){
        UploadChatImageResponseDTO uploadChatImageResponseDTO=new UploadChatImageResponseDTO();
        if(image==null||image.isEmpty()||image.getSize()==0){
            uploadChatImageResponseDTO.setMessage("请选择要上传的图片");
            return uploadChatImageResponseDTO;
        }


//        判断一下拓展名
        String extension=image.getOriginalFilename().split("\\.")[1];
        System.out.println("file extension is "+extension);
        if(!Objects.equals(extension, "jpg")&&!Objects.equals(extension, "png")&&!Objects.equals(extension, "gif")&&!Objects.equals(extension, "JPG")&&!Objects.equals(extension, "PNG")&&!Objects.equals(extension, "GIF")){
            uploadChatImageResponseDTO.setMessage("图片格式不正确");
            return uploadChatImageResponseDTO;
        }

        try{
            boolean success=uploadInputStream("chat_image",image.getOriginalFilename(),image.getInputStream());
            if(success){
                uploadChatImageResponseDTO.setMessage("上传成功");
                uploadChatImageResponseDTO.setUrl("https://food-bank.obs.cn-east-3.myhuaweicloud.com\\chat_image\\"+image.getOriginalFilename());
                return uploadChatImageResponseDTO;
            }else{
                uploadChatImageResponseDTO.setMessage("上传失败");
                return uploadChatImageResponseDTO;
            }
        } catch (Exception e) {
            System.out.println(e);
            uploadChatImageResponseDTO.setMessage("上传失败");
            return uploadChatImageResponseDTO;
        }

    }
}
