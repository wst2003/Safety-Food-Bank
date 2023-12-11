package cn.tju.sse.spring_backend.repository.pub.modify;

import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @author raoji
 * @date 2023/12/9
 * @Description
 */
public interface StoreCategoriesModifyRepository extends JpaRepository<StoreCategoriesEntity, Integer> {
}
