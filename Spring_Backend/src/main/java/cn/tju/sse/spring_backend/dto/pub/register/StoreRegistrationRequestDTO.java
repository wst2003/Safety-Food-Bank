package cn.tju.sse.spring_backend.dto.pub.register;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;

@Getter
@Setter
public class StoreRegistrationRequestDTO {
    private String sto_ID;
    private String sto_name;
    private String sto_introduction;
    private MultipartFile sto_licenseImage;
    private ArrayList<String> com_categories;
    private ArrayList<MultipartFile> sto_picture;
}
