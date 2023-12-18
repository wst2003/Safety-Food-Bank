package cn.tju.sse.spring_backend.service.cus.favorite;

import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerSetFavorStateRequest;
import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerSetFavorStateResponse;
import cn.tju.sse.spring_backend.model.FavoriteEntity;
import cn.tju.sse.spring_backend.repository.cus.favorite.CustomerSetFavorStateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CustomerSetFavorStateService {
    @Autowired
    private CustomerSetFavorStateRepository customerSetFavorStateRepository;
    /**
     * 设置收藏状态
     * @param request 收藏、取消收藏请求
     * @return 修改收藏状态，并返回收藏状态信息，0添加收藏成功，1取消收藏成功，2操作失败
     */
    public int setFavorState(CustomerSetFavorStateRequest request){
        int favor_state = request.getFavor_state();
        int com_id = request.getCom_id();
        int cus_id = request.getCus_id();
        //判断favor_state为0还是1
        // 取消收藏操作
        if(favor_state==0){
            FavoriteEntity favoriteEntity = customerSetFavorStateRepository.findFavoriteEntityByComIdAndCusId(com_id,cus_id);
            if(favoriteEntity!=null){
                customerSetFavorStateRepository.delete(favoriteEntity);
                return 1;
            }
            else
                return 2;
        }
        // 添加收藏
        else{
            FavoriteEntity new_favor = new FavoriteEntity();
            new_favor.setComId(com_id);
            new_favor.setCusId(cus_id);
            FavoriteEntity insert_favor = customerSetFavorStateRepository.save(new_favor);
            if(insert_favor!=null)
                return 0;
            else
                return 2;
        }
    }
}
