package cn.tju.sse.spring_backend.dto.pub.register;


import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UserRegistrationResponseDTO {
    private String user_ID;
    private String user_type;
    private String message;
}
