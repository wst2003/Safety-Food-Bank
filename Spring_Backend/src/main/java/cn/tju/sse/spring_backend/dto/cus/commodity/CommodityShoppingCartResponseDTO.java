package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName CommodityShoppingCartResponseDTO
 * @author raoji
 * @date 2023/12/13
 * @Description 用于发送给前端的购物车中商品详细信息
 */
@Getter
@Setter
public class CommodityShoppingCartResponseDTO {
    public CommodityShoppingCartResponseDTO(){
        com_list = new ArrayList<>();
    }
    @Getter
    @Setter
    public static class ComListItem{
        // COMMODITY TABLE
        private Integer com_id;
        private String com_name;
        private String com_introduction;
        private String com_expirationDate;
        private String com_uploadDate;
        private Integer com_left;
        private Integer com_rating;
        private Integer sto_id;
        private float com_oriPrice;
        private Integer com_status;
        // COM_CATEGORIES TABLE
        private String[] com_categories;
        // STORE TABLE
        private String sto_name;
        // COMMODITY_IMAGE TABLE
        private String com_firstImage;  // the first one
        // COMMODITY_PRICE_CURVE TABLE
        private float com_price;  // the lowest one
        // FAVORITE TABLE
        private Integer favor_state; // 0 or 1 judged by lines
    }
    private List<ComListItem> com_list;
}
