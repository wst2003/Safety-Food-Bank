package cn.tju.sse.spring_backend.controller.cus.history;

import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryNumberRequest;
import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryNumberResponse;
import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryRequest;
import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryResponse;
import cn.tju.sse.spring_backend.repository.cus.history.HistoryGetBrowsingHistoryNumberRepository;
import cn.tju.sse.spring_backend.service.cus.history.HistoryGetBrowsingHistoryNumberService;
import cn.tju.sse.spring_backend.service.cus.history.HistoryGetBrowsingHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/api/cus/history")
public class HistoryGetBrowsingHistoryNumberController {

    @Autowired
    HistoryGetBrowsingHistoryNumberService historyGetBrowsingHistoryNumberService;

    /**
     * 拉取用户浏览记录数量
     * 疑似路径有误！！！！！！！！！！！！！                                                                                                                      
     * @param historyGetBrowsingHistoryNumberRequest
     * @return
     */
    @PostMapping("/getBrowsingHistoryNumber")
    public ResponseEntity<?> getBrowsingHistory(@RequestBody HistoryGetBrowsingHistoryNumberRequest historyGetBrowsingHistoryNumberRequest){
        HistoryGetBrowsingHistoryNumberResponse response =historyGetBrowsingHistoryNumberService.getBrowsingHistoryNumberResponse(historyGetBrowsingHistoryNumberRequest.getCus_id());

        return ResponseEntity.ok().body(response);
    }
}