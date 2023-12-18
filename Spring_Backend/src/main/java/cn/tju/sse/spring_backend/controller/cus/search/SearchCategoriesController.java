package cn.tju.sse.spring_backend.controller.cus.search;

import cn.tju.sse.spring_backend.dto.cus.search.SearchCategoriesResponseDTO;
import cn.tju.sse.spring_backend.service.cus.search.SearchCategoriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author raoji
 * @date 2023/12/13
 * @Description
 */
@RestController
@RequestMapping("/api/cus/search")
public class SearchCategoriesController {
    @Autowired
    private SearchCategoriesService searchCategoriesService;
    @RequestMapping(value = "/categories", method = RequestMethod.GET)
    public ResponseEntity<SearchCategoriesResponseDTO> categories(){
        SearchCategoriesResponseDTO responseDTO = searchCategoriesService.categories();
        return new ResponseEntity<>(responseDTO, HttpStatus.OK);
    }
}
