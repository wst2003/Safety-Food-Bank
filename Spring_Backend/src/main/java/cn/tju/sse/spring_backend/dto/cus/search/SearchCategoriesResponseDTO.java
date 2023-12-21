package cn.tju.sse.spring_backend.dto.cus.search;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName SearchCategoriesResponseDTO
 * @author raoji
 * @date 2023/12/13
 * @Description 发送给前端的所有类别的数组
 */
@Getter
@Setter
public class SearchCategoriesResponseDTO {
    private String[] com_categories;
}
