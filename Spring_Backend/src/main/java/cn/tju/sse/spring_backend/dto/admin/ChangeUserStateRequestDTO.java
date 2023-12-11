package cn.tju.sse.spring_backend.dto.admin;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * 修改用户状态的数据传输对象（DTO）
 */
@Getter
@Setter
public class ChangeUserStateRequestDTO {
    @JsonProperty("USER_ID")
    private int USER_ID;
    @JsonProperty("USER_TYPE")
    private int USER_TYPE;
    @JsonProperty("TO_STATE")
    private int TO_STATE;
}
