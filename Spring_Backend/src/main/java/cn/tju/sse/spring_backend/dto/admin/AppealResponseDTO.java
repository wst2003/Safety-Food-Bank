package cn.tju.sse.spring_backend.dto.admin;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * 获取申诉的响应的数据传输对象（DTO）
 */
@Getter
@Setter
public class AppealResponseDTO {
    @JsonProperty("APP_ID")
    private int APP_ID;
    @JsonProperty("APP_TIME")
    private String APP_TIME;
    @JsonProperty("SCT_IMAGE")
    private List<String> SCT_IMAGE;
    @JsonProperty("USER_ID")
    private int USER_ID;
    @JsonProperty("COM_ID")
    private int COM_ID;
    @JsonProperty("CMT_ID")
    private int CMT_ID;
    @JsonProperty("CMT_CONTENT")
    private String CMT_CONTENT;
    @JsonProperty("APP_USERID")
    private int APP_USERID;
    @JsonProperty("APP_MATTERS")
    private int APP_MATTERS;
    @JsonProperty("APP_CONTENT")
    private String APP_CONTENT;
}
