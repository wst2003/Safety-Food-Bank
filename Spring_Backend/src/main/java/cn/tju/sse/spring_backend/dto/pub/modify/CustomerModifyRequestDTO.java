package cn.tju.sse.spring_backend.dto.pub.modify;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName CustomerModifyRequestDTO
 * @author raoji
 * @date 2023/12/9
 * @Description 用于接收前端发来的待修改的顾客信息
 */

@Getter
@Setter
public class CustomerModifyRequestDTO {
    private String cus_ID;
    private String cus_nickname;
    private String cus_notes;
    private String cus_payPassword;
    private String[] cus_category;
}
