package cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

/**
 * 按条件搜索商品的响应的数据传输对象（DTO）
 */
@Getter
@Setter
public class SearchCommodityResponseDTO {
    @JsonProperty("com_id")
    private int com_id;
    @JsonProperty("com_name")
    private String com_name;
    @JsonProperty("com_left")
    private int com_left;
    @JsonProperty("com_uploaddate")
    private String com_uploaddate;
    @JsonProperty("com_expirationdate")
    private String com_expirationdate;
    @JsonProperty("com_curr_price")
    private BigDecimal com_curr_price;
    @JsonProperty("com_categories")
    private List<String> com_categories;
    @JsonProperty("com_image")
    private List<String> com_image;
}
