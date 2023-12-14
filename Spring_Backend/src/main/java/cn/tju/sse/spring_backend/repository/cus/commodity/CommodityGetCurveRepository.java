package cn.tju.sse.spring_backend.repository.cus.commodity;

import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author raoji
 * @date 2023/12/13
 * @Description
 */
public interface CommodityGetCurveRepository extends JpaRepository<CommodityPriceCurveEntity, CommodityPriceCurveEntityPK> {
    List<CommodityPriceCurveEntity> findAllByComId(int id);
}
