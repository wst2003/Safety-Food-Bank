package cn.tju.sse.spring_backend.dto.pub.getinformation;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName StoreGetinformationRequestDTO
 * @Author RaoJi
 * @Description 用于接收前端传来的商家id
 */
@Getter
@Setter
public class StoreGetinformationRequestDTO {
    private String sto_ID;
}
