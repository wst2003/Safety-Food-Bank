package cn.tju.sse.spring_backend.dto.pub.register;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRegistrationRequest {
    private String user_phone;
    private String user_password;
    private String user_address;
    private String user_type;

}
