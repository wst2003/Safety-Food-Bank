package cn.tju.sse.spring_backend.repository.cus.history;

import cn.tju.sse.spring_backend.model.BrowseEntity;
import cn.tju.sse.spring_backend.model.BrowseEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HistorySetBrowsingHistoryRepository extends JpaRepository<BrowseEntity, BrowseEntityPK> {
}
