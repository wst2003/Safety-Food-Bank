package cn.tju.sse.spring_backend.dto.cus.store;

import cn.tju.sse.spring_backend.service.cus.store.CustomerGetStoreDetailService;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

/*
获取商店详情成功响应
 */
@Getter
@Setter
public class CustomerGetStoreDetailResponse {
    public Integer sto_id;
    public String sto_name;
    public String sto_introduction;
    public String sto_licenseImg;
    public List<String> com_categories;
    public String user_address;
    public List<String> sto_imageList;
    public List<CustomerGetStoreDetailService.StoNoticeInfo> sto_notice;
    public List<CustomerGetStoreDetailService.ComListInfo> com_list;
}
