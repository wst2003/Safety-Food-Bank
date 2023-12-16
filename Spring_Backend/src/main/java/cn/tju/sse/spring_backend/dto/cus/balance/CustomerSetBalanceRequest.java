package cn.tju.sse.spring_backend.dto.cus.balance;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/*
设置余额请求
 */
@Getter
@Setter
public class CustomerSetBalanceRequest {
    private Integer cus_id;
    private BigDecimal balance;
}
