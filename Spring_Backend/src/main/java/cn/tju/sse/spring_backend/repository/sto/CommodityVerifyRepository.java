package cn.tju.sse.spring_backend.repository.sto;

import cn.tju.sse.spring_backend.model.IndentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 商品核销的数据访问接口。
 */
@Transactional
public interface CommodityVerifyRepository extends JpaRepository<IndentEntity, Integer> {
    /**
     * 获取待审核的订单列表。
     *
     * @param indentVerificationCode 订单验证码
     * @return 订单列表，以Object数组形式返回
     */
    @Query(value = "SELECT INDENT.CUS_ID, INDENT.IND_ID, INDENT.COM_ID, COMMODITY.COM_NAME, INDENT.IND_QUANTITY " +
            "FROM INDENT JOIN COMMODITY ON INDENT.COM_ID = COMMODITY.COM_ID " +
            "WHERE INDENT.IND_STATE = 0 AND INDENT.IND_VERIFICATIONCODE = :indentVerificationCode AND COMMODITY.COM_STATUS != -1",
            nativeQuery = true)
    List<Object[]> getIndentToVerify(@Param("indentVerificationCode") String indentVerificationCode);

    /**
     * 核销订单。
     *
     * @param indentVerificationCode 订单验证码
     * @return 受影响的行数
     */
    @Modifying
    @Query(value = "UPDATE INDENT SET IND_STATE = 1 " +
            "WHERE IND_ID IN (" +
            "   SELECT TMP.IND_ID FROM (" +
            "       SELECT INDENT.IND_ID " +
            "       FROM INDENT JOIN COMMODITY ON INDENT.COM_ID = COMMODITY.COM_ID " +
            "       WHERE INDENT.IND_STATE = 0 AND INDENT.IND_VERIFICATIONCODE = :indentVerificationCode AND COMMODITY.COM_STATUS != -1" +
            "   ) TMP" +
            ")",
            nativeQuery = true)
    int verifyIndent(@Param("indentVerificationCode") String indentVerificationCode);
}
