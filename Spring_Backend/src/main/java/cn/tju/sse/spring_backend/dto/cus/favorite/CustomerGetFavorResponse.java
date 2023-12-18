package cn.tju.sse.spring_backend.dto.cus.favorite;


import cn.tju.sse.spring_backend.service.cus.favorite.CustomerGetFavorService;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

/*
返回收藏夹信息的响应
 */
@Getter
@Setter
public class CustomerGetFavorResponse {
    private List<CustomerGetFavorService.FavorPageContent> favor_list;
}
