package cn.tju.sse.spring_backend.repository.pub.register;

import cn.tju.sse.spring_backend.model.StoreEntity;
import cn.tju.sse.spring_backend.model.StoreimageEntity;
import cn.tju.sse.spring_backend.model.StoreimageEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StoreImgRepository extends JpaRepository<StoreimageEntity, StoreimageEntityPK> {
}
