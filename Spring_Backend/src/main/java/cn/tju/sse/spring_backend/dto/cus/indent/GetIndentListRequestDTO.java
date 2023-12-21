package cn.tju.sse.spring_backend.dto.cus.indent;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class GetIndentListRequestDTO {
    Integer cus_id;
    Integer ind_state;
    String search_str;
    Integer sort_order;
    Integer begin_pos;
    Integer end_pos;
}
