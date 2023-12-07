package cn.tju.sse.spring_backend.dto.pub.getinformation.mapper;

import cn.tju.sse.spring_backend.dto.pub.getinformation.CustomerGetinformationRequest;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CustomerGetinformationRequestMapper {
    CustomerGetinformationRequestMapper INSTANCE =
            Mappers.getMapper(CustomerGetinformationRequestMapper.class);

    @Mapping(source = "cus_ID", target = "cusId")
    CustomerEntity requestToEntity (CustomerGetinformationRequest request);
}
