package cn.tju.sse.spring_backend.controller.cus.commodity;


import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityCommentRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityCommentResponseDTO;
import cn.tju.sse.spring_backend.service.cus.commodity.CommodityCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;


@Controller
@RequestMapping("/api/cus/commodity")
public class CommodityCommentController {
    @Autowired
    private CommodityCommentService commodityCommentService;

    /**
     *发布评论
     * @param request
     * @return
     */
    @PostMapping ("/comment")
    public ResponseEntity<?> commodityComment(@RequestBody CommodityCommentRequestDTO request) throws IOException {
        CommodityCommentResponseDTO responseDTO=commodityCommentService.publishComment(request.getUser_id(),request.getCmt_content(), request.getCmt_father(), request.getCom_id());
        return ResponseEntity.ok().body(responseDTO);
    }
}
