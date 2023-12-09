package cn.tju.sse.spring_backend.service.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.CustomerModifyRequest;
import cn.tju.sse.spring_backend.dto.pub.modify.CustomerModifyResponse;
import cn.tju.sse.spring_backend.dto.pub.modify.mapper.CustomerModifyRequestMapper;
import cn.tju.sse.spring_backend.model.CommoditiesCategoriesEntity;
import cn.tju.sse.spring_backend.model.CustomerEntity;
import cn.tju.sse.spring_backend.model.CustomerLoveEntity;
import cn.tju.sse.spring_backend.repository.pub.modify.CommoditiesCategoriesRepository;
import cn.tju.sse.spring_backend.repository.pub.modify.CustomerLoveModifyRepository;
import cn.tju.sse.spring_backend.repository.pub.modify.CustomerModifyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class CustomerModifyService {
    @Autowired
    private CustomerModifyRepository customerModifyRepository;

    @Autowired
    private CustomerLoveModifyRepository customerLoveModifyRepository;

    @Autowired
    private CommoditiesCategoriesRepository commoditiesCategoriesRepository;

    private String[] getAllCategories(){
        List<CommoditiesCategoriesEntity> categoriesEntities = commoditiesCategoriesRepository.findAll();

        return categoriesEntities.stream()
                .map(CommoditiesCategoriesEntity::getComCategory) // 替换成实际的属性名
                .toArray(String[]::new);
    }

    private boolean checkCategories(Iterable<CustomerLoveEntity> loves){
        String[] allCategories = getAllCategories();

        for (CustomerLoveEntity love : loves) {
            String comCategory = love.getComCategory();
            boolean categoryExists = Arrays.asList(allCategories).contains(comCategory);

            if (!categoryExists) {
                return false;
            }
        }

        return true;
    }

    private final CustomerModifyRequestMapper customerModifyRequestMapper
            = CustomerModifyRequestMapper.INSTANCE;

    public CustomerModifyResponse customerModify(CustomerModifyRequest request){
        CustomerModifyResponse response = new CustomerModifyResponse();

        boolean existsCustomer = customerModifyRepository.
                existsById(Integer.valueOf(request.getCus_ID()));

        if(!existsCustomer){
            response.setMessage("customer not found");
            return response;
        }

        if(request.getCus_nickname().length() >= 20){
            response.setMessage("nickname is too long");
            return response;
        }

        if(request.getCus_payPassword().length() >= 20){
            response.setMessage("pay password is too long");
            return response;
        }

        CustomerEntity customer = customerModifyRequestMapper.requestToEntity(request);
        Iterable<CustomerLoveEntity> loves = List.of(customerModifyRequestMapper.
                requestToLoveEntities(request));

        if(!checkCategories(loves)){
            response.setMessage("categories not right");
            return response;
        }

        CustomerEntity exists = customerModifyRepository.
                findById(Integer.valueOf(request.getCus_ID())).orElseThrow();

        exists.setCusPaypassword(customer.getCusPaypassword());
        exists.setCusNickname(customer.getCusNickname());
        exists.setCusNotes(customer.getCusNotes());

        CustomerEntity update = customerModifyRepository.save(exists);
        Iterable<CustomerLoveEntity> update_loves = customerLoveModifyRepository.saveAll(loves);
        response.setMessage("success");

        return response;
    }
}
