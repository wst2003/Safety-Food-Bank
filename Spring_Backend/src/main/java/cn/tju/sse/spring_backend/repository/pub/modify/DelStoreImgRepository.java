package cn.tju.sse.spring_backend.repository.pub.modify;

import cn.tju.sse.spring_backend.model.StoreimageEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DelStoreImgRepository extends JpaRepository<StoreimageEntity,Integer> {

    @Transactional
    public Integer deleteByStoIdAndAndStoImage(@Param("StoId") Integer StoId,
                                               @Param("StoImage") String StoImage);
}
