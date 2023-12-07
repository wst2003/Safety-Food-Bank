package cn.tju.sse.spring_backend.dto.pub.getinformation;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreGetinformationResponse {
    private String message;
    private Integer sto_ID;
    private String sto_name;
    private String sto_introduction;
    private String sto_licenseImg;
    private String sto_state;
    private String[] categories;
}
