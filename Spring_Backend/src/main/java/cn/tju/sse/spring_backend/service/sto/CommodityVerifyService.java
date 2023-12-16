package cn.tju.sse.spring_backend.service.sto;

import cn.tju.sse.spring_backend.dto.sto.CommodityVerifyResponseDTO;
import cn.tju.sse.spring_backend.repository.sto.CommodityVerifyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 商品核销服务类
 */
@Service
public class CommodityVerifyService {
    @Autowired
    private CommodityVerifyRepository commodityVerifyRepository;

    /**
     * 获取待核销的订单信息。
     *
     * @param indentVerificationCode 订单验证代码
     * @return 待核销的订单信息
     */
    public CommodityVerifyResponseDTO getIndentToVerify(String indentVerificationCode) {
        CommodityVerifyResponseDTO indents = new CommodityVerifyResponseDTO();
        List<CommodityVerifyResponseDTO.ListItem> listItems = new ArrayList<>();

        List<Object[]> indentList = commodityVerifyRepository.getIndentToVerify(indentVerificationCode);
        for (Object[] row : indentList) {
            indents.setCUS_ID((Integer) row[0]);

            CommodityVerifyResponseDTO.ListItem listItem = new CommodityVerifyResponseDTO.ListItem();
            listItem.setIND_ID((Integer) row[1]);
            listItem.setCOM_ID((Integer) row[2]);
            listItem.setCOM_NAME((String) row[3]);
            listItem.setIND_QUANTITY((Integer) row[4]);
            listItems.add(listItem);
        }
        indents.setLIST(listItems);

        return indents;
    }

    /**
     * 核销商品。
     *
     * @param indentVerificationCode 订单验证代码
     * @return 核销结果
     */
    public boolean verifyIndent(String indentVerificationCode) {
        int rowsAffected = commodityVerifyRepository.verifyIndent(indentVerificationCode);
        commodityVerifyRepository.setComRating(indentVerificationCode);
        return rowsAffected > 0;
    }
}
