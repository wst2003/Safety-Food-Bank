package cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * 按条件搜索商品的请求的数据传输对象（DTO）
 */
@Getter
@Setter
public class SearchCommodityRequestDTO {
    @JsonProperty("status")
    private int status;
    @JsonProperty("order")
    private int order;
    @JsonProperty("category")
    private List<String> category;
    @JsonProperty("query")
    private String query;
    @JsonProperty("COM_UPLOADDATE")
    private String COM_UPLOADDATE;
    @JsonProperty("COM_EXPIRATIONDATE")
    private String COM_EXPIRATIONDATE;
}
