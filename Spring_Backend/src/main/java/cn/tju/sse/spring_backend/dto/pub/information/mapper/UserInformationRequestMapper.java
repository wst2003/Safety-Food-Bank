package cn.tju.sse.spring_backend.dto.pub.information.mapper;

import cn.tju.sse.spring_backend.dto.pub.information.UserInformationRequestDTO;
import cn.tju.sse.spring_backend.model.UsersEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

/**
 * @ClassName UserInformationRequestMapper
 * @Author RaoJi
 * @Description 用于将前端接收数据转化为model
 */
@Mapper
public interface UserInformationRequestMapper {
    // generate a mapper instance
    UserInformationRequestMapper INSTANCE =
            Mappers.getMapper(UserInformationRequestMapper.class);

    /**
     * @param request 前端发来的request
     * @return User表映射
     * @see UsersEntity
     */
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
    UsersEntity requestToEntity(UserInformationRequestDTO request);
}
