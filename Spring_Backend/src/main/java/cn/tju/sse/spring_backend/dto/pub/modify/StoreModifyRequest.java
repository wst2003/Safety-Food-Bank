package cn.tju.sse.spring_backend.dto.pub.modify;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreModifyRequest {
    private Integer sto_ID;
    private String sto_name;
    private String sto_introduction;
    //private file sto_licenseImg;
    //private file sto_picture;
    private String[] categories;
}
