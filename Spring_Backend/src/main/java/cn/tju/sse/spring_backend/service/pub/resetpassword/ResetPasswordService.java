package cn.tju.sse.spring_backend.service.pub.resetpassword;


import cn.tju.sse.spring_backend.dto.pub.resetpassword.ResetPasswordRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.resetpassword.ResetPasswordVerifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.resetpassword.ResetPasswordResponseDTO;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.pub.resetpassword.ResetPasswordRepository;
import cn.tju.sse.spring_backend.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ResetPasswordService {
    @Autowired
    private ResetPasswordRepository resetPasswordRepository;

    public ResetPasswordResponseDTO verifyUser(ResetPasswordVerifyRequestDTO request){
        ResetPasswordResponseDTO response = new ResetPasswordResponseDTO();
        boolean existsPhoneNumber =  resetPasswordRepository.existsUsersEntityByUserPhone(request.getUser_phone());
        if(existsPhoneNumber){
            response.setMessage("success");
        }
        else{
            response.setMessage("手机号不存在");
        }
        return response;
    }
    @Transactional
    public ResetPasswordResponseDTO resetPassword(ResetPasswordRequestDTO request){
        ResetPasswordResponseDTO response = new ResetPasswordResponseDTO();
        UsersEntity user = resetPasswordRepository.findByUserPhone(request.getUser_phonenumber());
        if (user != null) {
            // 在这里，应该使用哈希函数来处理密码
            // 由于前端已经调用了verify服务，验证了用户存在，正常情况下应该到这里
            user.setUserPassword(SecurityUtils.encodePassword(request.getUser_new_password()));
            System.out.println(SecurityUtils.encodePassword(request.getUser_new_password()));
            resetPasswordRepository.save(user);
            response.setMessage("success");
            return response;
        }
        response.setMessage("手机号不存在");
        return response;
    }
}
