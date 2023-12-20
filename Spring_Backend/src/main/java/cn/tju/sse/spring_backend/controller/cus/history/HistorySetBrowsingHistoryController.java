package cn.tju.sse.spring_backend.controller.cus.history;


import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryNumberRequest;
import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryNumberResponse;
import cn.tju.sse.spring_backend.dto.cus.history.HistorySetBrowsingHistoryRequest;
import cn.tju.sse.spring_backend.dto.cus.history.HistorySetBrowsingHistoryResponse;
import cn.tju.sse.spring_backend.service.cus.history.HistoryGetBrowsingHistoryNumberService;
import cn.tju.sse.spring_backend.service.cus.history.HistorySetBrowsingHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api/cus/history")
public class HistorySetBrowsingHistoryController {

    @Autowired
    HistorySetBrowsingHistoryService historySetBrowsingHistoryService;


    /**
     * 添加用户浏览记录
     * @param historySetBrowsingHistoryRequest
     * @return
     */
    @PostMapping("/setBrowsingHistory")
    public ResponseEntity<?> setBrowsingHistory(@RequestBody HistorySetBrowsingHistoryRequest historySetBrowsingHistoryRequest){
        HistorySetBrowsingHistoryResponse response =historySetBrowsingHistoryService.setBrowsingHistory(
                historySetBrowsingHistoryRequest.getBro_time_start(),
                historySetBrowsingHistoryRequest.getBro_time_end(),
                historySetBrowsingHistoryRequest.getBrowser_id(),
                historySetBrowsingHistoryRequest.getCom_id(),
                historySetBrowsingHistoryRequest.getWhether_buy());

        return ResponseEntity.ok().body(response);
    }

}
