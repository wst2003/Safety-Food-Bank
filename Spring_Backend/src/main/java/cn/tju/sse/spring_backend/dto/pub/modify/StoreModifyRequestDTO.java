package cn.tju.sse.spring_backend.dto.pub.modify;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

/**
 * @ClassName StoreModifyRequestDTO
 * @author raoji
 * @date 2023/12/9
 * @Description 接收前端发来的待修改的商家消息
 */
@Getter
@Setter
public class StoreModifyRequestDTO {
    private String sto_ID;
    private String sto_name;
    private String sto_introduction;
    private String[] categories;
    private MultipartFile stoLicenseImg;
    private MultipartFile[] stoPicture;
}
