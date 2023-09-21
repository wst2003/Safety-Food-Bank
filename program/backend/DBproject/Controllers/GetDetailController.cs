using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Globalization;
using System.IO;
using Newtonsoft.Json;
namespace DBproject.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GetDetailController : Controller
    {
        [HttpGet("0")]
        public ActionResult storerGetComDetails0([FromQuery] int sto_id, [FromQuery]int com_begin_n, [FromQuery] int com_end_n)
        {
            Console.WriteLine(sto_id + "访问自己的商品"+ com_begin_n+""+ com_end_n);
            //商家获取自己的商品（略图）
            List<CommodityForStorer0> jsonList = new List<CommodityForStorer0>();   //转json之用
            string selectSQL1 = "select com_id,com_name,com_left,com_uploadDate,com_expirationDate,com_oriprice from(" +
                "select com_id, com_name, com_left,com_uploadDate,com_expirationDate, com_oriprice, ROWNUM as row_num from(" +
                "select com_id, com_name, com_left,com_uploadDate,com_expirationDate, com_oriprice " +
                "from commodity " +
                "where sto_id = " + sto_id +
                " order by com_id))" +
                "where row_num >=" + com_begin_n + " and row_num<= " + com_end_n;//从commodity找信息

            CommodityForStorer0 jsonItem;   //转json之用
            using (OracleCommand selectComIDCommand = new OracleCommand(selectSQL1, DBproject.DataBase.oracleCon.con))
            {
            using (OracleDataReader reader1 = selectComIDCommand.ExecuteReader())
            {
                while (reader1.Read())
                {
                    jsonItem = new CommodityForStorer0();
                    int com_id = reader1.GetInt32(0);
                    jsonItem.com_id = com_id;
                    jsonItem.com_name = reader1.GetString(1);
                    jsonItem.com_left = reader1.GetInt32(2);
                    jsonItem.com_categories = new List<string>();
                    jsonItem.com_image = new List<string>();
                    double com_oriprice = reader1.GetDouble(3);
                    //计算当前商品的当前价格
                    string selectCommodityPCSQL = "select COM_PC_TIME,COM_PC_PRICE from COMMODITY_PRICE_CURVE where com_id = " + com_id;
                    using (OracleCommand selectCommodityPCommand = new OracleCommand(selectCommodityPCSQL, DBproject.DataBase.oracleCon.con))
                    {
                        using (OracleDataReader selectCommodityPCReader = selectCommodityPCommand.ExecuteReader())
                        {
                            double cur_price = com_oriprice;
                            while (selectCommodityPCReader.Read())
                            {
                                string[] date = selectCommodityPCReader.GetString("COM_PC_TIME").Split('-');
                                date[1] = date[1].Remove(date[1].IndexOf('月'));
                                if (date[1].Length == 1) date[1] = "0" + date[1];
                                DateTime current = DateTime.Now;
                                DateTime dst = new DateTime(year: int.Parse("20" + date[2]),month: int.Parse(date[1]), day: int.Parse(date[1]));
                                if (DateTime.Compare(current, dst) < 0) break;
                                cur_price = selectCommodityPCReader.GetDouble(1);
                            }
                            jsonItem.com_curr_price = cur_price;
                        }
                    }
                    //查找当前商品种类
                    string selectSQL2 = "select COM_CATEGORY from COMMODITY_CATEGORIES where com_id = " + com_id;
                        using (OracleCommand selectComCataCommand = new OracleCommand(selectSQL2, DBproject.DataBase.oracleCon.con))
                    {
                    using (OracleDataReader reader2 = selectComCataCommand.ExecuteReader())
                    {
                        while(reader2.Read())
                        {
                            jsonItem.com_categories.Add(reader2.GetString(0));
                        }
                    }
                    }
                        //查找当前商品的商品图片路径 
                        string selectSQL3 = "select  COM_IMAGE from COMMODITY_IMAGE where com_id =" + com_id;
                        using (OracleCommand selectComImageCommand = new OracleCommand(selectSQL3, DBproject.DataBase.oracleCon.con))
                    {
                    using (OracleDataReader reader3 = selectComImageCommand.ExecuteReader())
                    {
                        while (reader3.Read())
                        {
                            jsonItem.com_image.Add(reader3.GetString(0));
                        }
                    }
                    }
                    jsonList.Add(jsonItem);
                }
            }
            }
            string comDetail0 = JsonConvert.SerializeObject(jsonList);  //转json
            Console.WriteLine(comDetail0);
            return Ok(comDetail0);
        }

        [HttpGet("1")]
        public ActionResult storerGetComDetails1([FromQuery] int com_id)
        {
            Console.WriteLine("传商品详情");
            //商家获取自己的商品（详细）
            CommodityForStorer1 jsonItem = new CommodityForStorer1();   //转json之用
            string selectCommoditySQL = "select * from COMMODITY where COM_ID = " + com_id; //从COMMODITY中获取信息
            using (OracleCommand selectCommodityCommand = new OracleCommand(selectCommoditySQL, DBproject.DataBase.oracleCon.con))
            {
                using(OracleDataReader selectCommodityReader = selectCommodityCommand.ExecuteReader())
                {
                    while (selectCommodityReader.Read())
                    {
                        jsonItem.com_id = selectCommodityReader.GetInt32("COM_ID");
                        jsonItem.com_name = selectCommodityReader.GetString("com_name");
                        jsonItem.com_introduction = selectCommodityReader.GetString("com_introduction");
                        jsonItem.com_oriprice = selectCommodityReader.GetDouble("com_oriprice");
                        string[] date = selectCommodityReader.GetString("com_expirationdate").Split('-');
                        date[1] = date[1].Remove(date[1].IndexOf('月'));
                        if (date[1].Length == 1) date[1] = "0" + date[1];
                        jsonItem.com_expirationdate = string.Format("20{0}-{1}-{2}", date[2], date[1], date[0]);
                        date = selectCommodityReader.GetString("com_uploaddate").Split('-');
                        date[1] = date[1].Remove(date[1].IndexOf('月'));
                        if (date[1].Length == 1) date[1] = "0" + date[1];
                        jsonItem.com_uploaddate = string.Format("20{0}-{1}-{2}", date[2], date[1], date[0]); 
                        jsonItem.com_left = selectCommodityReader.GetInt32("com_left");
                        jsonItem.com_rating = selectCommodityReader.GetDouble("com_rating");
                    }
                }
            }
            //从COMMODITY_CATEGORIES中获取商品种类信息
            string selectCommodityCateSQL = "select com_category from COMMODITY_CATEGORIES where com_id = " + com_id;
            using (OracleCommand selectCommodityCateCommand = new OracleCommand(selectCommodityCateSQL, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader selectCommodityCateReader = selectCommodityCateCommand.ExecuteReader())
                { 
                    while(selectCommodityCateReader.Read())
                    {
                        jsonItem.com_categories.Add(selectCommodityCateReader.GetString("com_category"));
                    }
                }
            }
            //从COMMODITY_IMAGE中获取商品图片路径
            string selectCommodityImageSQL = "select com_image from COMMODITY_IMAGE where com_id = " + com_id;
            using (OracleCommand selectCommodityImageCommand = new OracleCommand(selectCommodityImageSQL, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader selectCommodityImageReader = selectCommodityImageCommand.ExecuteReader())
                {
                    while (selectCommodityImageReader.Read())
                    {
                        jsonItem.com_image.Add(selectCommodityImageReader.GetString("com_image"));
                    }
                }
            }
            //从COMMODITY_PRICE_CURVE中获取商品价格曲线
            string selectCommodityPCSQL = "select COM_PC_TIME,COM_PC_PRICE from COMMODITY_PRICE_CURVE where com_id = " + com_id;
            using (OracleCommand selectCommodityPCommand = new OracleCommand(selectCommodityPCSQL, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader selectCommodityPCReader = selectCommodityPCommand.ExecuteReader())
                {
                    while (selectCommodityPCReader.Read())
                    {
                        string[] date = selectCommodityPCReader.GetString("COM_PC_TIME").Split('-');
                        date[1] = date[1].Remove(date[1].IndexOf('月'));
                        if (date[1].Length == 1) date[1] = "0" + date[1];
                        jsonItem.com_pc_time.Add(string.Format("20{0}-{1}-{2}", date[2], date[1], date[0]));
                        jsonItem.com_pc_price.Add(selectCommodityPCReader.GetDouble("COM_PC_PRICE"));
                    }
                }
            }
            return Ok(JsonConvert.SerializeObject(jsonItem));
        }

        [HttpGet("get-form-json")]
        public ActionResult getformjson()
        {
            Console.WriteLine(11);
            string jsonFilePath = "./vform.json";
            string json = System.IO.File.ReadAllText(jsonFilePath);

            return Ok(json);
        }

    }

   

    public class CommodityForStorer0
    {
        public int com_id { get; set; }
        public string com_name { get; set; }
        public int com_left { get; set; }
        public string com_uploaddate { get;set; }
        public string com_expirationdate { get; set; }
        public double com_curr_price { get; set; }
        public List<string> com_categories { get; set; }

        public List<string> com_image { get; set; }
        public CommodityForStorer0()
        {
            com_categories = new List<string>();
            com_image = new List<string>();
        }
    }

    public class CommodityForStorer1
    {
        public int com_id{ get; set; }
        public string com_name { get; set; }
        public string com_introduction { get; set; }
        public double com_oriprice { get; set; }
        public string com_expirationdate { get; set; }
        public string com_uploaddate { get; set; }
        public int com_left { get; set; }
        public double com_rating { get; set; }
        public List<string> com_categories { get; set; }
        public List<double> com_pc_price { get; set; }
        public List<string> com_pc_time { get; set; }
        public List<string> com_image { get; set; }
        public CommodityForStorer1()
        {
            com_categories = new List<string>();
            com_pc_price = new List<double>();
            com_pc_time = new List<string>();
            com_image = new List<string>();
        }
    }

}
