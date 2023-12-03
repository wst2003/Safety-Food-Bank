package cn.tju.sse.spring_backend.controller.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity.CommodityDetailResponseDTO;
import cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity.CommodityDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * 处理商品详细信息请求的控制器类
 */
@RestController
@RequestMapping("/api/sto/StoreQueryCommodity")
public class StoreQueryCommodityController {
    @Autowired
    private CommodityDetailService commodityDetailService;

    /**
     * 获取指定商品ID的商品详细信息。
     *
     * @param com_id  商品ID。
     * @return        包含商品详细信息的响应实体。
     */
    @GetMapping("/detail")
    public ResponseEntity<CommodityDetailResponseDTO> getCommodityDetail(@RequestParam int com_id) {
        CommodityDetailResponseDTO response = commodityDetailService.getCommodityDetail(com_id);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
