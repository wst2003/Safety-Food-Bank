package cn.tju.sse.spring_backend.dto.pub.modify;


import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class DelStoreImgRequestDTO {
    private String sto_ID;
    private String url;
}
