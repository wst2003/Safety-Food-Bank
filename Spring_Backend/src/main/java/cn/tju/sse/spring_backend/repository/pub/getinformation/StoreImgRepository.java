package cn.tju.sse.spring_backend.repository.pub.getinformation;

import cn.tju.sse.spring_backend.model.StoreimageEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreImgResponseDTO;

import java.util.List;

@Repository
public interface StoreImgRepository extends JpaRepository<StoreimageEntity,Integer> {
    @Query("select new cn.tju.sse.spring_backend.dto.pub.getinformation.StoreImgResponseDTO(q.stoImage) from StoreimageEntity q where q.stoId=:sto_ID")
    public List<StoreImgResponseDTO> storeImg(@Param("sto_ID") String sto_ID);

}
