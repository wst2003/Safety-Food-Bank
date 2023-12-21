package cn.tju.sse.spring_backend.dto.pub.information;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName UserInformationRequestDTO
 * @Author RaoJi
 * @Description 用于接收前端发送的用户id
 */
@Getter  // replace get methods
@Setter  // replace set methods
public class UserInformationRequestDTO {
    private String user_ID;  // from api-fox
}
