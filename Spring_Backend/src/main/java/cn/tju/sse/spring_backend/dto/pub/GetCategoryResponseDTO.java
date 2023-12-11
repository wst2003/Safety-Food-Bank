package cn.tju.sse.spring_backend.dto.pub;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;

@Getter
@Setter
public class GetCategoryResponseDTO {
    private ArrayList<String> categorylist;
}
