package cn.tju.sse.spring_backend.repository.cus.store;

import cn.tju.sse.spring_backend.model.StoreEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/*
进入商家详情接口
 */
public interface CustomerGetStoreDetailRepository extends JpaRepository<StoreEntity,Integer> {
    /**
     * 查询商家是否存在
     * @param sto_id 传入商家id
     * @return 返回对应商家的名称
     */
    @Query(value = "SELECT STO_NAME FROM STORE WHERE STO_ID = :sto_id",nativeQuery = true)
    String findStoNameByStoID(int sto_id);
}
