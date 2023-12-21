package cn.tju.sse.spring_backend.dto.cus.search.mapper;

import cn.tju.sse.spring_backend.dto.cus.search.SearchCategoriesResponseDTO;
import cn.tju.sse.spring_backend.model.CommoditiesCategoriesEntity;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

/**
 * @ClassName CategoriesResponseMapper
 * @author raoji
 * @date 2023/12/13
 * @Description 将查询到的类别实体转化为发送给前端的消息
 */
@Mapper
public interface CategoriesResponseMapper {
    CategoriesResponseMapper INSTANCE = Mappers.getMapper(CategoriesResponseMapper.class);

    /**
     * @param entities 查询到的商品类别实体
     * @return 发送给前端的实体数组
     * @see SearchCategoriesResponseDTO
     * @see CommoditiesCategoriesEntity
     */
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
