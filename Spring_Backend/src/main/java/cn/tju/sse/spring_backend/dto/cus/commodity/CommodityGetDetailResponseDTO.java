package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CommodityGetDetailResponseDTO {
    private int com_id = -1;
    private String com_name = "-1";
    private String com_introduction = "-1";
    private double com_oriPrice = -1.0;
    private String com_expirationDate = "0000-00-00";
    private String com_uploadDate = "0000-00-00";
    private int com_left = -1;
    private double com_rating = -1.0;
    private String sto_name = "-1";
    private double sto_id = 111;
    private List<String> com_categories = new ArrayList<>();
    private List<String> com_images = new ArrayList<>();
    private double com_price;
    private List<CommodityGetDetailResponsePriceCurveModelDTO> com_prices = new ArrayList<>();
    private List<CommodityGetDetailResponseSendCommentModelDTO> comments = new ArrayList<>();
    private int favor_state = -1;
    private int com_status = -2; // -1 is expired, 0 is sold out, 1 is on sale


}
