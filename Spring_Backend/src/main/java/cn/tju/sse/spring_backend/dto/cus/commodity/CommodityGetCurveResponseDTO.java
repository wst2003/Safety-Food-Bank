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
public class CommodityGetCurveResponseDTO {
    @Setter
    @Getter
    public static class ComPrice{
        private String com_pc_time;
        private Integer com_pc_price;
    }
    private ComPrice[] com_prices;
}
