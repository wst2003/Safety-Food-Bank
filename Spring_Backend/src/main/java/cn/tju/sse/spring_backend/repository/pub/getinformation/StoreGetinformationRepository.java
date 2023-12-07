package cn.tju.sse.spring_backend.repository.pub.getinformation;

import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StoreGetinformationRepository extends JpaRepository<StoreEntity, Integer> {
    boolean existsByStoId(Integer id);
}
