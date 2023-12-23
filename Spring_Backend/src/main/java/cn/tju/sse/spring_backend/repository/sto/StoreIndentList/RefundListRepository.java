package cn.tju.sse.spring_backend.repository.sto.StoreIndentList;

import cn.tju.sse.spring_backend.model.IndentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 退款列表数据访问接口
 */
public interface RefundListRepository extends JpaRepository<IndentEntity, Integer> {
    /**
     * 按创建时间升序检索退款列表。
     *
     * @param stoId        店铺ID
     * @param userPhone    用户手机号
     * @param beginNumber  结果集的起始索引
     * @param pageSize     返回结果的最大数量
     * @return 退款列表，以Object数组形式返回
     */
    @Query(value = "WITH COMMODITY_WITH_IMAGE AS (" +
            "   SELECT COMMODITY.*, ci.COM_IMAGE " +
            "   FROM COMMODITY " +
            "   JOIN (SELECT COM_ID, MAX(COM_IMAGE) AS COM_IMAGE FROM COMMODITY_IMAGE GROUP BY COM_ID) ci ON COMMODITY.COM_ID = ci.COM_ID " +
            ") " +
            "SELECT INDENT.IND_ID, INDENT.IND_QUANTITY, INDENT.COM_ID, INDENT.CUS_ID, " +
            "       COMMODITY_WITH_IMAGE.COM_NAME, COMMODITY_WITH_IMAGE.COM_IMAGE, INDENT.IND_MONEY, " +
            "       INDENT.IND_RMONEY, INDENT.IND_CREATIONTIME, INDENT.IND_RTIME, IND_RNOTES " +
            "FROM INDENT " +
            "JOIN COMMODITY_WITH_IMAGE ON INDENT.COM_ID = COMMODITY_WITH_IMAGE.COM_ID " +
            "JOIN USERS ON INDENT.CUS_ID = USERS.USER_ID " +
            "WHERE STO_ID = :stoId AND IND_STATE = 2 AND USERS.USER_PHONE like :userPhone " +
            "ORDER BY INDENT.IND_CREATIONTIME ASC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getRefundListAsc(@Param("stoId") int stoId, @Param("userPhone") String userPhone,
                                    @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按创建时间降序检索退款列表。
     *
     * @param stoId        店铺ID
     * @param userPhone    用户手机号
     * @param beginNumber  结果集的起始索引
     * @param pageSize     返回结果的最大数量
     * @return 退款列表，以Object数组形式返回
     */
    @Query(value = "WITH COMMODITY_WITH_IMAGE AS (" +
            "   SELECT COMMODITY.*, ci.COM_IMAGE " +
            "   FROM COMMODITY " +
            "   JOIN (SELECT COM_ID, MAX(COM_IMAGE) AS COM_IMAGE FROM COMMODITY_IMAGE GROUP BY COM_ID) ci ON COMMODITY.COM_ID = ci.COM_ID " +
            ") " +
            "SELECT INDENT.IND_ID, INDENT.IND_QUANTITY, INDENT.COM_ID, INDENT.CUS_ID, " +
            "       COMMODITY_WITH_IMAGE.COM_NAME, COMMODITY_WITH_IMAGE.COM_IMAGE, INDENT.IND_MONEY, " +
            "       INDENT.IND_RMONEY, INDENT.IND_CREATIONTIME, INDENT.IND_RTIME, IND_RNOTES " +
            "FROM INDENT " +
            "JOIN COMMODITY_WITH_IMAGE ON INDENT.COM_ID = COMMODITY_WITH_IMAGE.COM_ID " +
            "JOIN USERS ON INDENT.CUS_ID = USERS.USER_ID " +
            "WHERE STO_ID = :stoId AND IND_STATE = 2 AND USERS.USER_PHONE like :userPhone " +
            "ORDER BY INDENT.IND_CREATIONTIME DESC " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getRefundListDesc(@Param("stoId") int stoId, @Param("userPhone") String userPhone,
                                    @Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);
}
