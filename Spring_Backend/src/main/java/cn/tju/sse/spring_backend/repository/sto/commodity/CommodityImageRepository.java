package cn.tju.sse.spring_backend.repository.sto.commodity;

import cn.tju.sse.spring_backend.model.CommodityImageEntity;
import cn.tju.sse.spring_backend.model.CommodityImageEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.ArrayList;

/**
 * 商品图片
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/02 18:36
 */
public interface CommodityImageRepository extends JpaRepository<CommodityImageEntity, CommodityImageEntityPK> {
    ArrayList<CommodityImageEntity> findCommodityImageEntitiesByComId(int COM_ID);
    int deleteCommodityImageEntityByComIdAndComImage(int COM_ID,String COM_IMAGE);
}
