package cn.tju.sse.spring_backend.repository.cus.commodity;

import cn.tju.sse.spring_backend.model.FavoriteEntity;
import cn.tju.sse.spring_backend.model.FavoriteEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author raoji
 * @date 2023/12/17
 * @Description
 */
public interface CommodityShoppingCartFavorateRepository extends JpaRepository<FavoriteEntity, FavoriteEntityPK> {
    List<FavoriteEntity> findAllByCusIdAndComId(int cus_id, int com_id);
}
