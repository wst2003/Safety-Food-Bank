package cn.tju.sse.spring_backend.controller.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyRequest;
import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyResponse;
import cn.tju.sse.spring_backend.service.pub.modify.StoreModifyService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@RestController
@RequestMapping("/api/pub/modify")
public class StoreModifyController {

    @Autowired
    StoreModifyService service;

    @PostMapping(value = "/store", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<StoreModifyResponse> storeModify(
            @RequestParam("sto_ID") String sto_ID,
            @RequestParam("sto_introduction") String sto_introduction,
            @RequestParam("sto_name") String sto_name,
            @RequestParam("categories") String[] categories,
            @RequestParam("sto_licenseImg") MultipartFile sto_licenseImg,
            @RequestParam("sto_picture") MultipartFile sto_picture) {
        StoreModifyRequest request = new StoreModifyRequest();
        request.setCategories(categories);
        request.setSto_ID(sto_ID);
        request.setSto_name(sto_name);
        request.setSto_introduction(sto_introduction);
        request.setStoLicenseImg(sto_licenseImg);
        request.setStoPicture(sto_picture);

        System.out.println(request.getStoLicenseImg().getSize());
        System.out.println(request.getStoPicture().getSize());
        StoreModifyResponse response = service.storeModify(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
