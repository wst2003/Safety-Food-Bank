package cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

/**
 * 商品详细信息请求的数据传输对象（DTO）
 */
@Getter
@Setter
public class CommodityDetailResponseDTO {
    @JsonProperty("com_id")
    private int com_id;
    @JsonProperty("com_name")
    private String com_name;
    @JsonProperty("com_introduction")
    private String com_introduction;
    @JsonProperty("com_oriprice")
    private BigDecimal com_oriprice;
    @JsonProperty("com_expirationdate")
    private String com_expirationdate;
    @JsonProperty("com_uploaddate")
    private String com_uploaddate;
    @JsonProperty("com_left")
    private int com_left;
    @JsonProperty("com_rating")
    private BigDecimal com_rating;
    @JsonProperty("com_categories")
    private List<String> com_categories;
    @JsonProperty("com_pc_time")
    private List<String> com_pc_time;
    @JsonProperty("com_pc_price")
    private List<BigDecimal> com_pc_price;
    @JsonProperty("com_image")
    private List<String> com_image;
}
