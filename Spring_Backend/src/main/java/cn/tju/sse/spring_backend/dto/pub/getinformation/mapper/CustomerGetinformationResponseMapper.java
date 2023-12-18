package cn.tju.sse.spring_backend.dto.pub.getinformation.mapper;

import cn.tju.sse.spring_backend.dto.pub.getinformation.CustomerGetinformationResponse;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import cn.tju.sse.spring_backend.model.CustomerLoveEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

@Mapper
public interface CustomerGetinformationResponseMapper {
    CustomerGetinformationResponseMapper INSTANCE =
            Mappers.getMapper(CustomerGetinformationResponseMapper.class);

    @Mapping(source = "customer.cusId", target = "cus_ID")
    @Mapping(source = "customer.cusNickname", target = "cus_nickname")
    @Mapping(source = "customer.cusNotes", target = "cus_notes")
    @Mapping(source = "customer.cusPaypassword", target = "cus_payPassword")
    @Mapping(source = "customer.cusState", target = "cus_state")
    @Mapping(expression = "java(mapCustomerCategories(loves))", target = "cus_loves")
    @Mapping(target = "message", ignore = true)
    CustomerGetinformationResponse entityToResponse(CustomerEntity customer, CustomerLoveEntity[] loves);

    default String[] mapCustomerCategories(CustomerLoveEntity[] loves) {
        if (loves == null || loves.length == 0) {
            return new String[0]; // or null, depending on your requirements
        }
        return Arrays.stream(loves).map(CustomerLoveEntity::getComCategory).
                toArray(String[]::new);

    }
}
