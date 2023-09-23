//WST. 商家系统-上传商品相关信息
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
    public class UploadCommodityController : Controller
    {

        [HttpGet("imagekey")]
        public ActionResult getImageKey()
        {
            int IMAGE_KEY = 0;
            using (OracleCommand selectIMAGEKEYCommand = new OracleCommand("SELECT TMP_IMAGE_KEY_SEQ.NEXTVAL FROM dual", DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader reader = selectIMAGEKEYCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        IMAGE_KEY = reader.GetInt32(0);
                    }
                }
            }
            return Ok(""+IMAGE_KEY);
        }


        [HttpPost("imgs")]
        [Consumes("multipart/form-data")]
        public ActionResult postImage([FromForm] CommodityImageModel commodityImageModel)
        {
            string wwwRootPath = ".\\wwwroot\\commodity_tmp";
            string folderPath = Path.Combine(wwwRootPath, commodityImageModel.IMAGE_KEY);



            if (!Directory.Exists(folderPath))  //若临时文件夹不存在
            {
                Directory.CreateDirectory(folderPath);
            }

            string[] files = Directory.GetFiles(folderPath);
            List<string>  imagePath = new List<string>(files);
            string fileName = "";
            if (imagePath.Count == 0)
            {
                fileName = $"com_image_0."
                + commodityImageModel.key.Split('.')[commodityImageModel.key.Split('.').Length - 1];

                string filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    commodityImageModel.file.CopyTo(stream);
                }
            }
            else
            {
                List<int> imageNum = new List<int>();
                foreach (string imageName in imagePath)
                {
                    int num_start_index = imageName.IndexOf("com_image_") + 10;
                    int num_end_index = imageName.IndexOf('.', 8);
                    int num = int.Parse(imageName.Substring(num_start_index, num_end_index - num_start_index));
                    //Console.WriteLine("xinde" + num);
                    imageNum.Add(num);
                }
                fileName = $"com_image_{imageNum.Max()+1}."
                + commodityImageModel.key.Split('.')[commodityImageModel.key.Split('.').Length - 1];

                string filePath = Path.Combine(folderPath, fileName);

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    commodityImageModel.file.CopyTo(stream);
                }
            }

            return Ok(fileName);

        }


        [HttpPost("deltmpimg")]
        public ActionResult deleteTmpImage([FromQuery] string fileName, [FromQuery] string IMAGE_KEY)
        {
            //Console.WriteLine(fileName);
            string deletePath = ".\\wwwroot\\commodity_tmp\\"+IMAGE_KEY+"\\"+fileName;
            if (System.IO.File.Exists(deletePath))
            {
                System.IO.File.Delete(deletePath);
                Console.WriteLine(deletePath + "临时文件删除成功");
            }
            return Ok(deletePath + "临时文件删除成功");
        }

        [HttpPost("basic")]
        [Consumes("application/json")]
        public ActionResult postBasicData([FromBody] CommodityModel commodityModel)
        {
            //OracleTransaction transaction = null;
            int COM_ID = 0;
            using (OracleCommand selectComIDCommand = new OracleCommand("SELECT COMMODITY_ID_SEQ.NEXTVAL FROM dual", DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader reader = selectComIDCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        COM_ID = reader.GetInt32(0);
                    }
                }
            }
            Console.WriteLine(COM_ID);
            using (OracleTransaction transaction = DBproject.DataBase.oracleCon.con.BeginTransaction())
            {
                string insertCommodity = "insert into COMMODITY(STO_ID,COM_ID,COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_EXPIRATIONDATE,COM_UPLOADDATE,COM_LEFT,COM_RATING)" +
                    "values (:STO_ID,:COM_ID,:COM_NAME,:COM_INTRODUCTION,:COM_ORIPRICE,TO_DATE(:COM_EXPIRATIONDATE,'YYYY-MM-DD'),TO_DATE(:COM_UPLOADDATE,'YYYY-MM-DD'),:COM_LEFT,:COM_RATING)";
                string insertCommodityCatagories = "insert into COMMODITY_CATEGORIES(COM_ID,COM_CATEGORY) VALUES (:COM_ID,:COM_CATEGORY)";
                string insertCommofityTPC = "insert into COMMODITY_PRICE_CURVE(COM_ID,COM_PC_TIME,COM_PC_PRICE) VALUES (:COM_ID,TO_DATE(:COM_PC_TIME,'YYYY-MM-DD'),:COM_PC_PRICE)";
                try
                {
                    //transaction = DBproject.DataBase.oracleCon.con.BeginTransaction();
                    using (OracleCommand inserCommoditytCommand = new OracleCommand(insertCommodity, DBproject.DataBase.oracleCon.con))
                    {
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":STO_ID", commodityModel.STO_ID));
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":COM_ID", COM_ID));
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":COM_NAME", commodityModel.COM_NAME));
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":COM_INTRODUCTION", commodityModel.COM_INTRODUCTION));
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":COM_ORIPRICE", commodityModel.COM_ORIPRICE));
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":COM_EXPIRATIONDATE", commodityModel.COM_EXPIRATIONDATE));
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":COM_UPLOADDATE", DateTime.Now.ToString("yyyy-MM-dd")));
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":COM_LEFT", commodityModel.COM_LEFT));
                        inserCommoditytCommand.Parameters.Add(new OracleParameter(":COM_RATING", OracleDbType.Decimal, 0, ParameterDirection.Input));
                        inserCommoditytCommand.ExecuteNonQuery();
                    }
                    foreach (string COM_CATEGORY in commodityModel.COM_CATEGORIES)
                    {
                        using (OracleCommand insertCommodityCatagoriesCommand = new OracleCommand(insertCommodityCatagories, DBproject.DataBase.oracleCon.con))
                        {
                            {
                                insertCommodityCatagoriesCommand.Parameters.Add(new OracleParameter(":COM_ID", COM_ID));
                                insertCommodityCatagoriesCommand.Parameters.Add(new OracleParameter(":COM_CATEGORY", COM_CATEGORY));
                                insertCommodityCatagoriesCommand.ExecuteNonQuery();
                            }
                        }
                    }

                    foreach (TimePriceModel timePrice in commodityModel.COM_TIME_PRICE)
                    {
                        using (OracleCommand insertCommofityTPCCommand = new OracleCommand(insertCommofityTPC, DBproject.DataBase.oracleCon.con))
                        {
                            {
                                insertCommofityTPCCommand.Parameters.Add(new OracleParameter(":COM_ID", COM_ID));
                                string sourceFormat = "yyyy/M/d H:mm:ss";
                                string targetFormat = "yyyy-MM-dd";

                                if (DateTime.TryParseExact(timePrice.TIME_POINT, sourceFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime parsedDate))
                                {
                                    timePrice.TIME_POINT = parsedDate.ToString(targetFormat);
                                }
                                insertCommofityTPCCommand.Parameters.Add(new OracleParameter(":COM_PC_TIME", timePrice.TIME_POINT));
                                OracleParameter comPcPriceParam = new OracleParameter(":COM_PC_PRICE", OracleDbType.Decimal);
                                comPcPriceParam.DbType = DbType.Decimal;
                                comPcPriceParam.Precision = 8; // 10 位整数位数
                                comPcPriceParam.Scale = 2; // 2 位小数位数
                                decimal comPcPriceValue = timePrice.PRICE_PERCENT * commodityModel.COM_ORIPRICE / 100;
                                if (comPcPriceValue < (decimal)0.01) comPcPriceValue = (decimal)0.01;
                                comPcPriceParam.Value = comPcPriceValue;
                                insertCommofityTPCCommand.Parameters.Add(comPcPriceParam);
                                //insertCommofityTPCCommand.Parameters.Add(new OracleParameter(":COM_PC_PRICE", timePrice.PRICE_PERCENT*commodityModel.COM_ORIPRICE));
                                insertCommofityTPCCommand.ExecuteNonQuery();
                            }
                        }
                    }

                    string srcPath = Path.Combine(".\\wwwroot\\commodity_tmp", commodityModel.IMAGE_KEY);
                    string dstPath = Path.Combine(".\\wwwroot\\commodity_image", "" + COM_ID);
                    if (!Directory.Exists(dstPath))
                    {
                        Directory.CreateDirectory(dstPath);
                    }
                    string[] files = Directory.GetFiles(srcPath);
                    foreach (string file in files)
                    {
                        string fileName = Path.GetFileName(file);
                        if (fileName.EndsWith(".txt")) continue;
                        string destinationFile = Path.Combine(dstPath, fileName);

                        if (System.IO.File.Exists(destinationFile))
                        {
                            System.IO.File.Delete(destinationFile);
                        }

                        System.IO.File.Move(file, destinationFile);
                        using (OracleCommand insertCommodityImageCommand = new OracleCommand("insert into COMMODITY_IMAGE(COM_ID,COM_IMAGE) VALUES(:COM_ID,:COM_IMAGE)", DBproject.DataBase.oracleCon.con))
                        {
                            {
                                insertCommodityImageCommand.Parameters.Add(new OracleParameter(":COM_ID", COM_ID));
                                insertCommodityImageCommand.Parameters.Add(new OracleParameter(":COM_IMAGE", destinationFile));
                                insertCommodityImageCommand.ExecuteNonQuery();
                            }
                        }
                    }

                    // 最后，删除src文件夹
                    Directory.Delete(srcPath);


                    transaction.Commit();
                    return Ok(COM_ID);
                }
                catch (Exception ex)
                {
                    // If any error occurs, rollback the transaction
                    transaction.Rollback();
                    Console.WriteLine("Error occurred: " + ex.Message);
                    return Ok("数据库插入错误！该事务回滚");
                }
            }
        }


        public class CommodityImageModel
        {
            public IFormFile file { get; set; }
            public string IMAGE_KEY { get; set; }

            public string key { get; set; }
            public int COM_ID { get; set; }
            public CommodityImageModel()
            {
                //file = null;
                IMAGE_KEY = "";
                key = "";
                COM_ID = 0;
            }
        }

        public class CommodityModel
        {
            public int STO_ID { get; set; }
            public string COM_NAME { get; set; }
            public string COM_INTRODUCTION { get; set; }
            public decimal COM_ORIPRICE { get; set; }
            public string COM_EXPIRATIONDATE { get; set; }
            //public string COM_UPLOADDATE { get; set; }
            public int COM_LEFT { get; set; }
            public string IMAGE_KEY { get; set; }
            public List<string> COM_CATEGORIES { get; set; }
            public List<TimePriceModel> COM_TIME_PRICE { get; set; }

            public CommodityModel()
            {
                COM_CATEGORIES = new List<string>();
                COM_TIME_PRICE = new List<TimePriceModel>();
                IMAGE_KEY = "";
                COM_EXPIRATIONDATE = "";
            }
        }

        public class TimePriceModel
        {
            public string TIME_POINT { get; set; }
            public int PRICE_PERCENT { get; set; }
        }


    }
}
