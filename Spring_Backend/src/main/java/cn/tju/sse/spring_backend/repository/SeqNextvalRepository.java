package cn.tju.sse.spring_backend.repository;

import cn.tju.sse.spring_backend.model.SequencesEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigInteger;

public interface SeqNextvalRepository extends JpaRepository<SequencesEntity,String> {
    @Query(value = "SELECT SEQ_NEXTVAL(:seq_name)",nativeQuery = true)
    int callSEQ_NEXTVAL(@Param("seq_name") String seq_name);
}
