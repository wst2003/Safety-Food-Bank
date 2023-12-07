package cn.tju.sse.spring_backend.repository.pub.getinformation;

import cn.tju.sse.spring_backend.model.CustomerEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerGetinformationRepository extends JpaRepository<CustomerEntity, Integer> {
    boolean existsByCusId(int id);
}
