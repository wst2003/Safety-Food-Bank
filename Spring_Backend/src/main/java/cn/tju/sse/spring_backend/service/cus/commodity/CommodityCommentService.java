package cn.tju.sse.spring_backend.service.cus.commodity;

import cn.tju.sse.spring_backend.dto.cus.commodity.CommodityCommentResponseDTO;
import cn.tju.sse.spring_backend.dto.cus.commodity.CommoditySendCommentDTO;
import cn.tju.sse.spring_backend.model.CommodityCommentEntity;
import cn.tju.sse.spring_backend.repository.cus.commodity.CommodityCommentRepository;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import static cn.tju.sse.spring_backend.utils.ContentFilter.contentFilter;

@Service
public class CommodityCommentService {

    @Autowired
    private CommodityCommentRepository commodityCommentRepository;



    /**
     * 时间转换函数
     * 将查询的时间戳转换为"yyyy-MM-dd HH-mm-ss"形式
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
     * 发布评论服务
     * @param user_id-用户ID
     * @param cmt_content-评论内容
     * @param cmt_father-父评论
     * @param com_id-商品ID
     * @return CommodityCommentResponseDTO
     */
    @Transactional
    public CommodityCommentResponseDTO publishComment(int user_id,String cmt_content,int cmt_father,int com_id) throws IOException {
        CommodityCommentResponseDTO commodityCommentResponseDTO=new CommodityCommentResponseDTO();




        CommodityCommentEntity commodityCommentEntity=new CommodityCommentEntity();
        commodityCommentEntity.setUserId(user_id);
//        过滤敏感词用
//        commodityCommentEntity.setCmtContent(contentFilter(cmt_content));
        commodityCommentEntity.setCmtContent(cmt_content);
        commodityCommentEntity.setCmtFather(cmt_father);
        commodityCommentEntity.setComId(com_id);

        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String str = formatter.format(now);
        java.sql.Date insertedDate = java.sql.Date.valueOf(str);

        Integer maxID=commodityCommentRepository.findMaxCmtId();
        commodityCommentEntity.setCmtId(maxID+1);

        commodityCommentEntity.setCmtTime(insertedDate);

        try {
            CommodityCommentEntity commentEntity = commodityCommentRepository.save(commodityCommentEntity);
            System.out.println(commentEntity.getCmtId());
            if (commentEntity.getCmtId() > 0){
                commodityCommentResponseDTO.setMsg("评论发布成功");

                CommoditySendCommentDTO commoditySendCommentDTO=new CommoditySendCommentDTO();
                commoditySendCommentDTO.setCmt_id(commentEntity.getCmtId());
                commoditySendCommentDTO.setCom_id(commentEntity.getComId());
                commoditySendCommentDTO.setCmt_father(commentEntity.getCmtFather());
                commoditySendCommentDTO.setCmt_content(commentEntity.getCmtContent());
                commoditySendCommentDTO.setCmt_time(formatSqlDateTimeToDateString(commentEntity.getCmtTime()));
                commoditySendCommentDTO.setUser_id(commentEntity.getUserId());
                Integer publisher_type=commodityCommentRepository.findUserType(commentEntity.getUserId());
                if(publisher_type==1){
                    // 发布者为商家
                    commoditySendCommentDTO.setCmt_name(commodityCommentRepository.findStoName(commentEntity.getUserId()));
                    commoditySendCommentDTO.setUser_type(1);
                    commoditySendCommentDTO.setBuying_times(0);
                }else{
                    // 发布者为顾客
                    commoditySendCommentDTO.setCmt_name(commodityCommentRepository.findCusName(commentEntity.getUserId()));
                    commoditySendCommentDTO.setUser_type(0);
                    Integer buying_times=commodityCommentRepository.findBuyingTimes(commoditySendCommentDTO.getUser_id(), commoditySendCommentDTO.getCom_id());
                    commoditySendCommentDTO.setBuying_times(buying_times);
                }
                commodityCommentResponseDTO.setComment(commoditySendCommentDTO);
                return commodityCommentResponseDTO;


            } else{
                commodityCommentResponseDTO.setMsg("上传失败");
                return commodityCommentResponseDTO;
            }

        }catch (Exception e){
            e.printStackTrace();
            commodityCommentResponseDTO.setMsg("上传失败");
            return commodityCommentResponseDTO;
        }


    }

}
