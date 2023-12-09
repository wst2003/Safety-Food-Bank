package cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.model.CommodityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.sql.Date;
import java.util.List;

public interface SearchCommodityRepository extends JpaRepository<CommodityEntity, Integer> {
    @Query(value = "SELECT COUNT(*) FROM COMMODITY WHERE COM_ID = :comId AND COM_UPLOADDATE LIKE STR_TO_DATE(:uploadDate,'%Y-%m-%d')", nativeQuery = true)
    int uploadDateLike(@Param("comId") int comId, @Param("uploadDate") String uploadDate);

    @Query(value = "SELECT COUNT(*) FROM COMMODITY WHERE COM_ID = :comId AND COM_EXPIRATIONDATE LIKE STR_TO_DATE(:expirationDate,'%Y-%m-%d')", nativeQuery = true)
    int expirationDateLike(@Param("comId") int comId, @Param("expirationDate") String expirationDate);

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

    CommodityEntity findAllByComId(int comId);

    @Query(value = "SELECT COM_CATEGORY FROM COMMODITY_CATEGORIES WHERE COM_ID = :comId", nativeQuery = true)
    List<String> findComCategory(@Param("comId") int comId);

    @Query(value = "SELECT COM_PC_TIME, COM_PC_PRICE FROM COMMODITY_PRICE_CURVE WHERE COM_ID = :comId", nativeQuery = true)
    List<Object[]> findComPriceCurve(@Param("comId") int comId);

    @Query(value = "SELECT COM_IMAGE FROM COMMODITY_IMAGE WHERE COM_ID = :comId", nativeQuery = true)
    List<String> findComImage(@Param("comId") int comId);
}
