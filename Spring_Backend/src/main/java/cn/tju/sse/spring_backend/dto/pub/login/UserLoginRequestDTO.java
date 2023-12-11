package cn.tju.sse.spring_backend.dto.pub.login;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserLoginRequestDTO {
    private String login_type;
    private String user_ID_phonenumber;
    private String user_password;
}
