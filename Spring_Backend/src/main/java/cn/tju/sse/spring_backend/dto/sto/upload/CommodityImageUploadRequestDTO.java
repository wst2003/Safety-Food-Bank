package cn.tju.sse.spring_backend.dto.sto.upload;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

/**
 * 上传商品图片Request
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/02 14:26
 */
@Getter
@Setter
public class CommodityImageUploadRequestDTO {
    private MultipartFile file;
    private String IMAGE_KEY;
    private String key;
}
