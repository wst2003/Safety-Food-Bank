package cn.tju.sse.spring_backend.dto.sto.StoreIndentList;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

/**
 * 获取订单的响应的数据传输对象（DTO）
 */
@Getter
@Setter
public class IndentBoxResponseDTO {
    @JsonProperty("CUS_ID")
    private int CUS_ID;
    @JsonProperty("IND_CREATIONTIME")
    private String IND_CREATIONTIME;
    @JsonProperty("USER_PHONE")
    private String USER_PHONE;
    @JsonProperty("CUS_NICKNAME")
    private String CUS_NICKNAME;
    @JsonProperty("BOX")
    private List<ListItem> BOX;

    @Getter
    @Setter
    public static class ListItem {
        @JsonProperty("IND_ID")
        private int IND_ID;
        @JsonProperty("COM_ID")
        private int COM_ID;
        @JsonProperty("IND_QUANTITY")
        private int IND_QUANTITY;
        @JsonProperty("IND_MONEY")
        private BigDecimal IND_MONEY;
        @JsonProperty("COM_NAME")
        private String COM_NAME;
        @JsonProperty("COM_IMAGE")
        private String COM_IMAGE;
        @JsonProperty("IND_NOTES")
        private String IND_NOTES;
        @JsonProperty("IND_RATING")
        private int IND_RATING;
    }
}
