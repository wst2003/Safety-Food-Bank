package cn.tju.sse.spring_backend.dto.sto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * 上传通知请求的数据传输对象（DTO）
 */
@Getter
@Setter
public class UploadNoticeRequestDTO {
    @JsonProperty("STO_ID")
    private int STO_ID;
    @JsonProperty("NTC_CONTENT")
    private String NTC_CONTENT;
}
