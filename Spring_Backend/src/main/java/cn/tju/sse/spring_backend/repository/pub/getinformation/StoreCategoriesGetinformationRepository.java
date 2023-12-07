package cn.tju.sse.spring_backend.repository.pub.getinformation;

import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StoreCategoriesGetinformationRepository extends JpaRepository<StoreCategoriesEntity, Integer> {
    List<StoreCategoriesEntity> findAllByStoreId(Integer id);
}
