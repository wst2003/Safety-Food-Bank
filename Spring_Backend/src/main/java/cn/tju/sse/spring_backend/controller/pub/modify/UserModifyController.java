package cn.tju.sse.spring_backend.controller.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyResponseDTO;
import cn.tju.sse.spring_backend.service.pub.modify.UserModifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName UserModifyController
 * @Author RaoJI
 * @Description 控制类，修改用户信息
 */
@RestController
@RequestMapping("/api/pub/modify")
public class UserModifyController {
    @Autowired
    private UserModifyService userModifyService;

    /**
     * @param request - 被修改为的用户信息
     * @see UserModifyRequestDTO
     * @return 是否修改成功
     * @see UserModifyResponseDTO
     */
    @RequestMapping(value = "/user", method = RequestMethod.POST)
    public ResponseEntity<UserModifyResponseDTO> userModify
            (@RequestBody UserModifyRequestDTO request){
        UserModifyResponseDTO response = userModifyService.UserModify(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
