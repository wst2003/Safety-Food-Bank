package cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity.CommodityDetailResponseDTO;
import cn.tju.sse.spring_backend.model.CommodityEntity;
import cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity.CommodityDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * 获取商品详细信息的服务类
 */
@Service
public class CommodityDetailService {
    @Autowired
    private CommodityDetailRepository commodityDetailRepository;

    /**
     * 获取指定商品ID的商品详细信息。
     *
     * @param comId  商品ID。
     * @return       包含商品详细信息的响应数据传输对象。
     */
    public CommodityDetailResponseDTO getCommodityDetail(int comId) {
        CommodityDetailResponseDTO response = new CommodityDetailResponseDTO();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        CommodityEntity commodity = commodityDetailRepository.findCommodityEntityById(comId);
        if (commodity == null)
            return response;
        response.setCom_id(commodity.getComId());
        response.setCom_name(commodity.getComName());
        response.setCom_introduction(commodity.getComIntroduction());
        response.setCom_oriprice(commodity.getComOriprice());
        response.setCom_expirationdate(dateFormat.format(commodity.getComExpirationdate()));
        response.setCom_uploaddate(dateFormat.format(commodity.getComUploaddate()));
        response.setCom_left(commodity.getComLeft());
        response.setCom_rating(commodity.getComRating());

        List<String> categories = commodityDetailRepository.findCommodityCategoryById(comId);
        response.setCom_categories(categories);

        List<String> images = commodityDetailRepository.findCommodityImageById(comId);
        response.setCom_image(images);

        List<Object[]> priceCurve = commodityDetailRepository.findCommodityPriceCurveById(comId);
        List<String> comPriceCurveTime = new ArrayList<>();
        List<BigDecimal> comPriceCurvePrice = new ArrayList<>();
        for (Object[] row : priceCurve) {
            comPriceCurveTime.add(dateFormat.format(row[0]));
            comPriceCurvePrice.add((BigDecimal) row[1]);
        }
        response.setCom_pc_time(comPriceCurveTime);
        response.setCom_pc_price(comPriceCurvePrice);

        return response;
    }
}
