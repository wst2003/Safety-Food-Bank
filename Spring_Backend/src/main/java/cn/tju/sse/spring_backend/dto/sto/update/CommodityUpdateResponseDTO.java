package cn.tju.sse.spring_backend.dto.sto.update;

import cn.tju.sse.spring_backend.dto.sto.upload.CommodityTimePriceDTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;

/**
 * 在更新商品信息中得到商品原信息
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/09 12:47
 */
@Getter
@Setter
public class CommodityUpdateResponseDTO {
    @JsonProperty("STO_ID")
    private int STO_ID;
    @JsonProperty("COM_NAME")
    private String COM_NAME;
    @JsonProperty("COM_INTRODUCTION")
    private String COM_INTRODUCTION;
    @JsonProperty("COM_ORIPRICE")
    private BigDecimal COM_ORIPRICE;
    @JsonProperty("COM_EXPIRATIONDATE")
    private String COM_EXPIRATIONDATE;
    @JsonProperty("COM_LEFT")
    private int COM_LEFT;
    @JsonProperty("IMAGE_KEY")
    private String IMAGE_KEY;
    @JsonProperty("COM_CATEGORIES")
    private ArrayList<String> COM_CATEGORIES;
    @JsonProperty("COM_TIME_PRICE")
    private ArrayList<CommodityTimePriceDTO> COM_TIME_PRICE;
}
