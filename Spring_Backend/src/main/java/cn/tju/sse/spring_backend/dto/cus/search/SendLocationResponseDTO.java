package cn.tju.sse.spring_backend.dto.cus.search;


import lombok.Getter;
import lombok.Setter;



import java.util.List;

/**
 * @author 李恒鑫
 * @date 2023/12/20
 * @Description 接口返回DTO
 */
@Getter
@Setter
public class SendLocationResponseDTO {

    public List<SendLocationRepositoryDTO> address_list;

}

