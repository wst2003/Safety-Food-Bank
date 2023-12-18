package cn.tju.sse.spring_backend.service.sto.StoreQueryCommodity;

import cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity.SearchCommodityRequestDTO;
import cn.tju.sse.spring_backend.dto.sto.StoreQueryCommodity.SearchCommodityResponseDTO;
import cn.tju.sse.spring_backend.model.CommodityEntity;
import cn.tju.sse.spring_backend.repository.sto.StoreQueryCommodity.SearchCommodityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

/**
 * 按条件搜索商品的服务类
 */
@Service
public class SearchCommodityService {
    @Autowired
    private SearchCommodityRepository searchCommodityRepository;

    /**
     * 根据条件搜索商品，并返回搜索结果列表。
     *
     * @param stoId         商店ID。
     * @param comBeginNum   商品起始编号。
     * @param comEndNum     商品结束编号。
     * @param request       商品搜索请求信息。
     * @return 搜索结果列表。
     */
    public List<SearchCommodityResponseDTO> searchCommodity(int stoId, int comBeginNum, int comEndNum,
                                                            SearchCommodityRequestDTO request) {
        List<SearchCommodityResponseDTO> commoditys = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        int beginNumber = comBeginNum - 1;
        int pageSize = comEndNum - beginNumber;

        List<Integer> comIds;
        if (request.getCategory().size() > 0) {
            // 有category
            List<String> searchCategory = request.getCategory();

            if (request.getOrder() == 0)
                comIds = searchCommodityRepository.findComIdWithCategoryAsc(searchCategory, searchCategory.size(), stoId, request.getStatus(), request.getQuery(), beginNumber, pageSize);
            else
                comIds = searchCommodityRepository.findComIdWithCategoryDesc(searchCategory, searchCategory.size(), stoId, request.getStatus(), request.getQuery(), beginNumber, pageSize);
        } else {
            // 无category
            if (request.getOrder() == 0)
                comIds = searchCommodityRepository.findComIdWithoutCategoryAsc(stoId, request.getStatus(), request.getQuery(), beginNumber, pageSize);
            else
                comIds = searchCommodityRepository.findComIdWithoutCategoryDesc(stoId, request.getStatus(), request.getQuery(), beginNumber, pageSize);
        }
        String uploadDate = request.getCOM_UPLOADDATE();
        String expirationDate = request.getCOM_EXPIRATIONDATE();
        if (uploadDate.length() > 0)
            comIds.removeIf(element -> searchCommodityRepository.uploadDateLike(element, uploadDate) == 0);
        if (expirationDate.length() > 0)
            comIds.removeIf(element -> searchCommodityRepository.expirationDateLike(element, expirationDate) == 0);

        for (int comId : comIds) {
            SearchCommodityResponseDTO commodity = new SearchCommodityResponseDTO();
            BigDecimal currentPrice;

            CommodityEntity commodityEntity = searchCommodityRepository.findAllByComId(comId);
            commodity.setCom_id(commodityEntity.getComId());
            commodity.setCom_name(commodityEntity.getComName());
            commodity.setCom_left(commodityEntity.getComLeft());
            commodity.setCom_uploaddate(dateFormat.format(commodityEntity.getComUploaddate()));
            commodity.setCom_expirationdate(dateFormat.format(commodityEntity.getComExpirationdate()));

            currentPrice = commodityEntity.getComOriprice();

            List<String> categories = searchCommodityRepository.findComCategory(comId);
            commodity.setCom_categories(categories);

            List<Object[]> priceCurve = searchCommodityRepository.findComPriceCurve(comId);
            for (Object[] row : priceCurve) {
                Date currentDate = new Date(System.currentTimeMillis());
                Date curveDate = (Date) row[0];
                if (currentDate.before(curveDate))
                    break;
                currentPrice = (BigDecimal) row[1];
            }
            commodity.setCom_curr_price(currentPrice);

            List<String> images = searchCommodityRepository.findComImage(comId);
            commodity.setCom_image(images);

            commoditys.add(commodity);
        }

        return commoditys;
    }
}
