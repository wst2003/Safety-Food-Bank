package cn.tju.sse.spring_backend.controller.cus.search;


import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerSetFavorStateRequest;
import cn.tju.sse.spring_backend.dto.cus.search.GetLocationSortRequestDTO;
import cn.tju.sse.spring_backend.dto.cus.search.GetLocationSortResponseDTO;
import cn.tju.sse.spring_backend.dto.cus.search.SendLocationResponseDTO;
import cn.tju.sse.spring_backend.service.cus.search.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

/**
 * @author lhx
 * @date 2023/12/20
 * @Description 统一管理地理位置排序的接口类
 */
@RestController
@RequestMapping("/api/cus/search")
public class LocationController {
    @Autowired
    private LocationService locationService;

    @RequestMapping(value = "/sendLocation", method = RequestMethod.GET)
    public ResponseEntity<SendLocationResponseDTO> sendLocation(){
        SendLocationResponseDTO sendLocationResponseDTO=locationService.sendLocation() ;

        return new ResponseEntity<>(sendLocationResponseDTO, HttpStatus.OK);
    }

    @RequestMapping(value = "/getLocationSort", method = RequestMethod.POST)
    public ResponseEntity<GetLocationSortResponseDTO> getLocationSort(@RequestBody GetLocationSortRequestDTO request) throws IOException {
        GetLocationSortResponseDTO getLocationSortResponseDTO=locationService.getLocationSort(request) ;

        return new ResponseEntity<>(getLocationSortResponseDTO, HttpStatus.OK);
    }


}
