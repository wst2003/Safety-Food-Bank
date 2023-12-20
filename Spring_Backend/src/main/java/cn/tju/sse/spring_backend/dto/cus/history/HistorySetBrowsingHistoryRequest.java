package cn.tju.sse.spring_backend.dto.cus.history;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class HistorySetBrowsingHistoryRequest {
    private String bro_time_start;
    private String bro_time_end;
    private int com_id;
    private int browser_id;
    private int whether_buy;
}
