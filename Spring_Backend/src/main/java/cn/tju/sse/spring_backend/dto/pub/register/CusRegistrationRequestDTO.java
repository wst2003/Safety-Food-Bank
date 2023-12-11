package cn.tju.sse.spring_backend.dto.pub.register;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;

@Getter
@Setter
public class CusRegistrationRequestDTO {
    private String cus_ID;
    private String cus_nickname;
    private String cus_notes;
    private String cus_payPassword;
    private ArrayList<String> cus_category;
}
