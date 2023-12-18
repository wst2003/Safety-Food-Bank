package cn.tju.sse.spring_backend.dto.pub.getinformation.mapper;

import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationRequest;
import cn.tju.sse.spring_backend.model.StoreEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface StoreGetinformationRequestMapper {
    StoreGetinformationRequestMapper INSTANCE =
            Mappers.getMapper(StoreGetinformationRequestMapper.class);

    @Mapping(source = "sto_ID", target = "stoId")
    @Mapping(target = "stoName", ignore = true)
    @Mapping(target = "stoIntroduction", ignore = true)
    @Mapping(target = "stoLicenseimg", ignore = true)
    @Mapping(target = "stoState", ignore = true)
    StoreEntity requestToEntity(StoreGetinformationRequest request);
}
