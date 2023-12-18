package cn.tju.sse.spring_backend.service.cus.favorite;

import cn.tju.sse.spring_backend.dto.cus.favorite.CustomerGetFavorResponse;
import cn.tju.sse.spring_backend.repository.cus.favorite.CustomerGetFavorRepository;
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
public class CustomerGetFavorService {
    @Autowired
    private CustomerGetFavorRepository customerGetFavorRepository;
    /*
    JDBC接口
     */
    @Autowired
    private JdbcTemplate jdbcTemplate;
    /*
    收藏夹中的商品类
     */
    @Getter
    @Setter
    public class FavorPageContent {
        public Integer com_id;
        public String com_name;
        public String com_introduction;
        public BigDecimal com_oriPrice;
        public String com_expirationDate;
        public String com_uploadDate;
        public Integer com_left;
        public BigDecimal com_rating;
        public String sto_name;
        public Integer sto_id;
        public List<String> com_categories;
        public String com_firstImage;
        public BigDecimal com_price;
        public Integer favor_state;
        public Integer com_status;
    }
    /**
     * 多表查询，查询用户的收藏商品信息
     * @param cus_id 传入用户id
     * @return 嵌套查询，多表查询，根据用户id查询已收藏的商品id（commodity表所有字段），在根据com_id进行子查询，查询出
     * 对应商品的头图，商品种类，原价
     */
    List<FavorPageContent> searchCommodities(int cus_id) {

        List<FavorPageContent> list = new ArrayList<>();
        // 1. 主查询
        String sql = "SELECT " +
                " FAVORITE.COM_ID,COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING,COMMODITY.STO_ID,STORE.STO_NAME,COM_STATUS " +
                " FROM COMMODITY,STORE,FAVORITE " +
                " WHERE FAVORITE.CUS_ID = ? AND FAVORITE.COM_ID= COMMODITY.COM_ID AND COMMODITY.STO_ID=STORE.STO_ID " +
                " ORDER BY COM_RATING DESC";

        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                sql,
                cus_id
        );

        // 2. 对每一行数据进行子查询
        rows.forEach(row -> {

            int com_id = (int) row.get("com_id");

            // 3. 根据comId执行子查询1
            String sql1 = "SELECT COM_CATEGORY FROM COMMODITY_CATEGORIES WHERE COM_ID = ?";
            List<String> com_categories = jdbcTemplate.queryForList(sql1, String.class, com_id);

            // 4. 根据comId执行子查询2
            String sql2 = "SELECT COM_IMAGE FROM COMMODITY_IMAGE WHERE COM_ID= ? ORDER BY COM_ID DESC ";
            List<String> com_Images = jdbcTemplate.queryForList(sql2, String.class, com_id);
            String com_firstImage;
            if (com_Images != null && !com_Images.isEmpty()) {
                com_firstImage = com_Images.get(0);
            } else {
                com_firstImage = "";
            }

            // 5. 根据comId执行子查询3
            String sql3 = "SELECT COM_PC_PRICE FROM COMMODITY_PRICE_CURVE WHERE COM_ID =? ORDER BY COM_PC_TIME ASC";
            List<BigDecimal> com_prices = jdbcTemplate.queryForList(sql3, BigDecimal.class, com_id);
            BigDecimal com_price;
            if (com_prices != null && !com_prices.isEmpty()) {
                com_price = com_prices.get(0);
            } else {
                com_price = BigDecimal.valueOf(-1);
            }

            // 定义日期格式对象
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            // 6. 构建模型对象
            FavorPageContent commodity = new FavorPageContent();
            commodity.setCom_id(com_id);
            commodity.setCom_name((String) row.get("com_name"));
            commodity.setCom_introduction((String) row.get("com_introduction"));
            commodity.setCom_oriPrice((BigDecimal) row.get("com_oriPrice"));
            commodity.setCom_expirationDate(sdf.format((Date) row.get("com_expirationDate")));
            commodity.setCom_uploadDate(sdf.format((Date) row.get("com_uploadDate")));
            commodity.setCom_left((Integer) row.get("com_left"));
            commodity.setCom_rating((BigDecimal) row.get("com_rating"));
            commodity.setSto_name((String) row.get("sto_name"));
            commodity.setSto_id((Integer) row.get("sto_id"));

            commodity.setCom_categories(com_categories);
            commodity.setCom_firstImage(com_firstImage);
            commodity.setCom_price(com_price);
            commodity.setFavor_state(1);
            commodity.setCom_status((Integer) row.get("com_status"));
            list.add(commodity);
        });
        return list;
    }
    /**
     *
     * @param cus_id 传入用户id
     * @return 获取用户收藏商品信息并返回
     */
    public CustomerGetFavorResponse getFavorList(int cus_id) {
        List<FavorPageContent> list = searchCommodities(cus_id);
        CustomerGetFavorResponse customerGetFavorResponse = new CustomerGetFavorResponse();
        customerGetFavorResponse.setFavor_list(list);
        return customerGetFavorResponse;
    }
}
