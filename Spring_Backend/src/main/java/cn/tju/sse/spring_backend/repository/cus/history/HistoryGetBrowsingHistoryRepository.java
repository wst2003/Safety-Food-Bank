package cn.tju.sse.spring_backend.repository.cus.history;

import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryDTO;
import cn.tju.sse.spring_backend.model.BrowseEntity;
import cn.tju.sse.spring_backend.model.BrowseEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 查询浏览历史
 */
public interface HistoryGetBrowsingHistoryRepository extends JpaRepository<BrowseEntity, BrowseEntityPK> {


    /**
     * 查询浏览记录的详细信息
     * 在查询详细浏览记录时使用
     */
    @Query(value = "SELECT\n" +
            "\tCOM_ID,\n" +
            "\tCOM_NAME,\n" +
            "\tCOM_INTRODUCTION,\n" +
            "\tCOM_ORIPRICE,\n" +
            "\tCOM_EXPIRATIONDATE,\n" +
            "\tCOM_UPLOADDATE,\n" +
            "\tCOM_LEFT,\n" +
            "\tCOM_RATING,\n" +
            "\tSTO_ID,\n" +
            "\tSTO_NAME,\n" +
            "\tCOM_STATUS,\n" +
            "\tIMGS,\n" +
            "\tCATEGORIES,\n" +
            "\tPC_TIME,\n" +
            "\tPC_PRICE,\n" +
            "\tCUS_IDS,\n" +
            "\tBRO_TIME_END \n" +
            "FROM\n" +
            "\t(\n" +
            "\tSELECT\n" +
            "\t\tBROWSE.COM_ID,\n" +
            "\t\tCOM_NAME,\n" +
            "\t\tCOM_INTRODUCTION,\n" +
            "\t\tCOM_ORIPRICE,\n" +
            "\t\tCOM_EXPIRATIONDATE,\n" +
            "\t\tCOM_UPLOADDATE,\n" +
            "\t\tCOM_LEFT,\n" +
            "\t\tCOM_RATING,\n" +
            "\t\tCOMMODITY.STO_ID,\n" +
            "\t\tSTORE.STO_NAME,\n" +
            "\t\tCOM_STATUS,\n" +
            "\t\tGROUP_CONCAT( DISTINCT COM_IMAGE ORDER BY COM_IMAGE SEPARATOR ',' ) AS IMGS,\n" +
            "\t\tGROUP_CONCAT( DISTINCT COM_CATEGORY ORDER BY COM_CATEGORY SEPARATOR ',' ) AS CATEGORIES,\n" +
            "\t\tGROUP_CONCAT( DISTINCT COM_PC_TIME ORDER BY COM_PC_TIME SEPARATOR ',' ) AS PC_TIME,\n" +
            "\t\tGROUP_CONCAT( DISTINCT COM_PC_PRICE ORDER BY COM_PC_PRICE DESC SEPARATOR ',' ) AS PC_PRICE,\n" +
            "\t\tGROUP_CONCAT( DISTINCT FAVORITE.CUS_ID ORDER BY FAVORITE.CUS_ID SEPARATOR ',' ) AS CUS_IDS,\n" +
            "\t\tROW_NUMBER() OVER ( ORDER BY BRO_TIME_END DESC ) AS row_num,\n" +
            "\t\tBROWSE.BRO_TIME_END \n" +
            "\tFROM\n" +
            "\t\tBROWSE\n" +
            "\t\tLEFT JOIN COMMODITY ON BROWSE.COM_ID = COMMODITY.COM_ID\n" +
            "\t\tLEFT JOIN STORE ON COMMODITY.STO_ID = STORE.STO_ID\n" +
            "\t\tLEFT JOIN COMMODITY_CATEGORIES ON COMMODITY.COM_ID = COMMODITY_CATEGORIES.COM_ID\n" +
            "\t\tLEFT JOIN COMMODITY_IMAGE ON COMMODITY.COM_ID = COMMODITY_IMAGE.COM_ID\n" +
            "\t\tLEFT JOIN FAVORITE ON COMMODITY.COM_ID = FAVORITE.COM_ID\n" +
            "\t\tLEFT JOIN COMMODITY_PRICE_CURVE ON COMMODITY.COM_ID = COMMODITY_PRICE_CURVE.COM_ID \n" +
            "\tWHERE\n" +
            "\t\tBROWSE.BROWSER_ID = :cus_id \n" +
            "\t\tAND BROWSE.COM_ID = COMMODITY.COM_ID \n" +
            "\t\tAND COMMODITY.STO_ID = STORE.STO_ID \n" +
            "\t\tAND COMMODITY.COM_NAME LIKE CONCAT('%', :search_str, '%') \n" +
            "\tGROUP BY\n" +
            "\t\tBROWSE.COM_ID,\n" +
            "\t\tCOM_NAME,\n" +
            "\t\tCOM_INTRODUCTION,\n" +
            "\t\tCOM_ORIPRICE,\n" +
            "\t\tCOM_EXPIRATIONDATE,\n" +
            "\t\tCOM_UPLOADDATE,\n" +
            "\t\tCOM_LEFT,\n" +
            "\t\tCOM_RATING,\n" +
            "\t\tCOMMODITY.STO_ID,\n" +
            "\t\tSTORE.STO_NAME,\n" +
            "\t\tCOM_STATUS,\n" +
            "\t\tBROWSE.BRO_TIME_END \n" +
            "\t) AS sub_query \n" +
            "WHERE\n" +
            "\trow_num >= :begin_pos \n" +
            "\tAND row_num < :end_pos ", nativeQuery = true)
    public List<Object[]> findBrowseEntity(@Param("cus_id") int cus_id,
                                           @Param("begin_pos") int begin_pos,
                                           @Param("end_pos") int end_pos,
                                           @Param("search_str") String search_str);


    /**
     * 获取时间变化曲线的节点，按升序返回
     * 在查询浏览记录时使用
     * @param com_id-商品ID
     */
    @Query(value = "SELECT COM_PC_PRICE,COM_PC_TIME FROM COMMODITY_PRICE_CURVE WHERE COM_ID=:com_id ORDER BY COM_PC_TIME ASC", nativeQuery = true)
    public List<Object[]> findComCurveNode(int com_id);



}
