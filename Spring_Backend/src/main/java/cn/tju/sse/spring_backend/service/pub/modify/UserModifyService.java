package cn.tju.sse.spring_backend.service.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.mapper.UserModifyRequestMapper;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.pub.modify.UserModifyRepository;
import cn.tju.sse.spring_backend.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ClassName UserModifyService
 * @Author RaoJi
 * @Description 修改用户信息的业务逻辑
 */
@Service
public class UserModifyService {
    @Autowired
    private UserModifyRepository userModifyRepository;

    private final UserModifyRequestMapper userModifyRequestMapper
            = UserModifyRequestMapper.INSTANCE;

    /**
     * @param request 前端发送来的消息
     * @return 返回给前端的信息
     * @see UserModifyRequestDTO
     * @see UserModifyResponseDTO
     */
    public UserModifyResponseDTO UserModify(UserModifyRequestDTO request){
        UserModifyResponseDTO response = new UserModifyResponseDTO();

        boolean existsUser = userModifyRepository.
                existsByUserId(Integer.parseInt(request.getUser_ID()));

        if(!existsUser){
            response.setMessage("user not found");
            return response;
        }

        if(request.getUser_phone().length() >= 20){
            response.setMessage("phone is too long");
            return response;
        }

        UsersEntity user = userModifyRequestMapper.requestToEntity(request);
        UsersEntity exists = userModifyRepository.findById(Integer.valueOf(request.getUser_ID())).orElseThrow();
        if(!user.getUserPhone().isEmpty())
            exists.setUserPhone(user.getUserPhone());
        if(!user.getUserPassword().isEmpty())
            exists.setUserPassword(SecurityUtils.encodePassword(user.getUserPassword()));  // encode
        if(!user.getUserAddress().isEmpty())
            exists.setUserAddress(user.getUserAddress());
        UsersEntity update = userModifyRepository.save(exists);

        response.setMessage("success");
        return response;



    }
}
