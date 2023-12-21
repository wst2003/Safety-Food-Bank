package cn.tju.sse.spring_backend.controller.pub.information;

import cn.tju.sse.spring_backend.dto.pub.information.UserInformationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.information.UserInformationResponseDTO;
import cn.tju.sse.spring_backend.service.pub.information.UserInformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * @ClassName UserInformationController
 * @Description 控制类，返回用户基本信息
 * @Author RaoJi
 */
@RestController  // All return values must be directly written into the response body
@RequestMapping("/api/pub/information")  // process specific url responses
public class UserInformationController {
    @Autowired  // Automatic assembly dependency
    private UserInformationService userInformationService;

    /**
     * @param user_ID - 用户的id
     * @return id对应的用户信息
     * @see UserInformationResponseDTO
     */
    @RequestMapping(value = "/user", method = RequestMethod.GET)
    public ResponseEntity<UserInformationResponseDTO> userInformation
            (@RequestParam String user_ID){
        UserInformationRequestDTO request = new UserInformationRequestDTO();
        request.setUser_ID(user_ID);
        UserInformationResponseDTO response = userInformationService.UserInformation(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
