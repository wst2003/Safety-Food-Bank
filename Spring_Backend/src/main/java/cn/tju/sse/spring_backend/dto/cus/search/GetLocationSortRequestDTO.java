package cn.tju.sse.spring_backend.dto.cus.search;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class GetLocationSortRequestDTO {
    List<Integer> sto_id;
    Integer user_id;
}
