package cn.tju.sse.spring_backend.dto.pub.register.mapper;

import cn.tju.sse.spring_backend.dto.pub.register.StoreRegistrationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.register.UserRegistrationRequestDTO;
import cn.tju.sse.spring_backend.model.StoreEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;


@Mapper
public interface StoreRegistrationRequestMapper {
    StoreRegistrationRequestMapper INSTANCE= Mappers.getMapper(StoreRegistrationRequestMapper.class);

    @Mapping(target="stoId",source="sto_ID")
    @Mapping(target = "stoName",source = "sto_name")
    @Mapping(target = "stoIntroduction",source = "sto_introduction")
    StoreEntity requestToEntity(StoreRegistrationRequestDTO request);

}
