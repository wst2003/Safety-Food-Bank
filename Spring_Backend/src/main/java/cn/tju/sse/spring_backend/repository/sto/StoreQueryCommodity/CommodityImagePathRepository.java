package cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.model.CommodityImageEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CommodityImagePathRepository extends JpaRepository<CommodityImageEntity, CommodityImageEntity> {
    @Query(value = "SELECT COM_IMAGE FROM COMMODITY_IMAGE WHERE COM_ID = :com_id", nativeQuery = true)
    List<String> findImageByComId(@Param("com_id") int comId);
}
