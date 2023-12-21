package cn.tju.sse.spring_backend.dto.pub.getinformation;

import lombok.Getter;
import lombok.Setter;

/**
 * @ClassName StoreGetinformationResponseDTO
 * @Author RaoJi
 * @Description 用于返回查询到的商家详细信息
 */
@Getter
@Setter
public class StoreGetinformationResponseDTO {
    private String message;
    private Integer sto_ID;
    private String sto_name;
    private String sto_introduction;
    private String sto_licenseImg;
    private String sto_state;
    private String[] categories;
}
