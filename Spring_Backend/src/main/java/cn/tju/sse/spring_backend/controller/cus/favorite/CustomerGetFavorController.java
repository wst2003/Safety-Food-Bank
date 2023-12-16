package cn.tju.sse.spring_backend.controller.cus.favorite;

import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerGetFavorFailResponse;
import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerGetFavorResponse;
import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerSetFavorStateRequest;
import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerSetFavorStateResponse;
import cn.tju.sse.spring_backend.service.cus.favorite.CustomerGetFavorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/*
    关于收藏夹的控制类
 */
@RestController
@RequestMapping("/api/cus/favorite")
public class CustomerGetFavorController {
    @Autowired
    private CustomerGetFavorService customerGetFavorService;

    /**
     * 获取用户收藏夹列表
     * @param cus_id 传入用户id
     * @return 返回用户已收藏的商品列表信息
     */
    @RequestMapping(value = "/getFavor", method = RequestMethod.GET)
    public ResponseEntity<?> customerSetFavorState
            (@RequestParam int cus_id){
        CustomerGetFavorResponse response;
        try {
            response = customerGetFavorService.getFavorList(cus_id);
        }
        catch(Exception e){
            CustomerGetFavorFailResponse failResponse = new CustomerGetFavorFailResponse();
            failResponse.setMsg("获取收藏夹失败");
            return ResponseEntity.ok().body(failResponse);
        }
        return ResponseEntity.ok().body(response);
    }
}
