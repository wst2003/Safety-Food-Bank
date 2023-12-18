package cn.tju.sse.spring_backend.repository.cus.favorite;

import cn.tju.sse.spring_backend.model.FavoriteEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/*
进入收藏夹接口
 */
public interface CustomerGetFavorRepository extends JpaRepository<FavoriteEntity,Integer>{

    /**
     * 查询该用户是否有收藏的商品
     * @param cus_id 传入用户id
     * @return 返回对应用户的收藏商品
     */
    @Query(value = "SELECT COM_ID FROM FAVORITE WHERE CUS_ID = :cus_id",nativeQuery = true)
    List<String> findComIDByCusID(int cus_id);

}
