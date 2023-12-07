package cn.tju.sse.spring_backend.controller.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyRequest;
import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyResponse;
import cn.tju.sse.spring_backend.service.pub.modify.UserModifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pub/modify")
public class UserModifyController {
    @Autowired
    private UserModifyService userModifyService;

    @RequestMapping(value = "/user", method = RequestMethod.POST)
    public ResponseEntity<UserModifyResponse> userModify
            (@RequestBody UserModifyRequest request){
        UserModifyResponse response = userModifyService.UserModify(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
