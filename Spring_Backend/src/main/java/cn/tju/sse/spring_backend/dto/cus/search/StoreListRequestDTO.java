package cn.tju.sse.spring_backend.dto.cus.search;

import lombok.Getter;
import lombok.Setter;

import java.util.List;
/**
 * @author lhx
 * @date 2023/12/22
 * @Description 用于搜索商店接口
 * sort_order取值：
 *  0 按照订单数量
 *  1 按照地理位置排序
 *  2 按照开业时间排序
 */

@Getter
@Setter
public class StoreListRequestDTO {
    String search_str;
    List<String> com_categories;
    Integer begin_pos;
    Integer end_pos;
    Integer sort_order;
    Integer cus_id;
}
