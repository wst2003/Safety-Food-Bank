package cn.tju.sse.spring_backend.repository.sto.upload;

import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 价格曲线
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/02 18:31
 */
public interface CommodityPriceCurveRepository extends JpaRepository<CommodityPriceCurveEntity, CommodityPriceCurveEntityPK> {

}
