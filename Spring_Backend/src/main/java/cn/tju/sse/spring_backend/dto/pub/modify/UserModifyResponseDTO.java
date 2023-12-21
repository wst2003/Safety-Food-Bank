package cn.tju.sse.spring_backend.dto.pub.modify;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName UserModifyResponseDTO
 * @Author RaoJi
 * @Description 用于返回给前端的 用户修改 是否成功的消息
 */
@Getter
@Setter
public class UserModifyResponseDTO {
    private String message;
}
