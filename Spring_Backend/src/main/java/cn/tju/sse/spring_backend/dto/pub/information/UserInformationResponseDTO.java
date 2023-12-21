package cn.tju.sse.spring_backend.dto.pub.information;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName UserInformationResponseDTO
 * @Author RaoJI
 * @Description 用于返回给前端的用户数据
 */
@Setter
@Getter
public class UserInformationResponseDTO {
    // same in the api fox response
    private String message;
    private String user_ID;
    private String user_phone;
    private String user_password;
    private String user_address;
    private String user_balance;
    private String user_regTime;
    private String user_type;
}
