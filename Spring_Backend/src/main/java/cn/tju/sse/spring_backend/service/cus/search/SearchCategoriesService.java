package cn.tju.sse.spring_backend.service.cus.search;

import cn.tju.sse.spring_backend.dto.cus.search.SearchCategoriesResponseDTO;
import cn.tju.sse.spring_backend.dto.cus.search.mapper.CategoriesResponseMapper;
import cn.tju.sse.spring_backend.model.CommoditiesCategoriesEntity;
import cn.tju.sse.spring_backend.repository.cus.search.SearchCategoriesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author raoji
 * @date 2023/12/13
 * @Description
 */
@Service
public class SearchCategoriesService {
    @Autowired
    private SearchCategoriesRepository searchCategoriesRepository;

    private final CategoriesResponseMapper categoriesResponseMapper
            = CategoriesResponseMapper.INSTANCE;

    public SearchCategoriesResponseDTO categories(){
        List<CommoditiesCategoriesEntity> categoriesEntities = searchCategoriesRepository.findAll();

        return categoriesResponseMapper.
                entitiesToResponse(categoriesEntities.toArray(new CommoditiesCategoriesEntity[0]));
    }
}
