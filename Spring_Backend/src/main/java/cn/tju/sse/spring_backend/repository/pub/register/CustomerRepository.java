package cn.tju.sse.spring_backend.repository.pub.register;

import cn.tju.sse.spring_backend.model.CustomerEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<CustomerEntity,Integer> {
}
