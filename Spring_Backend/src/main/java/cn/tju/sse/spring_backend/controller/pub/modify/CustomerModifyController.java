package cn.tju.sse.spring_backend.controller.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.CustomerModifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.CustomerModifyResponseDTO;
import cn.tju.sse.spring_backend.service.pub.modify.CustomerModifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


/**
 * @ClassName CustomerModifyController
 * @Author RaoJi
 * @Description 控制类，修改顾客基本信息
 */
@RestController
@RequestMapping("/api/pub/modify")
public class CustomerModifyController {
    @Autowired
    private CustomerModifyService customerModifyService;

    /**
     * @param request - 被修改为的顾客信息
     * @see CustomerModifyRequestDTO
     * @return 是否修改成功
     * @see CustomerModifyResponseDTO
     */
    @RequestMapping(value = "/customer", method = RequestMethod.POST)
    public ResponseEntity<CustomerModifyResponseDTO> customerModify
            (@RequestBody CustomerModifyRequestDTO request){
        CustomerModifyResponseDTO response = customerModifyService.customerModify(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
