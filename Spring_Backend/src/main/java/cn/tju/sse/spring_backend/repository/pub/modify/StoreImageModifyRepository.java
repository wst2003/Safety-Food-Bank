package cn.tju.sse.spring_backend.repository.pub.modify;

import cn.tju.sse.spring_backend.model.StoreimageEntity;
import cn.tju.sse.spring_backend.model.StoreimageEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @author raoji
 * @date 2023/12/9
 * @Description
 */
public interface StoreImageModifyRepository extends JpaRepository<StoreimageEntity, StoreimageEntityPK> {
    boolean existsDistinctByStoId(int id);
    StoreimageEntity findDistinctByStoId(int id);
}
