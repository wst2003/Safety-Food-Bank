package cn.tju.sse.spring_backend.service.pub.register;

import cn.tju.sse.spring_backend.dto.pub.register.CusRegistrationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.register.CusRegistrationResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.register.mapper.CusRegistrationRequestMapper;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import cn.tju.sse.spring_backend.model.CustomerLoveEntity;
import cn.tju.sse.spring_backend.repository.pub.register.CustomerLoveRepository;
import cn.tju.sse.spring_backend.repository.pub.register.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CusRegisterService {
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private CustomerLoveRepository customerLoveRepository;
    private final CusRegistrationRequestMapper cusRegistrationRequestMapper=CusRegistrationRequestMapper.INSTANCE;
    public CusRegistrationResponseDTO CustomerRegister(CusRegistrationRequestDTO request){
        CustomerEntity newCustomer=cusRegistrationRequestMapper.requestToEntity(request);
        CusRegistrationResponseDTO response = new CusRegistrationResponseDTO();
        int cusID=Integer.parseInt(request.getCus_ID());
        newCustomer.setCusState(1);
        CustomerEntity customer=customerRepository.save(newCustomer);
        for(String category:request.getCus_category()){
            CustomerLoveEntity customerLove=new CustomerLoveEntity();
            customerLove.setCusId(cusID);
            customerLove.setComCategory(category);
            customerLove.setCusLoveWeight(1);
            CustomerLoveEntity customerlove=customerLoveRepository.save(customerLove);
            if(customerlove == null) {
                System.out.println("注册顾客出现错误");
                response.setMessage("注册顾客出现错误");
                return response;
            }
        }


        if(customer!=null){
            response.setMessage("success");
            return response;
        }
        else
            return null;

    }
}
