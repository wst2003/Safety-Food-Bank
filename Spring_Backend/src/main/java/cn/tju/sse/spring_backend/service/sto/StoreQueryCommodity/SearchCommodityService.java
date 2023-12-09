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

@Service
public class SearchCommodityService {
    @Autowired
    private SearchCommodityRepository searchCommodityRepository;

    public List<SearchCommodityResponseDTO> searchCommodity(int stoId, int comBeginNum, int comEndNum,
                                                            SearchCommodityRequestDTO request) {
        List<SearchCommodityResponseDTO> commoditys = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        int beginNumber = comBeginNum - 1;
        int pageSize = comEndNum - beginNumber;

//        System.out.println(stoId);
//        System.out.println(comBeginNum);
//        System.out.println(comEndNum);
//        System.out.println(beginNumber);
//        System.out.println(pageSize);
//        System.out.println("-------");
//        System.out.println(request.getStatus());
//        System.out.println(request.getOrder());
//        System.out.println(request.getCategory().toString());
//        System.out.println(request.getQuery());
//        System.out.println(request.getCOM_UPLOADDATE_ORDER());
//        System.out.println(request.getCOM_EXPIRATIONDATE_ORDER());

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
        System.out.println("获得" + comIds.size());
        String uploadDate = request.getCOM_UPLOADDATE();
        String expirationDate = request.getCOM_EXPIRATIONDATE();
        if (uploadDate.length() > 0)
            comIds.removeIf(element -> searchCommodityRepository.uploadDateLike(element, uploadDate) == 0);
        System.out.println("剩余" + comIds.size());
        if (expirationDate.length() > 0)
            comIds.removeIf(element -> searchCommodityRepository.expirationDateLike(element, expirationDate) == 0);
        System.out.println("剩余" + comIds.size());

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
