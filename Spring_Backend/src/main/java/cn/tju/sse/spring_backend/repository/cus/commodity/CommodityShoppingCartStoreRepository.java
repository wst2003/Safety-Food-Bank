package cn.tju.sse.spring_backend.repository.cus.commodity;

import cn.tju.sse.spring_backend.model.StoreEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @author raoji
 * @date 2023/12/17
 * @Description
 */
public interface CommodityShoppingCartStoreRepository extends JpaRepository<StoreEntity, Integer> {
}
