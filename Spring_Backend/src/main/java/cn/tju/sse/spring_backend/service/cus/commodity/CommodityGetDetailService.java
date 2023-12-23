package cn.tju.sse.spring_backend.service.cus.commodity;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetDetailResponseDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetDetailResponsePriceCurveModelDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityGetDetailResponseSendCommentModelDTO;
import cn.tju.sse.spring_backend.repository.cus.commodity.CommodityGetDetailRepository;
import org.apache.logging.log4j.core.pattern.IntegerPatternConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.print.attribute.standard.JobOriginatingUserName;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.DoubleUnaryOperator;

@Service
public class CommodityGetDetailService {
    @Autowired
    private CommodityGetDetailRepository commodityGetDetailRepository;



    /**
     * 时间转换函数
     * 将查询的时间戳转换为"yyyy-MM-dd"形式
     */
    private String formatSqlDateTimeToDateString(Object dateTimeObject) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        if (dateTimeObject instanceof Date) {
            LocalDate date = ((Date) dateTimeObject).toLocalDate();
            return date.format(formatter);
        } else if (dateTimeObject instanceof Timestamp) {
            LocalDateTime dateTime = ((Timestamp) dateTimeObject).toLocalDateTime();
            return dateTime.format(formatter);
        }
        return null;
    }

    /**
     * CommodityDetail接口的方法
     * 四个SQL方法在repository层有定义
     * @param com_id 商品ID
     * @param cus_id 用户ID
     * @return
     */
    @Transactional
    public CommodityGetDetailResponseDTO getCommodityDetail(int com_id,int cus_id){
        CommodityGetDetailResponseDTO commodityGetDetailResponseDTO=new CommodityGetDetailResponseDTO();

        // 先添加商品相关属性
        List<Object[]> objects=commodityGetDetailRepository.getCommodityDetail(com_id);
        if(objects.isEmpty())return commodityGetDetailResponseDTO;

        // 开转,这里先添加基本信息
        if(objects.getFirst()[0]!=null)commodityGetDetailResponseDTO.setCom_id((Integer) objects.getFirst()[0]);
        if(objects.getFirst()[1]!=null)commodityGetDetailResponseDTO.setCom_name(objects.getFirst()[1].toString());
        if(objects.getFirst()[2]!=null)commodityGetDetailResponseDTO.setCom_introduction((String) objects.getFirst()[2]);
        if(objects.getFirst()[3]!=null)commodityGetDetailResponseDTO.setCom_oriPrice(Double.parseDouble(objects.getFirst()[3].toString()));
        if(objects.getFirst()[4]!=null)commodityGetDetailResponseDTO.setCom_expirationDate(formatSqlDateTimeToDateString(objects.getFirst()[4]));
        if(objects.getFirst()[5]!=null)commodityGetDetailResponseDTO.setCom_uploadDate(formatSqlDateTimeToDateString(objects.getFirst()[5]));
        if(objects.getFirst()[6]!=null)commodityGetDetailResponseDTO.setCom_left(Integer.parseInt(objects.getFirst()[6].toString()));
        if(objects.getFirst()[7]!=null)commodityGetDetailResponseDTO.setCom_rating(Double.parseDouble(objects.getFirst()[7].toString()));
        if(objects.getFirst()[8]!=null)commodityGetDetailResponseDTO.setSto_id(Double.parseDouble(objects.getFirst()[8].toString()));
        if(objects.getFirst()[9]!=null)commodityGetDetailResponseDTO.setSto_name(objects.getFirst()[9].toString());
        if(objects.getFirst()[10]!=null)commodityGetDetailResponseDTO.setCom_status(Integer.parseInt(objects.getFirst()[10].toString()));
        if(objects.getFirst()[11]!=null)commodityGetDetailResponseDTO.setCom_categories(Arrays.stream(objects.getFirst()[11].toString().split(",")).toList());
        if(objects.getFirst()[12]!=null)commodityGetDetailResponseDTO.setCom_images(Arrays.stream(objects.getFirst()[12].toString().split(",")).toList());

        // 接下来先加一下价格曲线信息
        // 由于在sql中设置了升序，在此不需要排序
        List<CommodityGetDetailResponsePriceCurveModelDTO> commodityGetDetailResponsePriceCurveModelDTOList=new ArrayList<>();
        CommodityGetDetailResponsePriceCurveModelDTO firstNode=new CommodityGetDetailResponsePriceCurveModelDTO();
        firstNode.setCom_pc_time(commodityGetDetailResponseDTO.getCom_uploadDate());
        firstNode.setCom_pc_price(commodityGetDetailResponseDTO.getCom_oriPrice());
        // 节点不能重复，当第一个节点和初始时间重叠时不添加
        if(!commodityGetDetailResponseDTO.getCom_uploadDate().equals(formatSqlDateTimeToDateString(objects.getFirst()[13])))
            commodityGetDetailResponsePriceCurveModelDTOList.add(firstNode);
        for(Object[] tempObject:objects){
            CommodityGetDetailResponsePriceCurveModelDTO tempNode=new CommodityGetDetailResponsePriceCurveModelDTO();
            tempNode.setCom_pc_time(formatSqlDateTimeToDateString(tempObject[13]));
            tempNode.setCom_pc_price(Double.parseDouble(tempObject[14].toString()));
            commodityGetDetailResponsePriceCurveModelDTOList.add(tempNode);
        }
        CommodityGetDetailResponsePriceCurveModelDTO LastNode=new CommodityGetDetailResponsePriceCurveModelDTO();
        LastNode.setCom_pc_time(commodityGetDetailResponseDTO.getCom_expirationDate());
        LastNode.setCom_pc_price(0.0);
        // 节点不能重复，当最后一个节点和过期时间重叠时不添加
        if(!commodityGetDetailResponseDTO.getCom_expirationDate().equals(formatSqlDateTimeToDateString(objects.getLast()[13])))
            commodityGetDetailResponsePriceCurveModelDTOList.add(LastNode);

        commodityGetDetailResponseDTO.setCom_prices(commodityGetDetailResponsePriceCurveModelDTOList);

        // 接下来获取一下收藏信息
        Object favoriteObject =commodityGetDetailRepository.getCommodityFavoriteDetail(com_id,cus_id);
        commodityGetDetailResponseDTO.setFavor_state(Integer.parseInt(favoriteObject.toString()));


        // 接下来添加comment信息
        List<CommodityGetDetailResponseSendCommentModelDTO> commentList=new ArrayList<>();
        List<Object[]> commentObject=commodityGetDetailRepository.getCommodityCommentDetail(com_id);
        for(Object[] tempObject:commentObject){
            CommodityGetDetailResponseSendCommentModelDTO commentModelDTO=new CommodityGetDetailResponseSendCommentModelDTO();
            commentModelDTO.setCmt_id(Integer.parseInt(tempObject[0].toString()));
            commentModelDTO.setCmt_father(Integer.parseInt(tempObject[1].toString()));
            commentModelDTO.setCmt_content(tempObject[2].toString());
            commentModelDTO.setCmt_time(formatSqlDateTimeToDateString(tempObject[3]));
            commentModelDTO.setCom_id(Integer.parseInt(tempObject[4].toString()));
            commentModelDTO.setUser_id(Integer.parseInt(tempObject[5].toString()));
            commentModelDTO.setUser_type(Integer.parseInt(tempObject[6].toString()));
            commentModelDTO.setCmt_name(tempObject[7].toString());
            Integer buy_times =commodityGetDetailRepository.getBuyTimes(commentModelDTO.getCom_id(),commentModelDTO.getUser_id());
            commentModelDTO.setBuying_times(buy_times);
            commentList.add(commentModelDTO);
        }
        commodityGetDetailResponseDTO.setComments(commentList);




        return commodityGetDetailResponseDTO;
    }
}
