package cn.tju.sse.spring_backend.service.admin;

import cn.tju.sse.spring_backend.dto.admin.ChangeUserStateRequestDTO;
import cn.tju.sse.spring_backend.repository.admin.UserStateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 用户状态服务类
 */
@Service
public class UserStateService {
    @Autowired
    private UserStateRepository userStateRepository;

    /**
     * 获取用户状态
     *
     * @param userId   用户ID
     * @param userType 用户类型
     * @return 用户状态
     */
    public int getUserState(int userId, int userType) {
        if (userType == 0)
            return userStateRepository.getCustomerStateById(userId);
        else
            return userStateRepository.getStoreStateById(userId);
    }

    /**
     * 修改用户状态
     *
     * @param request 包含修改用户状态的请求体
     * @return 修改是否成功
     */
    public boolean changeUserState(ChangeUserStateRequestDTO request) {
        int rowsAffected = 0;
        if (request.getUSER_TYPE() == 0)
            rowsAffected = userStateRepository.updateCustomerStateById(request.getUSER_ID(), request.getTO_STATE());
        else
            rowsAffected = userStateRepository.updateStoreStateById(request.getUSER_ID(), request.getTO_STATE());
        return rowsAffected > 0;
    }
}
