package cn.tju.sse.spring_backend.dto.cus.commodity.mapper;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityShoppingCartResponseDTO;
import cn.tju.sse.spring_backend.model.*;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.Arrays;

/**
 * @ClassName CommodityShoppingCartResponseMapper
 * @author raoji
 * @date 2023/12/13
 * @Description 将查询到的商家实体、顾客实体、类别实体、商家照片实体等转化为发送给前端的消息
 */
@Mapper
public interface CommodityShoppingCartResponseMapper {
    CommodityShoppingCartResponseMapper INSTANCE =
            Mappers.getMapper(CommodityShoppingCartResponseMapper.class);

//    @Mapping(source = "commodityEntity.comId", target = "com_id")
//    @Mapping(source = "commodityEntity.comName", target = "com_name")
//    @Mapping(source = "commodityEntity.comIntroduction", target = "com_introduction")
//    @Mapping(source = "commodityEntity.comUploaddate", target = "uploadDate")
//    @Mapping(source = "commodityEntity.comLeft", target = "com_left")
//    @Mapping(source = "commodityEntity.comOriPrice", target = "com_oriPrice")
//    @Mapping(source = "commodityEntity.comRating", target = "com_rating")
//    @Mapping(source = "commodityEntity.stoId", target = "sto_id")
//    @Mapping(source = "commodityEntity.comStatus", target = "com_status")
//    @Mapping(expression = "java(present(entities[0].cusId))", target = "favor_state")
//    @Mapping(source = "commodityImageEntity.comImage", target = "com_firstImage")
//    @Mapping(source = "storeEntity.stoName", target = "sto_name")
//    @Mapping(source = "commodityEntity.expirationDate", target = "com_expirationDate")

    /**
     * @param commodityEntity 查询到的商品实体
     * @param commodityImageEntity 查询到的商品照片实体
     * @param commodityCategoriesEntities 查询到的商品所属类别实体
     * @param storeEntity 查询到的商家实体
     * @param favoriteEntities 查询到的用户收藏实体
     * @return 发送给前端的用户消息对
     * @see CommodityEntity
     * @see CommodityImageEntity
     * @see CommodityCategoriesEntity
     * @see StoreEntity
     * @see FavoriteEntity
     * @see CommodityShoppingCartResponseDTO.ComListItem
     */
    default CommodityShoppingCartResponseDTO.ComListItem entitiesToComListItem
            (CommodityEntity commodityEntity,
             CommodityImageEntity commodityImageEntity,
             CommodityCategoriesEntity[] commodityCategoriesEntities,
             StoreEntity storeEntity,
             FavoriteEntity[] favoriteEntities){
        if(commodityEntity == null){
            return new CommodityShoppingCartResponseDTO.ComListItem();
        }

        CommodityShoppingCartResponseDTO.ComListItem item =
                new CommodityShoppingCartResponseDTO.ComListItem();

        item.setCom_id(commodityEntity.getComId());
        item.setCom_name(commodityEntity.getComName());
        item.setCom_introduction(commodityEntity.getComIntroduction());
        item.setCom_expirationDate(commodityEntity.getComExpirationdate().toString());
        item.setCom_uploadDate(commodityEntity.getComUploaddate().toString());
        item.setCom_left(commodityEntity.getComLeft());
        item.setCom_rating(commodityEntity.getComRating().intValue());
        item.setSto_id(commodityEntity.getStoId());
        item.setCom_oriPrice(commodityEntity.getComOriprice().floatValue());
        item.setCom_status(commodityEntity.getComStatus());
        item.setSto_name(storeEntity.getStoName());
        item.setCom_firstImage(commodityImageEntity!=null?commodityImageEntity.getComImage():"暂无图片");

        item.setCom_categories(Arrays.stream(commodityCategoriesEntities).map
                (CommodityCategoriesEntity::getComCategory).distinct().toArray(String[]::new));
        item.setFavor_state((favoriteEntities.length==0?0:1));
//        item.setCom_firstImage(Arrays.stream(entities).map(ShoppingCartView::getComImage)
//                .distinct().findFirst().orElse("暂无图片"));

        return item;
    }

//    default int present(Integer cusId){
//        return cusId == null? 0 :1;
//    }
}
