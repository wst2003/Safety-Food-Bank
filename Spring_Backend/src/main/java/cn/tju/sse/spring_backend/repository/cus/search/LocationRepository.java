package cn.tju.sse.spring_backend.repository.cus.search;

import cn.tju.sse.spring_backend.model.StoreEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @author lhx
 * @date 2023/12/20
 * @Description 用于处理地理位置信息的仓库类
 */
public interface LocationRepository extends JpaRepository<StoreEntity, Integer> {

    @Query(value="SELECT STO_ID,USER_ADDRESS FROM STORE,USERS WHERE USER_ID=STO_ID ",
            nativeQuery = true
    )
    List<Object[]> getStoreAddresses();
}
