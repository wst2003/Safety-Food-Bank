package cn.tju.sse.spring_backend.dto.pub.modify.mapper;

import cn.tju.sse.spring_backend.dto.pub.modify.CustomerModifyRequest;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import cn.tju.sse.spring_backend.model.CustomerLoveEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

@Mapper
public interface CustomerModifyRequestMapper {
    CustomerModifyRequestMapper INSTANCE =
            Mappers.getMapper(CustomerModifyRequestMapper.class);

    @Mapping(target = "cusId", source = "cus_ID")
    @Mapping(target = "cusNickname", source = "cus_nickname")
    @Mapping(target = "cusNotes", source = "cus_notes")
    @Mapping(target = "cusPaypassword", source = "cus_payPassword")
    @Mapping(target = "cusState", ignore = true)
    CustomerEntity requestToEntity(CustomerModifyRequest request);

    default CustomerLoveEntity[] requestToLoveEntities(CustomerModifyRequest request) {
        if (request.getCus_category() == null || request.getCus_category().length == 0) {
            return new CustomerLoveEntity[0];
        }
        // 生成一个长度与request.getCus_category()相同的CustomerLoveEntity[]数组
        // CustomerLoveEntity[]中每个元素都具有相同的cusId，来自request.getCus_ID()
        // CustomerLoveEntity[]中每个元素的comCategory对应String[] 类型的request.getCus_category()中的一个元素
        int cusId = Integer.parseInt(request.getCus_ID()); // 获取cusId，假设 cus_ID 是一个数字

        return Arrays.stream(request.getCus_category())
                .map(category -> {
                    CustomerLoveEntity entity = new CustomerLoveEntity();
                    entity.setCusId(cusId);
                    entity.setComCategory(category);
                    // 设置其他属性，如果有的话
                    return entity;
                })
                .toArray(CustomerLoveEntity[]::new);
    }

}
