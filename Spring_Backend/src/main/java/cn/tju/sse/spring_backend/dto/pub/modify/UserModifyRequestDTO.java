package cn.tju.sse.spring_backend.dto.pub.modify;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName UserModifyRequestDTO
 * @Author RaoJi
 * @Description 用于接收前端发来的待修改的顾客消息
 */
@Getter
@Setter
public class UserModifyRequestDTO {
    private String user_ID;
    private String user_phone;
    private String user_password;
    private String user_address;
}
