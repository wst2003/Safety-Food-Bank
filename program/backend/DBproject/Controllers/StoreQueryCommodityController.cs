using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Globalization;
using System.IO;
using Newtonsoft.Json;
namespace DBproject.Controllers
{
    [Route("api/sto/[controller]")]
    [ApiController]
    public class StoreQueryCommodityController : Controller      
    {
        [HttpGet("detail")]
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

        [HttpPost("list")]
        [Consumes("application/json")]
        public ActionResult searchCommodity([FromQuery] int STO_ID, [FromQuery] int com_begin_n, [FromQuery] int com_end_n, [FromBody] SearchOptionModel searchOptionModel)
        {
            string selectCOMIDSQL = "";
            string isAsc = "";
            string optionDate = "";
            if (searchOptionModel.order == 0) isAsc = "asc";
            else isAsc = "desc";
            if (searchOptionModel.COM_UPLOADDATE.Length > 0) optionDate += " and COM_UPLOADDATE like TO_DATE('" + searchOptionModel.COM_UPLOADDATE + "','YYYY-MM-DD') ";
            if (searchOptionModel.COM_EXPIRATIONDATE.Length > 0) optionDate += " and COM_EXPIRATIONDATE like TO_DATE('" + searchOptionModel.COM_EXPIRATIONDATE + "','YYYY-MM-DD') ";
            if (searchOptionModel.category.Count > 0)
            {
                string cateList = "(";
                foreach (string cate in searchOptionModel.category)
                {
                    cateList += "'" + cate + "',";
                }
                cateList = cateList.Remove(cateList.Length - 1);
                cateList += ")";
                selectCOMIDSQL = "select COM_ID from( " +
                    "select COM_ID,ROWNUM as ROW_NUM from( " +
                    "with specific_cate_ID(COM_ID) as " +
                    "(select COM_ID from commodity_categories " +
                    "where com_category IN " + cateList +
                    " group by COM_ID " +
                    "HAVING COUNT(DISTINCT com_category) = " + searchOptionModel.category.Count + ") " +
                    "select COM_ID from COMMODITY where " +
                    "sto_ID = " + STO_ID + " and com_status =  " + searchOptionModel.status +
                    " and COM_ID in (select COM_ID from specific_cate_ID ) and com_name like '%" + searchOptionModel.query + "%' " + optionDate +
                    " order by COM_ID " + isAsc + ")) " +
                    "where ROW_NUM >= " + com_begin_n + " and ROW_NUM <= " + com_end_n;
            }
            else
            {
                selectCOMIDSQL = "select COM_ID from( " +
                    "select COM_ID,ROWNUM as ROW_NUM from( " +
                    " select COM_ID from COMMODITY " +
                    "where sto_id = " + STO_ID + " and com_status = " + searchOptionModel.status + " and com_name like '%" + searchOptionModel.query + "%' " + optionDate +
                    "order by COM_ID " + isAsc + ")) " +
                    "where ROW_NUM >= " + com_begin_n + " and ROW_NUM <= " + com_end_n;

            }
            Console.WriteLine(selectCOMIDSQL);
            Console.WriteLine(searchOptionModel.status);
            List<CommodityForStorer0> jsonList = new List<CommodityForStorer0>();   //转json之用
            CommodityForStorer0 jsonItem;   //转json之用
            string selectSQL1 = "select com_id,com_name,com_left,com_uploaddate,com_expirationdate,com_oriprice from COMMODITY where COM_ID = :COM_ID";
            string selectSQL2 = "select COM_CATEGORY from COMMODITY_CATEGORIES where COM_ID = :COM_ID";
            string selectCommodityPCSQL = "select COM_PC_TIME,COM_PC_PRICE from COMMODITY_PRICE_CURVE where com_id = :COM_ID";
            string selectSQL4 = "select  COM_IMAGE from COMMODITY_IMAGE where com_id = :COM_ID";
            using (OracleCommand selectComIDCommand = new OracleCommand(selectCOMIDSQL, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader COMIDReader = selectComIDCommand.ExecuteReader())
                {
                    while (COMIDReader.Read())
                    {
                        //遍历每个选中的COM_ID
                        jsonItem = new CommodityForStorer0();
                        double com_curr_price = 0;
                        using (OracleCommand selectCommand1 = new OracleCommand(selectSQL1, DBproject.DataBase.oracleCon.con))
                        {
                            selectCommand1.Parameters.Add(new OracleParameter(":COM_ID", COMIDReader.GetInt32(0)));
                            using (OracleDataReader selectReader1 = selectCommand1.ExecuteReader())
                            {
                                while (selectReader1.Read())//事实上只有一行
                                {
                                    jsonItem.com_id = selectReader1.GetInt32(0);
                                    jsonItem.com_name = selectReader1.GetString(1);
                                    jsonItem.com_left = selectReader1.GetInt32(2);
                                    string[] date = selectReader1.GetString(3).Split('-');
                                    date[1] = date[1].Remove(date[1].IndexOf('月'));
                                    if (date[1].Length == 1) date[1] = "0" + date[1];
                                    jsonItem.com_uploaddate = string.Format("20{0}-{1}-{2}", date[2], date[1], date[0]);
                                    date = selectReader1.GetString(4).Split('-');
                                    date[1] = date[1].Remove(date[1].IndexOf('月'));
                                    if (date[1].Length == 1) date[1] = "0" + date[1];
                                    jsonItem.com_expirationdate = string.Format("20{0}-{1}-{2}", date[2], date[1], date[0]);
                                    com_curr_price = selectReader1.GetDouble(5);
                                }
                            }
                        }
                        using (OracleCommand selectCommand2 = new OracleCommand(selectSQL2, DBproject.DataBase.oracleCon.con))
                        {
                            selectCommand2.Parameters.Add(new OracleParameter(":COM_ID", COMIDReader.GetInt32(0)));
                            using (OracleDataReader selectReader2 = selectCommand2.ExecuteReader())
                            {
                                while (selectReader2.Read())
                                {
                                    jsonItem.com_categories.Add(selectReader2.GetString(0));
                                }
                            }
                        }
                        using (OracleCommand selectComPCommand = new OracleCommand(selectCommodityPCSQL, DBproject.DataBase.oracleCon.con))
                        {
                            selectComPCommand.Parameters.Add(new OracleParameter(":COM_ID", COMIDReader.GetInt32(0)));
                            using (OracleDataReader selectReader3 = selectComPCommand.ExecuteReader())
                            {
                                Console.WriteLine(selectComPCommand.CommandText + COMIDReader.GetInt32(0));
                                while (selectReader3.Read())
                                {
                                    string[] date = selectReader3.GetString("COM_PC_TIME").Split('-');
                                    date[1] = date[1].Remove(date[1].IndexOf('月'));
                                    if (date[1].Length == 1) date[1] = "0" + date[1];
                                    DateTime current = DateTime.Now.Date; // Get current date without the time component

                                    // Parse year, month, and day from the "COM_PC_TIME" string
                                    int year = int.Parse("20" + date[2]);
                                    int month = int.Parse(date[1]);
                                    int day = int.Parse(date[0]);

                                    DateTime dst = new DateTime(year, month, day);
                                    if (current.Date < dst) break;
                                    com_curr_price = selectReader3.GetDouble(1);
                                }
                                jsonItem.com_curr_price = com_curr_price;
                            }
                        }
                        using (OracleCommand selectComImageCommand = new OracleCommand(selectSQL4, DBproject.DataBase.oracleCon.con))
                        {
                            selectComImageCommand.Parameters.Add(new OracleParameter(":COM_ID", COMIDReader.GetInt32(0)));
                            using (OracleDataReader selectReader4 = selectComImageCommand.ExecuteReader())
                            {
                                while (selectReader4.Read())
                                {
                                    jsonItem.com_image.Add(selectReader4.GetString(0));
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
        [HttpGet("totalnum")]
        public ActionResult getcommoditytotal([FromQuery] int STO_ID, [FromQuery] int COM_STATUS)
        {
            string sql = "select count(*) from commodity where STO_ID = :STO_ID and COM_STATUS = :COM_STATUS";
            using (OracleCommand selectComPCommand = new OracleCommand(sql, DBproject.DataBase.oracleCon.con))
            {
                selectComPCommand.Parameters.Add(new OracleParameter(":STO_ID", STO_ID));
                selectComPCommand.Parameters.Add(new OracleParameter(":COM_STATUS", COM_STATUS));
                using (OracleDataReader selectReader = selectComPCommand.ExecuteReader())
                {
                    while (selectReader.Read())
                    {
                        return Ok("" + selectReader.GetInt32(0));
                    }
                }
            }
            return Ok("" + 0);
        }

        [HttpGet("imgpath")]
        public ActionResult getImagePath([FromQuery] int COM_ID)
        {
            string selectImagePathSQL = "select COM_IMAGE from COMMODITY_IMAGE where com_id = " + COM_ID;
            List<string> imagePath = new List<string>();
            using (OracleCommand selectImagePathCommand = new OracleCommand(selectImagePathSQL, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader selectImagePathReader = selectImagePathCommand.ExecuteReader())
                {
                    while (selectImagePathReader.Read())
                    {
                        imagePath.Add(selectImagePathReader.GetString(0));
                    }
                }
            }
            return Ok(JsonConvert.SerializeObject(imagePath));
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

    public class SearchOptionModel
    {
        public int status { get; set; }
        public int order { get; set; }

        public List<string> category { get; set; }
        public string query { get; set; }
        public string COM_UPLOADDATE { get; set; }
        public string COM_EXPIRATIONDATE { get; set; }
        public SearchOptionModel()
        {
            COM_UPLOADDATE = "";
            COM_EXPIRATIONDATE = "";
        }
    }

}
