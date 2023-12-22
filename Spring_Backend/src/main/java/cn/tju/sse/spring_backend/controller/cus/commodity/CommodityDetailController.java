package cn.tju.sse.spring_backend.controller.cus.commodity;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetDetailResponseDTO;
import cn.tju.sse.spring_backend.service.cus.commodity.CommodityGetDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/api/cus/commodity")
public class CommodityDetailController {

    @Autowired
    private CommodityGetDetailService commodityGetDetailService;

    @GetMapping("/detail")
    public ResponseEntity<?> getCommodityDetail(@Param("com_id") int com_id,@Param("cus_id") int cus_id){
        CommodityGetDetailResponseDTO response= commodityGetDetailService.getCommodityDetail(com_id,cus_id);
        return ResponseEntity.ok().body(response);
    }

}
