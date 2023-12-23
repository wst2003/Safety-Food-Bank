package cn.tju.sse.spring_backend.service.cus.history;


import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryDTO;
import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryResponse;
import cn.tju.sse.spring_backend.repository.cus.history.HistoryGetBrowsingHistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;

@Service
public class HistoryGetBrowsingHistoryService {
    @Autowired
    HistoryGetBrowsingHistoryRepository historyGetBrowsingHistoryRepository;

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
     * 拉取浏览记录的Service
     * @param cus_id
     * @return
     */
    @Transactional
    public HistoryGetBrowsingHistoryResponse getBrowsingHistory(int cus_id,int begin_pos,int end_pos,String search_str){
        HistoryGetBrowsingHistoryResponse historyGetBrowsingHistoryResponse=new HistoryGetBrowsingHistoryResponse();

        List<Object[]> jpaObjectList=historyGetBrowsingHistoryRepository.findBrowseEntity(cus_id,begin_pos,end_pos,search_str);
        List<HistoryGetBrowsingHistoryDTO> historyGetBrowsingHistoryDTOList = new ArrayList<>();

        for (Object[] object : jpaObjectList) {
            HistoryGetBrowsingHistoryDTO dto = new HistoryGetBrowsingHistoryDTO();


            // 开转
            dto.setCom_id(object[0] != null ? Integer.parseInt(object[0].toString()) : -1);
            dto.setCom_name(object[1] != null ? object[1].toString() : "-1");
            dto.setCom_introduction(object[2] != null ? object[2].toString() : "-1");
            dto.setCom_oriPrice(object[3] != null ? Double.parseDouble(object[3].toString()) : -1);
            dto.setCom_expirationDate(object[4] != null ?formatSqlDateTimeToDateString(object[4]):"0000-00-00");
            dto.setCom_uploadDate(object[5] != null?formatSqlDateTimeToDateString(object[5]):"0000-00-00");
            dto.setCom_left(object[6] != null ? (Integer) object[6] : -1);
            dto.setCom_rating(object[7] != null ? Double.parseDouble(object[7].toString()) : -1);
            dto.setSto_id(object[8] != null ? Double.parseDouble(object[8].toString()) : 111);
            dto.setSto_name(object[9] != null ? object[9].toString() : "-1");
            dto.setCom_status(object[10] != null ? Integer.parseInt(object[10].toString()) : -2);
            dto.setBro_time_end(object[16] != null ?formatSqlDateTimeToDateString(object[16]):"");

            // img转换
            dto.setCom_firstImage(object[11]==null?"-1":object[11].toString().split(",")[0]);
            // categories转换
            dto.setCom_categories(object[12]==null?new ArrayList<>(): Arrays.stream(object[12].toString().split(",")).toList());
            // 获取favor_status
            List<String> tempOri=(object[15]==null?null: Arrays.stream(object[15].toString().split(",")).toList());
            if(tempOri==null)dto.setFavor_state(0);
            else
                if(tempOri.contains(Integer.toString(cus_id))) dto.setFavor_state(1);
                else dto.setFavor_state(0);


            // 获取当前价格
            List<Object[]> curveNodes=historyGetBrowsingHistoryRepository.findComCurveNode(dto.getCom_id());
            // 先看当前时间是不是在第一次节点之前
            LocalDate now = LocalDate.now();
            Object[] previousNode = null;
            Object[] nextNode = null;
            for (Object[] node : curveNodes) {
                LocalDate nodeDate = LocalDate.parse(node[1].toString(), DateTimeFormatter.ISO_LOCAL_DATE);
                if (!nodeDate.isAfter(now)) {
                    // 如果节点日期不晚于当前日期，则这是一个过去的节点
                    previousNode = node;
                } else {
                    // 如果节点日期晚于当前日期，这是一个未来的节点
                    // 我们找到未来的第一个节点就停止搜索
                    nextNode = node;
                    break;
                }
            }
            if(nextNode==null&&previousNode==null){
                // 假如之前之后都为null，说明没有曲线
                if(now.isAfter(LocalDate.parse(object[4].toString(), DateTimeFormatter.ISO_LOCAL_DATE)))
                    dto.setCom_price(0.0);
                else dto.setCom_price(dto.getCom_oriPrice());
            }else if (nextNode != null&&previousNode==null) {
                // 此时在曲线变动之前，直接设置为初始价格
                dto.setCom_price(dto.getCom_oriPrice());
            } else if(nextNode == null&&previousNode!=null) {
                // 此时在最后一个节点之后，检查有没有过期
                if(now.isAfter(LocalDate.parse(object[4].toString(), DateTimeFormatter.ISO_LOCAL_DATE)))
                    dto.setCom_price(0.0);
                else dto.setCom_price(Double.parseDouble(previousNode[0].toString()));
            }else{
                //此时直接设置为前一个时间变动点
                dto.setCom_price(Double.parseDouble(previousNode[0].toString()));
            }

            // 映射到DTO
            historyGetBrowsingHistoryDTOList.add(dto);
        }

        historyGetBrowsingHistoryResponse.setCom_list(historyGetBrowsingHistoryDTOList);
        historyGetBrowsingHistoryResponse.setTotal(historyGetBrowsingHistoryResponse.getCom_list().size());
        return historyGetBrowsingHistoryResponse;
    }

}
