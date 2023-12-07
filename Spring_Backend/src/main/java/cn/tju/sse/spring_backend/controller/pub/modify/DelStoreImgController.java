package cn.tju.sse.spring_backend.controller.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.DelStoreImgRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.DelStoreImgResponseDTO;
import cn.tju.sse.spring_backend.service.pub.modify.DelStoreImgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pub/modify")
public class DelStoreImgController {
    @Autowired
    private DelStoreImgService delStoreImgService;

    @PostMapping("/delstoreimg")
    public DelStoreImgResponseDTO delStoreImg(@RequestBody DelStoreImgRequestDTO delStoreImgRequestDTO){
        DelStoreImgResponseDTO delStoreImgResponseDTO=delStoreImgService.delStoreImg(delStoreImgRequestDTO);
        return delStoreImgResponseDTO;

    }
}
