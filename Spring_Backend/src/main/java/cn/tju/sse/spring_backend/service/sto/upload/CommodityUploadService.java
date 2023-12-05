package cn.tju.sse.spring_backend.service.sto.upload;

import cn.tju.sse.spring_backend.dto.sto.upload.*;
import cn.tju.sse.spring_backend.model.CommodityCategoriesEntity;
import cn.tju.sse.spring_backend.model.CommodityEntity;
import cn.tju.sse.spring_backend.model.CommodityImageEntity;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import cn.tju.sse.spring_backend.repository.SeqNextvalRepository;
import cn.tju.sse.spring_backend.repository.obs.ObsOperationTool;
import cn.tju.sse.spring_backend.repository.sto.upload.CommodityCategoriesRepository;
import cn.tju.sse.spring_backend.repository.sto.upload.CommodityImageRepository;
import cn.tju.sse.spring_backend.repository.sto.upload.CommodityPriceCurveRepository;
import cn.tju.sse.spring_backend.repository.sto.upload.CommodityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.file.Paths;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;

/**
 * 上传商品
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/02 13:57
 */
@Service
public class CommodityUploadService {
    @Autowired
    private SeqNextvalRepository seqNextvalRepository;
    @Autowired
    private CommodityRepository commodityRepository;
    @Autowired
    private CommodityPriceCurveRepository commodityPriceCurveRepository;
    @Autowired
    private CommodityCategoriesRepository commodityCategoriesRepository;
    @Autowired
    private CommodityImageRepository commodityImageRepository;
    public String getImageKey(){
        int nextImageKey = seqNextvalRepository.callSEQ_NEXTVAL("TMP_IMAGE_KEY_SEQ");
        return Integer.toString(nextImageKey);
    }

    public String postImage(CommodityImageUploadRequestDTO request) throws IOException {
        String rootPath = "commodity_tmp";
        String folderPath = Paths.get(rootPath).resolve(request.getIMAGE_KEY()).toString().replace('\\','/');

        ObsOperationTool.createFolder(rootPath,request.getIMAGE_KEY());

        ArrayList<String> imagePath = ObsOperationTool.getObjectnamesInFolder(folderPath,false);
        String fileName = "";
        InputStream inputStream = request.getFile().getInputStream();

        if (imagePath == null || imagePath.isEmpty()) {
            fileName = "com_image_0."+request.getKey().split("\\.")[request.getKey().split("\\.").length-1];
            ObsOperationTool.uploadInputStream(folderPath,fileName,inputStream);
        }
        else{
            ArrayList<Integer> imageNum = new ArrayList<>();

            if (imagePath != null) {
                imagePath.forEach(imageName -> {
                    int num_start_index = imageName.indexOf("com_image_") + 10;
                    int num_end_index = imageName.indexOf('.', 8);
                    int num = Integer.parseInt(imageName.substring(num_start_index, num_end_index));

                    imageNum.add(num);
                });
            }

            fileName = String.format("com_image_%d.%s", Collections.max(imageNum) + 1,
                    request.getKey().split("\\.")[request.getKey().split("\\.").length - 1]);

            ObsOperationTool.uploadInputStream(folderPath,fileName,inputStream);
        }

        return fileName;
    }

    public String deleteTmpImage(CommodityDeleteTmpImageRequestDTO request){
        String deletePath = "commodity_tmp/"+request.getIMAGE_KEY();

        ObsOperationTool.deleteObject(deletePath,request.getFileName(),false);
        deletePath = deletePath+'/'+request.getFileName();
        System.out.println(deletePath+"临时文件删除成功");

        return deletePath+"临时文件删除成功";
    }

