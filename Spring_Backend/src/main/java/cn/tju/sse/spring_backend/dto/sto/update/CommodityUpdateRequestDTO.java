package cn.tju.sse.spring_backend.dto.sto.update;

import cn.tju.sse.spring_backend.dto.sto.upload.CommodityTimePriceDTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;

/**
 * 更新商品
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/09 15:20
 */
@Getter
@Setter
public class CommodityUpdateRequestDTO {
    @JsonProperty("STO_ID")
    private int sto_id;
    @JsonProperty("COM_NAME")
    private String com_name;
    @JsonProperty("COM_INTRODUCTION")
    private String com_introduction;
    @JsonProperty("COM_ORIPRICE")
    private BigDecimal com_oriprice;
    @JsonProperty("COM_EXPIRATIONDATE")
    private String com_expirationDate;
    @JsonProperty("COM_LEFT")
    private int com_left;
    @JsonProperty("IMAGE_KEY")
    private String image_key;
    @JsonProperty("COM_CATEGORIES")
    private ArrayList<String> com_categories;
    @JsonProperty("COM_TIME_PRICE")
    private ArrayList<CommodityTimePriceDTO> com_time_price;
}
