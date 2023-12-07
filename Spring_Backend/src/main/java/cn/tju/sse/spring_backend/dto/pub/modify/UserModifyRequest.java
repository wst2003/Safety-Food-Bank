package cn.tju.sse.spring_backend.dto.pub.modify;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserModifyRequest {
    private String user_ID;
    private String user_phone;
    private String user_password;
    private String user_address;
}
