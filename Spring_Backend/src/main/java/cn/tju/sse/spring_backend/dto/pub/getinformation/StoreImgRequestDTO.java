package cn.tju.sse.spring_backend.dto.pub.getinformation;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreImgRequestDTO {
    private String sto_ID;
    public StoreImgRequestDTO(String sto_ID){
        this.setSto_ID(sto_ID);
    }
}
