package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName CommodityShoppingCartRequestDTO
 * @author raoji
 * @date 2023/12/13
 * @Description 用于接收前端发来的购物车的商品id数组和顾客id
 */
@Getter
@Setter
public class CommodityShoppingCartRequestDTO {
    private Integer[] com_id_arr;
    private Integer cus_id;
}
