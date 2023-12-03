package cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity;


import cn.tju.sse.spring_backend.model.CommodityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 获取商品详细信息的接口
 */
public interface CommodityDetailRepository extends JpaRepository<CommodityEntity, Integer> {
    /**
     * 根据商品ID查询商品实体对象。
     *
     * @param comId  商品ID。
     * @return       匹配的商品实体对象。
     */
    @Query(value = "SELECT * FROM COMMODITY WHERE COM_ID = :com_id", nativeQuery = true)
    CommodityEntity findCommodityEntityById(@Param("com_id") int comId);

    /**
     * 根据商品ID查询商品分类列表。
     *
     * @param comId  商品ID。
     * @return       匹配的商品分类列表。
     */
    @Query(value = "SELECT COM_CATEGORY FROM COMMODITY_CATEGORIES WHERE COM_ID = :com_id", nativeQuery = true)
    List<String> findCommodityCategoryById(@Param("com_id") int comId);

    /**
     * 根据商品ID查询商品图片列表。
     *
     * @param comId  商品ID。
     * @return       匹配的商品图片列表。
     */
    @Query(value = "SELECT COM_IMAGE FROM COMMODITY_IMAGE WHERE COM_ID = :com_id", nativeQuery = true)
    List<String> findCommodityImageById(@Param("com_id") int comId);

    /**
     * 根据商品ID查询商品价格曲线列表。
     *
     * @param comId  商品ID。
     * @return       匹配的商品价格曲线列表。
     */
    @Query(value = "SELECT COM_PC_TIME, COM_PC_PRICE FROM COMMODITY_PRICE_CURVE WHERE COM_ID = :com_id", nativeQuery = true)
    List<Object[]> findCommodityPriceCurveById(@Param("com_id") int comId);
}
