package cn.tju.sse.spring_backend.dto.sto.upload;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * 上传商品Response
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/02 14:24
 */
@Getter
@Setter
public class CommodityUploadResponseDTO {
    private int com_id;
    private String message;
}
