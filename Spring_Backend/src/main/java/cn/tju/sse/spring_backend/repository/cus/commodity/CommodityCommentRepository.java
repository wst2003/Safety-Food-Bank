package cn.tju.sse.spring_backend.repository.cus.commodity;

import cn.tju.sse.spring_backend.model.CommodityCommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;

public interface CommodityCommentRepository extends JpaRepository<CommodityCommentEntity,Integer> {
    // 这里利用JPA提供的save方法进行数据插入，无需自定义


    /**
     * 查找用户type
     * @param user_id-用户id
     * @return
     */
    @Query(value = "SELECT USER_TYPE FROM USERS WHERE USER_ID =:user_id ",nativeQuery = true)
    public Integer findUserType(@Param("user_id") int user_id);


    /**
     * 查找购买次数
     * @param cus_id-用户ID
     * @param com_id-商品ID
     * @return
     */
    @Query(value = "SELECT COUNT(*) FROM INDENT WHERE COM_ID = :com_id AND CUS_ID = :cus_id GROUP BY CUS_ID ",nativeQuery = true)
    public Integer findBuyingTimes(@Param("cus_id") int cus_id,@Param("com_id") int com_id);


    /**
     * 找到最大主键
     * 为什么不是自增主键？
     * @return
     */
    @Query(value = "SELECT MAX(CMT_ID) FROM COMMODITY_COMMENT",nativeQuery = true)
    public Integer findMaxCmtId();


    /**
     * 查找顾客昵称
     * @param cus_id-顾客ID
     * @return
     */
    @Query(value = "SELECT CUS_NICKNAME FROM CUSTOMER WHERE CUS_ID =:cus_id",nativeQuery = true)
    public String findCusName(@Param("cus_id") int cus_id);

    /**
     * 查找商家昵称
     * @param cus_id-顾客ID
     * @return
     */
    @Query(value = "SELECT STO_NAME FROM STORE WHERE STO_ID =:sto_id",nativeQuery = true)
    public String findStoName(@Param("sto_id") int sto_id);
}
