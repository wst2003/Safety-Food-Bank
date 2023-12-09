package cn.tju.sse.spring_backend.controller.sto.update;

import cn.tju.sse.spring_backend.dto.sto.update.CommodityImageUpdateRequestDTO;
import cn.tju.sse.spring_backend.dto.sto.update.CommodityUpdateRequestDTO;
import cn.tju.sse.spring_backend.dto.sto.update.CommodityUpdateResponseDTO;
import cn.tju.sse.spring_backend.service.sto.update.CommodityUpdateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import shade.kotlin.ReplaceWith;

import java.io.IOException;

/**
 * 更新商品
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/09 14:53
 */
@RestController
@RequestMapping("/api/sto/updatecommodity")
public class CommodityUpdateController {
    @Autowired
    private CommodityUpdateService commodityUpdateService;

    @RequestMapping(value = "/basic",method = RequestMethod.GET)
    public ResponseEntity<CommodityUpdateResponseDTO> getFormData(@RequestParam("COM_ID") int COM_ID){
        CommodityUpdateResponseDTO response = commodityUpdateService.getFormData(COM_ID);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @RequestMapping(value = "/updatebasic",method = RequestMethod.POST)
    public ResponseEntity<String> updateBasicData(@RequestParam("COM_ID") int COM_ID, @RequestBody CommodityUpdateRequestDTO request){
        String response = commodityUpdateService.updateBasicData(COM_ID,request);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    @RequestMapping(value = "/updateimg",method = RequestMethod.POST)
    public ResponseEntity<String> postUpdateImage(@ModelAttribute CommodityImageUpdateRequestDTO request) throws IOException {
        String response = commodityUpdateService.postUpdateImage(request);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    @RequestMapping(value = "/delimg",method = RequestMethod.POST)
    public ResponseEntity<String> postDeleteImage(@RequestParam("COM_ID") int COM_ID, @RequestParam("COM_IMAGE") String COM_IMAGE){
        String response = commodityUpdateService.postDeleteImage(COM_ID,COM_IMAGE);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    @RequestMapping(value = "/delcommodity",method = RequestMethod.POST)
    public ResponseEntity<String> postDeleteCommodity(@RequestParam("COM_ID") int COM_ID){
        String response = commodityUpdateService.postDeleteCommodity(COM_ID);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }
}
