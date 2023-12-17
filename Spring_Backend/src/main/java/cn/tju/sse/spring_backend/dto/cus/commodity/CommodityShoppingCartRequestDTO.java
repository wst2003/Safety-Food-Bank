package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author raoji
 * @date 2023/12/13
 * @Description
 */
@Getter
@Setter
public class CommodityShoppingCartRequestDTO {
    private Integer[] com_id_arr;
    private Integer cus_id;
}
