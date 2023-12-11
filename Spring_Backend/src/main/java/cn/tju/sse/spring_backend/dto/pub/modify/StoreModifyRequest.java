package cn.tju.sse.spring_backend.dto.pub.modify;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

/**
 * @author raoji
 * @date 2023/12/9
 * @Description
 */
@Getter
@Setter
public class StoreModifyRequest {
    private String sto_ID;
    private String sto_name;
    private String sto_introduction;
    private String[] categories;
    private MultipartFile stoLicenseImg;
    private MultipartFile stoPicture;
}
