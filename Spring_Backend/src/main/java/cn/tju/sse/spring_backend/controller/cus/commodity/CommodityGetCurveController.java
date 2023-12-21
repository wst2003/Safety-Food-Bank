package cn.tju.sse.spring_backend.controller.cus.commodity;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetCurveRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetCurveResponseDTO;
import cn.tju.sse.spring_backend.service.cus.commodity.CommodityGetCurveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author raoji
 * @date 2023/12/13
 * @Description 控制类，返回商品的价格曲线
 */
@RestController
@RequestMapping("/api/cus/commodity")
public class CommodityGetCurveController {
    @Autowired
    private CommodityGetCurveService commodityGetCurveService;

    /**
     * @param com_id - 商品的id
     * @return 商品的价格变动曲线数组
     * @see CommodityGetCurveResponseDTO
     */
    @RequestMapping(value = "/getCurve", method = RequestMethod.GET)
    public ResponseEntity<CommodityGetCurveResponseDTO> getCurve
            (@RequestParam int com_id){
        CommodityGetCurveRequestDTO requestDTO = new CommodityGetCurveRequestDTO();
        requestDTO.setCom_id(com_id);
        CommodityGetCurveResponseDTO responseDTO =
                commodityGetCurveService.getCurve(requestDTO);
        return new ResponseEntity<>(responseDTO, HttpStatus.OK);
    }



}
