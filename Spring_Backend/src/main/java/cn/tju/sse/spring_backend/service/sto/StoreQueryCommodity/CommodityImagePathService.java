package cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity.CommodityImagePathRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 获取商品图片路径的服务类
 */
@Service
public class CommodityImagePathService {
    @Autowired
    private CommodityImagePathRepository imagePathRepository;

    /**
     * 根据商品ID获取商品的图片路径列表。
     *
     * @param comId 商品ID。
     * @return 商品的图片路径列表。
     */
    public List<String> getImagePath(int comId) {
        return imagePathRepository.findImageByComId(comId);
    }
}
