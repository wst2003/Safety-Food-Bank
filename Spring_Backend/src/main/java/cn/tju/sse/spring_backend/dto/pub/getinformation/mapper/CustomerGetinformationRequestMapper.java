package cn.tju.sse.spring_backend.dto.pub.getinformation.mapper;

import cn.tju.sse.spring_backend.dto.pub.getinformation.CustomerGetinformationRequestDTO;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

/**
 * @ClassName CustomerGetinformationRequestMapper
 * @Author RaoJi
 * @Description 用于将前端发来的顾客信息转成model
 */
@Mapper
public interface CustomerGetinformationRequestMapper {
    CustomerGetinformationRequestMapper INSTANCE =
            Mappers.getMapper(CustomerGetinformationRequestMapper.class);

    /**
     * @param request 前端发来的信息
     * @return Customer表的映射
     * @see CustomerEntity
     * @see CustomerGetinformationRequestDTO
     */
    @Mapping(source = "cus_ID", target = "cusId")
    @Mapping(target = "cusNickname", ignore = true)
    @Mapping(target = "cusNotes", ignore = true)
    @Mapping(target = "cusPaypassword", ignore = true)
    @Mapping(target = "cusState", ignore = true)
    CustomerEntity requestToEntity (CustomerGetinformationRequestDTO request);
}
