package cn.tju.sse.spring_backend.service.cus.indent;

import cn.tju.sse.spring_backend.controller.cus.balance.CustomerBalanceController;
import cn.tju.sse.spring_backend.dto.cus.balance.CustomerGetBalanceResponse;
import cn.tju.sse.spring_backend.dto.cus.balance.CustomerSetBalanceRequest;
import cn.tju.sse.spring_backend.dto.cus.balance.CustomerSetBalanceResponse;
import cn.tju.sse.spring_backend.dto.cus.indent.*;
import cn.tju.sse.spring_backend.model.CommodityCommentEntity;
import cn.tju.sse.spring_backend.model.CommodityEntity;
import cn.tju.sse.spring_backend.model.CommodityPriceCurveEntity;
import cn.tju.sse.spring_backend.model.IndentEntity;
import cn.tju.sse.spring_backend.repository.cus.indent.*;
import cn.tju.sse.spring_backend.repository.SeqNextvalRepository;
import cn.tju.sse.spring_backend.utils.ContentFilter;
import cn.tju.sse.spring_backend.utils.StorageFileReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.io.File;
import java.io.IOException;
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
 * @date 2023/12/20
 * @Description 统一管理订单服务类
 */
@Service
public class IndentService {
    @Autowired
    IndentRepository indentRepository;

    @Autowired
    SeqNextvalRepository seqNextvalRepository;

    @Autowired
    IndentCommodityRepository indentCommodityRepository;

    @Autowired
    CustomerBalanceController customerBalanceController;

    @Autowired
    IndentCommodityPriceCurveRepository commodityPriceCurveRepository;

    @Autowired
    IndentCommentRepository indentCommentRepository;

    @Autowired
    IndentCommodityImageRepository indentCommodityImageRepository;

    /**
     * @author lhx
     * @date 2023/12/20
     * @Description 生成订单
     * 插入订单表、修改商品余量、修改商家与顾客账户余额
     */
    @Transactional
    public MsgResponseDTO generateIndent(GenerateIndentRequestDTO request) throws ParseException {
        MsgResponseDTO msgResponseDTO = new MsgResponseDTO();
        long millis = System.currentTimeMillis();
        Date currentDate = new Date(millis);

        for (GenerateIndentRequestDTO.IndentsDTO indentDTO:request.getIndent_arr()){
            // 生成一个随机的UUID
            UUID uuid = UUID.randomUUID();
            String uuidAsString = uuid.toString();
            if(indentDTO.getInd_notes().length()==0){
                indentDTO.setInd_notes(" ");
            }
            for(GenerateIndentRequestDTO.CommoditiesDTO commodityDTO:indentDTO.getCom_arr()){
                IndentEntity indentEntity = new IndentEntity();
                indentEntity.setIndId(seqNextvalRepository.callSEQ_NEXTVAL("IND_ID_SEQ"));
                indentEntity.setIndQuantity(commodityDTO.getInd_quantity());
                indentEntity.setIndMoney(commodityDTO.getInd_money());

                indentEntity.setIndCreationtime(currentDate);
                // 此处存疑
                indentEntity.setIndVerificationcode(uuidAsString);
                indentEntity.setIndNotes(indentDTO.getInd_notes());
                indentEntity.setIndState(0);
                indentEntity.setIndRating(BigDecimal.valueOf(-1));
                indentEntity.setCusId(Integer.valueOf(request.getCus_id()));
                indentEntity.setComId(Integer.valueOf(commodityDTO.getCom_id()));

                indentEntity.setIndRtime(new Date(0));
                indentEntity.setIndRnotes(" ");
                indentEntity.setIndRmoney(BigDecimal.valueOf(-1));
                IndentEntity indentEntity_save = indentRepository.save(indentEntity);
                if(indentEntity_save==null){
                    throw new RuntimeException();

                }

                // 修改商品余量
                CommodityEntity exists = indentCommodityRepository.
                        findById(Integer.valueOf(commodityDTO.getCom_id())).orElseThrow();
                exists.setComLeft(exists.getComLeft()-commodityDTO.getInd_quantity());
                CommodityEntity update = indentCommodityRepository.save(exists);
                if(update==null){
                    throw new RuntimeException();
                }
                // 修改用户账户余额
                CustomerSetBalanceRequest customerSetBalanceRequest=new CustomerSetBalanceRequest();
                customerSetBalanceRequest.setCus_id(Integer.valueOf(request.getCus_id()));
                ResponseEntity<CustomerGetBalanceResponse> balance= customerBalanceController.customerGetBalance(Integer.valueOf(request.getCus_id()));
                customerSetBalanceRequest.setBalance(balance.getBody().getBalance().subtract(commodityDTO.getInd_money()));
                ResponseEntity<CustomerSetBalanceResponse> msg= customerBalanceController.customerSetBalance(customerSetBalanceRequest);
                if(msg.getBody().getMsg()=="设置失败"){
                    throw new RuntimeException();
                }

                // 修改商家账户余额
                customerSetBalanceRequest=new CustomerSetBalanceRequest();
                customerSetBalanceRequest.setCus_id(Integer.valueOf(indentDTO.getSto_id()));
                balance= customerBalanceController.customerGetBalance(Integer.valueOf(indentDTO.getSto_id()));
                customerSetBalanceRequest.setBalance(balance.getBody().getBalance().add(commodityDTO.getInd_money()));
                msg= customerBalanceController.customerSetBalance(customerSetBalanceRequest);
                if(msg.getBody().getMsg()=="设置失败"){
                    throw new RuntimeException();
                }

            }
        }

        msgResponseDTO.setMsg("订单生成成功");
        return msgResponseDTO;
    }

