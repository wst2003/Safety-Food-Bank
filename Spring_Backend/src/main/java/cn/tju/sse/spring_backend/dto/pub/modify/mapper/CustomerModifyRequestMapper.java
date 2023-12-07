package cn.tju.sse.spring_backend.dto.pub.modify.mapper;

import cn.tju.sse.spring_backend.dto.pub.modify.CustomerModifyRequest;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CustomerModifyRequestMapper {
    CustomerModifyRequestMapper INSTANCE =
            Mappers.getMapper(CustomerModifyRequestMapper.class);

    @Mapping(target = "cusId", source = "cus_ID")
    @Mapping(target = "cusNickname", source = "cus_nickname")
    @Mapping(target = "cusNotes", source = "cus_notes")
    @Mapping(target = "cusPaypassword", source = "cus_payPassword")
    @Mapping(target = "cusState", source = "cus_state")
    CustomerEntity requestToEntity(CustomerModifyRequest request);

    //@Mapping(expression = "java(mapCustomerCategories(loves))", target = "cus_loves")

}
