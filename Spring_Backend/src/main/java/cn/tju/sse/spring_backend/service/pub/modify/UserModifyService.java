package cn.tju.sse.spring_backend.service.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyRequest;
import cn.tju.sse.spring_backend.dto.pub.modify.UserModifyResponse;
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

    public UserModifyResponse UserModify(UserModifyRequest request){
        UserModifyResponse response = new UserModifyResponse();

        boolean existsUser = userModifyRepository.
                existsByUserId(Integer.parseInt(request.getUser_ID()));

        if(!existsUser){
            response.setMessage("user not found");
            return response;
        }

        UsersEntity user = userModifyRequestMapper.requestToEntity(request);
        UsersEntity update = userModifyRepository.save(user);

        response.setMessage("error occurred in database");
        return response;



    }
}
