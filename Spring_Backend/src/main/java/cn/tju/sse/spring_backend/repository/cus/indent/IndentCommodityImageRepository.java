package cn.tju.sse.spring_backend.repository.cus.indent;

import cn.tju.sse.spring_backend.model.CommodityImageEntity;
import cn.tju.sse.spring_backend.model.CommodityImageEntityPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface IndentCommodityImageRepository extends JpaRepository<CommodityImageEntity, CommodityImageEntityPK> {

    @Query(value="SELECT * FROM COMMODITY_IMAGE WHERE COM_ID=:com_id ORDER BY COM_ID DESC ",nativeQuery = true)
    List<Object[]> getReferenceByComID(@Param("com_id") Integer comId);
}
