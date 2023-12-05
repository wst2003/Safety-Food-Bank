package cn.tju.sse.spring_backend.controller.sto.upload;

import cn.tju.sse.spring_backend.dto.sto.upload.CommodityDeleteTmpImageRequestDTO;
import cn.tju.sse.spring_backend.dto.sto.upload.CommodityImageUploadRequestDTO;
import cn.tju.sse.spring_backend.dto.sto.upload.CommodityUploadRequestDTO;
import cn.tju.sse.spring_backend.service.sto.upload.CommodityUploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

/**
 * 上传商品
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/02 15:14
 */
@RestController
@RequestMapping("/api/sto/uploadcommodity")
public class CommodityUploadController {
    @Autowired
    private CommodityUploadService commodityUploadService;

    /**
     * 获得 IMAGE_KEY
     * @return 一个字符串表示 IMAGE_KEY
     */
    @RequestMapping(value = "/imagekey",method = RequestMethod.GET)
    public ResponseEntity<String> getImageKey(){
        String response = commodityUploadService.getImageKey();
        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    /**
     *
     * @param request 一个 CommodityImageUploadRequestDTO 类，表示 api 传入的参数
     * @return 一个字符串表示图片在后端保存的名字
     * @throws IOException
     */
    @RequestMapping(value = "/imgs",method = RequestMethod.POST)
    public ResponseEntity<String> postImage(@ModelAttribute CommodityImageUploadRequestDTO request) throws IOException {
        String response = commodityUploadService.postImage(request);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    /**
     *
     * @param request 一个 CommodityDeleteTmpImageRequestDTO 类，表示 api 传入的参数
     * @return
     */
    @RequestMapping(value = "/deltmpimg",method = RequestMethod.POST)
    public ResponseEntity<String> deleteTmpImage(@RequestBody CommodityDeleteTmpImageRequestDTO request){
        String response = commodityUploadService.deleteTmpImage(request);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    @RequestMapping(value = "/basic",method = RequestMethod.POST)
    public ResponseEntity<Integer> postBasicData(@RequestBody CommodityUploadRequestDTO request) {
        int response = commodityUploadService.postBasicData(request).getCom_id();
        return new ResponseEntity<>(response,HttpStatus.OK);
    }
}

