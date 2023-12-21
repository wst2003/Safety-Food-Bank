package cn.tju.sse.spring_backend.dto.cus.commodity.mapper;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetCurveResponseDTO;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.lang.reflect.Array;
import java.util.Arrays;

/**
 * @ClassName CommodityGetCurveResponseMapper
 * @author raoji
 * @date 2023/12/13
 * @Description 用于将查询到的商品转化为发送给前端的消息
 */
@Mapper
public interface CommodityGetCurveResponseMapper {
    CommodityGetCurveResponseMapper INSTANCE = Mappers.getMapper(CommodityGetCurveResponseMapper.class);

    /**
     * @param entity 查询到的价格曲线实体
     * @return 发送给前端的价格-曲线对
     * @see CommodityGetCurveResponseDTO.ComPrice
     * @see CommodityPriceCurveEntity
     */
    @Mapping(source = "comPcTime", target = "com_pc_time")
    @Mapping(source = "comPcPrice", target = "com_pc_price")
    CommodityGetCurveResponseDTO.ComPrice entityToComPrice(CommodityPriceCurveEntity entity);

    /**
     * @param entities 查询到的多个价格曲线实体
     * @return 发送给前端的一个消息数组
     * @see CommodityPriceCurveEntity
     * @see CommodityGetCurveResponseDTO
     */
    default CommodityGetCurveResponseDTO entitiesToResponses(CommodityPriceCurveEntity[] entities){
        if (entities == null)
            return new CommodityGetCurveResponseDTO();

        CommodityGetCurveResponseDTO.ComPrice[] target = Arrays.stream(entities)
                .map(this::entityToComPrice).toArray(CommodityGetCurveResponseDTO.ComPrice[]::new);

        CommodityGetCurveResponseDTO responseDTO = new CommodityGetCurveResponseDTO();
        responseDTO.setCom_prices(target);
        return responseDTO;

    }

}
