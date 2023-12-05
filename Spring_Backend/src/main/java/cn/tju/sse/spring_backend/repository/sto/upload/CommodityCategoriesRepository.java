package cn.tju.sse.spring_backend.repository.sto.upload;

import cn.tju.sse.spring_backend.model.CommodityCategoriesEntity;
import cn.tju.sse.spring_backend.model.CommodityCategoriesEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 商品类别
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/02 18:34
 */
public interface CommodityCategoriesRepository extends JpaRepository<CommodityCategoriesEntity, CommodityCategoriesEntityPK> {

}
