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
    StoreEntity requestToEntity(StoreGetinformationRequest request);
}
