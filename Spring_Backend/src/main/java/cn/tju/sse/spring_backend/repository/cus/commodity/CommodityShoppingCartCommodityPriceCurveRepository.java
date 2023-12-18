package cn.tju.sse.spring_backend.repository.cus.commodity;

import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author raoji
 * @date 2023/12/17
 * @Description
 */
public interface CommodityShoppingCartCommodityPriceCurveRepository extends JpaRepository<CommodityPriceCurveEntity, Integer> {
    List<CommodityPriceCurveEntity> findAllByComId(int com_id);
}
