package cn.tju.sse.spring_backend.service.pub;

import cn.tju.sse.spring_backend.dto.pub.GetCategoryResponseDTO;
import cn.tju.sse.spring_backend.model.CommoditiesCategoriesEntity;
import cn.tju.sse.spring_backend.repository.pub.CategoryRespository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class GetCategoryService {
    @Autowired
    private CategoryRespository categoryRespository;
    public GetCategoryResponseDTO GetCategory(){
        GetCategoryResponseDTO response =new GetCategoryResponseDTO();
        ArrayList<String> temp=new ArrayList<>();
        for(CommoditiesCategoriesEntity category:  categoryRespository.findAll()){
            temp.add(category.getComCategory());

        }
        response.setCategorylist(temp);
        if(response!=null)
            return response;
        else{
            System.out.println("获取商品类别失败！");
            return null;
        }
    }
}
