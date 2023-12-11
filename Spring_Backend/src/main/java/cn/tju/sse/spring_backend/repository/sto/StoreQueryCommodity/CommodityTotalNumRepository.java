package cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.model.CommodityEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 获取某状态商品总数的接口
 */
public interface CommodityTotalNumRepository extends JpaRepository<CommodityEntity, Integer> {
    /**
     * 根据商店ID和商品状态统计商品总数量。
     *
     * @param stoId     商店ID。
     * @param comStatus 商品状态。
     * @return 商品总数量。
     */
    int countByStoIdAndComStatus(int stoId, int comStatus);
}
