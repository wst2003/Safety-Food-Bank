package cn.tju.sse.spring_backend.service.cus.balance;

import cn.tju.sse.spring_backend.dto.cus.balance.CustomerGetBalanceRequest;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.cus.balance.CustomerGetBalanceRespository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
public class CustomerGetBalanceService {
    @Autowired
    private CustomerGetBalanceRespository customerGetBalanceRespository;
    /**
     * 查询余额
     * @param customerGetBalanceRequest 获取余额请求
     * @return 返回对应用户的余额
     */
    public BigDecimal getBalance(CustomerGetBalanceRequest customerGetBalanceRequest){
        int cus_id = customerGetBalanceRequest.getCus_id();
        // UsersEntity user = customerGetBalanceRespository.findById(cus_id).get();
        UsersEntity user = customerGetBalanceRespository.findUsersEntityByUserId(cus_id);
        return user.getUserBalance();
    }
}
