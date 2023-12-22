package cn.tju.sse.spring_backend.service.cus.search;

import cn.tju.sse.spring_backend.dto.cus.search.*;
import cn.tju.sse.spring_backend.dto.cus.search.mapper.StoListMapper;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import cn.tju.sse.spring_backend.repository.cus.search.SearchCommodityPriceCurveRepository;
import cn.tju.sse.spring_backend.repository.cus.search.SearchItemRepository;
import cn.tju.sse.spring_backend.utils.StorageFileReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author lhx
 * @date 2023/12/22
 * @Description 用于管理搜索商家、搜索商品接口的Service类
 */
@Service
public class SearchItemService {
    @Autowired
    SearchItemRepository searchItemRepository;

    @Autowired
    SearchCommodityPriceCurveRepository searchCommodityPriceCurveRepository;


    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 搜索商品
     */
    public CommodityListResponseDTO commodityList(CommodityListRequestDTO request) {
        CommodityListResponseDTO commodityListResponseDTO=new CommodityListResponseDTO();
        List<CommodityListResponseDTO.ComEleDTO> eleList=new ArrayList<>();
        List<Object[]> sqlList;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        if(request.getCom_categories().size()>0){
            sqlList=searchItemRepository.queryForCategoriedCommodityList(request.getCom_categories(), request.getSearch_str());
        }
        else
            sqlList = searchItemRepository.queryForCommodityList(request.getSearch_str());
        // 查询完成，遍历赋值
        for(Object[] row:sqlList){
            CommodityListResponseDTO.ComEleDTO eleDTO=new CommodityListResponseDTO.ComEleDTO();

            eleDTO.setCom_id((Integer) row[0]);
            eleDTO.setCom_name((String)row[1]);
            eleDTO.setCom_introduction((String)row[2]);
            eleDTO.setCom_oriPrice((BigDecimal) row[3]);
            Date com_expirationDate=(Date) row[4];
            LocalDateTime localDateTime = com_expirationDate.toLocalDate().atStartOfDay();
            String formattedDate = localDateTime.format(formatter);
            eleDTO.setCom_expirationDate(formattedDate);
            Date com_uploadDate=(Date) row[5];
            localDateTime = com_uploadDate.toLocalDate().atStartOfDay();
            formattedDate = localDateTime.format(formatter);
            eleDTO.setCom_uploadDate(formattedDate);
            eleDTO.setCom_left((Integer)row[6]);
            eleDTO.setCom_rating((BigDecimal) row[7]);
            eleDTO.setSto_id((Integer) row[8]);
            eleDTO.setSto_name((String) row[9]);
            eleDTO.setCom_status((Integer) row[10]);
            //设置头图
            String imgs=(String)row[11];
            if(imgs!=null){
                eleDTO.setCom_firstImage(imgs.split(",")[0]);
            }
            else
                eleDTO.setCom_firstImage("");
            // 设置商品类别
            String categories=(String)row[12];
            if(categories!=null){
                eleDTO.setCom_categories(Arrays.stream(categories.split(","))
                        .distinct()
                        .collect(Collectors.toList()));
            }
            else
                eleDTO.setCom_categories(new ArrayList<>());
            // 检查收藏状态
            List<Object[]> favor_list= searchItemRepository.checkFavorite(request.getCus_id(),eleDTO.getCom_id());
            if(favor_list.size()>0)
                eleDTO.setFavor_state(1);
            else
                eleDTO.setFavor_state(0);
            //设置现价
            eleDTO.setCom_price(getCurrentPrice(eleDTO.getCom_id()));

            eleList.add(eleDTO);
            //System.out.println(eleDTO.getCom_id()+"商品现价"+eleDTO.getCom_price());
        }

        String folderPath,filePath;
        List<Integer> sequence;
        switch (request.getSort_order()){
            case 0:
                //根据评分排序
                Collections.sort(eleList, new Comparator<CommodityListResponseDTO.ComEleDTO>() {
                    @Override
                    public int compare(CommodityListResponseDTO.ComEleDTO o1, CommodityListResponseDTO.ComEleDTO o2) {
                        return o2.getCom_rating().compareTo(o1.getCom_rating());
                    }
                });
                break;
            case 1:
                //根据地理位置排序
                folderPath = ".\\NearbySto";
                filePath = folderPath + File.separator + "nearbysto"+request.getCus_id() + ".txt";
                sequence = StorageFileReader.getStorage(filePath);
                Collections.sort(eleList, new Comparator<CommodityListResponseDTO.ComEleDTO>() {
                    @Override
                    public int compare(CommodityListResponseDTO.ComEleDTO x, CommodityListResponseDTO.ComEleDTO y) {
                        return Integer.compare(sequence.indexOf(x.getSto_id()), sequence.indexOf(y.getSto_id()));
                    }
                });
                break;
            case 2:
                // 按到期日期排序
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Collections.sort(eleList, new Comparator<CommodityListResponseDTO.ComEleDTO>() {
                    @Override
                    public int compare(CommodityListResponseDTO.ComEleDTO x, CommodityListResponseDTO.ComEleDTO y) {
                        try {
                            java.util.Date dateX = sdf.parse(x.getCom_expirationDate());
                            java.util.Date dateY = sdf.parse(y.getCom_expirationDate());
                            return dateX.compareTo(dateY);
                        } catch (ParseException e) {
                            throw new IllegalArgumentException("Invalid date format", e);
                        }
                    }
                });
                break;
            case 3:
                //按照价格排序
                Collections.sort(eleList, new Comparator<CommodityListResponseDTO.ComEleDTO>() {
                    @Override
                    public int compare(CommodityListResponseDTO.ComEleDTO x, CommodityListResponseDTO.ComEleDTO y) {
                            return x.getCom_price().compareTo(y.getCom_price());
                    }
                });
                break;
            case 4:
                // 按照推荐算法排序
                folderPath = ".\\ItemCF";
                filePath = folderPath + File.separator + "recommendation"+request.getCus_id() + ".txt";
                sequence = StorageFileReader.getStorage(filePath);
                Collections.sort(eleList, new Comparator<CommodityListResponseDTO.ComEleDTO>() {
                    @Override
                    public int compare(CommodityListResponseDTO.ComEleDTO x, CommodityListResponseDTO.ComEleDTO y) {
                        return Integer.compare(sequence.indexOf(x.getCom_id()), sequence.indexOf(y.getCom_id()));
                    }
                });
                break;
        }

        // 裁切
        int len;
        if(eleList.size()>request.getEnd_pos()){
            len=request.getEnd_pos()-request.getBegin_pos();
        }
        else
            len=eleList.size()- request.getBegin_pos();
        int beginPos=Math.max(0,Math.min(request.getBegin_pos(),eleList.size()));
        int toIndex=Math.min(eleList.size(),beginPos+len);
        commodityListResponseDTO.setCom_list(eleList.subList(beginPos,toIndex));
        commodityListResponseDTO.setTotal(toIndex-beginPos);

        return commodityListResponseDTO;
    }

    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 根据价格曲线，查询商品当前价格
     */
    BigDecimal getCurrentPrice(Integer com_id){
        List<CommodityPriceCurveEntity> list= searchCommodityPriceCurveRepository.getCommodityPriceCurveEntitiesByComId(com_id);
        long millis = System.currentTimeMillis();
        BigDecimal result = BigDecimal.valueOf(-1);
        Date currentDate = new Date(millis);
//        System.out.println("当前时间："+currentDate);
        Collections.sort(list, Comparator.comparing(CommodityPriceCurveEntity::getComPcTime).reversed());
        for (CommodityPriceCurveEntity item : list){
            if(item.getComPcTime().compareTo(currentDate)<=0){
                result=item.getComPcPrice();
                //System.out.println("商品当前价格："+result);
                break;
            }
        }
        if(result == BigDecimal.valueOf(-1))
            // 价格曲线数据出现问题，没有当前时间前的节点
            throw new RuntimeException();
        return result;
    }

