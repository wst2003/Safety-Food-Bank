package cn.tju.sse.spring_backend.utils;
import cn.tju.sse.spring_backend.model.CommodityEntity;
import cn.tju.sse.spring_backend.repository.sto.commodity.CommodityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.sql.Types;
import java.util.*;

@Service
public class ItemCFRecommendation {
    Map<Integer, List<Integer>> itemSimilarities=new HashMap<>();
    Map<Integer, Map<Integer,Double>> ComSimilarity = new HashMap<>();
    Map<Integer,Double> ComPreference = new HashMap<>();
    @Autowired
    private CommodityRepository commodityRepository;

    private JdbcTemplate jdbcTemplate;

    public ItemCFRecommendation(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void CalculateAllPreference(int userID){

        List<Integer> tempID=new ArrayList<>();
        List<Double> tempValue=new ArrayList<>();
        int num=0;
        String storedProcedure = "CALL GET_ALL_COM_REFERENCE(?)";

        // 获取结果集
        List<Map<String, Object>> tempList = jdbcTemplate.queryForList(storedProcedure, userID);
        for(Map<String,Object> m:tempList){
            for (Map.Entry<String, Object> entry : m.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                if(key.equals("com_ID")){
                    tempID.add(Integer.parseInt(value.toString()));
                    num++;
                }else{
                    tempValue.add(Double.parseDouble(value.toString()));
                }
            }
        }
        for(int i=0;i<num;i++){
            System.out.println("comID: "+tempID.get(i)+" Score: "+tempValue.get(i));
            ComPreference.put(tempID.get(i),tempValue.get(i));
        }

    }

    public List<Integer> CalculateAllSim(int userID){

        List<Integer> tempID=new ArrayList<>();
        List<Integer> tempavaID=new ArrayList<>();
        List<Double> tempValue=new ArrayList<>();
        int num=0;

        List<Integer> userComList=new ArrayList<>();
        String storedProcedure = "CALL GET_COM_SIM_PROC(?)";

        // 获取结果集
        List<Map<String, Object>> tempList = jdbcTemplate.queryForList(storedProcedure, userID);
        for(Map<String,Object> m:tempList){
            for (Map.Entry<String, Object> entry : m.entrySet()) {
                System.out.println("Key"+entry.getKey());
                System.out.println("Va+"+entry.getValue());
                String key = entry.getKey();
                Object value = entry.getValue();
                if(key.equals("com_ID")){
                    tempID.add(Integer.parseInt(value.toString()));
                    num++;
                }else if(key.equals("avaID")){
                    tempavaID.add(Integer.parseInt(value.toString()));
                }else{
                    tempValue.add(Double.parseDouble(value.toString()));
                }
            }

            int oldid = -1;
            Map<Integer,Double> similarityScores=new HashMap<>();
            for(int i=0;i<num;++i){
                int comId=tempID.get(i);
                int avaid=tempavaID.get(i);
                double someDoubleValue=tempValue.get(i);
                if((oldid==comId)||oldid==-1) {
                    similarityScores.put(avaid, someDoubleValue);
                    oldid = comId;
                }else{
                    ComSimilarity.put(oldid,similarityScores);
                    userComList.add(oldid);
                    oldid=comId;
                    similarityScores=new HashMap<>();
                }
            }
            if(!ComSimilarity.containsKey(oldid)){
                userComList.add(oldid);
                ComSimilarity.put(oldid,similarityScores);
            }
        }
        return userComList;
    }

    public List<Integer> GetAvailableCommodities(){
        List<Integer>  availableCommodityIDs=new ArrayList<>();
        List<CommodityEntity> commodityEntityList= commodityRepository.findCommodityEntityByComStatusTrue();
        for(CommodityEntity e : commodityEntityList){
            int comID=e.getComId();
            availableCommodityIDs.add(comID);
        }
        return availableCommodityIDs;
    }

    public List<Integer> GetComMostSim(int comID){
        if(itemSimilarities.containsKey(comID) && itemSimilarities.get(comID).size()>=20){
            return itemSimilarities.get(comID);
        }

        List<Integer> com_list=GetAvailableCommodities();
        List<Integer> mostSimilarComIDs=new ArrayList<>();

        // 计算当前商品与其他所有商品的相似度，并按相似度降序排列
        Map<Integer,Double> similarityScores=new HashMap<>();
        for(int otherComID : com_list){
            double similarity=(ComSimilarity.get(comID).containsKey(otherComID))? ComSimilarity.get(comID).get(otherComID):0.0;
            similarityScores.put(otherComID,similarity);
        }

        List<Map.Entry<Integer, Double>> entryList = new ArrayList<>(similarityScores.entrySet());
        // 使用自定义的比较器对 List 进行排序（按值）
        Collections.sort(entryList, Comparator.comparing(Map.Entry::getValue,Comparator.reverseOrder()));
        // 创建一个新的 Map，将排序后的键值对放入其中
        LinkedHashMap<Integer, Double> sortedSimilarities = new LinkedHashMap<>();
        for (Map.Entry<Integer,Double> entry : entryList) {
            sortedSimilarities.put(entry.getKey(), entry.getValue());
        }

        int count=0;
        for (Map.Entry<Integer, Double> entry :sortedSimilarities.entrySet()) {
            if(count>=20)
                break;
            mostSimilarComIDs.add(entry.getKey());
            count++;
        }

        if(!itemSimilarities.containsKey(comID)){
            itemSimilarities.put(comID,mostSimilarComIDs);
        }
        return mostSimilarComIDs;
    }

    public List<Integer> RecommendItems(int userID){
        List<Integer> recommendedItems = new ArrayList<>();
        CalculateAllPreference(userID);
        List<Integer> userComList=CalculateAllSim(userID);
        HashSet<Integer> uniqueComIDs=new HashSet<>(userComList);
        userComList=uniqueComIDs.stream().toList();

        Map<Integer,Double> itemScores=new HashMap<>();
        for(int candidateItem:userComList){
            List<Integer> similarComIDs=GetComMostSim(candidateItem);
            for(int similarComID : similarComIDs){
                double score=0.0;
                if(ComSimilarity.get(candidateItem).containsKey(similarComID) && ComSimilarity.get(candidateItem).get(similarComID)>0.0)
                    score=ComSimilarity.get(candidateItem).get(similarComID) * ComPreference.get(similarComID);

                if (itemScores.containsKey(similarComID)){
                    itemScores.replace(similarComID,itemScores.get(similarComID)+score);
                }else {
                    itemScores.put(similarComID, score);
                }
            }
        }

        List<Map.Entry<Integer, Double>> entryList = new ArrayList<>(itemScores.entrySet());
        // 使用自定义的比较器对 List 进行排序（按值）
        Collections.sort(entryList, Comparator.comparing(Map.Entry::getValue,Comparator.reverseOrder()));
        // 创建一个新的 Map，将排序后的键值对放入其中
        LinkedHashMap<Integer, Double> sortedScores = new LinkedHashMap<>();
        for (Map.Entry<Integer,Double> entry : entryList) {
            sortedScores.put(entry.getKey(), entry.getValue());
        }

        for (Map.Entry<Integer, Double> entry :sortedScores.entrySet()) {
            if(entry.getValue()>1e-5)
                recommendedItems.add(entry.getKey());
        }

        List<Integer> ALLItem = GetAvailableCommodities();
        Random random = new Random();
        int n = ALLItem.size();
        while(n>1){
            n--;
            int k=random.nextInt(n+1);
            int value=ALLItem.get(k);
            ALLItem.set(k, ALLItem.get(n));
            ALLItem.set(n,value);
        }

        for(int item : ALLItem){
            if(!recommendedItems.contains(item))
                recommendedItems.add(item);
        }
        return recommendedItems;
    }
}
