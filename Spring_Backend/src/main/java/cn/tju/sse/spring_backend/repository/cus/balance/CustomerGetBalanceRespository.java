package cn.tju.sse.spring_backend.repository.cus.balance;

import cn.tju.sse.spring_backend.model.UsersEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.math.BigDecimal;

/*
获取余额接口
 */
public interface CustomerGetBalanceRespository extends JpaRepository<UsersEntity,Integer>
{
    /**
     * 查找是否有对应用户
     * @param cus_id 传入用户id
     * @return 返回对应用户
     */
    UsersEntity findUsersEntityByUserId(int cus_id);
}
