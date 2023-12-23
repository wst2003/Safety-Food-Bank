package cn.tju.sse.spring_backend.dto.cus.history;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 存放单个记录的DTO
 */
@Getter
@Setter
public class HistoryGetBrowsingHistoryDTO {
        private int com_id;
        private String com_name;
        private String com_introduction;
        private Double com_oriPrice;
        private String com_expirationDate;
        private String com_uploadDate;
        private Integer com_left;
        private Double com_rating;
        private double sto_id;
        private String sto_name;
        private List<String> com_categories;
        private String com_firstImage;
        private Double com_price;

        private int com_status;
        private int favor_state;


        private String bro_time_end;

}
