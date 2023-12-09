package cn.tju.sse.spring_backend.service.sto.update;

import cn.tju.sse.spring_backend.dto.sto.update.CommodityImageUpdateRequestDTO;
import cn.tju.sse.spring_backend.dto.sto.update.CommodityUpdateRequestDTO;
import cn.tju.sse.spring_backend.dto.sto.update.CommodityUpdateResponseDTO;
import cn.tju.sse.spring_backend.dto.sto.upload.CommodityTimePriceDTO;
import cn.tju.sse.spring_backend.model.CommodityCategoriesEntity;
import cn.tju.sse.spring_backend.model.CommodityEntity;
import cn.tju.sse.spring_backend.model.CommodityImageEntity;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import cn.tju.sse.spring_backend.repository.obs.ObsOperationTool;
import cn.tju.sse.spring_backend.repository.sto.commodity.CommodityCategoriesRepository;
import cn.tju.sse.spring_backend.repository.sto.commodity.CommodityImageRepository;
import cn.tju.sse.spring_backend.repository.sto.commodity.CommodityPriceCurveRepository;
import cn.tju.sse.spring_backend.repository.sto.commodity.CommodityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;

/**
 * 更新商品信息
 *
 * @author XiangZhang ID:2151792 Email:422563809@qq.com
 * @since 2023/12/09 12:42
 */
@Service
public class CommodityUpdateService {
    @Autowired
    private CommodityRepository commodityRepository;
    @Autowired
    private CommodityCategoriesRepository commodityCategoriesRepository;
    @Autowired
    private CommodityPriceCurveRepository commodityPriceCurveRepository;
    @Autowired
    private CommodityImageRepository commodityImageRepository;
    public CommodityUpdateResponseDTO getFormData(int COM_ID){
        CommodityUpdateResponseDTO response = new CommodityUpdateResponseDTO();
        CommodityEntity commodity = commodityRepository.findCommodityEntityByComId(COM_ID);

        response.setSTO_ID(commodity.getStoId());
        response.setCOM_NAME(commodity.getComName());
        response.setCOM_INTRODUCTION(commodity.getComIntroduction());
        response.setCOM_ORIPRICE(commodity.getComOriprice());
        response.setCOM_LEFT(commodity.getComLeft());
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        response.setCOM_EXPIRATIONDATE(formatter.format(commodity.getComExpirationdate()));

        ArrayList<CommodityCategoriesEntity> categories = commodityCategoriesRepository.findCommodityCategoriesEntitiesByComId(COM_ID);
        ArrayList<String> commodityCategories=new ArrayList<>();
        categories.forEach(category->{
            commodityCategories.add(category.getComCategory());
        });
        response.setCOM_CATEGORIES(commodityCategories);

        ArrayList<CommodityPriceCurveEntity> commodityPriceCurve = commodityPriceCurveRepository.findCommodityPriceCurveEntitiesByComId(COM_ID);
        ArrayList<CommodityTimePriceDTO> commodityTimePrice=new ArrayList<>();
        commodityPriceCurve.forEach(priceCurve->{
            CommodityTimePriceDTO timePrice = new CommodityTimePriceDTO();
            timePrice.setPrice_percent(BigDecimal.valueOf(100).multiply(priceCurve.getComPcPrice()).divide(commodity.getComOriprice(),0, RoundingMode.DOWN).intValue());
            timePrice.setTime_point(formatter.format(priceCurve.getComPcTime()));
            commodityTimePrice.add(timePrice);
        });
        response.setCOM_TIME_PRICE(commodityTimePrice);

        response.setIMAGE_KEY("");

        return response;
    }

    @Transactional
    public String updateBasicData(int COM_ID, CommodityUpdateRequestDTO request){
        CommodityEntity commodity = commodityRepository.findCommodityEntityByComId(COM_ID);
        commodity.setComName(request.getCom_name());
        commodity.setComIntroduction(request.getCom_introduction());
        commodity.setComLeft(request.getCom_left());
        commodityRepository.save(commodity);

        commodityCategoriesRepository.deleteCommodityCategoriesEntitiesByComId(COM_ID);
        request.getCom_categories().forEach(category->{
            CommodityCategoriesEntity commodityCategory = new CommodityCategoriesEntity();
            commodityCategory.setComCategory(category);
            commodityCategory.setComId(COM_ID);
            commodityCategoriesRepository.save(commodityCategory);
        });

        commodityPriceCurveRepository.deleteCommodityPriceCurveEntitiesByComId(COM_ID);

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

        return "更新成功！";
    }

    public String postUpdateImage(CommodityImageUpdateRequestDTO request) throws IOException {
        ArrayList<CommodityImageEntity> commodityImages = commodityImageRepository.findCommodityImageEntitiesByComId(request.getCOM_ID());
        ArrayList<String> imageNames = new ArrayList<>();

        commodityImages.forEach(commodityImage->{
            imageNames.add(commodityImage.getComImage());
        });

        ArrayList<Integer> imageNum = new ArrayList<>();
        imageNames.forEach(imageName->{
            int startIndex = imageName.indexOf("com_image_")+10;
            int endIndex = imageName.indexOf('.',8);
            int num = Integer.parseInt(imageName.substring(startIndex,endIndex));
            imageNum.add(num);
        });

        String folderPath = "commodity_image/"+request.getCOM_ID();
        String fileName = String.format("com_image_%d.%s", Collections.max(imageNum) + 1,"jpg");

        InputStream inputStream = request.getFile().getInputStream();
        ObsOperationTool.uploadInputStream(folderPath,fileName,inputStream);

        String dstFile = Paths.get(folderPath).resolve(fileName).toString();
        CommodityImageEntity commodityImage = new CommodityImageEntity();
        commodityImage.setComImage(dstFile);
        commodityImage.setComId(request.getCOM_ID());
        commodityImageRepository.save(commodityImage);

        return dstFile;
    }

    public String postDeleteImage(int COM_ID, String COM_IMAGE){
        Path deleteFile = Paths.get(COM_IMAGE);
        ObsOperationTool.deleteObject(deleteFile.getParent().toString(),deleteFile.getFileName().toString(),false);

        commodityImageRepository.deleteCommodityImageEntityByComIdAndComImage(COM_ID,COM_IMAGE);
        return "成功！";
    }

    public String postDeleteCommodity(int COM_ID){
        CommodityEntity commodity = commodityRepository.findCommodityEntityByComId(COM_ID);
        commodity.setComLeft(0);
        commodityRepository.save(commodity);
        return "成功！";
    }
}