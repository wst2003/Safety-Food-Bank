package cn.tju.sse.spring_backend.dto.pub.getinformation.mapper;

import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationRequestDTO;
import cn.tju.sse.spring_backend.model.StoreEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

/**
 * @ClassName StoreGetinformationRequestMapper
 * @Author RaoJi
 * @Description 用于将前端发来的用户数据转成model
 */
@Mapper
public interface StoreGetinformationRequestMapper {
    StoreGetinformationRequestMapper INSTANCE =
            Mappers.getMapper(StoreGetinformationRequestMapper.class);

    /**
     * @param request 前端发来的数据
     * @return Store表的映射
     * @see StoreEntity
     * @see StoreGetinformationRequestDTO
     */
    @Mapping(source = "sto_ID", target = "stoId")
    @Mapping(target = "stoName", ignore = true)
    @Mapping(target = "stoIntroduction", ignore = true)
    @Mapping(target = "stoLicenseimg", ignore = true)
    @Mapping(target = "stoState", ignore = true)
    StoreEntity requestToEntity(StoreGetinformationRequestDTO request);
}
