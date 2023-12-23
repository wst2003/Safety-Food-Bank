package cn.tju.sse.spring_backend.service.cus.history;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import cn.tju.sse.spring_backend.dto.cus.history.HistorySetBrowsingHistoryResponse;
import cn.tju.sse.spring_backend.model.BrowseEntity;
import cn.tju.sse.spring_backend.repository.cus.history.HistorySetBrowsingHistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HistorySetBrowsingHistoryService {
    @Autowired
    private HistorySetBrowsingHistoryRepository historySetBrowsingHistoryRepository;


    /**
     * 插入浏览记录
     * @param bro_time_start-开始时间
     * @param bro_time_end-结束时间
     * @param browser_id-浏览者ID
     * @param com_id-商品ID
     * @param whether_buy-是否购买
     * @return
     */
    public HistorySetBrowsingHistoryResponse setBrowsingHistory(String bro_time_start,
                                                                String bro_time_end,
                                                                int browser_id,
                                                                int com_id,
                                                                int whether_buy){

        // 将字符串转换为timestamp形式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime startTime = LocalDateTime.parse(bro_time_start, formatter);
        Timestamp startTimeStamp = Timestamp.valueOf(startTime);
        LocalDateTime endTime = LocalDateTime.parse(bro_time_end, formatter);
        Timestamp endTimeStamp = Timestamp.valueOf(endTime);

        BrowseEntity browseEntity=new BrowseEntity();
        browseEntity.setBroTimeStart(startTimeStamp);
        browseEntity.setBroTimeEnd(endTimeStamp);
        browseEntity.setBrowserId(browser_id);
        browseEntity.setComId(com_id);
        browseEntity.setWhetherBuy(whether_buy);

        BrowseEntity insertedBrowse=historySetBrowsingHistoryRepository.save(browseEntity);

        HistorySetBrowsingHistoryResponse historySetBrowsingHistoryResponse=new HistorySetBrowsingHistoryResponse();
        historySetBrowsingHistoryResponse.setMsg("成功存入浏览记录");
        return historySetBrowsingHistoryResponse;




    }
}
