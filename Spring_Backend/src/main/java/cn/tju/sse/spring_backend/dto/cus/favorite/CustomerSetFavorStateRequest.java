package cn.tju.sse.spring_backend.dto.cus.favorite;

import lombok.Getter;
import lombok.Setter;

/*
收藏、取消收藏请求
 */
@Getter
@Setter
public class CustomerSetFavorStateRequest {
    private Integer com_id;
    private Integer cus_id;
    private Integer favor_state;
}
