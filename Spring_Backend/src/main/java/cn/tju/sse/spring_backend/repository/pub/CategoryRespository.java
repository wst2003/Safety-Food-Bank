package cn.tju.sse.spring_backend.repository.pub;

import cn.tju.sse.spring_backend.model.CommoditiesCategoriesEntity;
import cn.tju.sse.spring_backend.model.CommodityCategoriesEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRespository extends JpaRepository<CommoditiesCategoriesEntity, String> {
}
