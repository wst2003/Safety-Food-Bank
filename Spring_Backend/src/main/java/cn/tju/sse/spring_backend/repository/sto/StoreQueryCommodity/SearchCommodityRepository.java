package cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.model.CommodityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 获取按条件搜索到的商品的接口
 */
public interface SearchCommodityRepository extends JpaRepository<CommodityEntity, Integer> {
    /**
     * 根据商品ID和上传日期模糊匹配查询符合条件的商品数量。
     *
     * @param comId       商品ID。
     * @param uploadDate  上传日期，格式为"yyyy-MM-dd"。
     * @return 符合条件的商品数量。
     */
    @Query(value = "SELECT COUNT(*) FROM COMMODITY WHERE COM_ID = :comId AND COM_UPLOADDATE LIKE STR_TO_DATE(:uploadDate,'%Y-%m-%d')", nativeQuery = true)
    int uploadDateLike(@Param("comId") int comId, @Param("uploadDate") String uploadDate);

    /**
     * 根据商品ID和过期日期模糊匹配查询符合条件的商品数量。
     *
     * @param comId          商品ID。
     * @param expirationDate 过期日期，格式为"yyyy-MM-dd"。
     * @return 符合条件的商品数量。
     */
    @Query(value = "SELECT COUNT(*) FROM COMMODITY WHERE COM_ID = :comId AND COM_EXPIRATIONDATE LIKE STR_TO_DATE(:expirationDate,'%Y-%m-%d')", nativeQuery = true)
    int expirationDateLike(@Param("comId") int comId, @Param("expirationDate") String expirationDate);

    /**
     * 根据商店ID、商品状态和查询关键字模糊匹配查询符合条件的商品ID列表，按照商品ID降序排序。
     *
     * @param stoId        商店ID。
     * @param comStatus    商品状态。
     * @param query        查询关键字。
     * @param beginNumber  查询起始位置。
     * @param pageSize     查询结果数量。
     * @return 符合条件的商品ID列表。
     */
    @Query(value = "SELECT COM_ID " +
            "FROM COMMODITY " +
            "WHERE STO_ID = :stoId AND COM_STATUS = :comStatus AND COM_NAME LIKE %:query% " +
            "ORDER BY COM_ID DESC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Integer> findComIdWithoutCategoryDesc(@Param("stoId") int stoId,
                                               @Param("comStatus") int comStatus,
                                               @Param("query") String query,
                                               @Param("beginNumber") int beginNumber,
                                               @Param("pageSize") int pageSize);

    /**
     * 根据商店ID、商品状态和查询关键字模糊匹配查询符合条件的商品ID列表，按照商品ID升序排序。
     *
     * @param stoId        商店ID。
     * @param comStatus    商品状态。
     * @param query        查询关键字。
     * @param beginNumber  查询起始位置。
     * @param pageSize     查询结果数量。
     * @return 符合条件的商品ID列表。
     */
    @Query(value = "SELECT COM_ID " +
            "FROM COMMODITY " +
            "WHERE STO_ID = :stoId AND COM_STATUS = :comStatus AND COM_NAME LIKE %:query% " +
            "ORDER BY COM_ID ASC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Integer> findComIdWithoutCategoryAsc(@Param("stoId") int stoId,
                                              @Param("comStatus") int comStatus,
                                              @Param("query") String query,
                                              @Param("beginNumber") int beginNumber,
                                              @Param("pageSize") int pageSize);

