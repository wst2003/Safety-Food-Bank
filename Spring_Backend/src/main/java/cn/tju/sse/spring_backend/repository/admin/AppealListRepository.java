package cn.tju.sse.spring_backend.repository.admin;

import cn.tju.sse.spring_backend.model.AppealEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 申诉列表数据访问接口
 */
public interface AppealListRepository extends JpaRepository<AppealEntity, Integer> {
    /**
     * 按升序获取申诉列表
     *
     * @param beginNumber 起始索引
     * @param pageSize    每页大小
     * @return 申诉列表数据
     */
    @Query(value = "WITH APPEAL_WITH_IMAGE AS(" +
            "SELECT APPEAL.APP_ID, " +
            "APPEAL.APP_MATTERS, " +
            "APPEAL.APP_CONTENT, " +
            "APPEAL.USER_ID, " +
            "APPEAL.COM_ID, " +
            "APPEAL.CMT_ID, " +
            "APPEAL.APP_USERID, " +
            "APPEAL.APP_TIME, " +
            "GROUP_CONCAT(SCREENSHOT.SCT_IMAGE ORDER BY SCREENSHOT.SCT_IMAGE SEPARATOR ';') AS IMAGESET " +
            "FROM APPEAL " +
            "LEFT JOIN SCREENSHOT ON APPEAL.APP_ID = SCREENSHOT.APP_ID " +
            "GROUP BY APPEAL.APP_ID, " +
            "APPEAL.APP_MATTERS, " +
            "APPEAL.APP_CONTENT, " +
            "APPEAL.USER_ID, " +
            "APPEAL.COM_ID, " +
            "APPEAL.CMT_ID, " +
            "APPEAL.APP_USERID, " +
            "APPEAL.APP_TIME " +
            "ORDER BY APPEAL.APP_TIME " +
            "ASC) " +
            "SELECT APPEAL_WITH_IMAGE.*, COMMODITY_COMMENT.CMT_CONTENT " +
            "FROM APPEAL_WITH_IMAGE " +
            "LEFT JOIN COMMODITY_COMMENT ON APPEAL_WITH_IMAGE.CMT_ID = COMMODITY_COMMENT.CMT_ID " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getAppealListAsc(@Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);

    /**
     * 按降序获取申诉列表
     *
     * @param beginNumber 起始索引
     * @param pageSize    每页大小
     * @return 申诉列表数据
     */
    @Query(value = "WITH APPEAL_WITH_IMAGE AS(" +
            "SELECT APPEAL.APP_ID, " +
            "APPEAL.APP_MATTERS, " +
            "APPEAL.APP_CONTENT, " +
            "APPEAL.USER_ID, " +
            "APPEAL.COM_ID, " +
            "APPEAL.CMT_ID, " +
            "APPEAL.APP_USERID, " +
            "APPEAL.APP_TIME, " +
            "GROUP_CONCAT(SCREENSHOT.SCT_IMAGE ORDER BY SCREENSHOT.SCT_IMAGE SEPARATOR ';') AS IMAGESET " +
            "FROM APPEAL " +
            "LEFT JOIN SCREENSHOT ON APPEAL.APP_ID = SCREENSHOT.APP_ID " +
            "GROUP BY APPEAL.APP_ID, " +
            "APPEAL.APP_MATTERS, " +
            "APPEAL.APP_CONTENT, " +
            "APPEAL.USER_ID, " +
            "APPEAL.COM_ID, " +
            "APPEAL.CMT_ID, " +
            "APPEAL.APP_USERID, " +
            "APPEAL.APP_TIME " +
            "ORDER BY APPEAL.APP_TIME " +
            "DESC) " +
            "SELECT APPEAL_WITH_IMAGE.*, COMMODITY_COMMENT.CMT_CONTENT " +
            "FROM APPEAL_WITH_IMAGE " +
            "LEFT JOIN COMMODITY_COMMENT ON APPEAL_WITH_IMAGE.CMT_ID = COMMODITY_COMMENT.CMT_ID " +
            "LIMIT :beginNumber, :pageSize",
            nativeQuery = true)
    List<Object[]> getAppealListDesc(@Param("beginNumber") int beginNumber, @Param("pageSize") int pageSize);
}
