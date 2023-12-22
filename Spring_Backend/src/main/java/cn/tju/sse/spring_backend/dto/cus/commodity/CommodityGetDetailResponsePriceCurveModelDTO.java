package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;


/**
 * 获取商品信息辅助类
 * 价格曲线类
 */
@Getter
@Setter
public class CommodityGetDetailResponsePriceCurveModelDTO {
    private String com_pc_time="-1";
    private double com_pc_price=-1;
}
