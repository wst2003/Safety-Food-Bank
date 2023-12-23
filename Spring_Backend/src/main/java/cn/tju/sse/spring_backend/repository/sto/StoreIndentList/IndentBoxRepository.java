package cn.tju.sse.spring_backend.repository.sto.StoreIndentList;

import cn.tju.sse.spring_backend.model.IndentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 订单列表数据访问接口
 */
public interface IndentBoxRepository extends JpaRepository<IndentEntity, Integer> {
    /**
     * 按升序获取带有分组信息的订单数据。
     *
     * @param stoId          商店ID
     * @param userPhone      用户手机号码
     * @param indState       订单状态
     * @param indStateOrigin 订单状态来源
     * @param boxBegin       分组编号起始值
     * @param boxEnd         分组编号结束值
     * @return 包含订单数据的对象数组列表
     */
    @Query(value = "WITH COMMODITY_WITH_IMAGE AS (" +
            "    SELECT COMMODITY.*, ci.COM_IMAGE " +
            "    FROM COMMODITY " +
            "    JOIN ( " +
            "        SELECT COM_ID, MAX(COM_IMAGE) AS COM_IMAGE " +
            "        FROM COMMODITY_IMAGE " +
            "        GROUP BY COM_ID " +
            "    ) ci ON COMMODITY.COM_ID = ci.COM_ID " +
            "), " +
            "NUMBERED_RESULTS AS (" +
            "    SELECT " +
            "        A.*, " +
            "        CASE " +
            "            WHEN LAG(IND_VERIFICATIONCODE) OVER (ORDER BY IND_CREATIONTIME DESC, IND_VERIFICATIONCODE) = IND_VERIFICATIONCODE THEN 0 " +
            "            ELSE 1 " +
            "        END AS IS_NEW_GROUP " +
            "    FROM ( " +
            "        SELECT " +
            "            INDENT.IND_ID, INDENT.COM_ID, INDENT.IND_QUANTITY, INDENT.IND_MONEY, COMMODITY_WITH_IMAGE.COM_NAME, INDENT.IND_VERIFICATIONCODE, " +
            "            COMMODITY_WITH_IMAGE.COM_IMAGE, INDENT.IND_NOTES, INDENT.IND_RATING, INDENT.CUS_ID, INDENT.IND_CREATIONTIME, USERS.USER_PHONE, CUSTOMER.CUS_NICKNAME " +
            "        FROM INDENT " +
            "        JOIN COMMODITY_WITH_IMAGE ON INDENT.COM_ID = COMMODITY_WITH_IMAGE.COM_ID " +
            "        JOIN CUSTOMER ON INDENT.CUS_ID = CUSTOMER.CUS_ID " +
            "        JOIN USERS ON INDENT.CUS_ID = USERS.USER_ID " +
            "        WHERE COMMODITY_WITH_IMAGE.STO_ID = :stoId " +
            "            AND USERS.USER_PHONE LIKE :userPhone " +
            "            AND INDENT.IND_STATE = :indState " +
            "            AND ((:indStateOrigin = -1 AND COMMODITY_WITH_IMAGE.COM_STATUS = -1) OR (:indStateOrigin = 0 AND COMMODITY_WITH_IMAGE.COM_STATUS != -1) OR :indStateOrigin = 1) " +
            "        ORDER BY INDENT.IND_CREATIONTIME ASC, INDENT.IND_VERIFICATIONCODE " +
            "    ) A " +
            "), " +
            "GROUPED_RESULTS AS (" +
            "    SELECT " +
            "        IND_ID, COM_ID, IND_QUANTITY, IND_MONEY, COM_NAME, IND_VERIFICATIONCODE, " +
            "        COM_IMAGE, IND_NOTES, IND_RATING, CUS_ID, IND_CREATIONTIME, USER_PHONE, CUS_NICKNAME, " +
            "        SUM(IS_NEW_GROUP) OVER (ORDER BY IND_CREATIONTIME ASC, IND_VERIFICATIONCODE) AS GROUP_NUMBER " +
            "    FROM NUMBERED_RESULTS " +
            "    ORDER BY IND_CREATIONTIME ASC, IND_VERIFICATIONCODE, IND_ID " +
            ") " +
            "SELECT * " +
            "FROM GROUPED_RESULTS " +
            "WHERE GROUP_NUMBER BETWEEN :boxBegin AND :boxEnd",
            nativeQuery = true)
    List<Object[]> getIndentWithBoxAsc(@Param("stoId") int stoId, @Param("userPhone") String userPhone,
                                       @Param("indState") int indState, @Param("indStateOrigin") int indStateOrigin,
                                       @Param("boxBegin") int boxBegin, @Param("boxEnd") int boxEnd);

