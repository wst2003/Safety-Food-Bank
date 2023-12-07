package cn.tju.sse.spring_backend.controller.pub.getinformation;

import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationRequest;
import cn.tju.sse.spring_backend.dto.pub.getinformation.StoreGetinformationResponse;
import cn.tju.sse.spring_backend.service.pub.getinformation.StoreGetinformationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/pub/getinformation")
public class StoreGetinformationController {
    @Autowired
    private StoreGetinformationService storeGetinformationService;

    @RequestMapping(value = "/store", method = RequestMethod.GET)
    public ResponseEntity<StoreGetinformationResponse> storeGetinformation
            (@RequestParam String sto_ID){
        StoreGetinformationRequest request = new StoreGetinformationRequest();
        request.setSto_ID(sto_ID);
        StoreGetinformationResponse response = storeGetinformationService.StoreGetinformation(request);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
