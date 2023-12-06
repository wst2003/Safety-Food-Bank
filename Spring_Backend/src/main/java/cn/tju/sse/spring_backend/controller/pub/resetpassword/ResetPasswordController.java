package cn.tju.sse.spring_backend.controller.pub.resetpassword;

import cn.tju.sse.spring_backend.dto.pub.resetpassword.ResetPasswordRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.resetpassword.ResetPasswordVerifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.resetpassword.ResetPasswordResponseDTO;
import cn.tju.sse.spring_backend.service.pub.resetpassword.ResetPasswordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pub/resetpassword")
public class ResetPasswordController {
    @Autowired
    private ResetPasswordService resetPasswordService;
    @RequestMapping(value = "/verify",method = RequestMethod.POST)
    public ResponseEntity<ResetPasswordResponseDTO> userVerify(@RequestBody ResetPasswordVerifyRequestDTO request){
        ResetPasswordResponseDTO response = resetPasswordService.verifyUser(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @RequestMapping(value = "/sendnewpassword",method = RequestMethod.POST)
    public ResponseEntity<ResetPasswordResponseDTO> userVerify(@RequestBody ResetPasswordRequestDTO request){
        ResetPasswordResponseDTO response = resetPasswordService.resetPassword(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
