package cn.tju.sse.spring_backend.repository.pub.register;

import cn.tju.sse.spring_backend.model.CustomerLoveEntity;
import cn.tju.sse.spring_backend.model.CustomerLoveEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerLoveRepository extends JpaRepository<CustomerLoveEntity, CustomerLoveEntityPK> {
}
