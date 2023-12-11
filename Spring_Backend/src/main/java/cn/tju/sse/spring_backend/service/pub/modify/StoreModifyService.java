package cn.tju.sse.spring_backend.service.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyRequest;
import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyResponse;
import cn.tju.sse.spring_backend.dto.pub.modify.mapper.StoreModifyRequestMapper;
import cn.tju.sse.spring_backend.model.CommoditiesCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreEntity;
import cn.tju.sse.spring_backend.model.StoreimageEntity;
import cn.tju.sse.spring_backend.repository.obs.ObsOperationTool;
import cn.tju.sse.spring_backend.repository.pub.modify.CommoditiesCategoriesRepository;
import cn.tju.sse.spring_backend.repository.pub.modify.StoreCategoriesModifyRepository;
import cn.tju.sse.spring_backend.repository.pub.modify.StoreImageModifyRepository;
import cn.tju.sse.spring_backend.repository.pub.modify.StoreModifyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
public class StoreModifyService {
    @Autowired
    private StoreCategoriesModifyRepository storeCategoriesModifyRepository;
    @Autowired
    private StoreModifyRepository storeModifyRepository;
    @Autowired
    private StoreImageModifyRepository storeImageModifyRepository;

    private final StoreModifyRequestMapper storeModifyRequestMapper
            = StoreModifyRequestMapper.INSTANCE;

    @Autowired
    private CommoditiesCategoriesRepository commoditiesCategoriesRepository;

    private String[] getAllCategories(){
        List<CommoditiesCategoriesEntity> categoriesEntities = commoditiesCategoriesRepository.findAll();

        return categoriesEntities.stream()
                .map(CommoditiesCategoriesEntity::getComCategory) // 替换成实际的属性名
                .toArray(String[]::new);
    }

    private boolean checkCategories(Iterable<StoreCategoriesEntity> categories){
        String[] allCategories = getAllCategories();

        for(StoreCategoriesEntity category: categories){
            String comCategory = category.getComCategory();

            boolean categoryExists = Arrays.asList(allCategories).contains(comCategory);

            if(!categoryExists){
                return false;
            }
        }

        return true;
    }

    private ObsOperationTool obs;
    private String endpoint = "";
    private String IMAGE_PATH =  endpoint + "store_image";

    private String LICENSE_PATH = endpoint +  "licenses";

    public StoreModifyResponse storeModify(StoreModifyRequest request){
        StoreModifyResponse response = new StoreModifyResponse();

        boolean existsStore = storeModifyRepository.existsById(Integer.valueOf(request.getSto_ID()));

        if(!existsStore){
            response.setMessage("store not found");
            return response;
        }

        StoreEntity exists = storeModifyRepository.
                findById(Integer.valueOf(request.getSto_ID())).orElseThrow();

        if(request.getSto_name().length() >= 20){
            response.setMessage("name is too long");
            return response;
        }

        Iterable<StoreCategoriesEntity> categories =
                List.of(storeModifyRequestMapper.requestToCategoryEntities(request));

        if(!checkCategories(categories)){
            response.setMessage("categories not right");
            return response;
        }

        // set simple attribute
        StoreEntity store = storeModifyRequestMapper.requestToStoreEntity(request);
        exists.setStoName(store.getStoName());
        exists.setStoIntroduction(store.getStoIntroduction());

        // process license
        // if there is a license, delete it
        String deleteLicense = Paths.get(exists.getStoLicenseimg()).getFileName().toString();
        boolean originalLicenseExists = ObsOperationTool.isObjectPathExist(LICENSE_PATH + "/" + deleteLicense);
        if(originalLicenseExists){
            boolean del =  ObsOperationTool.deleteObject(LICENSE_PATH, deleteLicense, false);
            if(!del){
                System.out.println("original license delete failed");
            }
        }
        else
            System.out.println("original license " + LICENSE_PATH + "/" + deleteLicense +  " not exists");
        // update license path
        String licenseName = store.getStoId() + "_license.jpg";
        exists.setStoLicenseimg(licenseName);


        // set new image path
        StoreimageEntity ImageEntity = new StoreimageEntity();
        ImageEntity.setStoId(Integer.parseInt(request.getSto_ID()));
        String imageName = store.getStoId() + "_picture_" + request.getStoPicture().getOriginalFilename();
        ImageEntity.setStoImage(imageName);

        // save store
        try {
            ObsOperationTool.uploadInputStream(LICENSE_PATH, licenseName, request.getStoLicenseImg().getInputStream());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        storeModifyRepository.save(exists);

        // save image
        try {
            ObsOperationTool.uploadInputStream(IMAGE_PATH, imageName, request.getStoPicture().getInputStream());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        storeImageModifyRepository.save(ImageEntity);

        // save categories
        storeCategoriesModifyRepository.saveAll(categories);

        response.setMessage("success");
        return response;
    }
}
