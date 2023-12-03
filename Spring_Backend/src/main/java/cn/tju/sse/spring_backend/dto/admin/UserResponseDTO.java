package cn.tju.sse.spring_backend.dto.admin;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * 用户响应的数据传输对象（DTO）
 */
@Getter
@Setter
public class UserResponseDTO {
    @JsonProperty("USER_ID")
    private int USER_ID;
    @JsonProperty("USER_NAME")
    private String USER_NAME;
    @JsonProperty("USER_REGTIME")
    private String USER_REGTIME;
    @JsonProperty("USER_STATE")
    private int USER_STATE;
    @JsonProperty("STO_IMAGE")
    private String STO_IMAGE;
}
