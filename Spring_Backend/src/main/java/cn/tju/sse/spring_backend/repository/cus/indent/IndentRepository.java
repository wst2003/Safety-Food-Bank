package cn.tju.sse.spring_backend.repository.cus.indent;

import cn.tju.sse.spring_backend.model.IndentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.sql.Date;
import java.util.List;

public interface IndentRepository extends JpaRepository<IndentEntity,Integer> {

    @Query(value="SELECT AVG(IND_RATING)"+
            "FROM INDENT WHERE COM_ID = :com_id AND IND_RATING!=-1",
    nativeQuery = true)
    double getAvgRating(@Param("com_id")Integer com_id );

    @Query(value="SELECT "+
            "INDENT.IND_ID,INDENT.IND_QUANTITY,INDENT.IND_MONEY,INDENT.IND_CREATIONTIME,INDENT.IND_VERIFICATIONCODE,INDENT.IND_NOTES,"+
            "INDENT.IND_STATE,INDENT.IND_RATING, INDENT.CUS_ID,INDENT.COM_ID,INDENT.IND_RTIME,INDENT.IND_RNOTES,INDENT.IND_RMONEY,COMMODITY.COM_NAME,COMMODITY.COM_EXPIRATIONDATE,"+
            "STORE.STO_NAME,STORE.STO_ID "+
            "FROM INDENT,COMMODITY,STORE "+
            "WHERE INDENT.CUS_ID = :cus_id " +
            "AND INDENT.COM_ID=COMMODITY.COM_ID " +
            "AND INDENT.IND_STATE=:state " +
            "AND COMMODITY.COM_NAME LIKE  CONCAT('%',:search_str,'%')  " +
            "AND COMMODITY.STO_ID = STORE.STO_ID",
            nativeQuery = true)
    List<Object[]> getIndentList(@Param("cus_id")Integer cus_id,@Param("state")Integer state ,@Param("search_str")String search_str );
}
