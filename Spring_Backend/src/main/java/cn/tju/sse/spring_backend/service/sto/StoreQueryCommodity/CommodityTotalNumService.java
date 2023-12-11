package cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity.CommodityTotalNumRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 获取商品数量的服务类
 */
@Service
public class CommodityTotalNumService {
    @Autowired
    private CommodityTotalNumRepository commodityTotalNumRepository;

    /**
     * 获取商店中指定状态的商品总数量。
     *
     * @param stoId     商店ID。
     * @param comStatus 商品状态。
     * @return 商店中指定状态的商品总数量。
     */

    public int getCommodityTotalNum(int stoId, int comStatus) {
        return commodityTotalNumRepository.countByStoIdAndComStatus(stoId, comStatus);
    }
}
