package cn.tju.sse.spring_backend.dto.cus.search;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
public class StoEleDTO {
    Integer sto_id;
    String sto_name;
    String sto_introduction;
    List<String> com_categories;
    String user_address;
    String sto_firstImage;
    Long ind_num;//前端不接收，用于排序
    String reg_time;//同上
}
