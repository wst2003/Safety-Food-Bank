package cn.tju.sse.spring_backend.service.pub.register;

import cn.tju.sse.spring_backend.dto.pub.register.StoreRegistrationRequestDTO;
import cn.tju.sse.spring_backend.dto.pub.register.StoreRegistrationResponseDTO;
import cn.tju.sse.spring_backend.dto.pub.register.mapper.StoreRegistrationRequestMapper;
import cn.tju.sse.spring_backend.model.StoreCategoriesEntity;
import cn.tju.sse.spring_backend.model.StoreEntity;
import cn.tju.sse.spring_backend.model.StoreimageEntity;
import cn.tju.sse.spring_backend.model.UsersEntity;
import cn.tju.sse.spring_backend.repository.obs.ObsOperationTool;
import cn.tju.sse.spring_backend.repository.pub.register.StoreCategoryRepository;
import cn.tju.sse.spring_backend.repository.pub.register.StoreImgRepository;
import cn.tju.sse.spring_backend.repository.pub.register.StoreRegisterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.UUID;

@Service
public class StoreRegisterService {
    @Autowired
    private StoreRegisterRepository storeRegisterRepository;
    @Autowired
    private StoreImgRepository storeImgRepository;
    @Autowired
    private StoreCategoryRepository storeCategoryRepository;
    private final StoreRegistrationRequestMapper storeRegistrationRequestMapper=StoreRegistrationRequestMapper.INSTANCE;

    public StoreRegistrationResponseDTO StoreRegister(StoreRegistrationRequestDTO request) throws IOException {
        String ImgPath="https://food-bank.obs.cn-east-3.myhuaweicloud.com/";

        StoreEntity newStore = storeRegistrationRequestMapper.requestToEntity(request);
        StoreRegistrationResponseDTO response = new StoreRegistrationResponseDTO();

        newStore.setStoState(1);

        String licenseImgName=request.getSto_licenseImage().getOriginalFilename();
        String fileExtension=getFileExtension(licenseImgName);
        if (!fileExtension.equals("jpg") && !fileExtension.equals("png") && !fileExtension.equals("gif")){
            System.out.println(fileExtension);
            response.setMessage("图片格式不正确");
            System.out.println(response.getMessage());
            return response;
        }
        String uploadPath = "licenses";
        if(!ObsOperationTool.isObjectPathExist(uploadPath)){
            ObsOperationTool.createFolder("",uploadPath);
        }

        String licenseName= newStore.getStoId() + "_license." + fileExtension;
        String licenseURL=ImgPath+uploadPath+"/"+licenseName;
        newStore.setStoLicenseimg(licenseURL);
        boolean ifSuccess=ObsOperationTool.uploadInputStream(uploadPath,licenseName,request.getSto_licenseImage().getInputStream());
        if(!ifSuccess){
            response.setMessage("商家已经存在，无法重新创建");
            System.out.println(response.getMessage());
            return response;
        }

        String uploadPath1 = "store_image";
        ArrayList<String> fileURLs=new ArrayList<>();
        for (MultipartFile pictureFile : request.getSto_picture()) {
            String StoImgName=pictureFile.getOriginalFilename();
            String StoImgExtension=getFileExtension(StoImgName);
            if (!StoImgExtension.equals("jpg") && !StoImgExtension.equals("png") && !StoImgExtension.equals("gif")){
                System.out.println(fileExtension);
                response.setMessage("图片格式不正确");
                System.out.println(response.getMessage());
                return response;
            }

            if(!ObsOperationTool.isObjectPathExist(uploadPath1)){
                ObsOperationTool.createFolder("",uploadPath1);
            }
            //生成UUID
            UUID uuid = UUID.randomUUID();
            String generatedUUID = uuid.toString();

            //添加商家图片到OBS
            String newStoImgName= request.getSto_ID().toString()+"_picture_"+generatedUUID+"."+StoImgExtension;
            String StoImgURL=ImgPath+uploadPath1+"/"+newStoImgName;
            fileURLs.add(StoImgURL);
            boolean ifSuccess1=ObsOperationTool.uploadInputStream(uploadPath1,newStoImgName,pictureFile.getInputStream());
            if(!ifSuccess1){
                response.setMessage("图片存储出现错误");
                System.out.println(response.getMessage());
                return response;
            }
        }

        StoreEntity insertUser =  storeRegisterRepository.save(newStore);

        //存储商家图片
        for(String filer:fileURLs){
            StoreimageEntity newStoreImg=new StoreimageEntity();
            System.out.println("ID: "+Integer.parseInt(request.getSto_ID()));
            newStoreImg.setStoId(Integer.parseInt(request.getSto_ID()));
            newStoreImg.setStoImage(filer);
            StoreimageEntity insertStoImg=storeImgRepository.save(newStoreImg);
            if(insertStoImg==null){
                response.setMessage("图片存储出现错误-数据库错误");
                System.out.println(response.getMessage());
                return response;
            }
        }

        //存储商家商品类别
        for (String category:request.getCom_categories()){
            StoreCategoriesEntity newStoCategory=new StoreCategoriesEntity();
            newStoCategory.setComCategory(category);
            newStoCategory.setStoreId(Integer.parseInt(request.getSto_ID()));
            StoreCategoriesEntity insertStoCategory=storeCategoryRepository.save(newStoCategory);
            if(insertStoCategory==null){
                response.setMessage("商品类别存储出现错误-数据库错误");
                System.out.println(response.getMessage());
                return response;
            }
        }

        if(insertUser!=null){
            response.setMessage("success");
            return response;
        }
        else return null;

    }
    private static String getFileExtension(String fileName) {
        Path path = Paths.get(fileName);
        return path.getFileName().toString().contains(".") ?
                path.getFileName().toString().substring(path.getFileName().toString().lastIndexOf(".") + 1) :
                "";
    }

}
