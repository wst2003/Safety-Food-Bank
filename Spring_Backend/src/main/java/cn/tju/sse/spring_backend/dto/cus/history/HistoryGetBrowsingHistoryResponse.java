package cn.tju.sse.spring_backend.dto.cus.history;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class HistoryGetBrowsingHistoryResponse {
    private List<HistoryGetBrowsingHistoryDTO> com_list;
    private int total;



}
