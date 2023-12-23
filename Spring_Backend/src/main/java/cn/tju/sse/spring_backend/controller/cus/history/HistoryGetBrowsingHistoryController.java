package cn.tju.sse.spring_backend.controller.cus.history;


import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryRequest;
import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryResponse;
import cn.tju.sse.spring_backend.repository.cus.history.HistoryGetBrowsingHistoryRepository;
import cn.tju.sse.spring_backend.service.cus.history.HistoryGetBrowsingHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequestMapping("/api/cus/history")
public class HistoryGetBrowsingHistoryController {

    @Autowired
    HistoryGetBrowsingHistoryService historyGetBrowsingHistoryService;

    /**
     * 获取详细浏览历史
     * @param historyGetBrowsingHistoryRequest
     * @return
     */
    @PostMapping("/getBrowsingHistory")
    public ResponseEntity<?> getBrowsingHistory(@RequestBody HistoryGetBrowsingHistoryRequest historyGetBrowsingHistoryRequest){
        HistoryGetBrowsingHistoryResponse response =historyGetBrowsingHistoryService.getBrowsingHistory(historyGetBrowsingHistoryRequest.getCus_id(),historyGetBrowsingHistoryRequest.getBegin_pos(),historyGetBrowsingHistoryRequest.getEnd_pos(),historyGetBrowsingHistoryRequest.getSearch_str());
        return ResponseEntity.ok().body(response);
    }
}
