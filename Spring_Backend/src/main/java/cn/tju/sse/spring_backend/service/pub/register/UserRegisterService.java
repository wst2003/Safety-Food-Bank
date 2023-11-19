package cn.tju.sse.spring_backend.service.pub.register;

import cn.tju.sse.spring_backend.dto.pub.register.UserRegistrationRequest;
import cn.tju.sse.spring_backend.dto.pub.register.UserRegistrationResponse;
import cn.tju.sse.spring_backend.dto.pub.register.mapper.UserRegistrationRequestMapper;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.SeqNextvalRepository;
import cn.tju.sse.spring_backend.repository.pub.register.UserRegisterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;

@Service
public class UserRegisterService {
    @Autowired
    private UserRegisterRepository userRegisterRepository;
    @Autowired
    private SeqNextvalRepository seqNextvalRepository;
    private final UserRegistrationRequestMapper userRegistrationRequestMapper = UserRegistrationRequestMapper.INSTANCE;
    public UserRegistrationResponse UserRegister(UserRegistrationRequest request){
        UsersEntity newUser = userRegistrationRequestMapper.requestToEntity(request);

        UserRegistrationResponse response = new UserRegistrationResponse();
        boolean existsPhoneNumber = userRegisterRepository.existsUsersEntityByUserPhone(request.getUser_phone());
        if(existsPhoneNumber){
            System.out.println("电话号码已经存在!");
            response.setMessage("电话号码已经存在!");
            response.setUser_type(request.getUser_type());
            return response;
        }
        int nextID = seqNextvalRepository.callSEQ_NEXTVAL("USER_ID_SEQ");
        newUser.setUserId(nextID);
        newUser.setUserState(0);
        newUser.setUserBalance(BigDecimal.ZERO);
        newUser.setUserRegtime(new Date(System.currentTimeMillis()));

        UsersEntity insertUser =  userRegisterRepository.save(newUser);
        if(insertUser!=null){
            response.setUser_type(String.valueOf(insertUser.getUserType()));
            response.setMessage("user已经注册成功");
            response.setUser_ID(String.valueOf(insertUser.getUserId()));
            return response;
        }
        else return null;
    }
}
