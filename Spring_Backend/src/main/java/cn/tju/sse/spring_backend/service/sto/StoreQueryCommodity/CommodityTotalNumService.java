package cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity.CommodityTotalNumRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommodityTotalNumService {
    @Autowired
    private CommodityTotalNumRepository commodityTotalNumRepository;

    public int getCommodityTotalNum(int stoId, int comStatus) {
        return commodityTotalNumRepository.countByStoIdAndComStatus(stoId, comStatus);
    }
}
