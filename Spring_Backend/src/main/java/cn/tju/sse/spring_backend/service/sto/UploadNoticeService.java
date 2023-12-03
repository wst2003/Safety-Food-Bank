package cn.tju.sse.spring_backend.service.sto;

import cn.tju.sse.spring_backend.dto.sto.UploadNoticeRequestDTO;
import cn.tju.sse.spring_backend.model.NoticeEntity;
import cn.tju.sse.spring_backend.repository.SeqNextvalRepository;
import cn.tju.sse.spring_backend.repository.sto.UploadNoticeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;

/**
 * 用于处理上传通知请求的服务类
 */
@Service
public class UploadNoticeService {
    @Autowired
    private UploadNoticeRepository uploadNoticeRepository;
    @Autowired
    private SeqNextvalRepository seqNextvalRepository;

    /**
     * 处理上传通知的逻辑并保存到数据库
     *
     * @param request 上传通知的请求数据对象
     * @return String 表示操作结果的字符串
     */
    public String uploadNotice(UploadNoticeRequestDTO request) {
        int nextID = seqNextvalRepository.callSEQ_NEXTVAL("NTC_ID_SEQ");
        System.out.println(nextID);
        System.out.println(request.getSTO_ID());
        System.out.println(request.getNTC_CONTENT());

        NoticeEntity notice = new NoticeEntity();
        notice.setNtcId(nextID);
        notice.setNtcTime(new Date(System.currentTimeMillis()));
        notice.setNtcContent(request.getNTC_CONTENT());
        notice.setNtcState(1);
        notice.setStoId(request.getSTO_ID());

        uploadNoticeRepository.save(notice);

        return "插入成功";
    }
}
