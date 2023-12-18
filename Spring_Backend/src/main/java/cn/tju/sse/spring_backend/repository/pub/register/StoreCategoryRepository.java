package cn.tju.sse.spring_backend.repository.pub.register;

import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreCategoriesEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StoreCategoryRepository extends JpaRepository<StoreCategoriesEntity, StoreCategoriesEntityPK> {
}
