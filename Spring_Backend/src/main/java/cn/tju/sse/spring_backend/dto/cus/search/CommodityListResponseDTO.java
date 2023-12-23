package cn.tju.sse.spring_backend.dto.cus.search;

import jakarta.persistence.criteria.CriteriaBuilder;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author lhx
 * @date 2023/12/22
 * @Description 用于搜索商品接口
 */

@Setter
@Getter
public class CommodityListResponseDTO {
    Integer total;
    List<ComEleDTO> com_list;

    @Setter
    @Getter
    public static class ComEleDTO{
        Integer com_id;
        String com_name;
        String com_introduction;
        BigDecimal com_oriPrice;
        String com_expirationDate;
        String com_uploadDate;
        Integer com_left;
        BigDecimal com_rating;
        String sto_name;
        Integer sto_id;
        List<String> com_categories;
        String com_firstImage;
        BigDecimal com_price;
        Integer favor_state;
        Integer com_status;
    }

}
