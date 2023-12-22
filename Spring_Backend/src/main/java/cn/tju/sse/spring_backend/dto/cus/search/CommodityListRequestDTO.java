package cn.tju.sse.spring_backend.dto.cus.search;

import jakarta.persistence.criteria.CriteriaBuilder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/**
 * @author lhx
 * @date 2023/12/22
 * @Description 用于搜索商品接口
 * sort_order取值：
 *  0 按照评分排序
 *  1 按照地理位置排序
 *  2 按照到期日期排序
 *  3 按照现价排序
 *  4 按照推荐算法排序
 */

@Setter
@Getter
public class CommodityListRequestDTO {
    Integer cus_id;
    String search_str;
    Integer sort_order;
    List<String> com_categories;
    Integer begin_pos;
    Integer end_pos;
}
