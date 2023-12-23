package cn.tju.sse.spring_backend.controller.cus.search;

import cn.tju.sse.spring_backend.dto.cus.search.*;
import cn.tju.sse.spring_backend.service.cus.search.SearchItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author lhx
 * @date 2023/12/22
 * @Description 用于管理搜索商家、搜索商品的Controller
 */
@RestController
@RequestMapping("/api/cus/search")
public class SearchItemController {
    @Autowired
    SearchItemService searchItemService;

    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 用于搜索商品
     */
    @RequestMapping(value = "/commodityList", method = RequestMethod.POST)
    public ResponseEntity<CommodityListResponseDTO> commodityList(@RequestBody CommodityListRequestDTO request){
        CommodityListResponseDTO responseDTO = searchItemService.commodityList(request);
        return new ResponseEntity<>(responseDTO, HttpStatus.OK);
    }

    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 用于搜索商店
     */
    @RequestMapping(value = "/storeList", method = RequestMethod.POST)
    public ResponseEntity<StoreListResponseDTO> storeList(@RequestBody StoreListRequestDTO request){
        StoreListResponseDTO responseDTO = searchItemService.storeList(request);
        return new ResponseEntity<>(responseDTO, HttpStatus.OK);
    }


}
