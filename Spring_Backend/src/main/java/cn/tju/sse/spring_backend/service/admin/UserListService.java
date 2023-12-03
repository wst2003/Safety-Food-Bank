package cn.tju.sse.spring_backend.service.admin;

import cn.tju.sse.spring_backend.dto.admin.UserResponseDTO;
import cn.tju.sse.spring_backend.repository.admin.UserListRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * 用户列表服务类
 */
@Service
public class UserListService {
    @Autowired
    private UserListRepository userListRepository;

    /**
     * 获取用户列表
     *
     * @param idOrder      用户ID的排序方式
     * @param nameOrder    用户名的排序方式
     * @param userName     用户名关键字
     * @param userType     用户类型
     * @param beginNumber  开始位置
     * @param endNumber    结束位置
     * @return List<UserResponseDTO> 用户列表
     */
    public List<UserResponseDTO> getUserList(int idOrder, int nameOrder, String userName, int userType, int beginNumber, int endNumber) {
        List<UserResponseDTO> users = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        if (Objects.equals(userName, "NULL"))
            userName = "";
        userName = "%" + userName + "%";
        beginNumber = beginNumber - 1;
        int pageSize = endNumber - beginNumber;

        if (userType == 0) {
            List<Object[]> customerList = new ArrayList<>();
            if (nameOrder == 0)
                customerList = userListRepository.getCustomerByNameDesc(userName, beginNumber, pageSize);
            else if (nameOrder == 1)
                customerList = userListRepository.getCustomerByNameAsc(userName, beginNumber, pageSize);
            else if (idOrder == 0)
                customerList = userListRepository.getCustomerByIdDesc(userName, beginNumber, pageSize);
            else if (idOrder == 1)
                customerList = userListRepository.getCustomerByIdAsc(userName, beginNumber, pageSize);

            for (Object[] row : customerList) {
                UserResponseDTO user = new UserResponseDTO();
                user.setUSER_ID((Integer) row[0]);
                user.setUSER_NAME((String) row[1]);
                user.setUSER_REGTIME(dateFormat.format(row[2]));
                user.setUSER_STATE((Integer) row[3]);
                user.setSTO_IMAGE("NULL");

                users.add(user);
            }

        } else {
            List<Object[]> merchantList = new ArrayList<>();
            if (nameOrder == 0)
                merchantList = userListRepository.getMerchantByNameDesc(userName, beginNumber, pageSize);
            else if (nameOrder == 1)
                merchantList = userListRepository.getMerchantByNameAsc(userName, beginNumber, pageSize);
            else if (idOrder == 0)
                merchantList = userListRepository.getMerchantByIdDesc(userName, beginNumber, pageSize);
            else if (idOrder == 1)
                merchantList = userListRepository.getMerchantByIdAsc(userName, beginNumber, pageSize);

            for (Object[] row : merchantList) {
                UserResponseDTO user = new UserResponseDTO();
                user.setUSER_ID((Integer) row[0]);
                user.setUSER_NAME((String) row[1]);
                user.setUSER_REGTIME(dateFormat.format(row[2]));
                user.setUSER_STATE((Integer) row[3]);
                user.setSTO_IMAGE((String) row[4]);

                users.add(user);
            }
        }

        return users;
    }
}
