package cn.tju.sse.spring_backend.service.pub.getinformation;

import cn.tju.sse.spring_backend.dto.pub.getinformation.CustomerGetinformationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.getinformation.CustomerGetinformationResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.getinformation.mapper.CustomerGetinformationRequestMapper;
import cn.tju.sse.spring_backend.dto.pub.getinformation.mapper.CustomerGetinformationResponseMapper;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import cn.tju.sse.spring_backend.model.CustomerLoveEntity;
import cn.tju.sse.spring_backend.repository.pub.getinformation.CustomerGetinformationRepository;
import cn.tju.sse.spring_backend.repository.pub.getinformation.CustomerLoveGetinformationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CustomerGetinformationService {
    @Autowired
    private CustomerGetinformationRepository customerGetinformationRepository;
    @Autowired
    private CustomerLoveGetinformationRepository customerLoveGetinformationRepository;

    private final CustomerGetinformationResponseMapper customerGetinformationResponseMapper
            = CustomerGetinformationResponseMapper.INSTANCE;

    private final CustomerGetinformationRequestMapper customerGetinformationRequestMapper
            = CustomerGetinformationRequestMapper.INSTANCE;

    public CustomerGetinformationResponseDTO CustomerGetinformation(CustomerGetinformationRequestDTO request){
        CustomerGetinformationResponseDTO response = new CustomerGetinformationResponseDTO();

        boolean existsCustomer = customerGetinformationRepository.
                existsByCusId(Integer.parseInt(request.getCus_ID()));

        if(!existsCustomer){  // no customer
            response.setMessage("customers not found");
            return response;
        }

        Optional<CustomerEntity> customer = customerGetinformationRepository.
                findById(Integer.valueOf(request.getCus_ID()));

        if(customer.isEmpty()){
            response.setMessage("error occurred in database");
            return response;
        }

        CustomerLoveEntity[] loves = customerLoveGetinformationRepository.
                findAllByCusId(Integer.parseInt(request.getCus_ID())).toArray(new CustomerLoveEntity[0]);

        //throw should not be executed
        response = customerGetinformationResponseMapper.entityToResponse(customer.orElseThrow(), loves);
        response.setMessage("success");
        return response;
    }
}
