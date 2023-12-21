package cn.tju.sse.spring_backend.service.pub.information;

import cn.tju.sse.spring_backend.dto.pub.information.UserInformationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.information.UserInformationResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.information.mapper.UserInformationRequestMapper;
import cn.tju.sse.spring_backend.dto.pub.information.mapper.UserInformationResponseMapper;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.pub.information.UserInformationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * @ClassName UserInformationService
 * @Author RaoJi
 * @Description 查询用户消息的业务逻辑
 */
@Service
public class UserInformationService {
    // service class need to interact with database
    @Autowired
    private UserInformationRepository userInformationRepository;

    // service class need receive modeled request
    private final UserInformationRequestMapper userInformationRequestMapper
            = UserInformationRequestMapper.INSTANCE;

    private final UserInformationResponseMapper userInformationResponseMapper
            = UserInformationResponseMapper.INSTANCE;

    /**
     * @param request 前端发来的消息
     * @return 回复给前端的消息
     * @see UserInformationResponseDTO
     * @see UserInformationRequestDTO
     */
    // service class need make response
    public UserInformationResponseDTO UserInformation(UserInformationRequestDTO request){
        // results probably returned
        UserInformationResponseDTO response =
                new UserInformationResponseDTO();

        // check if the user exists
        boolean existsUser = userInformationRepository.
                existsUsersEntityByUserId(Integer.parseInt(request.getUser_ID()));

        if(!existsUser){
            response.setMessage("user not found");
            return response;  // return empty response
        }


        // find user by repository
        Optional<UsersEntity> user = userInformationRepository.
                findById(Integer.valueOf(request.getUser_ID()));

        // check if the data is obtained
        if(user.isEmpty()){
            response.setMessage("error occurred in database");
            return response;  // error by repository or database
        }

        // throw should not be executed
        response = userInformationResponseMapper.entityToResponse(user.orElseThrow());
        response.setMessage("success");

        return response;
    }
}