    /**
     * 根据商品分类、商店ID、商品状态和查询关键字模糊匹配查询符合条件的商品ID列表，按照商品ID降序排序。
     *
     * @param categories     商品分类列表。
     * @param categoryCount  商品分类数量。
     * @param stoId          商店ID。
     * @param comStatus      商品状态。
     * @param query          查询关键字。
     * @param beginNumber    查询起始位置。
     * @param pageSize       查询结果数量。
     * @return 符合条件的商品ID列表。
     */
    @Query(value = "WITH SPECIFIC_CATE_ID(COM_ID) AS (" +
            "    SELECT COM_ID " +
            "    FROM COMMODITY_CATEGORIES " +
            "    WHERE COM_CATEGORY IN :categories " +
            "    GROUP BY COM_ID " +
            "    HAVING COUNT(DISTINCT COM_CATEGORY) = :categoryCount " +
            ") " +
            "SELECT COM_ID " +
            "FROM COMMODITY " +
            "WHERE STO_ID = :stoId AND COM_STATUS = :comStatus " +
            "AND COM_ID IN (SELECT COM_ID FROM SPECIFIC_CATE_ID) " +
            "AND COM_NAME LIKE %:query% " +
            "ORDER BY COM_ID DESC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Integer> findComIdWithCategoryDesc(@Param("categories") List<String> categories,
                                            @Param("categoryCount") int categoryCount,
                                            @Param("stoId") int stoId,
                                            @Param("comStatus") int comStatus,
                                            @Param("query") String query,
                                            @Param("beginNumber") int beginNumber,
                                            @Param("pageSize") int pageSize);

    /**
     * 根据商品分类、商店ID、商品状态和查询关键字模糊匹配查询符合条件的商品ID列表，按照商品ID升序排序。
     *
     * @param categories     商品分类列表。
     * @param categoryCount  商品分类数量。
     * @param stoId          商店ID。
     * @param comStatus      商品状态。
     * @param query          查询关键字。
     * @param beginNumber    查询起始位置。
     * @param pageSize       查询结果数量。
     * @return 符合条件的商品ID列表。
     */
    @Query(value = "WITH SPECIFIC_CATE_ID(COM_ID) AS (" +
            "    SELECT COM_ID " +
            "    FROM COMMODITY_CATEGORIES " +
            "    WHERE COM_CATEGORY IN :categories " +
            "    GROUP BY COM_ID " +
            "    HAVING COUNT(DISTINCT COM_CATEGORY) = :categoryCount " +
            ") " +
            "SELECT COM_ID " +
            "FROM COMMODITY " +
            "WHERE STO_ID = :stoId AND COM_STATUS = :comStatus " +
            "AND COM_ID IN (SELECT COM_ID FROM SPECIFIC_CATE_ID) " +
            "AND COM_NAME LIKE %:query% " +
            "ORDER BY COM_ID ASC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Integer> findComIdWithCategoryAsc(@Param("categories") List<String> categories,
                                            @Param("categoryCount") int categoryCount,
                                            @Param("stoId") int stoId,
                                            @Param("comStatus") int comStatus,
                                            @Param("query") String query,
                                            @Param("beginNumber") int beginNumber,
                                            @Param("pageSize") int pageSize);

    /**
     * 根据商品ID查询商品实体。
     *
     * @param comId 商品ID。
     * @return 商品实体。
     */
    CommodityEntity findAllByComId(int comId);

    /**
     * 根据商品ID查询商品的分类列表。
     *
     * @param comId 商品ID。
     * @return 商品的分类列表。
     */
    @Query(value = "SELECT COM_CATEGORY FROM COMMODITY_CATEGORIES WHERE COM_ID = :comId", nativeQuery = true)
    List<String> findComCategory(@Param("comId") int comId);

    /**
     * 根据商品ID查询商品的价格曲线信息。
     *
     * @param comId 商品ID。
     * @return 商品的价格曲线信息。
     */
    @Query(value = "SELECT COM_PC_TIME, COM_PC_PRICE FROM COMMODITY_PRICE_CURVE WHERE COM_ID = :comId", nativeQuery = true)
    List<Object[]> findComPriceCurve(@Param("comId") int comId);

    /**
     * 根据商品ID查询商品的图片列表。
     *
     * @param comId 商品ID。
     * @return 商品的图片列表。
     */
    @Query(value = "SELECT COM_IMAGE FROM COMMODITY_IMAGE WHERE COM_ID = :comId", nativeQuery = true)
    List<String> findComImage(@Param("comId") int comId);
}
