package cn.tju.sse.spring_backend.controller.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.CustomerModifyRequest;
import cn.tju.sse.spring_backend.dto.pub.modify.CustomerModifyResponse;
import cn.tju.sse.spring_backend.service.pub.modify.CustomerModifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pub/modify")
public class CustomerModifyController {
    @Autowired
    private CustomerModifyService customerModifyService;

    @RequestMapping(value = "/customer", method = RequestMethod.POST)
    public ResponseEntity<CustomerModifyResponse> customerModify
            (@RequestBody CustomerModifyRequest request){
        CustomerModifyResponse response = customerModifyService.customerModify(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
