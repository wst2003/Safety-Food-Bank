package cn.tju.sse.spring_backend.dto.pub.getinformation;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName CustomerGetinformationRequestDTO
 * @Author RaoJI
 * Description 用于接收前端发来的顾客id
 */
@Getter
@Setter
public class CustomerGetinformationRequestDTO {
    private String cus_ID;
}