    /**
     * @author lhx
     * @date 2023/12/21
     * @Description 订单退款
     * 记录退款信息、修改商品余量、修改商家与顾客账户余额
     */
    @Transactional
    public RefundResponseDTO refund(RefundRequestDTO request){
        IndentEntity indentEntity= indentRepository.getReferenceById(request.getInd_ID());

        Integer com_id=indentEntity.getComId();
        Integer cus_id=indentEntity.getCusId();
        CommodityEntity commodityEntity=indentCommodityRepository.getReferenceById(com_id);
        Integer sto_id=commodityEntity.getStoId();
        BigDecimal ind_rmoney=getCurrentPrice(com_id).multiply(BigDecimal.valueOf(indentEntity.getIndQuantity()));

        long millis = System.currentTimeMillis();
        Date currentDate = new Date(millis);
        // 修改订单信息
        indentEntity.setIndRmoney(ind_rmoney);
        indentEntity.setIndRtime(currentDate);
        indentEntity.setIndRnotes(request.getInd_rnotes());
        indentEntity.setIndState(2);
        IndentEntity indentres= indentRepository.save(indentEntity);
        if(indentres==null){
            throw new RuntimeException();
        }

        //修改商品余量
        CommodityEntity exists = indentCommodityRepository.findById(com_id).orElseThrow();
        exists.setComLeft(exists.getComLeft()+indentEntity.getIndQuantity());
        CommodityEntity update = indentCommodityRepository.save(exists);
        if(update==null){
            throw new RuntimeException();
        }

        // 修改用户账户余额
        CustomerSetBalanceRequest customerSetBalanceRequest=new CustomerSetBalanceRequest();
        customerSetBalanceRequest.setCus_id(cus_id);
        ResponseEntity<CustomerGetBalanceResponse> balance= customerBalanceController.customerGetBalance(cus_id);
        customerSetBalanceRequest.setBalance(balance.getBody().getBalance().add(ind_rmoney));
        ResponseEntity<CustomerSetBalanceResponse> msg= customerBalanceController.customerSetBalance(customerSetBalanceRequest);
        if(msg.getBody().getMsg()=="设置失败"){
            throw new RuntimeException();
        }

        // 修改商家账户余额
        customerSetBalanceRequest=new CustomerSetBalanceRequest();
        customerSetBalanceRequest.setCus_id(sto_id);
        ResponseEntity<CustomerGetBalanceResponse> balance2= customerBalanceController.customerGetBalance(Integer.valueOf(sto_id));
        customerSetBalanceRequest.setBalance(balance2.getBody().getBalance().subtract(ind_rmoney));
        msg= customerBalanceController.customerSetBalance(customerSetBalanceRequest);
        if(msg.getBody().getMsg()=="设置失败"){
            throw new RuntimeException();
        }

        RefundResponseDTO refundResponseDTO = new RefundResponseDTO();
        refundResponseDTO.setPrice_return(ind_rmoney);
        refundResponseDTO.setBalance(balance.getBody().getBalance().add(ind_rmoney));
        return refundResponseDTO;
    }


