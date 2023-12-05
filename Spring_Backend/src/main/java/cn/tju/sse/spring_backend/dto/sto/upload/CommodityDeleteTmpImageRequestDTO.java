package cn.tju.sse.spring_backend.dto.sto.upload;

import lombok.Getter;
import lombok.Setter;

/**
 * 删除临时文件夹Request
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/02 16:32
 */
@Getter
@Setter
public class CommodityDeleteTmpImageRequestDTO {
    private String fileName;
    private String IMAGE_KEY;
}
