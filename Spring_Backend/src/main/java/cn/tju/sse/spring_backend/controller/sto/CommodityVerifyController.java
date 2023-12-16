package cn.tju.sse.spring_backend.controller.sto;

import cn.tju.sse.spring_backend.dto.sto.CommodityVerifyResponseDTO;
import cn.tju.sse.spring_backend.service.sto.CommodityVerifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 订单核销控制器类
 */
@RestController
@RequestMapping("/api/sto/verficate")
public class CommodityVerifyController {
    @Autowired
    private CommodityVerifyService commodityVerifyService;

    /**
     * 核销订单
     *
     * @param IND_VERFICATIONCODE 订单核销码
     * @return ResponseEntity<?> 响应实体，包含核销后的订单信息或核销失败的提示
     */
    @PostMapping("")
    public ResponseEntity<?> verifyIndent(@RequestParam String IND_VERFICATIONCODE) {
        CommodityVerifyResponseDTO response = commodityVerifyService.getIndentToVerify(IND_VERFICATIONCODE);
        boolean success = commodityVerifyService.verifyIndent(IND_VERFICATIONCODE);
        if (success)
            return new ResponseEntity<>(response, HttpStatus.OK);
        else
            return new ResponseEntity<>("核销失败", HttpStatus.OK);
    }
}
