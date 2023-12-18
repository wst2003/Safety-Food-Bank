package cn.tju.sse.spring_backend.controller.cus.favorite;


import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerSetFavorStateRequest;
import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerSetFavorStateResponse;
import cn.tju.sse.spring_backend.service.cus.favorite.CustomerSetFavorStateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/*
关于用户收藏夹的控制类
 */
@RestController
@RequestMapping("/api/cus/favorite")
public class CustomerSetFavorStateController {
    @Autowired
    private CustomerSetFavorStateService customerSetFavorStateService;

    /**
     * 收藏、取消收藏操作
     * @param request 传入用户id，商品id和收藏状态
     * @return 返回操作是否成功以及收藏状态
     */
    @RequestMapping(value = "/setFavorState", method = RequestMethod.POST)
    public ResponseEntity<CustomerSetFavorStateResponse> customerSetFavorState
            (@RequestBody CustomerSetFavorStateRequest request){
        CustomerSetFavorStateResponse response = new CustomerSetFavorStateResponse();
        try {
            int result = customerSetFavorStateService.setFavorState(request);
            if(result==0){
                response.setMsg("成功，当前收藏状态：已收藏");
            }
            else if(result==1){
                response.setMsg("成功，当前收藏状态：未收藏");
            }
            else{
                response.setMsg("请求处理失败");
            }
        }
        catch(Exception e) {
            response.setMsg("请求处理失败");
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
