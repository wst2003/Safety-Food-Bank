package cn.tju.sse.spring_backend.controller.sto.StoreIndentList;

import cn.tju.sse.spring_backend.dto.sto.StoreIndentList.IndentBoxResponseDTO;
import cn.tju.sse.spring_backend.dto.sto.StoreIndentList.RefundResponseDTO;
import cn.tju.sse.spring_backend.service.sto.StoreIndentList.IndentBoxService;
import cn.tju.sse.spring_backend.service.sto.StoreIndentList.RefundListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 订单信息控制器类
 */
@RestController
@RequestMapping("/api/sto/storeindentlist")
public class StoreIndentListController {
    @Autowired
    private RefundListService refundListService;
    @Autowired
    private IndentBoxService indentBoxService;

    /**
     * 获取退款订单列表
     *
     * @param STO_ID       商家ID
     * @param TIME_ORDER   时间排序方式
     * @param USER_PHONE   用户手机号
     * @param BEGIN_NUMBER 开始位置
     * @param END_NUMBER   结束位置
     * @return ResponseEntity<List<RefundResponseDTO>> 包含退款列表的响应实体
     */
    @GetMapping("/refundlist")
    public ResponseEntity<List<RefundResponseDTO>> getRefundList(@RequestParam int STO_ID,
                                                                 @RequestParam int TIME_ORDER,
                                                                 @RequestParam String USER_PHONE,
                                                                 @RequestParam int BEGIN_NUMBER,
                                                                 @RequestParam int END_NUMBER) {
        List<RefundResponseDTO> response = refundListService.getRefundList(STO_ID, TIME_ORDER, USER_PHONE, BEGIN_NUMBER, END_NUMBER);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /**
     * 获取订单列表
     *
     * @param STO_ID     商家ID
     * @param TIME_ORDER 时间排序方式
     * @param BOX_BEGIN  箱子开始位置
     * @param BOX_END    箱子结束位置
     * @param USER_PHONE 用户手机号
     * @param IND_STATE  订单状态
     * @return ResponseEntity<List<IndentBoxResponseDTO>> 包含订单箱子列表的响应实体
     */
    @GetMapping("/indentbox")
    public ResponseEntity<List<IndentBoxResponseDTO>> getIndentBox(@RequestParam int STO_ID,
                                                                   @RequestParam int TIME_ORDER,
                                                                   @RequestParam int BOX_BEGIN,
                                                                   @RequestParam int BOX_END,
                                                                   @RequestParam String USER_PHONE,
                                                                   @RequestParam int IND_STATE) {
        List<IndentBoxResponseDTO> response = indentBoxService.getIndentWithBox(STO_ID, TIME_ORDER, BOX_BEGIN, BOX_END, USER_PHONE, IND_STATE);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
