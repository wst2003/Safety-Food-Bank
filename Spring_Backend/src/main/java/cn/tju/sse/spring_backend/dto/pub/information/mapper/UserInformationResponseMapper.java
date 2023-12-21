package cn.tju.sse.spring_backend.dto.pub.information.mapper;

import cn.tju.sse.spring_backend.dto.pub.information.UserInformationResponseDTO;
import cn.tju.sse.spring_backend.model.UsersEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserInformationResponseMapper {
    UserInformationResponseMapper INSTANCE =
            Mappers.getMapper(UserInformationResponseMapper.class);

    // transfer model to response
    // this is used in the service class, when you get what you want as model,
    // you can switch each attribute explicitly, and judge how to transfer like using
    // String.valueOf and so on.
    @Mapping(target = "user_ID", source = "userId")  // no explicitly
    @Mapping(target = "user_phone", source = "userPhone")
    @Mapping(target = "user_password", source = "userPassword")
    @Mapping(target = "user_address", source = "userAddress")
    @Mapping(target = "user_balance", source = "userBalance")
    @Mapping(target = "user_regTime", source = "userRegtime")
    @Mapping(target = "user_type", source = "userType")
    @Mapping(target = "message", ignore = true)
    UserInformationResponseDTO entityToResponse(UsersEntity user);
}
