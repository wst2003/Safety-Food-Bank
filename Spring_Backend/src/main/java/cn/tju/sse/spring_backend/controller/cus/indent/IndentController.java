package cn.tju.sse.spring_backend.controller.cus.indent;

import cn.tju.sse.spring_backend.dto.cus.indent.*;
import cn.tju.sse.spring_backend.service.cus.indent.IndentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.text.ParseException;

/**
 * @author lhx
 * @date 2023/12/20
 * @Description 统一管理订单接口类
 */
@RestController
@RequestMapping("/api/cus/indent")
public class IndentController {
    @Autowired
    IndentService indentService;

    /**
     * @author lhx
     * @date 2023/12/20
     * @Description 生成订单
     */
    @RequestMapping(value = "/generateIndent", method = RequestMethod.POST)
    public ResponseEntity<MsgResponseDTO> generateIndent (@RequestBody GenerateIndentRequestDTO request) throws ParseException {
        MsgResponseDTO msgResponseDTO=new MsgResponseDTO();
        try {
            msgResponseDTO = indentService.generateIndent(request);
        }catch(RuntimeException e){
            msgResponseDTO.setMsg("订单生成失败");
        }
        return new ResponseEntity<>(msgResponseDTO, HttpStatus.OK);
    }
    /**
     * @author lhx
     * @date 2023/12/21
     * @Description 订单退款
     */
    @RequestMapping(value = "/refund", method = RequestMethod.POST)
    public ResponseEntity<RefundResponseDTO> refund (@RequestBody RefundRequestDTO request) throws ParseException {

        RefundResponseDTO refundResponseDTO=indentService.refund(request);
        return new ResponseEntity<>(refundResponseDTO, HttpStatus.OK);
    }

    /**
     * @author lhx
     * @date 2023/12/21
     * @Description 订单评价、评分
     */
    @RequestMapping(value = "/evaluation", method = RequestMethod.POST)
    public ResponseEntity<MsgResponseDTO> evaluation (@RequestBody EvaluationRequestDTO request) throws IOException {

        MsgResponseDTO msgResponseDTO=indentService.evaluation(request);
        return new ResponseEntity<>(msgResponseDTO, HttpStatus.OK);
    }

    @RequestMapping(value = "/getIndentList", method = RequestMethod.POST)
    public ResponseEntity<GetIndentListResponseDTO> getIndentList (@RequestBody GetIndentListRequestDTO request)  {

        GetIndentListResponseDTO getIndentListResponseDTO=indentService.getIndentList(request);
        return new ResponseEntity<>(getIndentListResponseDTO, HttpStatus.OK);
    }
}
