package cn.tju.sse.spring_backend.service.cus.commodity;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityShoppingCartRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityShoppingCartResponseDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.mapper.CommodityShoppingCartResponseMapper;
import cn.tju.sse.spring_backend.model.*;
import cn.tju.sse.spring_backend.repository.cus.commodity.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

/**
 * @ClassName CommodityShoppingCartService
 * @author raoji
 * @date 2023/12/15
 * @Description 查询购物车消息的业务逻辑
 */
@Service
public class CommodityShoppingCartService {
    @Autowired
    private CommodityShoppingCartComCategoriesRepository commodityShoppingCartComCategoriesRepository;
    @Autowired
    private CommodityShoppingCartCommodityPriceCurveRepository commodityShoppingCartCommodityPriceCurveRepository;
    @Autowired
    private CommodityShoppingCartCommodityRepository commodityShoppingCartCommodityRepository;
    @Autowired
    private CommodityShoppingCartStoreRepository commodityShoppingCartStoreRepository;
    @Autowired
    private CommodityShoppingCartCommodityImageRepository commodityShoppingCartCommodityImageRepository;
    @Autowired
    private CommodityShoppingCartFavorateRepository commodityShoppingCartFavorateRepository;

    private final CommodityShoppingCartResponseMapper commodityShoppingCartResponseMapper
            = CommodityShoppingCartResponseMapper.INSTANCE;

    /**
     * @param requestDTO 前端发来的购物车商品消息和顾客id
     * @return 购物车中商品的详细消息
     * @see CommodityShoppingCartResponseDTO
     * @see CommodityShoppingCartRequestDTO
     */
    public CommodityShoppingCartResponseDTO shoppingCart(CommodityShoppingCartRequestDTO requestDTO){
        int cusId = requestDTO.getCus_id();
        Integer[] com_id_arr = requestDTO.getCom_id_arr();

        CommodityShoppingCartResponseDTO responseDTO = new CommodityShoppingCartResponseDTO();

        for(Integer com_id: com_id_arr){

            boolean existsCommodityEntity = commodityShoppingCartCommodityRepository
                    .existsById(com_id);
            if(!existsCommodityEntity){
                System.out.println("commodity id not found");
                continue;
            }
            CommodityEntity commodityEntity = commodityShoppingCartCommodityRepository
                    .findById(com_id).orElseThrow();

            CommodityImageEntity commodityImageEntity = commodityShoppingCartCommodityImageRepository
                    .findDistinctFirstByComId(com_id);

            CommodityCategoriesEntity[] commodityCategoriesEntities = commodityShoppingCartComCategoriesRepository
                    .findByComId(com_id).toArray(CommodityCategoriesEntity[]::new);

            FavoriteEntity[] favoriteEntities = commodityShoppingCartFavorateRepository
                    .findAllByCusIdAndComId(cusId, com_id).toArray(FavoriteEntity[]::new);

            StoreEntity storeEntity = commodityShoppingCartStoreRepository
                    .findById(commodityEntity.getStoId()).orElseThrow();

            CommodityShoppingCartResponseDTO.ComListItem dto_item =
                    commodityShoppingCartResponseMapper.entitiesToComListItem(
                            commodityEntity,
                            commodityImageEntity,
                            commodityCategoriesEntities,
                            storeEntity,
                            favoriteEntities);

            CommodityPriceCurveEntity[] commodityPriceCurveEntities = commodityShoppingCartCommodityPriceCurveRepository
                    .findAllByComId(com_id).toArray(CommodityPriceCurveEntity[]::new);

            Date[] pass_date = Arrays.stream(commodityPriceCurveEntities).map(CommodityPriceCurveEntity::getComPcTime)
                    .filter(date1 -> date1.before(new Date())).toArray(Date[]::new);

            int index = pass_date.length;
            if(index == 0){
                System.out.println("error by ex_date and price!");
            }

            dto_item.setCom_price(commodityPriceCurveEntities[index - 1].getComPcPrice().floatValue());
            responseDTO.getCom_list().addLast(dto_item);


            // 构建动态查询
//            Predicate p1 = QCommodityEntityRJ.commodityEntityRJ.comId.eq(com_id);
//            Predicate p2 = QFavoriteEntityRJ.favoriteEntityRJ.cusId.eq(cusId);
//            ShoppingCartView[] entities = commodityShoppingCartRepository.
//                    findByCusIdAndComId(p2, p1).toArray(ShoppingCartView[]::new);
//            ShoppingCartView[] entities = new ShoppingCartView[1];

//            if (entities.length == 0)
//                continue;
//            // 升序
//            Date[] dates = Arrays.stream(entities).map(ShoppingCartView::getComPcTime)
//                    .distinct().sorted(Comparator.naturalOrder()).toArray(Date[]::new);
//            // 降序
//            BigDecimal[] prices = Arrays.stream(entities).map(ShoppingCartView::getComPcPrice).
//                    distinct().sorted(Comparator.reverseOrder()).toArray(java.math.BigDecimal[]::new);
//
//            Date[] pass_date = Arrays.stream(dates).distinct().
//                    filter(date1 -> date1.before(new Date())).toArray(Date[]::new);
//
//            int index = pass_date.length;
//            if(index == 0){
//                System.out.println("error by ex_date and price!");
//            }
//            CommodityShoppingCartResponseDTO.ComListItem dto_item =
//                    commodityShoppingCartResponseMapper.entitiesToComListItem(entities);
//
//            dto_item.setCom_price(prices[index - 1].floatValue());
//            responseDTO.getCom_list().addLast(dto_item);
        }

        return responseDTO;
    }
}
