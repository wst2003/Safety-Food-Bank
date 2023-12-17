package cn.tju.sse.spring_backend.dto.pub.modify.mapper;

import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyRequest;
import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

/**
 * @author raoji
 * @date 2023/12/9
 * @Description
 */
@Mapper
public interface StoreModifyRequestMapper {
    StoreModifyRequestMapper INSTANCE = Mappers.getMapper(StoreModifyRequestMapper.class);

    @Mapping(target = "stoId", source = "sto_ID")
    @Mapping(target = "stoName", source = "sto_name")
    @Mapping(target = "stoIntroduction", source = "sto_introduction")
    @Mapping(target = "stoLicenseimg", ignore = true)
    @Mapping(target = "stoState", ignore = true)
    StoreEntity requestToStoreEntity(StoreModifyRequest request);

    default StoreCategoriesEntity[] requestToCategoryEntities(StoreModifyRequest request){
        if(request.getCategories() == null || request.getCategories().length == 0){
            return new StoreCategoriesEntity[0];
        }
        int stoId = Integer.parseInt(request.getSto_ID());

        return Arrays.stream(request.getCategories())
                .map(category ->{
                    StoreCategoriesEntity entity = new StoreCategoriesEntity();
                    entity.setStoreId(stoId);
                    entity.setComCategory(category);
                    return entity;
                }).toArray(StoreCategoriesEntity[]::new);
    }
}
