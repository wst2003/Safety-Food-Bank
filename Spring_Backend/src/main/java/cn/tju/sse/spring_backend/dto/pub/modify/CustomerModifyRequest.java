package cn.tju.sse.spring_backend.dto.pub.modify;

import lombok.Getter;
import lombok.Setter;

/**
 * @author raoji
 * @date 2023/12/9
 * @Description
 */

@Getter
@Setter
public class CustomerModifyRequest {
    private String cus_ID;
    private String cus_nickname;
    private String cus_notes;
    private String cus_payPassword;
    private String[] cus_category;
}
