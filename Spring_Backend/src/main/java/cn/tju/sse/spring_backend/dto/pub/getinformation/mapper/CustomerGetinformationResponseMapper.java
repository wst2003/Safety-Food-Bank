package cn.tju.sse.spring_backend.dto.pub.getinformation.mapper;

import cn.tju.sse.spring_backend.dto.pub.getinformation.CustomerGetinformationResponseDTO;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import cn.tju.sse.spring_backend.model.CustomerLoveEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

/**
 * @ClassName CustomerGetinformationResponseMapper
 * @Author RaoJi
 * @Description 用于将model转成发送给前端的消息
 */
@Mapper
public interface CustomerGetinformationResponseMapper {
    CustomerGetinformationResponseMapper INSTANCE =
            Mappers.getMapper(CustomerGetinformationResponseMapper.class);

    /**
     * @param customer - 查询到的顾客实体
     * @param loves - 查询到的顾客爱好
     * @return 返回给前端的顾客信息
     * @see CustomerEntity
     * @see CustomerLoveEntity
     * @see CustomerGetinformationResponseDTO
     */
    @Mapping(source = "customer.cusId", target = "cus_ID")
    @Mapping(source = "customer.cusNickname", target = "cus_nickname")
    @Mapping(source = "customer.cusNotes", target = "cus_notes")
    @Mapping(source = "customer.cusPaypassword", target = "cus_payPassword")
    @Mapping(source = "customer.cusState", target = "cus_state")
    @Mapping(expression = "java(mapCustomerCategories(loves))", target = "cus_loves")
    @Mapping(target = "message", ignore = true)
    CustomerGetinformationResponseDTO entityToResponse(CustomerEntity customer, CustomerLoveEntity[] loves);

    /**
     * @param loves 查询到的顾客爱好
     * @return String[]
     */
    default String[] mapCustomerCategories(CustomerLoveEntity[] loves) {
        if (loves == null || loves.length == 0) {
            return new String[0]; // or null, depending on your requirements
        }
        return Arrays.stream(loves).map(CustomerLoveEntity::getComCategory).
                toArray(String[]::new);

    }
}