    /**
     * @author lhx
     * @date 2023/12/21
     * @Description 根据价格曲线，查询商品当前价格
     */
    BigDecimal getCurrentPrice(Integer com_id){
        List<CommodityPriceCurveEntity> list= commodityPriceCurveRepository.getCommodityPriceCurveEntitiesByComId(com_id);
        long millis = System.currentTimeMillis();
        BigDecimal result = BigDecimal.valueOf(-1);
        Date currentDate = new Date(millis);
//        System.out.println("当前时间："+currentDate);
        Collections.sort(list, Comparator.comparing(CommodityPriceCurveEntity::getComPcTime).reversed());
        for (CommodityPriceCurveEntity item : list){
            if(item.getComPcTime().compareTo(currentDate)<=0){
                result=item.getComPcPrice();
                System.out.println("商品当前价格："+result);
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
     * @date 2023/12/21
     * @Description 订单评价评分
     * 更新订单信息，插入评论（过滤敏感词），更新商品评分
     */
    @Transactional
    public MsgResponseDTO evaluation(EvaluationRequestDTO request) throws IOException {
        Integer ind_id= request.getInd_id();
        String cmt_content= request.getCmt_content();
        double ind_rating= request.getInd_rating();
        long millis = System.currentTimeMillis();
        Date currentDate = new Date(millis);
        // 更新订单信息
        IndentEntity indentEntity= indentRepository.getReferenceById(ind_id);
        indentEntity.setIndRating(BigDecimal.valueOf(ind_rating));

        Integer cus_id= indentEntity.getCusId();
        Integer com_id = indentEntity.getComId();

        indentEntity=indentRepository.save(indentEntity);
        if(indentEntity==null){
            throw new RuntimeException();
        }

        //插入评论

        CommodityCommentEntity commodityCommentEntity=new CommodityCommentEntity();
        commodityCommentEntity.setCmtId(seqNextvalRepository.callSEQ_NEXTVAL("COMMENT_ID_SEQ"));
        commodityCommentEntity.setCmtFather(0);
        commodityCommentEntity.setCmtContent(ContentFilter.contentFilter(cmt_content));
        commodityCommentEntity.setCmtTime(currentDate);
        commodityCommentEntity.setUserId(cus_id);
        commodityCommentEntity.setComId(com_id);
        commodityCommentEntity=indentCommentRepository.save(commodityCommentEntity);
        if(commodityCommentEntity==null){
            throw new RuntimeException();
        }

        // 更新商品评分
        CommodityEntity commodityEntity=indentCommodityRepository.getReferenceById(com_id);
        double com_rating= indentRepository.getAvgRating(com_id);
        commodityEntity.setComRating(BigDecimal.valueOf(com_rating));
        commodityEntity=indentCommodityRepository.save(commodityEntity);
        if(commodityEntity==null){
            throw new RuntimeException();
        }

        MsgResponseDTO msgResponseDTO=new MsgResponseDTO();
        msgResponseDTO.setMsg("上传成功");
        return msgResponseDTO;

    }

    /**
     * @author lhx
     * @date 2023/12/21
     * @Description 订单获取
     */
    public GetIndentListResponseDTO getIndentList(GetIndentListRequestDTO request) {
        List<GetIndentListResponseDTO.IndentDTO>indList=new ArrayList<>();
        List<GetIndentListResponseDTO.IndentElementDTO>eleList=new ArrayList<>();
        Integer state = request.getInd_state();
        if(state==3)state=0;
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        long millis = System.currentTimeMillis();
        Date currentDate = new Date(millis);// 当前日期
        System.out.println("搜索字符串"+request.getSearch_str());
        List<Object[]> list=indentRepository.getIndentList(request.getCus_id(),state,request.getSearch_str());
        for(Object[] item:list){
            GetIndentListResponseDTO.IndentDTO indentDTO=new GetIndentListResponseDTO.IndentDTO();
            indentDTO.setInd_ID((Integer) item[0]);
            indentDTO.setInd_quantity((Integer) item[1]);
            indentDTO.setInd_money((BigDecimal) item[2]);
            indentDTO.setInd_rating((BigDecimal)  item[7]);
            if(indentDTO.getInd_rating()==null){
                indentDTO.setInd_rating(BigDecimal.valueOf(5));
            }
            indentDTO.setCom_ID((Integer) item[9]);
            Date ind_rtime=(Date) item[10];
            // 将java.sql.Date转换为"yyyy-MM-dd HH:mm:ss"格式字符串
            if(ind_rtime==null)
                indentDTO.setInd_rtime("");
            else {
                LocalDateTime localDateTime = ind_rtime.toLocalDate().atStartOfDay();
                String formattedDate = localDateTime.format(formatter);
                indentDTO.setInd_rtime(formattedDate);
            }
            indentDTO.setInd_notes((String) item[5]);
            if(indentDTO.getInd_notes()==null){
                indentDTO.setInd_notes("");
            }
            indentDTO.setInd_rnotes((String) item[11]);
            if(indentDTO.getInd_rnotes()==null){
                indentDTO.setInd_rnotes("");
            }
            indentDTO.setInd_rmoney((BigDecimal)  item[12]);
            if(indentDTO.getInd_rmoney()==null){
                indentDTO.setInd_rmoney(BigDecimal.valueOf(5));
            }
            indentDTO.setCom_name((String) item[13]);
            Date ind_creationTime=(Date) item[3];
            // 将java.sql.Date转换为"yyyy-MM-dd HH:mm:ss"格式字符串
            LocalDateTime localDateTime = ind_creationTime.toLocalDate().atStartOfDay();
            String formattedDate = localDateTime.format(formatter);
            indentDTO.setInd_creationTime( formattedDate);
            indentDTO.setInd_verificationCode((String) item[4]);
            indentDTO.setSto_id((Integer) item[16]);
            indentDTO.setSto_name((String) item[15]);
            Date com_expirationDate=(Date) item[14];


            List<Object[]> imgs= indentCommodityImageRepository.getReferenceByComID(indentDTO.getCom_ID());
            if(imgs.size()>0)
                indentDTO.setCom_firstImg((String) imgs.get(0)[1]);
            else
                indentDTO.setCom_firstImg("");

            if(request.getInd_state()==3){
                if(com_expirationDate.compareTo(currentDate)<0)
                    indList.add(indentDTO);
            }
            else if(request.getInd_state()==0){
                if(com_expirationDate.compareTo(currentDate)>=0)
                    indList.add(indentDTO);
            }
            else
                indList.add(indentDTO);
        }
        // 根据ind_verificationCode字段进行分组
        Map<String, List<GetIndentListResponseDTO.IndentDTO>> groupedByCode = indList.stream()
                .collect(Collectors.groupingBy(GetIndentListResponseDTO.IndentDTO::getInd_verificationCode));

        // 现在groupedByCode包含了按ind_verificationCode分组的结果
        // 遍历分组
        for (Map.Entry<String, List<GetIndentListResponseDTO.IndentDTO>> entry : groupedByCode.entrySet()) {
            GetIndentListResponseDTO.IndentElementDTO item = new GetIndentListResponseDTO.IndentElementDTO();
            item.setIndent_arr(new ArrayList<>());
            for (GetIndentListResponseDTO.IndentDTO i : entry.getValue()) {

                item.getIndent_arr().add(i);

                item.setInd_notes(i.getInd_notes());
                item.setInd_creationTime(i.getInd_creationTime());
                item.setInd_verificationCode(i.getInd_verificationCode());
                item.setSto_id(i.getSto_id());
                item.setSto_name(i.getSto_name());
            }
            eleList.add(item);
        }

        // eleList现在包含了处理后的数据

        if (request.getSort_order()==0){
            // 按时间先后排序
            // 定义一个SimpleDateFormat用于解析日期字符串
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Collections.sort(eleList, new Comparator<GetIndentListResponseDTO.IndentElementDTO>() {
                @Override
                public int compare(GetIndentListResponseDTO.IndentElementDTO x, GetIndentListResponseDTO.IndentElementDTO y) {
                    try {
                        java.util.Date dateX = sdf.parse(x.getInd_creationTime());
                        java.util.Date dateY = sdf.parse(y.getInd_creationTime());
                        return dateY.compareTo(dateX);
                    } catch (ParseException e) {
                        throw new IllegalArgumentException("Invalid date format", e);
                    }
                }
            });
        }
        else if(request.getSort_order()==1){
            // 按地理位置排序
            String folderPath = ".\\NearbySto";
            String filePath = folderPath + File.separator + "nearbysto"+request.getCus_id() + ".txt";
            List<Integer> sequence = StorageFileReader.getStorage(filePath);

            Collections.sort(eleList, new Comparator<GetIndentListResponseDTO.IndentElementDTO>() {
                @Override
                public int compare(GetIndentListResponseDTO.IndentElementDTO x, GetIndentListResponseDTO.IndentElementDTO y) {
                    return Integer.compare(sequence.indexOf(x.getSto_id()), sequence.indexOf(y.getSto_id()));
                }
            });

        }
        GetIndentListResponseDTO getIndentListResponseDTO=new GetIndentListResponseDTO();


        // 裁切
        int len;
        if(eleList.size()>request.getEnd_pos()){
            len=request.getEnd_pos()-request.getBegin_pos();
        }
        else
            len=eleList.size()- request.getBegin_pos();
        int beginPos=Math.max(0,Math.min(request.getBegin_pos(),eleList.size()));
        int toIndex=Math.min(eleList.size(),beginPos+len);
        getIndentListResponseDTO.setElement_arr(eleList.subList(beginPos,toIndex));
        getIndentListResponseDTO.setTotal(toIndex-beginPos);

        return getIndentListResponseDTO;
    }
}