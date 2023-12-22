package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommodityCommentRequestDTO {
    private int user_id;
    private String cmt_content;
    private int cmt_father;
    private int com_id;
}
