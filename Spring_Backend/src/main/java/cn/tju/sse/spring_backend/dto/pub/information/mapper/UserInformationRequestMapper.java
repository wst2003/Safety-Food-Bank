package cn.tju.sse.spring_backend.dto.pub.information.mapper;

import cn.tju.sse.spring_backend.dto.pub.information.UserInformationRequest;
import cn.tju.sse.spring_backend.dto.pub.information.UserInformationResponse;
import cn.tju.sse.spring_backend.dto.pub.register.UserRegistrationRequest;
import cn.tju.sse.spring_backend.model.UsersEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserInformationRequestMapper {
    // generate a mapper instance
    UserInformationRequestMapper INSTANCE =
            Mappers.getMapper(UserInformationRequestMapper.class);

    // transfer request to model
    // source: UserInformationRequest  String user_ID
    // target: UsersEntity  int userId
    // String to int: need to be decorated by "Integer.parseInt" seen in service class
    @Mapping(target = "userId", expression = "java(Integer.parseInt(request.getUser_ID()))")
    @Mapping(target = "userPhone", ignore = true)
    @Mapping(target = "userPassword", ignore = true)
    @Mapping(target = "userAddress", ignore = true)
    @Mapping(target = "userState", ignore = true)
    @Mapping(target = "userRegtime", ignore = true)
    @Mapping(target = "userType", ignore = true)
    @Mapping(target = "userBalance", ignore = true)
    UsersEntity requestToEntity(UserInformationRequest request);
}
