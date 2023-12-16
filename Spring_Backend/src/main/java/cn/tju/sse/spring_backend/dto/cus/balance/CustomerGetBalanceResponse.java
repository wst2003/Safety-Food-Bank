package cn.tju.sse.spring_backend.dto.cus.balance;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/*
获取余额响应
 */
@Getter
@Setter
public class CustomerGetBalanceResponse {
    private BigDecimal balance;
}
