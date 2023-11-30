package cn.tju.sse.spring_backend.controller.pub.register;

import cn.tju.sse.spring_backend.dto.pub.register.UserRegistrationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.register.UserRegistrationResponseDTO;
import cn.tju.sse.spring_backend.service.pub.register.UserRegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pub/register")
public class UserRegisterController {
    @Autowired
    private UserRegisterService userRegisterService;
    @RequestMapping(value = "/user",method = RequestMethod.POST)
    public ResponseEntity<UserRegistrationResponseDTO> userRegister(@RequestBody UserRegistrationRequestDTO request){
        UserRegistrationResponseDTO response = userRegisterService.UserRegister(request);
        return new ResponseEntity<>(response,HttpStatus.OK);
    }
}
