package cn.tju.sse.spring_backend.controller.cus.store;

import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerGetFavorResponse;
import cn.tju.sse.spring_backend.dto.cus.store.CustomerGetStoreDetailFailResponse;
import cn.tju.sse.spring_backend.dto.cus.store.CustomerGetStoreDetailResponse;
import cn.tju.sse.spring_backend.service.cus.store.CustomerGetStoreDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/*
关于商店的控制类
 */
@RestController
@RequestMapping("/api/cus/store")
public class CustomerGetStoreDetailController {
    @Autowired
    private CustomerGetStoreDetailService customerGetStoreDetailService;

    /**
     * 进入商店详情内
     * @param sto_id cus_id 传入商店id和用户id，用户id是为了显示商店内的商品是否被用户收藏
     * @return 返回商店详情信息
     */
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public ResponseEntity<?> customerGetStoreDetail
            (@RequestParam int sto_id,@RequestParam int cus_id){
        CustomerGetStoreDetailResponse response = new CustomerGetStoreDetailResponse();
        try{
            response = customerGetStoreDetailService.getStoreDetail(sto_id, cus_id);
        }
        catch (Exception e){
            CustomerGetStoreDetailFailResponse failResponse = new CustomerGetStoreDetailFailResponse();
            failResponse.setMsg("请求失败");
            return ResponseEntity.ok().body(failResponse);
        }
        if(response==null){
            CustomerGetStoreDetailFailResponse failResponse = new CustomerGetStoreDetailFailResponse();
            failResponse.setMsg("请求失败");
            return ResponseEntity.ok().body(failResponse);
        }
        return ResponseEntity.ok().body(response);
    }
}
