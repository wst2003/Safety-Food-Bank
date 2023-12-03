package cn.tju.sse.spring_backend.controller.sto;

import cn.tju.sse.spring_backend.dto.sto.UploadNoticeRequestDTO;
import cn.tju.sse.spring_backend.service.sto.UploadNoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用于处理上传通知请求的控制器类
 */
@RestController
@RequestMapping("/api/sto/uploadNotice")
public class UploadNoticeController {
    @Autowired
    private UploadNoticeService uploadNoticeService;

    /**
     * 处理上传通知的请求
     *
     * @param request 上传通知的请求数据对象
     * @return ResponseEntity 包含响应体和HTTP状态码的响应对象
     */
    @PostMapping("")
    public ResponseEntity<String> uploadNotice(@RequestBody UploadNoticeRequestDTO request) {
        String response = uploadNoticeService.uploadNotice(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
