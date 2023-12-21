package cn.tju.sse.spring_backend.dto.pub.getinformation;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName CustomerGetinformationResponseDTO
 * @Author RaoJi
 * @Description 发回给前端的用户数据
 */
@Getter
@Setter
public class CustomerGetinformationResponseDTO {
    private String message;
    private String cus_ID;
    private String cus_nickname;
    private String cus_notes;
    private String cus_payPassword;
    private String cus_state;
    private String[] cus_loves;
}
