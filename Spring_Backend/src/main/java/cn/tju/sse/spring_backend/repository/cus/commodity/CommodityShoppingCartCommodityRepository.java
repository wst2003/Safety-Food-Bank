package cn.tju.sse.spring_backend.repository.cus.commodity;

import cn.tju.sse.spring_backend.model.CommodityEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * @author raoji
 * @date 2023/12/17
 * @Description
 */
public interface CommodityShoppingCartCommodityRepository extends JpaRepository<CommodityEntity, Integer> {

}