    /**
     * @author lhx
     * @date 2023/12/22
     * @Description 搜索商家
     */
    public StoreListResponseDTO storeList(StoreListRequestDTO request) {
        StoreListResponseDTO storeListResponseDTO=new StoreListResponseDTO();
        List<StoEleDTO> eleList=new ArrayList<>();
        List<Object[]> sqlList;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        if(request.getCom_categories().size()>0){
            sqlList=searchItemRepository.queryForCategoriedStoreList(request.getCom_categories(), request.getSearch_str());
        }
        else
            sqlList = searchItemRepository.queryForStoreList(request.getSearch_str());

        for(Object[] row:sqlList){
            StoEleDTO eleDTO=new StoEleDTO();
            eleDTO.setSto_id((Integer) row[0]);
            eleDTO.setSto_name((String) row[1]);
            eleDTO.setSto_introduction((String) row[2]);
            eleDTO.setUser_address((String) row[3]);
            Date reg_time=(Date) row[4];
            LocalDateTime localDateTime = reg_time.toLocalDate().atStartOfDay();
            String formattedDate = localDateTime.format(formatter);
            eleDTO.setReg_time(formattedDate);
            Long ind_num=(Long) row[5];
            if(ind_num!=null)
                eleDTO.setInd_num((Long) row[5]);
            else
                eleDTO.setInd_num(0L);
//            System.out.println(eleDTO.getSto_name()+"订单数量"+eleDTO.getInd_num());
            //设置头图
            String imgs=(String)row[6];
            if(imgs!=null){
                eleDTO.setSto_firstImage(imgs.split(",")[0]);
            }
            else
                eleDTO.setSto_firstImage("");
            // 设置商品类别
            String categories=(String)row[7];
            if(categories!=null){
                eleDTO.setCom_categories(Arrays.stream(categories.split(","))
                        .distinct()
                        .collect(Collectors.toList()));
            }
            else
                eleDTO.setCom_categories(new ArrayList<>());

            eleList.add(eleDTO);


        }

        // 排序
        String folderPath,filePath;
        List<Integer> sequence;
        switch (request.getSort_order()){
            case 0:
                //根据订单数量排序
                Collections.sort(eleList, new Comparator<StoEleDTO>() {
                    @Override
                    public int compare(StoEleDTO o1, StoEleDTO o2) {
                        return o2.getInd_num().compareTo(o1.getInd_num());
                    }
                });
                break;
            case 1:
                //根据地理位置排序
                folderPath = ".\\NearbySto";
                filePath = folderPath + File.separator + "nearbysto"+request.getCus_id() + ".txt";
                sequence = StorageFileReader.getStorage(filePath);
                Collections.sort(eleList, new Comparator<StoEleDTO>() {
                    @Override
                    public int compare(StoEleDTO x, StoEleDTO y) {
                        return Integer.compare(sequence.indexOf(x.getSto_id()), sequence.indexOf(y.getSto_id()));
                    }
                });
                break;
            case 2:
                // 按开业时间排序
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Collections.sort(eleList, new Comparator<StoEleDTO>() {
                    @Override
                    public int compare(StoEleDTO x, StoEleDTO y) {
                        try {
                            java.util.Date dateX = sdf.parse(x.getReg_time());
                            java.util.Date dateY = sdf.parse(y.getReg_time());
                            return dateY.compareTo(dateX);
                        } catch (ParseException e) {
                            throw new IllegalArgumentException("Invalid date format", e);
                        }
                    }
                });
                break;
        }

        // 裁切
        int len;
        if(eleList.size()>request.getEnd_pos()){
            len=request.getEnd_pos()-request.getBegin_pos();
        }
        else
            len=eleList.size()- request.getBegin_pos();
        int beginPos=Math.max(0,Math.min(request.getBegin_pos(),eleList.size()));
        int toIndex=Math.min(eleList.size(),beginPos+len);
        List<StoEleDTO> listtemp=eleList.subList(beginPos,toIndex);
        storeListResponseDTO.setSto_list(new ArrayList<>());
        for(StoEleDTO temp:listtemp){
            storeListResponseDTO.getSto_list().add(StoListMapper.INSTANCE.EleToDTO(temp));
        }

        storeListResponseDTO.setTotal(toIndex-beginPos);
        return storeListResponseDTO;
    }
}
