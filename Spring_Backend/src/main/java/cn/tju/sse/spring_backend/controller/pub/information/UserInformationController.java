package cn.tju.sse.spring_backend.controller.pub.information;

import cn.tju.sse.spring_backend.dto.pub.information.UserInformationRequest;
import cn.tju.sse.spring_backend.dto.pub.information.UserInformationResponse;
import cn.tju.sse.spring_backend.service.pub.information.UserInformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController  // All return values must be directly written into the response body
@RequestMapping("/api/pub/information")  // process specific url responses
public class UserInformationController {
    @Autowired  // Automatic assembly dependency
    private UserInformationService userInformationService;

    @RequestMapping(value = "/user", method = RequestMethod.GET)
    public ResponseEntity<UserInformationResponse> userInformation
            (@RequestParam String user_ID){
        UserInformationRequest request = new UserInformationRequest();
        request.setUser_ID(user_ID);
        UserInformationResponse response = userInformationService.UserInformation(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
