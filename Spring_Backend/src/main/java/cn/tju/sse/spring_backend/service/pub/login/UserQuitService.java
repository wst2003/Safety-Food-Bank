package cn.tju.sse.spring_backend.service.pub.login;

import cn.dev33.satoken.stp.StpUtil;
import cn.tju.sse.spring_backend.dto.pub.login.UserQuitRequestDTO;
import cn.tju.sse.spring_backend.model.StoreEntity;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.pub.register.StoreRegisterRepository;
import cn.tju.sse.spring_backend.repository.pub.register.UserRegisterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserQuitService {
    @Autowired
    private UserRegisterRepository userRegisterRepository;

    public String userQuit(UserQuitRequestDTO request){
        StpUtil.getLoginId();
        Optional<UsersEntity> usersEntity=userRegisterRepository.findById(Integer.parseInt(request.getUser_ID()));
        usersEntity.get().setUserState(0);
        if (userRegisterRepository.save(usersEntity.get())!=null) {
            StpUtil.logout();
            System.out.println(request.getUser_ID()+" success logout");
            return "success";
        }else{
            return "退出登录异常";
        }

    }
}
