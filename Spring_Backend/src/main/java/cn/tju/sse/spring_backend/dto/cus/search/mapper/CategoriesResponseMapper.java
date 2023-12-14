package cn.tju.sse.spring_backend.dto.cus.search.mapper;

import cn.tju.sse.spring_backend.dto.cus.search.SearchCategoriesResponseDTO;
import cn.tju.sse.spring_backend.model.CommoditiesCategoriesEntity;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

/**
 * @author raoji
 * @date 2023/12/13
 * @Description
 */
@Mapper
public interface CategoriesResponseMapper {
    CategoriesResponseMapper INSTANCE = Mappers.getMapper(CategoriesResponseMapper.class);
    default SearchCategoriesResponseDTO entitiesToResponse(CommoditiesCategoriesEntity[] entities){
        if(entities == null){
            return new SearchCategoriesResponseDTO();
        }
        String[] target = Arrays.stream(entities).
                map(CommoditiesCategoriesEntity::getComCategory).toArray(String[]::new);

        SearchCategoriesResponseDTO responseDTO = new SearchCategoriesResponseDTO();
        responseDTO.setCom_categories(target);
        return responseDTO;
    }
}
