using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Security.Cryptography.Xml;
using System.Text.RegularExpressions;
using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;

namespace DBproject.Algorithms
{

    //计算用户对商品的喜好程度函数
    class ItemPreferenceCalculator
    {
        public double w1; // 购买次数权重
        public double w2; // 浏览次数权重
        public double w3; // 评分权重（会根据购买次数加权）
        public double w4; // 类别匹配得分权重
        public double w5; // 商品是否被收藏

        public ItemPreferenceCalculator()
        {
            w1 = 10;
            w2 = 1;
            w3 = 10;
            w4 = 5;
            w5 = 5;
        }
        public ItemPreferenceCalculator(double weight1, double weight2, double weight3, double weight4, double weight5)
        {
            w1 = weight1;
            w2 = weight2;
            w3 = weight3;
            w4 = weight4;
            w5 = weight5;
        }
        //计算所有物体的相似度
        

        //计算最终得分
        public double CalculateItemPreference(int userID, int comID)
        {
            Console.WriteLine("计算喜好度");
            double preference = 0;
            try
            {
                using (OracleCommand cmd = DataBase.oracleCon.con.CreateCommand())
                {
                    cmd.CommandText = "Calculate_Item_Preference_Procedure";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("p_userID", OracleDbType.Int32).Value = userID;
                    cmd.Parameters.Add("p_comID", OracleDbType.Int32).Value = comID;
                    cmd.Parameters.Add("p_w1", OracleDbType.Double).Value = w1;
                    cmd.Parameters.Add("p_w2", OracleDbType.Double).Value = w2;
                    cmd.Parameters.Add("p_w3", OracleDbType.Double).Value = w3;
                    cmd.Parameters.Add("p_w4", OracleDbType.Double).Value = w4;
                    cmd.Parameters.Add("p_w5", OracleDbType.Double).Value = w5;

                    OracleParameter preferenceParam = new OracleParameter("p_preference", OracleDbType.Double);
                    preferenceParam.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(preferenceParam);

                    cmd.ExecuteNonQuery();

                    if (preferenceParam.Value != DBNull.Value)
                    {
                        OracleDecimal oracleDecimal = (OracleDecimal)preferenceParam.Value;
                        if (!oracleDecimal.IsNull)
                        {
                            preference = Convert.ToDouble(oracleDecimal.Value);
                        }
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("其他异常：" + ex.Message);
            }

            return preference;
        }
    }

    //计算物品的相似度
    class ItemSimilarityCalculator
    {
        public ItemPreferenceCalculator itemPreference = new ItemPreferenceCalculator();

        private Dictionary<Tuple<int, int>, double> similarityCache = new Dictionary<Tuple<int, int>, double>();

        // 计算物品相似度
        public double CalculateItemSimilarity(int itemID1, int itemID2)
        {
            Console.WriteLine("正在相似度计算");
            Tuple<int, int> pair = new Tuple<int, int>(itemID1, itemID2);
            Tuple<int, int> pair1 = new Tuple<int, int>(itemID2, itemID1);

            if (similarityCache.ContainsKey(pair))
            {
                return similarityCache[pair];
            }
            if (similarityCache.ContainsKey(pair1))
            {
                return similarityCache[pair1];
            }

            double similarity = 0.0;

            using (OracleCommand cmd = DataBase.oracleCon.con.CreateCommand())
            {
                cmd.CommandText = "Calculate_Item_Similarity_Procedure";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("p_itemID1", OracleDbType.Int32).Value = itemID1;
                cmd.Parameters.Add("p_itemID2", OracleDbType.Int32).Value = itemID2;
                cmd.Parameters.Add("p_w1", OracleDbType.Double).Value = itemPreference.w1;
                cmd.Parameters.Add("p_w2", OracleDbType.Double).Value = itemPreference.w2;
                cmd.Parameters.Add("p_w3", OracleDbType.Double).Value = itemPreference.w3;
                cmd.Parameters.Add("p_w4", OracleDbType.Double).Value = itemPreference.w4;
                cmd.Parameters.Add("p_w5", OracleDbType.Double).Value = itemPreference.w5;

                OracleParameter similarityParam = new OracleParameter("v_similarity", OracleDbType.Double);
                similarityParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(similarityParam);

                cmd.ExecuteNonQuery();

                if (similarityParam.Value != DBNull.Value)
                {
                    OracleDecimal oracleDecimal = (OracleDecimal)similarityParam.Value;
                    if (!oracleDecimal.IsNull)
                    {
                        similarity = Convert.ToDouble(oracleDecimal.Value);
                        similarityCache[pair] = similarity; // Cache the result
                    }
                }
            }

            return similarity;
        
        }
    }

    //获取最终的推荐ID列表
    class ItemCFRecommendation
    {
        Dictionary<int, List<int>> userInteractions = new Dictionary<int, List<int>>(); // user_ID -> List of com_IDs
        Dictionary<int, List<int>> itemSimilarities = new Dictionary<int, List<int>>(); // com_ID -> List of similar com_IDs
        ItemSimilarityCalculator itemSimilarity = new ItemSimilarityCalculator();//计算物品相似度的类
        Dictionary<int, Dictionary<int, double>> ComSimilarity = new Dictionary<int, Dictionary<int, double>>();//商品->与该商品相似的商品->相似度
        Dictionary<int, double> ComPreference = new Dictionary<int, double>();//com_id->preference

        //获取用户的所有喜好程度
        public void CalculateAllPreference(int userID)
        {
            try
            {
                using (OracleCommand cmd = DataBase.oracleCon.con.CreateCommand())
                {
                    cmd.CommandText = "GET_ALL_COM_REFERENCE";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("cus_id", OracleDbType.Double).Value = userID;

                    OracleParameter outputParam = new OracleParameter();
                    outputParam.ParameterName = "result_cursor";
                    outputParam.Direction = ParameterDirection.Output;
                    outputParam.OracleDbType = OracleDbType.RefCursor;
                    cmd.Parameters.Add(outputParam);
                    cmd.ExecuteNonQuery();

                    using (OracleDataReader reader = ((OracleRefCursor)outputParam.Value).GetDataReader())
                    {
                        while (reader.Read())
                        {
                            int comId = reader.GetInt32(0);
                            double someDoubleValue = reader.GetDouble(1);
                            ComPreference.Add(comId, someDoubleValue);
                        }
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("其他异常：" + ex.Message);
            }
        }
        
        //获取所有相似度
        //
        public List<int> CalculateAllSim(int userID)
        {
            List<int> userComList = new List<int>();
            try
            {
                using (OracleCommand cmd = DataBase.oracleCon.con.CreateCommand())
                {
                    cmd.CommandText = "GET_COM_SIM_PROC";
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("cus_id", OracleDbType.Double).Value = userID;

                    OracleParameter outputParam = new OracleParameter();
                    outputParam.ParameterName = "result_cursor";
                    outputParam.Direction= ParameterDirection.Output;
                    outputParam.OracleDbType = OracleDbType.RefCursor;
                    cmd.Parameters.Add(outputParam);

                    cmd.ExecuteNonQuery();

                    using (OracleDataReader reader = ((OracleRefCursor)outputParam.Value).GetDataReader())
                    {
                        int oldid = -1;
                        Dictionary<int, double> similarityScores = new Dictionary<int, double>();
                        while (reader.Read())
                        {
                            int comId = reader.GetInt32(0);
                            int avaid = reader.GetInt32(1);
                            double someDoubleValue = reader.GetDouble(2);
                            if ((oldid == comId) || oldid == -1)
                            {
                                similarityScores.Add(avaid, someDoubleValue);
                                oldid = comId;
                            }
                            else
                            {
                                ComSimilarity.Add(oldid, similarityScores);
                                userComList.Add(oldid);
                                oldid = comId;
                                similarityScores = new Dictionary<int, double>();
                            }
                        }
                        if (!ComSimilarity.ContainsKey(oldid)) {
                            userComList.Add(oldid);
                            ComSimilarity.Add(oldid, similarityScores);
                    }
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("其他异常：" + ex.Message);
            }
            return userComList;
        }


        //获取在销售的所有商品ID
        public List<int> GetAvailableCommodities()
        {
            List<int> availableCommodityIDs = new List<int>();
            try
            {
                using (OracleCommand cmd = DataBase.oracleCon.con.CreateCommand())
                {
                    // 获取在售的所有商品的ID
                    cmd.CommandText = "SELECT com_ID FROM COMMODITY WHERE com_status = 1";

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int comID = reader.GetInt32(0);
                            availableCommodityIDs.Add(comID);
                        }
                    }
                }
            }
            catch (OracleException ex)
            {
                Console.WriteLine("数据库操作异常：" + ex.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("其他异常：" + ex.Message);
            }

            return availableCommodityIDs;
        }

        //计算商品间的相似度前20的商品
        public List<int> GetComMostSim(int comID)
        {
            if (itemSimilarities.ContainsKey(comID) && itemSimilarities[comID].Count >= 20)
                return itemSimilarities[comID];

            List<int> com_list = GetAvailableCommodities();
            List<int> mostSimilarComIDs = new List<int>();

            // 计算当前商品与其他所有商品的相似度，并按相似度降序排列
            Dictionary<int, double> similarityScores = new Dictionary<int, double>();
            foreach (int otherComID in com_list)
            {
                 double similarity = (ComSimilarity[comID].ContainsKey(otherComID))? ComSimilarity[comID][otherComID]:0.0;
                similarityScores.Add(otherComID, similarity);
            }
            var sortedSimilarities = similarityScores.OrderByDescending(kv => kv.Value);

            // 获取前20个相似度最高的商品
            int count = 0;
            foreach (var kv in sortedSimilarities)
            {
                if (count >= 20)
                    break;
                mostSimilarComIDs.Add(kv.Key);
                count++;
            }
            
            if (!itemSimilarities.ContainsKey(comID))
            {
                itemSimilarities.Add(comID, mostSimilarComIDs);
            }

            return mostSimilarComIDs;
        }


        //返回去重后的推荐商品ID列表
        public List<int> RecommendItems(int userID)
        {
            List<int> recommendedItems = new List<int>();
            CalculateAllPreference(userID);
            List<int> userComList = CalculateAllSim(userID);//GetUserComList(userID); // 获取用户浏览和购买的商品列表
            HashSet<int> uniqueComIDs = new HashSet<int>(userComList);
            userComList = uniqueComIDs.ToList();

         

            // 计算每个候选物品的预估兴趣得分
            Dictionary<int, double> itemScores = new Dictionary<int, double>();
            foreach (int candidateItem in userComList)
            {
                List<int> similarComIDs = GetComMostSim(candidateItem); // 获取与候选商品相似的商品列表
                foreach (int similarComID in similarComIDs)
                {
                    double score = 0.0;
                    if (ComSimilarity[candidateItem].ContainsKey(similarComID) && ComSimilarity[candidateItem][similarComID] > 0.0)
                        score = ComSimilarity[candidateItem][similarComID] * ComPreference[similarComID];
                    if (itemScores.ContainsKey(similarComID))
                        itemScores[similarComID] += score;
                    else
                        itemScores.Add(similarComID, score);
                }
            }

            

            // 按预估兴趣得分降序排列
            var sortedScores = itemScores.OrderByDescending(kv => kv.Value);

            // 获取去重后的推荐商品ID列表
            foreach (var kv in sortedScores)
            {
                if (kv.Value > 1e-5)
                    recommendedItems.Add(kv.Key);
            }
            //随机打乱列表
            List<int> ALLItem = GetAvailableCommodities();
            Random random = new Random();
            int n = ALLItem.Count;
            while (n > 1)
            {
                n--;
                int k = random.Next(n + 1);
                int value = ALLItem[k];
                ALLItem[k] = ALLItem[n];
                ALLItem[n] = value;
            }
            //合成列表
            foreach (int item in ALLItem)
            {
                if (!recommendedItems.Contains(item))
                    recommendedItems.Add(item);
            }
            return recommendedItems;
        }
    }
   
}
