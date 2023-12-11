package cn.tju.sse.spring_backend.controller.admin;

import cn.tju.sse.spring_backend.dto.admin.ChangeUserStateRequestDTO;
import cn.tju.sse.spring_backend.dto.admin.UserResponseDTO;
import cn.tju.sse.spring_backend.service.admin.UserListService;
import cn.tju.sse.spring_backend.service.admin.UserStateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户列表控制器类
 */
@RestController
@RequestMapping("/api/admin")
public class AdminController {
    @Autowired
    private UserListService userListService;
    @Autowired
    private UserStateService userStateService;

    /**
     * 获取用户列表
     *
     * @param ID_ORDER      用户ID的排序方式
     * @param NAME_ORDER    用户名的排序方式
     * @param USER_NAME     用户名关键字
     * @param USER_TYPE     用户类型
     * @param BEGIN_NUMBER  开始位置
     * @param END_NUMBER    结束位置
     * @return ResponseEntity<List<UserResponseDTO>> 包含用户列表的响应实体
     */
    @GetMapping("/userlist")
    public ResponseEntity<List<UserResponseDTO>> getUserList(@RequestParam int ID_ORDER, @RequestParam int NAME_ORDER,
                                                             @RequestParam String USER_NAME, @RequestParam int USER_TYPE,
                                                             @RequestParam int BEGIN_NUMBER, @RequestParam int END_NUMBER) {
        List<UserResponseDTO> response = userListService.getUserList(ID_ORDER, NAME_ORDER, USER_NAME, USER_TYPE, BEGIN_NUMBER, END_NUMBER);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /**
     * 获取用户状态
     *
     * @param USER_ID   用户ID
     * @param USER_TYPE 用户类型
     * @return ResponseEntity<Integer> 包含用户状态的响应实体
     */
    @GetMapping("/userstate")
    public ResponseEntity<Integer> getUserState(@RequestParam int USER_ID, @RequestParam int USER_TYPE) {
        int response = userStateService.getUserState(USER_ID, USER_TYPE);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /**
     * 修改用户状态
     *
     * @param request 包含修改用户状态的请求体
     * @return ResponseEntity<String> 响应实体，表示修改是否成功
     */
    @PostMapping("/changeuserstate")
    public ResponseEntity<String> changeUserState(@RequestBody ChangeUserStateRequestDTO request) {
        boolean success = userStateService.changeUserState(request);
        if (success)
            return new ResponseEntity<>(HttpStatus.OK);
        else
            return new ResponseEntity<>("未更新成功", HttpStatus.OK);
    }
}
