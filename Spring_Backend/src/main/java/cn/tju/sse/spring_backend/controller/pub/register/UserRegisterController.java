package cn.tju.sse.spring_backend.controller.pub.register;

import cn.tju.sse.spring_backend.dto.pub.register.*;
import cn.tju.sse.spring_backend.service.pub.register.CusRegisterService;
import cn.tju.sse.spring_backend.service.pub.register.StoreRegisterService;
import cn.tju.sse.spring_backend.service.pub.register.UserRegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("/api/pub/register")
public class UserRegisterController {
    @Autowired
    private UserRegisterService userRegisterService;
    @Autowired
    private StoreRegisterService storeRegisterService;
    @Autowired
    private CusRegisterService cusRegisterService;
    @RequestMapping(value = "/user",method = RequestMethod.POST)
    public ResponseEntity<UserRegistrationResponseDTO> userRegister(@RequestBody UserRegistrationRequestDTO request){
        UserRegistrationResponseDTO response = userRegisterService.UserRegister(request);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    @RequestMapping(value="/store",method = RequestMethod.POST,consumes = "multipart/form-data")
    public ResponseEntity<StoreRegistrationResponseDTO> storeRegister(@ModelAttribute StoreRegistrationRequestDTO request) throws IOException {
        StoreRegistrationResponseDTO response=storeRegisterService.StoreRegister(request);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    @RequestMapping(value="/customer",method = RequestMethod.POST)
    public ResponseEntity<CusRegistrationResponseDTO> customerRegister(@RequestBody CusRegistrationRequestDTO request){
        CusRegistrationResponseDTO response = cusRegisterService.CustomerRegister(request);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }
}
