package cn.tju.sse.spring_backend.repository.cus.search;

import cn.tju.sse.spring_backend.model.CommodityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SearchItemRepository extends JpaRepository<CommodityEntity,Integer> {

    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 用于搜索商品，带category筛选
     */
    @Query(value=" WITH FAVOR_COM_ID AS ("  +
            "SELECT COM_ID AS SUB_ID " +
            "FROM COMMODITY_CATEGORIES " +
            "WHERE COM_CATEGORY IN ( :sqlArray ) " +
            "GROUP BY COM_ID ) "+
            "   SELECT DISTINCT" +
            "   COMMODITY.COM_ID," +
            "   COMMODITY.COM_NAME," +
            "   COMMODITY.COM_INTRODUCTION," +
            "   COMMODITY.COM_ORIPRICE," +
            "   COMMODITY.COM_EXPIRATIONDATE," +
            "   COMMODITY.COM_UPLOADDATE," +
            "   COMMODITY.COM_LEFT," +
            "   COMMODITY.COM_RATING," +
            "   COMMODITY.STO_ID," +
            "   STORE.STO_NAME," +
            "   COMMODITY.COM_STATUS," +
            "   GROUP_CONCAT(COM_IMAGE ORDER BY COM_IMAGE SEPARATOR ',') AS IMGS,"+
            "   GROUP_CONCAT(COM_CATEGORY ORDER BY COM_CATEGORY SEPARATOR ',') AS CATEGORIES"+
            "   FROM COMMODITY" +
            "   JOIN STORE ON COMMODITY.STO_ID = STORE.STO_ID" +
            "   JOIN COMMODITY_CATEGORIES  ON COMMODITY.COM_ID = COMMODITY_CATEGORIES.COM_ID" +
            "   JOIN COMMODITY_IMAGE  ON COMMODITY.COM_ID = COMMODITY_IMAGE.COM_ID" +
            "  WHERE " +
            "   COMMODITY.COM_NAME LIKE CONCAT ('%',:search_str,'%') "+
            "  AND COMMODITY.COM_STATUS != -1 " +
            "  AND COMMODITY.COM_ID IN(SELECT SUB_ID FROM FAVOR_COM_ID) " +
            "   GROUP BY " +
            "   COMMODITY.COM_ID," +
            "   COMMODITY.COM_NAME," +
            "   COMMODITY.COM_INTRODUCTION," +
            "   COMMODITY.COM_ORIPRICE," +
            "   COMMODITY.COM_EXPIRATIONDATE," +
            "   COMMODITY.COM_UPLOADDATE," +
            "   COMMODITY.COM_LEFT," +
            "   COMMODITY.COM_RATING," +
            "   COMMODITY.STO_ID," +
            "   STORE.STO_NAME," +
            "   COMMODITY.COM_STATUS",

    nativeQuery = true)
    public List<Object[]> queryForCategoriedCommodityList(@Param("sqlArray") List<String> categories_string,
                                                @Param("search_str") String search_str);

    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 用于搜索商品，不带category筛选
     */
    @Query(value=
            "   SELECT DISTINCT" +
            "   COMMODITY.COM_ID," +
            "   COMMODITY.COM_NAME," +
            "   COMMODITY.COM_INTRODUCTION," +
            "   COMMODITY.COM_ORIPRICE," +
            "   COMMODITY.COM_EXPIRATIONDATE," +
            "   COMMODITY.COM_UPLOADDATE," +
            "   COMMODITY.COM_LEFT," +
            "   COMMODITY.COM_RATING," +
            "   COMMODITY.STO_ID," +
            "   STORE.STO_NAME," +
            "   COMMODITY.COM_STATUS," +
            "   GROUP_CONCAT(COM_IMAGE ORDER BY COM_IMAGE SEPARATOR ',') AS IMGS,"+
            "   GROUP_CONCAT(COM_CATEGORY ORDER BY COM_CATEGORY SEPARATOR ',') AS CATEGORIES "+
            "   FROM COMMODITY" +
            "   JOIN STORE ON COMMODITY.STO_ID = STORE.STO_ID" +
            "   JOIN COMMODITY_CATEGORIES  ON COMMODITY.COM_ID = COMMODITY_CATEGORIES.COM_ID" +
            "   JOIN COMMODITY_IMAGE  ON COMMODITY.COM_ID = COMMODITY_IMAGE.COM_ID" +
            "  WHERE " +
            "   COMMODITY.COM_NAME LIKE CONCAT ('%',:search_str,'%') AND"+
            "   COMMODITY.COM_STATUS != -1 " +
            "   GROUP BY " +
            "   COMMODITY.COM_ID," +
            "   COMMODITY.COM_NAME," +
            "   COMMODITY.COM_INTRODUCTION," +
            "   COMMODITY.COM_ORIPRICE," +
            "   COMMODITY.COM_EXPIRATIONDATE," +
            "   COMMODITY.COM_UPLOADDATE," +
            "   COMMODITY.COM_LEFT," +
            "   COMMODITY.COM_RATING," +
            "   COMMODITY.STO_ID," +
            "   STORE.STO_NAME," +
            "   COMMODITY.COM_STATUS",

            nativeQuery = true)
    public List<Object[]> queryForCommodityList(@Param("search_str") String search_str);


    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 搜索商家，带category筛选
     */
    @Query(value=" WITH STORE_INDENT_NUM AS (" +
            "    SELECT STORE.STO_ID AS STO_ID, COUNT(IND_ID) AS IND_NUM" +
            "    FROM STORE, COMMODITY, INDENT" +
            "    WHERE COMMODITY.sto_id = STORE.sto_id AND COMMODITY.com_id = INDENT.com_id" +
            "    GROUP BY STORE.STO_ID" +
            "), FAVOR_STO_ID AS (" +
            " SELECT STORE_CATEGORIES.STORE_ID AS SUB_ID" +
            " FROM STORE_CATEGORIES" +
            " WHERE COM_CATEGORY IN (:sqlArray) " +
            " GROUP BY STORE_CATEGORIES.STORE_ID" +
            ") " +
            "SELECT" +
            "    STORE.STO_ID," +
            "    STORE.STO_NAME," +
            "    STORE.STO_INTRODUCTION," +
            "    USERS.USER_ADDRESS," +
            "    USERS.USER_REGTIME," +
            "    STORE_INDENT_NUM.IND_NUM," +
            "   GROUP_CONCAT(STO_IMAGE ORDER BY STO_IMAGE SEPARATOR ',') AS IMGS, " +
            "   GROUP_CONCAT(COM_CATEGORY ORDER BY COM_CATEGORY SEPARATOR ',') AS CATEGORIES " +
            "FROM " +
            "    STORE " +
            "JOIN USERS ON STORE.STO_ID = USERS.USER_ID " +
            "JOIN STOREIMAGE ON STOREIMAGE.STO_ID = STORE.STO_ID " +
            "LEFT JOIN STORE_CATEGORIES ON STORE.STO_ID = STORE_CATEGORIES.STORE_ID " +
            "LEFT JOIN STORE_INDENT_NUM ON STORE.STO_ID = STORE_INDENT_NUM.STO_ID " +
            "WHERE " +
            "    STORE.STO_NAME LIKE CONCAT('%',:search_str,'%') " +
            "    AND STORE.STO_ID IN (SELECT SUB_ID FROM FAVOR_STO_ID)" +
            "GROUP BY " +
            "    STORE.STO_ID, " +
            "    STORE.STO_NAME, " +
            "    STORE.STO_INTRODUCTION, " +
            "    USERS.USER_ADDRESS," +
            "    USERS.USER_REGTIME," +
            "    STORE_INDENT_NUM.IND_NUM" ,
    nativeQuery = true)
    public List<Object[]> queryForCategoriedStoreList(@Param("sqlArray") List<String> categories_string,
                                                          @Param("search_str") String search_str);


    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 搜索商家，不带category筛选
     */
    @Query(value=" WITH STORE_INDENT_NUM AS (" +
            "    SELECT STORE.STO_ID AS STO_ID, COUNT(IND_ID) AS IND_NUM" +
            "    FROM STORE, COMMODITY, INDENT" +
            "    WHERE COMMODITY.sto_id = STORE.sto_id AND COMMODITY.com_id = INDENT.com_id" +
            "    GROUP BY STORE.STO_ID" +
            ") " +
            "SELECT" +
            "    STORE.STO_ID," +
            "    STORE.STO_NAME," +
            "    STORE.STO_INTRODUCTION," +
            "    USERS.USER_ADDRESS," +
            "    USERS.USER_REGTIME," +
            "    STORE_INDENT_NUM.IND_NUM," +
            "   GROUP_CONCAT(STO_IMAGE ORDER BY STO_IMAGE SEPARATOR ',') AS IMGS, " +
            "   GROUP_CONCAT(COM_CATEGORY ORDER BY COM_CATEGORY SEPARATOR ',') AS CATEGORIES " +
            "FROM " +
            "    STORE " +
            "JOIN USERS ON STORE.STO_ID = USERS.USER_ID " +
            "JOIN STOREIMAGE ON STOREIMAGE.STO_ID = STORE.STO_ID " +
            "LEFT JOIN STORE_CATEGORIES ON STORE.STO_ID = STORE_CATEGORIES.STORE_ID " +
            "LEFT JOIN STORE_INDENT_NUM ON STORE.STO_ID = STORE_INDENT_NUM.STO_ID " +
            "WHERE " +
            "    STORE.STO_NAME LIKE CONCAT('%',:search_str,'%') " +
            "GROUP BY " +
            "    STORE.STO_ID, " +
            "    STORE.STO_NAME, " +
            "    STORE.STO_INTRODUCTION, " +
            "    USERS.USER_ADDRESS," +
            "    USERS.USER_REGTIME," +
            "    STORE_INDENT_NUM.IND_NUM" ,
            nativeQuery = true)
    public List<Object[]> queryForStoreList(@Param("search_str") String search_str);
    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 检查商品是否被收藏
     */
    @Query(value="SELECT COM_ID,CUS_ID FROM FAVORITE WHERE COM_ID= :com_id AND CUS_ID= :cus_id",
    nativeQuery = true)
    public List<Object[]> checkFavorite(@Param("cus_id")Integer cus_id,@Param("com_id")Integer com_id);




}
