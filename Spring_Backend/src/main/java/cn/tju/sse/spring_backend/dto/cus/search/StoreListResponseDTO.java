package cn.tju.sse.spring_backend.dto.cus.search;


import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * @author lhx
 * @date 2023/12/22
 * @Description 用于搜索商店接口
 */
@Setter
@Getter
public class StoreListResponseDTO {
    Integer total;
    List<StoDTO> sto_list;

    @Setter
    @Getter
    public static class StoDTO {
        Integer sto_id;
        String sto_name;
        String sto_introduction;
        List<String> com_categories;
        String user_address;
        String sto_firstImage;


    }
}
