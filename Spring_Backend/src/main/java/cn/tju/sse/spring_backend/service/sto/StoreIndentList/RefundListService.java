package cn.tju.sse.spring_backend.service.sto.StoreIndentList;

import cn.tju.sse.spring_backend.dto.sto.StoreIndentList.RefundResponseDTO;
import cn.tju.sse.spring_backend.repository.sto.StoreIndentList.RefundListRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * 退款订单服务类
 */
@Service
public class RefundListService {
    @Autowired
    private RefundListRepository refundListRepository;

    /**
     * 获取退款列表。
     *
     * @param stoId      商家ID
     * @param timeOrder  时间排序方式
     * @param userPhone  用户手机号
     * @param beginNum   开始位置
     * @param endNum     结束位置
     * @return 退款列表
     */
    public List<RefundResponseDTO> getRefundList(int stoId, int timeOrder, String userPhone, int beginNum, int endNum) {
        List<RefundResponseDTO> refunds = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        beginNum = beginNum - 1;
        int pageSize = endNum - beginNum;
        if (userPhone == null)
            userPhone = "";

        List<Object[]> refundList;
        if (timeOrder == 0)
            refundList = refundListRepository.getRefundListDesc(stoId, userPhone, beginNum, pageSize);
        else
            refundList = refundListRepository.getRefundListAsc(stoId, userPhone, beginNum, pageSize);

        for (Object[] row : refundList) {
            RefundResponseDTO refund = new RefundResponseDTO();

            refund.setIND_ID((Integer) row[0]);
            refund.setIND_QUANTITY((Integer) row[1]);
            refund.setCOM_ID((Integer) row[2]);
            refund.setCUS_ID((Integer) row[3]);
            refund.setCOM_NAME((String) row[4]);
            refund.setCOM_IMAGE((String) row[5]);
            refund.setIND_MONEY((BigDecimal) row[6]);
            refund.setIND_RMONEY((BigDecimal) row[7]);
            refund.setIND_CREATIONTIME(dateFormat.format(row[8]));
            refund.setIND_RTIME(dateFormat.format(row[9]));
            refund.setIND_RNOTES((String) row[10]);

            refunds.add(refund);
        }

        return refunds;
    }
}
