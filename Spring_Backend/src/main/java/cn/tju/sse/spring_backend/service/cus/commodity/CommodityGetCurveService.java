package cn.tju.sse.spring_backend.service.cus.commodity;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetCurveRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetCurveResponseDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.mapper.CommodityGetCurveResponseMapper;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import cn.tju.sse.spring_backend.repository.cus.commodity.CommodityGetCurveRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author raoji
 * @date 2023/12/13
 * @Description
 */
@Service
public class CommodityGetCurveService {
    @Autowired
    private CommodityGetCurveRepository commodityGetCurveRepository;

    private final CommodityGetCurveResponseMapper commodityGetCurveResponseMapper
            = CommodityGetCurveResponseMapper.INSTANCE;

    public CommodityGetCurveResponseDTO getCurve(CommodityGetCurveRequestDTO requestDTO){
        List<CommodityPriceCurveEntity> entities = commodityGetCurveRepository.
                findAllByComId(requestDTO.getCom_id());

        CommodityGetCurveResponseDTO responseDTO = commodityGetCurveResponseMapper
                .entitiesToResponses(entities.toArray(new CommodityPriceCurveEntity[0]));

        return responseDTO;
    }
}
