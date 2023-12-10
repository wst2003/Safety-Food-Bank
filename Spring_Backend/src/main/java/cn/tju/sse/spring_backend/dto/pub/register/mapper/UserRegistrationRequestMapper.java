package cn.tju.sse.spring_backend.dto.pub.register.mapper;

import cn.tju.sse.spring_backend.dto.pub.register.UserRegistrationRequestDTO;
import cn.tju.sse.spring_backend.model.UsersEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UserRegistrationRequestMapper {
    UserRegistrationRequestMapper INSTANCE = Mappers.getMapper(UserRegistrationRequestMapper.class);

    @Mapping(target = "userPhone",source = "user_phone")
    @Mapping(target = "userPassword",expression = "java(encodePassword(request.getUser_password()))")
    @Mapping(target = "userAddress",source = "user_address")
    @Mapping(target = "userType",expression = "java(Integer.parseInt(request.getUser_type()))")
    UsersEntity requestToEntity(UserRegistrationRequestDTO request);

}