    /**
     * 按升序获取带有分组信息的订单数据。
     *
     * @param stoId          商店ID
     * @param userPhone      用户手机号码
     * @param indState       订单状态
     * @param indStateOrigin 订单状态来源
     * @param boxBegin       分组编号起始值
     * @param boxEnd         分组编号结束值
     * @return 包含订单数据的对象数组列表
     */
    @Query(value = "WITH COMMODITY_WITH_IMAGE AS (" +
            "    SELECT COMMODITY.*, ci.COM_IMAGE " +
            "    FROM COMMODITY " +
            "    JOIN ( " +
            "        SELECT COM_ID, MAX(COM_IMAGE) AS COM_IMAGE " +
            "        FROM COMMODITY_IMAGE " +
            "        GROUP BY COM_ID " +
            "    ) ci ON COMMODITY.COM_ID = ci.COM_ID " +
            "), " +
            "NUMBERED_RESULTS AS (" +
            "    SELECT " +
            "        A.*, " +
            "        CASE " +
            "            WHEN LAG(IND_VERIFICATIONCODE) OVER (ORDER BY IND_CREATIONTIME DESC, IND_VERIFICATIONCODE) = IND_VERIFICATIONCODE THEN 0 " +
            "            ELSE 1 " +
            "        END AS IS_NEW_GROUP " +
            "    FROM ( " +
            "        SELECT " +
            "            INDENT.IND_ID, INDENT.COM_ID, INDENT.IND_QUANTITY, INDENT.IND_MONEY, COMMODITY_WITH_IMAGE.COM_NAME, INDENT.IND_VERIFICATIONCODE, " +
            "            COMMODITY_WITH_IMAGE.COM_IMAGE, INDENT.IND_NOTES, INDENT.IND_RATING, INDENT.CUS_ID, INDENT.IND_CREATIONTIME, USERS.USER_PHONE, CUSTOMER.CUS_NICKNAME " +
            "        FROM INDENT " +
            "        JOIN COMMODITY_WITH_IMAGE ON INDENT.COM_ID = COMMODITY_WITH_IMAGE.COM_ID " +
            "        JOIN CUSTOMER ON INDENT.CUS_ID = CUSTOMER.CUS_ID " +
            "        JOIN USERS ON INDENT.CUS_ID = USERS.USER_ID " +
            "        WHERE COMMODITY_WITH_IMAGE.STO_ID = :stoId " +
            "            AND USERS.USER_PHONE LIKE :userPhone " +
            "            AND INDENT.IND_STATE = :indState " +
            "            AND ((:indStateOrigin = -1 AND COMMODITY_WITH_IMAGE.COM_STATUS = -1) OR (:indStateOrigin = 0 AND COMMODITY_WITH_IMAGE.COM_STATUS != -1) OR :indStateOrigin = 1) " +
            "        ORDER BY INDENT.IND_CREATIONTIME DESC, INDENT.IND_VERIFICATIONCODE " +
            "    ) A " +
            "), " +
            "GROUPED_RESULTS AS (" +
            "    SELECT " +
            "        IND_ID, COM_ID, IND_QUANTITY, IND_MONEY, COM_NAME, IND_VERIFICATIONCODE, " +
            "        COM_IMAGE, IND_NOTES, IND_RATING, CUS_ID, IND_CREATIONTIME, USER_PHONE, CUS_NICKNAME, " +
            "        SUM(IS_NEW_GROUP) OVER (ORDER BY IND_CREATIONTIME DESC, IND_VERIFICATIONCODE) AS GROUP_NUMBER " +
            "    FROM NUMBERED_RESULTS " +
            "    ORDER BY IND_CREATIONTIME DESC, IND_VERIFICATIONCODE, IND_ID " +
            ") " +
            "SELECT * " +
            "FROM GROUPED_RESULTS " +
            "WHERE GROUP_NUMBER BETWEEN :boxBegin AND :boxEnd",
            nativeQuery = true)
    List<Object[]> getIndentWithBoxDesc(@Param("stoId") int stoId, @Param("userPhone") String userPhone,
                                        @Param("indState") int indState, @Param("indStateOrigin") int indStateOrigin,
                                        @Param("boxBegin") int boxBegin, @Param("boxEnd") int boxEnd);
}
