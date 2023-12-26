package cn.tju.sse.spring_backend.service.pub.modify;

import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.modify.StoreModifyResponseDTO;
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
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @ClassName StoreModifyService
 * @Author RaoJi
 * @Description 修改商家信息的业务逻辑
 */
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

    /**
     * @return 所有商品类别属性的集合
     */
    private String[] getAllCategories(){
        List<CommoditiesCategoriesEntity> categoriesEntities = commoditiesCategoriesRepository.findAll();

        return categoriesEntities.stream()
                .map(CommoditiesCategoriesEntity::getComCategory) // 替换成实际的属性名
                .toArray(String[]::new);
    }

    /**
     * @param categories 前端消息转为的StoreCategories表的映射实体集合
     * @return 映射实体是否符合所有商品类别属性
     * @see StoreCategoriesEntity
     */
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
    private final String endpoint = "";
    private final String IMAGE_PATH =  endpoint + "store_image";

    private final String LICENSE_PATH = endpoint +  "licenses";

    /**
     * @param request 前端发送来的消息
     * @return 返回给前端的信息
     * @see StoreModifyRequestDTO
     * @see StoreModifyResponseDTO
     */
    @Transactional
    public StoreModifyResponseDTO storeModify(StoreModifyRequestDTO request){
        StoreModifyResponseDTO response = new StoreModifyResponseDTO();

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

        if(request.getSto_name().isEmpty())
            request.setSto_name(exists.getStoName());

        if(request.getSto_introduction().isEmpty())
            request.setSto_introduction(exists.getStoIntroduction());

        Iterable<StoreCategoriesEntity> categories =
                List.of(storeModifyRequestMapper.requestToCategoryEntities(request));

        if(!checkCategories(categories)){
            response.setMessage("categories not right");
            return response;
        }

        // set simple attribute
        StoreEntity store = storeModifyRequestMapper.requestToStoreEntity(request);

        if(store.getStoName() != null)
            exists.setStoName(store.getStoName());
        if(store.getStoIntroduction() != null)
            exists.setStoIntroduction(store.getStoIntroduction());

        // process license
        // if there is a license, delete it
        if(!request.getStoLicenseImg().isEmpty()){
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
            exists.setStoLicenseimg(LICENSE_PATH + "/" +licenseName);
            // save store
            try {
                ObsOperationTool.uploadInputStream(LICENSE_PATH, licenseName, request.getStoLicenseImg().getInputStream());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        // set new image path
        List<StoreimageEntity> ImageEntities = new ArrayList<>();
        System.out.println("ImageEntities"+request.getStoPicture().length);
        for (MultipartFile image : request.getStoPicture()) {
            if (image.isEmpty()) {
                System.out.println("It is empty");
                continue;
            }
            StoreimageEntity ImageEntity = new StoreimageEntity();
            ImageEntity.setStoId(Integer.parseInt(request.getSto_ID()));
            String imageName = store.getStoId() + "_picture_" + image.getOriginalFilename();
            ImageEntity.setStoImage(IMAGE_PATH + "/" + imageName);
            // save image
            try {
                ObsOperationTool.uploadInputStream(IMAGE_PATH, imageName, image.getInputStream());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            ImageEntities.addLast(ImageEntity);
        }

        storeModifyRepository.save(exists);
        storeImageModifyRepository.saveAll(ImageEntities);
        // save categories
        storeCategoriesModifyRepository.saveAll(categories);

        response.setMessage("success");
        return response;
    }
}
