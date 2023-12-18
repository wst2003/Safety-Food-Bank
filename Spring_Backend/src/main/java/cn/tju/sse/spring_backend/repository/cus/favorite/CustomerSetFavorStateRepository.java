package cn.tju.sse.spring_backend.repository.cus.favorite;

import cn.tju.sse.spring_backend.model.FavoriteEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/*
收藏取消收藏接口
 */
public interface CustomerSetFavorStateRepository extends JpaRepository<FavoriteEntity,Integer> {
    /**
     * 在数据库的收藏夹表中查询该用户和商品
     * @param cus_id com_id 传入用户id和商品id
     * @return 返回对应用户的收藏商品的实体
     */
    FavoriteEntity findFavoriteEntityByComIdAndCusId(int com_id,int cus_id);
}
