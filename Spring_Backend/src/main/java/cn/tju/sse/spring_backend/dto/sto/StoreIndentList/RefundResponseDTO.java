package cn.tju.sse.spring_backend.dto.sto.StoreIndentList;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * 获取退款订单的响应的数据传输对象（DTO）
 */
@Getter
@Setter
public class RefundResponseDTO {
    @JsonProperty("IND_ID")
    private int IND_ID;
    @JsonProperty("IND_QUANTITY")
    private int IND_QUANTITY;
    @JsonProperty("COM_ID")
    private int COM_ID;
    @JsonProperty("COM_NAME")
    private String COM_NAME;
    @JsonProperty("COM_IMAGE")
    private String COM_IMAGE;
    @JsonProperty("IND_MONEY")
    private BigDecimal IND_MONEY;
    @JsonProperty("IND_RMONEY")
    private BigDecimal IND_RMONEY;
    @JsonProperty("IND_CREATIONTIME")
    private String IND_CREATIONTIME;
    @JsonProperty("IND_RTIME")
    private String IND_RTIME;
    @JsonProperty("IND_RNOTES")
    private String IND_RNOTES;
    @JsonProperty("CUS_ID")
    private int CUS_ID;
}
