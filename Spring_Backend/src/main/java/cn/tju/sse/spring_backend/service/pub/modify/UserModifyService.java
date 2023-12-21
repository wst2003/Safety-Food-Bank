package cn.tju.sse.spring_backend.service.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.mapper.UserModifyRequestMapper;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.pub.modify.UserModifyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserModifyService {
    @Autowired
    private UserModifyRepository userModifyRepository;

    private final UserModifyRequestMapper userModifyRequestMapper
            = UserModifyRequestMapper.INSTANCE;

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
        exists.setUserPhone(user.getUserPhone());
        exists.setUserPassword(user.getUserPassword());
        exists.setUserAddress(user.getUserAddress());
        UsersEntity update = userModifyRepository.save(exists);

        response.setMessage("success");
        return response;



    }
}
