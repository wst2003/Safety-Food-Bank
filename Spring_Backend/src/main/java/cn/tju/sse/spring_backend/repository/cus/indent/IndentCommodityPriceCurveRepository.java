package cn.tju.sse.spring_backend.repository.cus.indent;

import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface IndentCommodityPriceCurveRepository extends JpaRepository<CommodityPriceCurveEntity, CommodityPriceCurveEntityPK> {


    List<CommodityPriceCurveEntity> getCommodityPriceCurveEntitiesByComId(Integer com_id);

}
