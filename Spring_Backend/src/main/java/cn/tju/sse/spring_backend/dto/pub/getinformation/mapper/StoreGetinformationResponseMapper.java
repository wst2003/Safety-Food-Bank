package cn.tju.sse.spring_backend.dto.pub.getinformation.mapper;

import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationResponseDTO;
import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

/**
 * @ClassName StoreGetinformationResponseMapper
 * @Author RaoJi
 * @Description 将后端查询到的model实体转为发送给前端的消息
 */
@Mapper
public interface StoreGetinformationResponseMapper {
    StoreGetinformationResponseMapper INSTANCE =
            Mappers.getMapper(StoreGetinformationResponseMapper.class);

    /**
     * @param store 查询到的商家实体
     * @param storeCategoriesEntities 查询到的商家经营范围的实体
     * @return 发送给前端的消息
     * @see StoreEntity
     * @see StoreCategoriesEntity
     * @see StoreGetinformationResponseDTO
     */
    @Mapping(target = "sto_ID", source = "store.stoId")
    @Mapping(target = "sto_name", source = "store.stoName")
    @Mapping(target = "sto_introduction", source = "store.stoIntroduction")
    @Mapping(target = "sto_licenseImg", source = "store.stoLicenseimg")
    @Mapping(target = "sto_state", source = "store.stoState")
    @Mapping(target = "categories", expression = "java(mapStoreCategories(storeCategoriesEntities))")
    @Mapping(target = "message", ignore = true)
    StoreGetinformationResponseDTO entityToResponse(StoreEntity store, StoreCategoriesEntity[] storeCategoriesEntities);

    /**
     * @param storeCategoriesEntities 商家经营范围的实体
     * @return String[]
     */
    default String[] mapStoreCategories(StoreCategoriesEntity[] storeCategoriesEntities) {
        if (storeCategoriesEntities == null || storeCategoriesEntities.length == 0) {
            return new String[0]; // or null, depending on your requirements
        }
        return Arrays.stream(storeCategoriesEntities).map(StoreCategoriesEntity::getComCategory).
                toArray(String[]::new);
    }
}
