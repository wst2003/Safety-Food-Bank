package cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity.CommodityImagePathRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommodityImagePathService {
    @Autowired
    private CommodityImagePathRepository imagePathRepository;

    public List<String> getImagePath(int comId) {
        return imagePathRepository.findImageByComId(comId);
    }
}
