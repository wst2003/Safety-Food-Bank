package cn.tju.sse.spring_backend.dto.cus.search;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * @author lhx
 * @date 2023/12/20
 * @Description 用于向前端发送地理位置信息的接口
 */
@Getter
@Setter
public class GetLocationSortRequestDTO {
    List<Integer> sto_id;
    Integer user_id;
}
