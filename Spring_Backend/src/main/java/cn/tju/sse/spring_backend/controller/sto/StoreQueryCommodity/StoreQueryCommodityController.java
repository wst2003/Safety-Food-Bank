package cn.tju.sse.spring_backend.controller.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity.CommodityDetailResponseDTO;
import cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity.SearchCommodityRequestDTO;
import cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity.SearchCommodityResponseDTO;
import cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity.CommodityDetailService;
import cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity.CommodityImagePathService;
import cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity.CommodityTotalNumService;
import cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity.SearchCommodityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 查询商品信息的控制器类
 */
@RestController
@RequestMapping("/api/sto/StoreQueryCommodity")
public class StoreQueryCommodityController {
    @Autowired
    private CommodityDetailService commodityDetailService;
    @Autowired
    private SearchCommodityService searchCommodityService;
    @Autowired
    private CommodityTotalNumService commodityTotalNumService;
    @Autowired
    private CommodityImagePathService imagePathService;

    /**
     * 获取指定商品ID的商品详细信息。
     *
     * @param com_id  商品ID。
     * @return        包含商品详细信息的响应实体。
     */
    @GetMapping("/detail")
    public ResponseEntity<CommodityDetailResponseDTO> getCommodityDetail(@RequestParam int com_id) {
        CommodityDetailResponseDTO response = commodityDetailService.getCommodityDetail(com_id);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /**
     * 搜索商品列表。
     *
     * @param STO_ID     商店ID。
     * @param com_begin_n 商品起始位置。
     * @param com_end_n   商品结束位置。
     * @param request    搜索商品请求体。
     * @return 包含搜索结果的响应实体。
     */
    @PostMapping("/list")
    public ResponseEntity<List<SearchCommodityResponseDTO>> searchCommodity(@RequestParam(value = "STO_ID") int STO_ID,
                                                                            @RequestParam(value = "com_begin_n") int com_begin_n,
                                                                            @RequestParam(value = "com_end_n") int com_end_n,
                                                                            @RequestBody SearchCommodityRequestDTO request) {
        List<SearchCommodityResponseDTO> response = searchCommodityService.searchCommodity(STO_ID, com_begin_n, com_end_n, request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /**
     * 获取商品总数量。
     *
     * @param STO_ID     商店ID。
     * @param COM_STATUS 商品状态。
     * @return 商品总数量。
     */
    @GetMapping("/totalnum")
    public ResponseEntity<Integer> getCommodityTotalNum(@RequestParam int STO_ID, @RequestParam int COM_STATUS) {
        int response = commodityTotalNumService.getCommodityTotalNum(STO_ID, COM_STATUS);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /**
     * 获取商品图片路径列表。
     *
     * @param COM_ID 商品ID。
     * @return 商品图片路径列表。
     */
    @GetMapping("/imgpath")
    public ResponseEntity<List<String>> getImagePath(@RequestParam int COM_ID) {
        List<String> response = imagePathService.getImagePath(COM_ID);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
