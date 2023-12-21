package cn.tju.sse.spring_backend.controller.cus.commodity;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityShoppingCartRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityShoppingCartResponseDTO;
import cn.tju.sse.spring_backend.service.cus.commodity.CommodityShoppingCartService;
import org.mapstruct.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author raoji
 * @date 2023/12/15
 * @Description 控制类，返回购物车内容
 */
@RestController
@RequestMapping("/api/cus/commodity")
public class CommodityShoppingCartController {
    @Autowired
    private CommodityShoppingCartService commodityShoppingCartService;

    /**
     * @param requestDTO - 顾客的购物车中的商品
     * @see CommodityShoppingCartRequestDTO
     * @return 购物车中商品的详细信息
     * @see CommodityShoppingCartResponseDTO
     */
    @RequestMapping("/shoppingCart")
    public ResponseEntity<CommodityShoppingCartResponseDTO> shoppingCart
            (@RequestBody CommodityShoppingCartRequestDTO requestDTO){
        System.out.println("request: " + requestDTO.toString() + "\n");
        CommodityShoppingCartResponseDTO responseDTO = commodityShoppingCartService.shoppingCart(requestDTO);
        System.out.println("response: " + responseDTO.toString() + "\n");
        return new ResponseEntity<>(responseDTO, HttpStatus.OK);
    }
}
