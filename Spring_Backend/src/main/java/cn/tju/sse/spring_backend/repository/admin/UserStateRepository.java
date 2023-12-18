package cn.tju.sse.spring_backend.repository.admin;

import cn.tju.sse.spring_backend.model.UsersEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

/**
 * 查询、修改用户状态的接口
 */
@Transactional
public interface UserStateRepository extends JpaRepository<UsersEntity, Integer> {
    /**
     * 根据用户ID查询用户状态
     *
     * @param cusId 用户ID
     * @return 用户状态
     */
    @Query(value = "SELECT CUS_STATE FROM CUSTOMER WHERE CUS_ID = :cusId", nativeQuery = true)
    int getCustomerStateById(@Param("cusId") int cusId);

    /**
     * 根据商店ID查询商店状态
     *
     * @param storeId 商店ID
     * @return 商店状态
     */
    @Query(value = "SELECT STO_STATE FROM STORE WHERE STO_ID = :storeId", nativeQuery = true)
    int getStoreStateById(@Param("storeId") int storeId);

    /**
     * 更新用户状态
     *
     * @param cusId   用户ID
     * @param toState 目标状态
     * @return 受影响的行数
     */
    @Modifying
    @Query(value = "UPDATE CUSTOMER SET CUS_STATE = :toState WHERE CUS_ID = :cusId", nativeQuery = true)
    int updateCustomerStateById(@Param("cusId") int cusId, @Param("toState") int toState);

    /**
     * 更新商店状态
     *
     * @param storeId 商店ID
     * @param toState 目标状态
     * @return 受影响的行数
     */
    @Modifying
    @Query(value = "UPDATE STORE SET STO_STATE = :toState WHERE STO_ID = :storeId", nativeQuery = true)
    int updateStoreStateById(@Param("storeId") int storeId, @Param("toState") int toState);
}
