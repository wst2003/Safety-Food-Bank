package cn.tju.sse.spring_backend.repository.cus.commodity;

import cn.tju.sse.spring_backend.model.CommodityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;

import java.util.List;

public interface CommodityGetDetailRepository extends JpaRepository<CommodityEntity,Integer> {


    /**
     * 整合基本商品信息、类别、图片和价格曲线:
     * @param com_id
     * @return
     */
    @Query(value = "SELECT\n" +
            "  c.COM_ID, c.COM_NAME, c.COM_INTRODUCTION, c.COM_ORIPRICE, c.COM_EXPIRATIONDATE, c.COM_UPLOADDATE, c.COM_LEFT, c.COM_RATING, c.STO_ID, s.STO_NAME, c.COM_STATUS,\n" +
            "  GROUP_CONCAT(DISTINCT cc.COM_CATEGORY) AS Categories,\n" +
            "  GROUP_CONCAT(DISTINCT ci.COM_IMAGE) AS Images,\n" +
            "  pc.COM_PC_TIME, pc.COM_PC_PRICE\n" +
            "FROM COMMODITY c\n" +
            "JOIN STORE s ON c.STO_ID = s.STO_ID\n" +
            "LEFT JOIN COMMODITY_CATEGORIES cc ON c.COM_ID = cc.COM_ID\n" +
            "LEFT JOIN COMMODITY_IMAGE ci ON c.COM_ID = ci.COM_ID\n" +
            "LEFT JOIN COMMODITY_PRICE_CURVE pc ON c.COM_ID = pc.COM_ID\n" +
            "WHERE c.COM_ID = :com_id\n" +
            "GROUP BY c.COM_ID, pc.COM_PC_TIME, pc.COM_PC_PRICE\n" +
            "ORDER BY pc.COM_PC_TIME ASC",nativeQuery = true)
    public List<Object[]> getCommodityDetail(@Param("com_id") int com_id);


    /**
     *根据商品ID和用户ID返回是否收藏
     * @param com_id-商品ID
     * @param cus_id-用户ID
     */
    @Query(value = "SELECT COUNT(*) > 0 AS IsFavorited\n" +
            "FROM FAVORITE\n" +
            "WHERE COM_ID = :com_id AND CUS_ID =:cus_id ",nativeQuery = true)
    public Object getCommodityFavoriteDetail(@Param("com_id") int com_id,@Param("cus_id") int cus_id);


    /**
     * 获取评论集合
     * @param com_id-商品ID
     * @return
     */
    @Query(value = "SELECT\n" +
            "  cc.*, u.USER_TYPE,\n" +
            "  CASE WHEN u.USER_TYPE = 0 THEN cu.CUS_NICKNAME WHEN u.USER_TYPE = 1 THEN s.STO_NAME ELSE 'Unknown' END AS CommenterName\n" +
            "FROM COMMODITY_COMMENT cc\n" +
            "JOIN USERS u ON cc.USER_ID = u.USER_ID\n" +
            "LEFT JOIN CUSTOMER cu ON u.USER_ID = cu.CUS_ID\n" +
            "LEFT JOIN STORE s ON u.USER_ID = s.STO_ID\n" +
            "WHERE cc.COM_ID = :com_id",nativeQuery = true)
    public List<Object[]> getCommodityCommentDetail(@Param("com_id") int com_id);


    /**
     * 获取购买次数
     * @param com_id-商品ID
     * @param cus_id-顾客ID
     * @return
     */
    @Query(value = "SELECT COUNT(*) FROM INDENT i WHERE i.COM_ID = :com_id AND i.CUS_ID = :cus_id",nativeQuery = true)
    Integer getBuyTimes(@Param("com_id") int com_id,@Param("cus_id") int cus_id);

}
