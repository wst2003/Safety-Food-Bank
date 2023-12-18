package cn.tju.sse.spring_backend.dto.cus.commodity.mapper;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetCurveResponseDTO;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.lang.reflect.Array;
import java.util.Arrays;

/**
 * @author raoji
 * @date 2023/12/13
 * @Description
 */
@Mapper
public interface CommodityGetCurveResponseMapper {
    CommodityGetCurveResponseMapper INSTANCE = Mappers.getMapper(CommodityGetCurveResponseMapper.class);

    @Mapping(source = "comPcTime", target = "com_pc_time")
    @Mapping(source = "comPcPrice", target = "com_pc_price")
    CommodityGetCurveResponseDTO.ComPrice entityToComPrice(CommodityPriceCurveEntity entity);

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
