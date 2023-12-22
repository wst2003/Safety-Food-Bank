package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;

/**
 * CommodityComment的辅助类
 */
@Getter
@Setter
public class CommoditySendCommentDTO {
    private int cmt_id;
    private int cmt_father;
    private String cmt_content;
    private String cmt_time;
    private String cmt_name;
    private int user_id;
    private int user_type;
    private int buying_times=0;
    private int com_id;
}
