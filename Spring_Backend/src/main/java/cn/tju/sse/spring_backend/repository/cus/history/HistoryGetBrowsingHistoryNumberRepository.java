package cn.tju.sse.spring_backend.repository.cus.history;

import cn.tju.sse.spring_backend.model.BrowseEntity;
import cn.tju.sse.spring_backend.model.BrowseEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Objects;

public interface HistoryGetBrowsingHistoryNumberRepository extends JpaRepository<BrowseEntity, BrowseEntityPK> {

    @Query(value = "SELECT BROWSER_ID ,COUNT(*) FROM BROWSE WHERE BROWSER_ID =:cus_id GROUP BY BROWSER_ID",nativeQuery = true)
    public List<Object[]> findBrowseEntitiesNum(@Param("cus_id") int cus_id);
}
