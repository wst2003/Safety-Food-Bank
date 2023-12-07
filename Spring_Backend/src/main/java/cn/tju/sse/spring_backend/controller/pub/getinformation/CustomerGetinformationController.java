package cn.tju.sse.spring_backend.controller.pub.getinformation;

import cn.tju.sse.spring_backend.dto.pub.getinformation.CustomerGetinformationRequest;
import cn.tju.sse.spring_backend.dto.pub.getinformation.CustomerGetinformationResponse;
import cn.tju.sse.spring_backend.service.pub.getinformation.CustomerGetinformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pub/getinformation")
public class CustomerGetinformationController {
    @Autowired
    private CustomerGetinformationService customerGetinformationService;

    @RequestMapping(value = "/customer", method = RequestMethod.GET)
    public ResponseEntity<CustomerGetinformationResponse> customerGetinformation
            (@RequestParam String cus_ID){
        CustomerGetinformationRequest request = new CustomerGetinformationRequest();
        request.setCus_ID(cus_ID);
        CustomerGetinformationResponse response =
                customerGetinformationService.CustomerGetinformation(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
