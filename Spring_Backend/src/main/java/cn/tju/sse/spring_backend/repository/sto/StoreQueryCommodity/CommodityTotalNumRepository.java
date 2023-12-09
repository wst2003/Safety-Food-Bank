package cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.model.CommodityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CommodityTotalNumRepository extends JpaRepository<CommodityEntity, Integer> {
    int countByStoIdAndComStatus(int stoId, int comStatus);
}
