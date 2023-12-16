package cn.tju.sse.spring_backend.service.admin;

import cn.tju.sse.spring_backend.dto.admin.AppealResponseDTO;
import cn.tju.sse.spring_backend.repository.admin.AppealListRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * 申诉列表服务类
 */
@Service
public class AppealListService {
    @Autowired
    private AppealListRepository appealListRepository;

    /**
     * 获取申诉列表。
     *
     * @param timeOrder  时间排序方式
     * @param beginNum   开始位置
     * @param endNum     结束位置
     * @return 申诉列表
     */
    public List<AppealResponseDTO> getAppealList(int timeOrder, int beginNum, int endNum) {
        List<AppealResponseDTO> appeals = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        beginNum = beginNum - 1;
        int pageSize = endNum - beginNum;

        List<Object[]> appealList;
        if (timeOrder == 1)
            appealList = appealListRepository.getAppealListAsc(beginNum, pageSize);
        else
            appealList = appealListRepository.getAppealListDesc(beginNum, pageSize);

        for (Object[] row : appealList) {
            AppealResponseDTO appeal = new AppealResponseDTO();

            appeal.setAPP_ID((Integer) row[0]);
            appeal.setAPP_MATTERS((Integer) row[1]);

            if (row[2] != null)
                appeal.setAPP_CONTENT((String) row[2]);
            else
                appeal.setAPP_CONTENT("null");

            if (row[3] != null)
                appeal.setUSER_ID((Integer) row[3]);
            else
                appeal.setUSER_ID(-1);

            if (row[4] != null)
                appeal.setCOM_ID((Integer) row[4]);
            else
                appeal.setCOM_ID(-1);

            if (row[5] != null)
                appeal.setCMT_ID((Integer) row[5]);
            else
                appeal.setCMT_ID(-1);

            if (row[6] != null)
                appeal.setAPP_USERID((Integer) row[6]);
            else
                appeal.setAPP_USERID(-1);

            appeal.setAPP_TIME(dateFormat.format(row[7]));

            if (row[8] != null) {
                String imageSet = (String) row[8];
                String[] images = imageSet.split(";");
                appeal.setSCT_IMAGE(List.of(images));
            } else {
                appeal.setSCT_IMAGE(new ArrayList<>());
            }

            if (row[9] != null)
                appeal.setCMT_CONTENT((String) row[9]);
            else
                appeal.setCMT_CONTENT("null");

            appeals.add(appeal);
        }

        return appeals;
    }
}
