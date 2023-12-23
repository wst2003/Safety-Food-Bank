package cn.tju.sse.spring_backend.dto.cus.commodity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommodityCommentResponseDTO {
    private String msg;
    private CommoditySendCommentDTO comment;
}
