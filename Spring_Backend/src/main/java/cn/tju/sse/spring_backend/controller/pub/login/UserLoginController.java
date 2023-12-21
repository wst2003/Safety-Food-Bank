package cn.tju.sse.spring_backend.controller.pub.login;

import cn.dev33.satoken.stp.StpUtil;
import cn.dev33.satoken.util.SaResult;
import cn.tju.sse.spring_backend.dto.pub.login.UserLoginRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.login.UserLoginResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.login.UserQuitRequestDTO;
import cn.tju.sse.spring_backend.service.pub.login.UserLoginService;
import cn.tju.sse.spring_backend.service.pub.login.UserQuitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/pub/login")
public class UserLoginController {
    @Autowired
    private UserLoginService userLoginService;
    @Autowired
    private UserQuitService userQuitService;
    @RequestMapping(value="",method = RequestMethod.POST)
    @ResponseBody
    public SaResult userLogin(@RequestBody UserLoginRequestDTO request){
        UserLoginResponseDTO response =userLoginService.UserLogin(request);
        if(response.getMessage().equals("success")){

            StpUtil.login(request.getUser_ID_phonenumber());
            System.out.println(request.getUser_ID_phonenumber()+" Success login");
            return SaResult.ok("success").setData(response);

        }
        return SaResult.error(response.getMessage());
    }
    @RequestMapping(value="/quit",method = RequestMethod.POST)
    public SaResult userQuit(@RequestBody UserQuitRequestDTO request){
        String log= userQuitService.userQuit(request);
        if(log.equals("success")){
            return SaResult.ok("success").setMsg("success");
        }
        else {
            return SaResult.error("登录失败");
        }
    }
}
