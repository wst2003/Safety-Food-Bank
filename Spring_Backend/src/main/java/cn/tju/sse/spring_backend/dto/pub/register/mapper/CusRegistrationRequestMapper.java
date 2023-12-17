package cn.tju.sse.spring_backend.dto.pub.register.mapper;

import cn.tju.sse.spring_backend.dto.pub.register.CusRegistrationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.register.CusRegistrationResponseDTO;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CusRegistrationRequestMapper {
    CusRegistrationRequestMapper INSTANCE= Mappers.getMapper(CusRegistrationRequestMapper.class);

    @Mapping(target = "cusId",source = "cus_ID")
    @Mapping(target="cusNickname",source = "cus_nickname")
    @Mapping(target="cusNotes",source="cus_notes")
    @Mapping(target = "cusPaypassword",source = "cus_payPassword")
    @Mapping(target = "cusState", ignore = true)
    CustomerEntity requestToEntity(CusRegistrationRequestDTO request);

}
