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
import cn.tju.sse.spring_backend.repository.cus.indent.IndentCommentRepository;
import cn.tju.sse.spring_backend.repository.cus.indent.IndentCommodityPriceCurveRepository;
import cn.tju.sse.spring_backend.repository.cus.indent.IndentCommodityRepository;
import cn.tju.sse.spring_backend.repository.cus.indent.IndentRepository;
import cn.tju.sse.spring_backend.repository.SeqNextvalRepository;
import cn.tju.sse.spring_backend.utils.ContentFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.ParseException;
import java.util.*;

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
        Collections.sort(list, Comparator.comparing(CommodityPriceCurveEntity::getComPcTime));
        BigDecimal last_item_price= BigDecimal.valueOf(-1);
        for (CommodityPriceCurveEntity item : list){

            if(item.getComPcTime().compareTo(currentDate)>=0){
                result=last_item_price;
//                System.out.println("商品当前价格："+result);
                break;
            }
            last_item_price=item.getComPcPrice();
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
        return new GetIndentListResponseDTO();
    }
}
