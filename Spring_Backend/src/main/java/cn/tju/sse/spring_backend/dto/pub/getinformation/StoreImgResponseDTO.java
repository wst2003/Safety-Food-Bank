package cn.tju.sse.spring_backend.dto.pub.getinformation;


import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class StoreImgResponseDTO {
    private String imgURL;

    public StoreImgResponseDTO(String imgURL){
        this.setImgURL(imgURL);
    }
}
