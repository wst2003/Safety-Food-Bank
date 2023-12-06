package cn.tju.sse.spring_backend.dto.pub.resetpassword;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResetPasswordRequestDTO {
    String user_phonenumber;
    String user_new_password;
}
