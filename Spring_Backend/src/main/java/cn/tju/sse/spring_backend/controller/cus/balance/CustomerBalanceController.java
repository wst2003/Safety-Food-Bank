package cn.tju.sse.spring_backend.controller.cus.balance;

import cn.tju.sse.spring_backend.dto.cus.balance.CustomerGetBalanceRequest;
import cn.tju.sse.spring_backend.dto.cus.balance.CustomerGetBalanceResponse;
import cn.tju.sse.spring_backend.dto.cus.balance.CustomerSetBalanceRequest;
import cn.tju.sse.spring_backend.dto.cus.balance.CustomerSetBalanceResponse;
import cn.tju.sse.spring_backend.service.cus.balance.CustomerGetBalanceService;
import cn.tju.sse.spring_backend.service.cus.balance.CustomerSetBalanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;

/**
 * 关于用户余额的控制器类
 */
@RestController
@RequestMapping("/api/cus/balance")
public class CustomerBalanceController {
    @Autowired
    private CustomerGetBalanceService customerGetBalanceService;
    @Autowired
    private CustomerSetBalanceService customerSetBalanceService;

    /**
     * 获取余额
     * @param cus_id 用户id
     * @return 返回用户余额
     */
    @RequestMapping(value = "/getBalance", method = RequestMethod.GET)
    public ResponseEntity<CustomerGetBalanceResponse> customerGetBalance
            (@RequestParam Integer cus_id){
        CustomerGetBalanceRequest customerGetBalanceRequest=new CustomerGetBalanceRequest();
        customerGetBalanceRequest.setCus_id(cus_id);
        BigDecimal balance = customerGetBalanceService.getBalance(customerGetBalanceRequest);
        CustomerGetBalanceResponse customerGetBalanceResponse = new CustomerGetBalanceResponse();
        customerGetBalanceResponse.setBalance(balance);
        return new ResponseEntity<>(customerGetBalanceResponse, HttpStatus.OK);
    }

    /**
     * 设置余额
     * @param request 请求头包括用户id和设置的余额
     * @return 设置是否成功
     */
    @RequestMapping(value = "/setBalance", method = RequestMethod.POST)
    public ResponseEntity<CustomerSetBalanceResponse> customerSetBalance
            (@RequestBody CustomerSetBalanceRequest request){
        boolean flag = customerSetBalanceService.setBalance(request);
        CustomerSetBalanceResponse response = new CustomerSetBalanceResponse();
        if(flag){
            response.setMsg("设置成功");
        }
        else{
            response.setMsg("设置失败");
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
