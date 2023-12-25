package cn.tju.sse.spring_backend.controller.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyResponseDTO;
import cn.tju.sse.spring_backend.service.pub.modify.StoreModifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * @ClassName StoreModifyController
 * @Author RaoJi
 * @Description 控制类，修改商家基本信息
 */
@RestController
@RequestMapping("/api/pub/modify")
public class StoreModifyController {

    @Autowired
    StoreModifyService service;

    /**
     * @param sto_ID - 待修改商家的id
     * @param sto_introduction - 待修改商家的简介
     * @param sto_name - 待修改的商家名称
     * @param categories - 待修改的商家的经营类别
     * @param sto_licenseImg - 待上传的商家的营业执照
     * @param sto_picture - 待上传的商家的图片
     * @return 是否修改成功
     * @see StoreModifyResponseDTO
     */
    @PostMapping(value = "/store", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<StoreModifyResponseDTO> storeModify(
            @RequestParam("sto_ID") String sto_ID,
            @RequestParam("sto_introduction") String sto_introduction,
            @RequestParam("sto_name") String sto_name,
            @RequestParam("categories") String[] categories,
            @RequestParam("sto_licenseImg") MultipartFile sto_licenseImg,
            @RequestParam("sto_picture") MultipartFile[] sto_picture) {
        StoreModifyRequestDTO request = new StoreModifyRequestDTO();
        request.setCategories(categories);
        request.setSto_ID(sto_ID);
        request.setSto_name(sto_name);
        request.setSto_introduction(sto_introduction);
        request.setStoLicenseImg(sto_licenseImg);
        request.setStoPicture(sto_picture);

        System.out.println(request.getStoLicenseImg().getSize());
        System.out.println(request.getStoPicture().length);
        StoreModifyResponseDTO response = service.storeModify(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
