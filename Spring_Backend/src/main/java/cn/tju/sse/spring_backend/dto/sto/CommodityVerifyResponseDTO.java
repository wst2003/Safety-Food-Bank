package cn.tju.sse.spring_backend.dto.sto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * 商品核销的响应的数据传输对象（DTO）
 */
@Getter
@Setter
public class CommodityVerifyResponseDTO {
    @JsonProperty("CUS_ID")
    private int CUS_ID;
    @JsonProperty("LIST")
    private List<ListItem> LIST;

    @Getter
    @Setter
    public static class ListItem {
        @JsonProperty("IND_ID")
        private int IND_ID;
        @JsonProperty("COM_ID")
        private int COM_ID;
        @JsonProperty("COM_NAME")
        private String COM_NAME;
        @JsonProperty("IND_QUANTITY")
        private int IND_QUANTITY;
    }
}
