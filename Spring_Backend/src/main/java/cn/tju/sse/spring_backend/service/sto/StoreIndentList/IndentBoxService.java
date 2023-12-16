package cn.tju.sse.spring_backend.service.sto.StoreIndentList;

import cn.tju.sse.spring_backend.dto.sto.StoreIndentList.IndentBoxResponseDTO;
import cn.tju.sse.spring_backend.repository.sto.StoreIndentList.IndentBoxRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * 获取订单服务类
 */
@Service
public class IndentBoxService {
    @Autowired
    private IndentBoxRepository indentBoxRepository;

    /**
     * 根据条件获取订单信息。
     *
     * @param stoId     门店ID
     * @param timeOrder 时间排序方式
     * @param boxBegin  起始位置
     * @param boxEnd    结束位置
     * @param userPhone 用户手机号
     * @param indState  订单状态
     * @return 订单信息列表
     */
    public List<IndentBoxResponseDTO> getIndentWithBox(int stoId, int timeOrder, int boxBegin, int boxEnd, String userPhone, int indState) {
        List<IndentBoxResponseDTO> indents = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        int indStateOrigin = indState;
        if (userPhone == null)
            userPhone = "";
        if (indState != 1)
            indState = 0;
        if (boxBegin == 1)
            boxBegin = 0;

        BigDecimal groupNumber = BigDecimal.valueOf(0);

        List<Object[]> indentList;
        if (timeOrder == 0)
            indentList = indentBoxRepository.getIndentWithBoxDesc(stoId, userPhone, indState, indStateOrigin, boxBegin, boxEnd);
        else
            indentList = indentBoxRepository.getIndentWithBoxAsc(stoId, userPhone, indState, indStateOrigin, boxBegin, boxEnd);

        for (Object[] row : indentList) {
            BigDecimal tmp = (BigDecimal) row[13];
            if (!Objects.equals(tmp, groupNumber)) {
                groupNumber = tmp;

                IndentBoxResponseDTO indent = new IndentBoxResponseDTO();
                List<IndentBoxResponseDTO.ListItem> listItems = new ArrayList<>();
                indent.setCUS_ID((Integer) row[9]);
                indent.setIND_CREATIONTIME(dateFormat.format(row[10]));
                indent.setUSER_PHONE((String) row[11]);
                indent.setCUS_NICKNAME((String) row[12]);
                indent.setBOX(listItems);

                indents.add(indent);
            }

            IndentBoxResponseDTO.ListItem listItem = new IndentBoxResponseDTO.ListItem();
            listItem.setIND_ID((Integer) row[0]);
            listItem.setCOM_ID((Integer) row[1]);
            listItem.setIND_QUANTITY((Integer) row[2]);
            listItem.setIND_MONEY((BigDecimal) row[3]);
            listItem.setCOM_NAME((String) row[4]);
            listItem.setCOM_IMAGE((String) row[6]);
            if (row[7] == null)
                listItem.setIND_NOTES("");
            else
                listItem.setIND_NOTES((String) row[7]);
            if (row[8] == null)
                listItem.setIND_RATING(-1);
            else {
                BigDecimal decimalValue = (BigDecimal) row[8];
                listItem.setIND_RATING(decimalValue.intValue());
            }

            indents.getLast().getBOX().add(listItem);
        }

        return indents;
    }
}
