package cn.tju.sse.spring_backend.service.cus.history;

import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryNumberResponse;
import cn.tju.sse.spring_backend.dto.cus.history.HistoryGetBrowsingHistoryResponse;
import cn.tju.sse.spring_backend.repository.cus.history.HistoryGetBrowsingHistoryNumberRepository;
import cn.tju.sse.spring_backend.repository.cus.history.HistoryGetBrowsingHistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HistoryGetBrowsingHistoryNumberService {
    @Autowired
    HistoryGetBrowsingHistoryNumberRepository historyGetBrowsingHistoryNumberRepository;


    /**
     * 获取历史记录
     * 对Repository的第二个对象进行转换
     * @param cus_id-用户id
     * @return HistoryGetBrowsingHistoryNumberResponse
     */
    public HistoryGetBrowsingHistoryNumberResponse getBrowsingHistoryNumberResponse(int cus_id){
        List<Object[]> object=historyGetBrowsingHistoryNumberRepository.findBrowseEntitiesNum(cus_id);

        // 错判
        if(object.isEmpty()){
            HistoryGetBrowsingHistoryNumberResponse historyGetBrowsingHistoryNumberResponse=new HistoryGetBrowsingHistoryNumberResponse();
            historyGetBrowsingHistoryNumberResponse.setBro_num(0);
            return historyGetBrowsingHistoryNumberResponse;
        }

        HistoryGetBrowsingHistoryNumberResponse historyGetBrowsingHistoryNumberResponse=new HistoryGetBrowsingHistoryNumberResponse();
        historyGetBrowsingHistoryNumberResponse.setBro_num(Integer.parseInt(object.get(0)[1].toString()));
        return historyGetBrowsingHistoryNumberResponse;
    }
}