    @Transactional
    public CommodityUploadResponseDTO postBasicData(CommodityUploadRequestDTO request) {
        CommodityUploadResponseDTO response = new CommodityUploadResponseDTO();
        int COM_ID = seqNextvalRepository.callSEQ_NEXTVAL("COMMODITY_ID_SEQ");
        System.out.println(COM_ID);
        String pattern = "yyyy-MM-dd"; // 日期字符串的格式
        SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
        try {
            CommodityEntity commodity = new CommodityEntity();
            commodity.setStoId(request.getSto_id());
            commodity.setComId(COM_ID);
            commodity.setComName(request.getCom_name());
            commodity.setComIntroduction(request.getCom_introduction());
            commodity.setComOriprice(request.getCom_oriprice());
            commodity.setComExpirationdate(new Date(dateFormat.parse(request.getCom_expirationDate()).getTime()));
            commodity.setComUploaddate(new Date(System.currentTimeMillis()));
            commodity.setComLeft(request.getCom_left());
            commodity.setComRating(BigDecimal.ZERO);

//            System.out.println(commodity.getComId());
            commodityRepository.save(commodity);
            System.out.println("Commodity success!");


            request.getCom_categories().forEach(COM_CATEGORY->{
                CommodityCategoriesEntity categories = new CommodityCategoriesEntity();
                categories.setComId(COM_ID);
                categories.setComCategory(COM_CATEGORY);
                commodityCategoriesRepository.save(categories);
            });

            //插入价格曲线
            request.getCom_time_price().forEach(timePrice->{
                CommodityPriceCurveEntity priceCurve = new CommodityPriceCurveEntity();
                priceCurve.setComId(COM_ID);

                if(timePrice.getTime_point().contains("/"))
                    timePrice.setTime_point(timePrice.getTime_point().split(" ")[0].replace('/','-'));

                priceCurve.setComPcTime(Date.valueOf(timePrice.getTime_point()));
                BigDecimal price = BigDecimal.valueOf(timePrice.getPrice_percent()).multiply(commodity.getComOriprice().divide(BigDecimal.valueOf(100),2, RoundingMode.UP));
                priceCurve.setComPcPrice(price);
                commodityPriceCurveRepository.save(priceCurve);
            });

            //将创建时间与过期时间加入价值曲线
            CommodityPriceCurveEntity priceCurve = new CommodityPriceCurveEntity();
            priceCurve.setComId(COM_ID);
            priceCurve.setComPcTime(commodity.getComUploaddate());
            priceCurve.setComPcPrice(commodity.getComOriprice());
            commodityPriceCurveRepository.save(priceCurve);

            priceCurve.setComPcTime(commodity.getComExpirationdate());
            priceCurve.setComPcPrice(BigDecimal.ZERO);
            commodityPriceCurveRepository.save(priceCurve);

            String srcPath = "commodity_tmp/"+request.getImage_key();
            String dstPath = "commodity_image/"+COM_ID;

            ObsOperationTool.createFolder("commodity_image",Integer.toString(COM_ID));
            ArrayList<String> files = ObsOperationTool.getObjectnamesInFolder(srcPath,false);
            if (files != null) {
                files.forEach(fileName->{
                    if(!fileName.endsWith(".txt")){
                        ObsOperationTool.deleteObject(dstPath,fileName,false);
                        ObsOperationTool.uploadFile(dstPath,fileName,srcPath+"/"+fileName);
                        ObsOperationTool.deleteObject(srcPath,fileName,false);

                        CommodityImageEntity commodityImage = new CommodityImageEntity();
                        commodityImage.setComId(COM_ID);
                        commodityImage.setComImage(dstPath+"/"+fileName);
                        commodityImageRepository.save(commodityImage);
                    }
                });
            }

            ObsOperationTool.deleteObject("commodity_tmp",request.getImage_key(),true);
            response.setMessage("");
            response.setCom_id(COM_ID);
            return response;
        }
        catch (Exception ex){
            System.out.println("Error occurred: "+ex.getMessage());
            response.setMessage("数据库插入错误！该事务回滚");
            response.setCom_id(-1);
            return response;
        }
    }

}
