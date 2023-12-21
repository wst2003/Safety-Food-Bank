package cn.tju.sse.spring_backend.repository.cus.indent;

import cn.tju.sse.spring_backend.model.IndentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.sql.Date;

public interface IndentRepository extends JpaRepository<IndentEntity,Integer> {

    @Query(value="SELECT AVG(IND_RATING)"+
            "FROM INDENT WHERE COM_ID = :com_id AND IND_RATING!=-1",
    nativeQuery = true)
    double getAvgRating(@Param("com_id")Integer com_id );
}
