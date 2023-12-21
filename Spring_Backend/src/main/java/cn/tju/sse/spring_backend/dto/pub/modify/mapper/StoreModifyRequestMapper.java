package cn.tju.sse.spring_backend.dto.pub.modify.mapper;

import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyRequestDTO;
import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

/**
 * @ClassName StoreModifyRequestMapper
 * @author raoji
 * @date 2023/12/9
 * @Description 将前端发送来的待修改的商家消息转化为model
 */
@Mapper
public interface StoreModifyRequestMapper {
    StoreModifyRequestMapper INSTANCE = Mappers.getMapper(StoreModifyRequestMapper.class);

    /**
     * @param request 前端发送来的消息
     * @return Store表的映射
     * @see StoreEntity
     * @see StoreModifyRequestDTO
     */
    @Mapping(target = "stoId", source = "sto_ID")
    @Mapping(target = "stoName", source = "sto_name")
    @Mapping(target = "stoIntroduction", source = "sto_introduction")
    @Mapping(target = "stoLicenseimg", ignore = true)
    @Mapping(target = "stoState", ignore = true)
    StoreEntity requestToStoreEntity(StoreModifyRequestDTO request);

    /**
     * @param request 前端发送来的消息
     * @return StoreCategories表的映射多个实体
     * @see StoreCategoriesEntity
     * @see StoreModifyRequestDTO
     */
    default StoreCategoriesEntity[] requestToCategoryEntities(StoreModifyRequestDTO request){
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
