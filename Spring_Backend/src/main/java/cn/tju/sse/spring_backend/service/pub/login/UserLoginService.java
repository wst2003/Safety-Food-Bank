package cn.tju.sse.spring_backend.service.pub.login;

import cn.tju.sse.spring_backend.dto.pub.login.UserLoginRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.login.UserLoginResponseDTO;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import cn.tju.sse.spring_backend.model.StoreEntity;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.pub.register.CustomerRepository;
import cn.tju.sse.spring_backend.repository.pub.register.StoreRegisterRepository;
import cn.tju.sse.spring_backend.repository.pub.register.UserRegisterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

import static cn.tju.sse.spring_backend.utils.SecurityUtils.matchesPassword;

@Service
public class UserLoginService {
    @Autowired
    private UserRegisterRepository userRegisterRepository;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private StoreRegisterRepository storeRegisterRepository;
    public UserLoginResponseDTO UserLogin(UserLoginRequestDTO request){
        UserLoginResponseDTO userLoginResponseDTO;
        String loginType= request.getLogin_type();
        if(loginType.equals("0")){
            userLoginResponseDTO= CodeLogin(request.getUser_ID_phonenumber(), request.getUser_password());
        }else{
            userLoginResponseDTO=PhoneNumberLogin(request.getUser_ID_phonenumber(), request.getUser_password());
        }
        return userLoginResponseDTO;
    }
    private UserLoginResponseDTO CodeLogin(String id, String password){
        UserLoginResponseDTO userLoginResponseDTO;
        int ID=Integer.parseInt(id);

        //检查用户是否存在
        if(!userRegisterRepository.existsById(ID)){
            userLoginResponseDTO=new UserLoginResponseDTO();
            userLoginResponseDTO.setMessage("用户不存在");
            userLoginResponseDTO.setUser_type("");
            userLoginResponseDTO.setUser_ID("");
            return userLoginResponseDTO;
        }

        //获取用户信息
        Optional<UsersEntity> usersEntity = userRegisterRepository.findById(ID);
        userLoginResponseDTO = DealWithLoginInfo(usersEntity.get(),password,true);
        return userLoginResponseDTO;
    }
    private UserLoginResponseDTO PhoneNumberLogin(String phoneNumber,String password){
        UserLoginResponseDTO userLoginResponseDTO;

        //检查用户是否存在
        if(!userRegisterRepository.existsUsersEntityByUserPhone(phoneNumber)){
            userLoginResponseDTO=new UserLoginResponseDTO();
            userLoginResponseDTO.setMessage("用户不存在");
            userLoginResponseDTO.setUser_type("");
            userLoginResponseDTO.setUser_ID("");
            return userLoginResponseDTO;
        }

        //获取用户信息
        Optional<UsersEntity> usersEntity = Optional.ofNullable(userRegisterRepository.findUsersEntitiesByUserPhone(phoneNumber));
        userLoginResponseDTO = DealWithLoginInfo(usersEntity.get(),password,false);
        return userLoginResponseDTO;
    }

    private UserLoginResponseDTO DealWithLoginInfo(UsersEntity usersEntity,String password,boolean isCode){
        UserLoginResponseDTO userLoginResponseDTO=new UserLoginResponseDTO();
        String StoredPassword=usersEntity.getUserPassword();
        int id = usersEntity.getUserId();
        int userType=usersEntity.getUserType();
        if(matchesPassword(password,StoredPassword) || isCode){
            if(userType==0){
                Optional<CustomerEntity> customer =customerRepository.findById(id);
                if(customer.get().getCusState()==0){
                    userLoginResponseDTO.setMessage("该账号已被封禁！");
                    userLoginResponseDTO.setUser_type("");
                    userLoginResponseDTO.setUser_ID("");
                    return userLoginResponseDTO;
                }

                userLoginResponseDTO.setMessage("success");
                userLoginResponseDTO.setUser_type("0");
                userLoginResponseDTO.setUser_ID(Integer.toString(id));
                usersEntity.setUserState(1);
                userRegisterRepository.save(usersEntity);
            } else if (userType==1) {
                Optional<StoreEntity> store =storeRegisterRepository.findById(id);
                if(store.get().getStoState()==0){
                    userLoginResponseDTO.setMessage("该账号已被封禁！");
                    userLoginResponseDTO.setUser_type("");
                    userLoginResponseDTO.setUser_ID("");
                    return userLoginResponseDTO;
                }

                userLoginResponseDTO.setMessage("success");
                userLoginResponseDTO.setUser_type("1");
                userLoginResponseDTO.setUser_ID(Integer.toString(id));
                usersEntity.setUserState(1);
                userRegisterRepository.save(usersEntity);

            }
        }else{
            userLoginResponseDTO.setMessage("密码错误");
            userLoginResponseDTO.setUser_type("");
            userLoginResponseDTO.setUser_ID("");
            return userLoginResponseDTO;
        }
        return userLoginResponseDTO;
    }
}
