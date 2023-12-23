package cn.tju.sse.spring_backend.controller.cus.appeal;


import cn.tju.sse.spring_backend.dto.cus.appeal.CreateAppealRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.appeal.MsgResponseDTO;
import cn.tju.sse.spring_backend.dto.cus.indent.RefundRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.indent.RefundResponseDTO;
import cn.tju.sse.spring_backend.service.cus.appeal.AppealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.text.ParseException;

/**
 * @author lhx
 * @date 2023/12/23
 * @Description 统一管理申诉类
 */
@RestController
@RequestMapping("/api/cus/appeal")
public class AppealController {
    @Autowired
    AppealService appealService;

    /**
     * @author lhx
     * @date 2023/12/23
     * @Description 创建申诉
     */
    @RequestMapping(value = "/createAppeal", method = RequestMethod.POST)
    public ResponseEntity<MsgResponseDTO> createAppeal (@RequestBody CreateAppealRequestDTO request) throws ParseException {

        MsgResponseDTO responseDTO=appealService.createAppeal(request);
        return new ResponseEntity<>(responseDTO, HttpStatus.OK);
    }
}
