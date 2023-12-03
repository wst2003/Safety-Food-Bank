package cn.tju.sse.spring_backend.repository.sto;

import cn.tju.sse.spring_backend.model.NoticeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * 上传通知的数据访问接口
 */
public interface UploadNoticeRepository extends JpaRepository<NoticeEntity, Integer> {
}
