package cn.tju.sse.spring_backend.controller.pub.getinformation;

import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationResponseDTO;
import cn.tju.sse.spring_backend.service.pub.getinformation.StoreGetinformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName StoreGetinformationController
 * @Description 控制类，返回商家基本信息
 * @Author RaoJi
 */
@RestController
@RequestMapping("/api/pub/getinformation")
public class StoreGetinformationController {
    @Autowired
    private StoreGetinformationService storeGetinformationService;

    /**
     *
     * @param sto_ID - 商家id
     * @return id对应的基本信息
     * @see StoreGetinformationResponseDTO
     */
    @RequestMapping(value = "/store", method = RequestMethod.GET)
    public ResponseEntity<StoreGetinformationResponseDTO> storeGetinformation
            (@RequestParam String sto_ID){
        StoreGetinformationRequestDTO request = new StoreGetinformationRequestDTO();
        request.setSto_ID(sto_ID);
        StoreGetinformationResponseDTO response = storeGetinformationService.StoreGetinformation(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
