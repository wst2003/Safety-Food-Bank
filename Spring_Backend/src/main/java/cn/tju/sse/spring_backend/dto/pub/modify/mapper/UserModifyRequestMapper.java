package cn.tju.sse.spring_backend.dto.pub.modify.mapper;

import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyRequestDTO;
import cn.tju.sse.spring_backend.model.UsersEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

/**
 * @ClassName UserModifyRequestMapper
 * @Author RaoJi
 * @Description 将前端发送来的用户待修改消息转化为model
 */
@Mapper
public interface UserModifyRequestMapper {
    UserModifyRequestMapper INSTANCE =
            Mappers.getMapper(UserModifyRequestMapper.class);

    /**
     * @param request 前端发来的消息
     * @return User表的映射
     * @see UsersEntity
     * @see UserModifyRequestDTO
     */
    @Mapping(source = "user_ID", target = "userId")  // no explicitly
    @Mapping(source = "user_phone", target = "userPhone")
    @Mapping(source = "user_password", target = "userPassword")
    @Mapping(source = "user_address", target = "userAddress")
    @Mapping(target = "userState", ignore = true)
    @Mapping(target = "userRegtime", ignore = true)
    @Mapping(target = "userType", ignore = true)
    @Mapping(target = "userBalance", ignore = true)
    UsersEntity requestToEntity(UserModifyRequestDTO request);
}
