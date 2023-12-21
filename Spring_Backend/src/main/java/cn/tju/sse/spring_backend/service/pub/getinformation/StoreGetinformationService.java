package cn.tju.sse.spring_backend.service.pub.getinformation;

import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.getinformation.mapper.StoreGetinformationRequestMapper;
import cn.tju.sse.spring_backend.dto.pub.getinformation.mapper.StoreGetinformationResponseMapper;
import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreEntity;
import cn.tju.sse.spring_backend.repository.pub.getinformation.StoreCategoriesGetinformationRepository;
import cn.tju.sse.spring_backend.repository.pub.getinformation.StoreGetinformationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * @ClassName StoreGetinformationService
 * @Author RaoJi
 * @Description 查询商家基本信息的业务逻辑
 */
@Service
public class StoreGetinformationService {
    @Autowired
    StoreCategoriesGetinformationRepository storeCategoriesGetinformationRepository;
    private final StoreGetinformationResponseMapper storeGetinformationResponseMapper
            = StoreGetinformationResponseMapper.INSTANCE;

    @Autowired
    StoreGetinformationRepository storeGetinformationRepository;

    private final StoreGetinformationRequestMapper storeGetinformationRequestMapper
            = StoreGetinformationRequestMapper.INSTANCE;

    /**
     * @param request 前端发来的消息
     * @return 回复给前端的消息
     * @see StoreGetinformationResponseDTO
     * @see StoreGetinformationRequestDTO
     */
    public StoreGetinformationResponseDTO StoreGetinformation(StoreGetinformationRequestDTO request){
        StoreGetinformationResponseDTO response = new StoreGetinformationResponseDTO();

        boolean existsStore = storeGetinformationRepository.
                existsByStoId(Integer.valueOf(request.getSto_ID()));

        if(!existsStore){
            response.setMessage("store not found");
            return response;
        }

        Optional<StoreEntity> store = storeGetinformationRepository.
                findById(Integer.valueOf(request.getSto_ID()));

        if(store.isEmpty()){
            response.setMessage("error occurred in database");
            return response;
        }

        StoreCategoriesEntity[] categoriesEntities = storeCategoriesGetinformationRepository.
                findAllByStoreId(Integer.valueOf(request.getSto_ID())).toArray(new StoreCategoriesEntity[0]);

        response = storeGetinformationResponseMapper.entityToResponse(store.orElseThrow(), categoriesEntities);
        response.setMessage("success");
        return response;
    }

}
