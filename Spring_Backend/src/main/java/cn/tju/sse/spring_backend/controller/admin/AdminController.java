package cn.tju.sse.spring_backend.controller.admin;

import cn.tju.sse.spring_backend.dto.admin.UserResponseDTO;
import cn.tju.sse.spring_backend.service.admin.UserListService;
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
}
