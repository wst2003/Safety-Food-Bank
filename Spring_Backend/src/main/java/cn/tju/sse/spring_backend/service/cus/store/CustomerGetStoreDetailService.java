package cn.tju.sse.spring_backend.service.cus.store;

import cn.tju.sse.spring_backend.dto.cus.store.CustomerGetStoreDetailResponse;
import cn.tju.sse.spring_backend.repository.cus.store.CustomerGetStoreDetailRepository;
import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class CustomerGetStoreDetailService {
    @Autowired
    private CustomerGetStoreDetailRepository customerGetStoreDetailRepository;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    // jdbc嵌套查询，返回对应的商店详情（包括该商品是否被用户收藏）,
    // 返回这个商家的基本信息和每个商家旗下三款商品的基本信息，用于商家详情页面

    /*
    商品信息类
     */
    @Getter
    @Setter
    public class ComListInfo {
        Integer com_id;
        String com_name;
        String com_firstImage;
        BigDecimal com_price;
        String com_expirationDate;
        Integer favor_state;
        Integer com_status;
    }
    /*
        商家公告类
     */
    @Getter
    @Setter
    public class StoNoticeInfo {
        String ntc_time;
        String ntc_content;
    }
    /*
    商店详情类
     */
    @Getter
    @Setter
    public class StoreDetailContent {
        public Integer sto_id;
        public String sto_name;
        public String sto_introduction;
        public String sto_licenseImg;
        public List<String> com_categories;
        public String user_address;
        public List<String> sto_imageList;
        public List<StoNoticeInfo> sto_notice;
        public List<ComListInfo> com_list;
    }
    /**
     * 查询商店详情信息，多表查询，嵌套查询，先根据sto_id查询STORE表中的所有信息，再根据sto_id进行子查询，查询
     * 商店的头图，类别和公告信息，再使用子查询，查询商店所有商品的信息（COMMODITY表以及商品头图，原价，种类，收藏状态）
     * @param sto_id cus_id 传入用户id和商店id
     * @return 返回商店详情信息
     */
    public StoreDetailContent getStoreDetailContent(int sto_id, int cus_id){
        StoreDetailContent storeDetailContent = new StoreDetailContent();

        // 定义日期格式对象
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String sql0 = " SELECT " +
                " USER_ADDRESS" +
                " FROM USERS" +
                " WHERE USER_ID= ?";
        String user_address = jdbcTemplate.queryForObject(sql0, String.class, cus_id);

        // 1. 主查询
        String sql = " SELECT " +
                " STORE.STO_ID,STORE.STO_NAME,STORE.STO_INTRODUCTION,STORE.STO_LICENSEIMG" +
                " FROM STORE" +
                " WHERE STORE.STO_ID= ?";

        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                sql,
                sto_id
        );
        // 2. 对每一行数据进行子查询
        rows.forEach(row -> {

            // 3. 根据stoId执行子查询
            String sql1 = "SELECT COM_CATEGORY FROM STORE_CATEGORIES WHERE STORE_ID = ?";
            List<String> sto_categories = jdbcTemplate.queryForList(sql1, String.class, sto_id);

            // 4. 根据stoId执行子查询
            String sql2 = "SELECT STO_IMAGE FROM STOREIMAGE WHERE STO_ID=?";
            List<String> sto_imageList = jdbcTemplate.queryForList(sql2, String.class, sto_id);

            // 5. 根据stoId执行子查询
            String sql3 = "SELECT NTC_TIME,NTC_CONTENT FROM  NOTICE WHERE STO_ID=? ORDER BY NTC_TIME DESC ";
            List<Map<String, Object>> temp = jdbcTemplate.queryForList(sql3, sto_id);
            List<StoNoticeInfo> sto_notice = new ArrayList<>();

            for(Map<String, Object> map : temp) {
                StoNoticeInfo notice = new StoNoticeInfo();
                notice.setNtc_time(sdf.format((Date)map.get("NTC_TIME")));
                notice.setNtc_content((String)map.get("NTC_CONTENT"));
                sto_notice.add(notice);
            }

            List<ComListInfo> com_list = new ArrayList<>();

            // 6. 根据comId执行子查询
            String sql4 = "SELECT " +
                    "COM_ID,COM_NAME,COM_EXPIRATIONDATE ,COM_STATUS " +
                    "FROM COMMODITY WHERE STO_ID =? AND COM_STATUS !=-1 ORDER BY COM_RATING";
            List<Map<String, Object>> rows2  = jdbcTemplate.queryForList(sql4, sto_id);

            // 7. 对每一行数据进行子查询
            rows2.forEach(row2 -> {

                ComListInfo comListInfo = new ComListInfo();
                int com_id = (int) row2.get("com_id");

                // 8. 根据comId执行子查询，获得现有价格
                String sql5 = "SELECT COM_PC_PRICE FROM COMMODITY_PRICE_CURVE WHERE COM_ID =? ORDER BY COM_PC_TIME ASC";
                List<BigDecimal> com_prices = jdbcTemplate.queryForList(sql5, BigDecimal.class, com_id);
                BigDecimal com_price;
                if (com_prices != null && !com_prices.isEmpty()) {
                    com_price = com_prices.get(0);
                } else {
                    com_price = BigDecimal.valueOf(-1);
                }

                // 9. 根据comId执行子查询
                String sql6 = "SELECT COM_IMAGE FROM COMMODITY_IMAGE WHERE COM_ID= ? ORDER BY COM_ID DESC ";
                List<String> com_Images = jdbcTemplate.queryForList(sql6, String.class, com_id);
                String com_firstImage;
                if (com_Images != null && !com_Images.isEmpty()) {
                    com_firstImage = com_Images.get(0);
                } else {
                    com_firstImage = "";
                }
                // 10. 根据comId执行子查询
                String sql7 = "SELECT COUNT(*) FROM FAVORITE WHERE COM_ID = ? AND CUS_ID =?";
                int num = jdbcTemplate.queryForObject(sql7, Integer.class,com_id,cus_id);
                Integer favor_state;
                if(num!=0){
                    favor_state = 1;
                }
                else{
                    favor_state = 0;
                }

                comListInfo.setCom_id(com_id);
                comListInfo.setCom_name((String)row2.get("com_name"));
                comListInfo.setCom_firstImage(com_firstImage);
                comListInfo.setCom_price(com_price);
                comListInfo.setCom_status((Integer)row2.get("com_status"));
                comListInfo.setFavor_state(favor_state);
                comListInfo.setCom_expirationDate(sdf.format((Date)row2.get("com_expirationDate")));
                com_list.add(comListInfo);
            });

            storeDetailContent.setSto_id(sto_id);
            storeDetailContent.setSto_name((String)row.get("sto_name"));
            storeDetailContent.setSto_introduction((String)row.get("sto_introduction"));
            storeDetailContent.setCom_categories(sto_categories);
            storeDetailContent.setUser_address(user_address);
            storeDetailContent.setSto_imageList(sto_imageList);
            storeDetailContent.setSto_licenseImg((String)row.get("sto_licenseImg"));
            storeDetailContent.setSto_notice(sto_notice);
            storeDetailContent.setCom_list(com_list);
        });
        return storeDetailContent;
    }

    /**
     * 获取商店详情
     * @param sto_id cus_id 传入用户id和商店id
     * @return 查询商店详情信息，并返回结果，如果没有对应的商店或传入的用户id错误，给出错误提示
     */
    public CustomerGetStoreDetailResponse getStoreDetail(int sto_id, int cus_id){
        CustomerGetStoreDetailResponse response = new CustomerGetStoreDetailResponse();
        // 查询有无该商家
        String query = customerGetStoreDetailRepository.findStoNameByStoID(sto_id);
        if(query==null){
            response=null;
            return response;
        }
        StoreDetailContent storeDetailContent= getStoreDetailContent(sto_id, cus_id);
        response.setSto_id(storeDetailContent.getSto_id());
        response.setCom_list(storeDetailContent.getCom_list());
        response.setSto_introduction(storeDetailContent.getSto_introduction());
        response.setSto_notice(storeDetailContent.getSto_notice());
        response.setSto_imageList(storeDetailContent.getSto_imageList());
        response.setUser_address(storeDetailContent.getUser_address());
        response.setCom_categories(storeDetailContent.getCom_categories());
        response.setSto_name(storeDetailContent.getSto_name());
        response.setSto_licenseImg(storeDetailContent.getSto_licenseImg());
        return response;
    }
}
