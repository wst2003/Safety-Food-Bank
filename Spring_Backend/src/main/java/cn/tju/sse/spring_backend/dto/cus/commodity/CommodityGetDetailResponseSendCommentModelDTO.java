package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;

/**
 * 获取商品信息辅助类
 * 评论类
 */
@Getter
@Setter
public class CommodityGetDetailResponseSendCommentModelDTO {
    private int cmt_id=-1;
    private int cmt_father;
    private String cmt_content;
    private String cmt_time;
    private String cmt_name;
    private int user_id;
    private int user_type;
    private int buying_times=0;
    private int com_id;
}
