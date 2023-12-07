package cn.tju.sse.spring_backend.controller.pub;

import cn.tju.sse.spring_backend.dto.pub.UploadChatImageResponseDTO;
import cn.tju.sse.spring_backend.service.pub.UploadChatImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/pub/uploadchatimage")
public class UploadChatImageController {

    @Autowired
    UploadChatImageService uploadChatImageService;

    @PostMapping()
    public ResponseEntity<?> uploadchatimage(@RequestBody MultipartFile image){
        UploadChatImageResponseDTO uploadChatImageResponseDTO= uploadChatImageService.uploadChatImage(image);
        return new ResponseEntity<>(uploadChatImageResponseDTO, HttpStatus.OK);
    }

}
