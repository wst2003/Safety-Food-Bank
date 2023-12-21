package cn.tju.sse.spring_backend.dto.cus.history;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class HistoryGetBrowsingHistoryRequest {

    private int cus_id;
    private int begin_pos;
    private int end_pos;
    private String search_str;

}
