//WST. 商家系统-上传商品相关信息
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


        [HttpPost("image")]
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


        [HttpPost("deleteTmpImage")]
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

        [HttpGet("form-data")]
        public ActionResult getFormData([FromQuery] int COM_ID)
        {
            CommodityModel commodityModel = new CommodityModel();
            string selectSQL1 = "select COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_LEFT,COM_EXPIRATIONDATE from COMMODITY" +
                " where COM_ID = " + COM_ID;
            decimal COM_ORIPRICE = 0;
            using (OracleCommand selectSQLCommand1 = new OracleCommand(selectSQL1, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader reader1 = selectSQLCommand1.ExecuteReader())
                {
                    while (reader1.Read())
                    {
                        commodityModel.COM_NAME = reader1.GetString("COM_NAME");
                        commodityModel.COM_INTRODUCTION = reader1.GetString("COM_INTRODUCTION");
                        commodityModel.COM_ORIPRICE = reader1.GetDecimal("COM_ORIPRICE");
                        COM_ORIPRICE = commodityModel.COM_ORIPRICE;
                        commodityModel.COM_LEFT = reader1.GetInt32("COM_LEFT");
                        string[] date = reader1.GetString("COM_EXPIRATIONDATE").Split('-');
                        date[1] = date[1].Remove(date[1].IndexOf('月'));
                        if (date[1].Length == 1) date[1] = "0" + date[1];
                        commodityModel.COM_EXPIRATIONDATE = string.Format("20{0}-{1}-{2}", date[2], date[1], date[0]);
                    }
                }
            }
            string selectSQL2 = "select COM_CATEGORY from COMMODITY_CATEGORIES where com_id = " + COM_ID;
            using (OracleCommand selectSQLCommand2 = new OracleCommand(selectSQL2, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader reader2 = selectSQLCommand2.ExecuteReader())
                {
                    while (reader2.Read())
                    {
                        commodityModel.COM_CATEGORIES.Add(reader2.GetString(0));
                    }
                }
            }

            string selectCommodityPCSQL = "select COM_PC_TIME,COM_PC_PRICE from COMMODITY_PRICE_CURVE where com_id = " + COM_ID;
            using (OracleCommand selectCommodityPCommand = new OracleCommand(selectCommodityPCSQL, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader selectCommodityPCReader = selectCommodityPCommand.ExecuteReader())
                {
                    while (selectCommodityPCReader.Read())
                    {
                        TimePriceModel timePriceModel = new TimePriceModel();
                        string[] date = selectCommodityPCReader.GetString("COM_PC_TIME").Split('-');
                        date[1] = date[1].Remove(date[1].IndexOf('月'));
                        if (date[1].Length == 1) date[1] = "0" + date[1];
                        timePriceModel.TIME_POINT = string.Format("20{0}-{1}-{2}", date[2], date[1], date[0]);
                        timePriceModel.PRICE_PERCENT = (int)((100 * selectCommodityPCReader.GetDouble("COM_PC_PRICE")) / (double)COM_ORIPRICE);

                        commodityModel.COM_TIME_PRICE.Add(timePriceModel);
                    }
                }
            }

            var json = JsonConvert.SerializeObject(commodityModel);
            Console.WriteLine(json);
            return Ok(json);
        }

        [HttpPost("updateBasicData")]
        [Consumes("application/json")]
        public ActionResult updateBasicData([FromQuery] int COM_ID, [FromBody] CommodityModel commodityModel)
        {
            Console.WriteLine(commodityModel.STO_ID);
            string updateCommoditySQL = "UPDATE COMMODITY SET COM_NAME = :COM_NAME,COM_INTRODUCTION= :COM_INTRODUCTION,COM_LEFT = :COM_LEFT where COM_ID = " + COM_ID;
            string deleteCommodityCateSQL = "DELETE FROM COMMODITY_CATEGORIES WHERE COM_ID = " + COM_ID;
            string insertCommodityCateSQL = "insert into COMMODITY_CATEGORIES(COM_ID,COM_CATEGORY) VALUES (:COM_ID,:COM_CATEGORY)";
            string deleteCommofityTPCSQL = "DELETE FROM COMMODITY_PRICE_CURVE WHERE COM_ID = " + COM_ID;
            string insertCommofityTPCSQL = "insert into COMMODITY_PRICE_CURVE(COM_ID,COM_PC_TIME,COM_PC_PRICE) VALUES (:COM_ID,TO_DATE(:COM_PC_TIME,'YYYY-MM-DD'),:COM_PC_PRICE)";
            using (OracleCommand updateCommodityCommand = new OracleCommand(updateCommoditySQL, DBproject.DataBase.oracleCon.con))
            {
                updateCommodityCommand.Parameters.Add(new OracleParameter(":COM_NAME", commodityModel.COM_NAME));
                updateCommodityCommand.Parameters.Add(new OracleParameter(":COM_INTRODUCTION", commodityModel.COM_INTRODUCTION));
                updateCommodityCommand.Parameters.Add(new OracleParameter(":COM_LEFT", commodityModel.COM_LEFT));
                updateCommodityCommand.ExecuteNonQuery();
            }
            using (OracleCommand deleteCommodityCateCommand = new OracleCommand(deleteCommodityCateSQL, DBproject.DataBase.oracleCon.con))
            {
                deleteCommodityCateCommand.ExecuteNonQuery();
            }

            foreach (string COM_CATEGORY in commodityModel.COM_CATEGORIES)
            {
                using (OracleCommand insertCommodityCateCommand = new OracleCommand(insertCommodityCateSQL, DBproject.DataBase.oracleCon.con))
                {
                    Console.WriteLine(COM_CATEGORY);
                    insertCommodityCateCommand.Parameters.Add(new OracleParameter(":COM_ID", COM_ID));
                    insertCommodityCateCommand.Parameters.Add(new OracleParameter(":COM_CATEGORY", COM_CATEGORY));
                    insertCommodityCateCommand.ExecuteNonQuery();
                }
            }
            using (OracleCommand deleteCommofityTPCommand = new OracleCommand(deleteCommofityTPCSQL, DBproject.DataBase.oracleCon.con))
            {
                deleteCommofityTPCommand.ExecuteNonQuery();
            }
            foreach (TimePriceModel timePrice in commodityModel.COM_TIME_PRICE)
            {
                using (OracleCommand insertCommofityTPCommand = new OracleCommand(insertCommofityTPCSQL, DBproject.DataBase.oracleCon.con))
                {
                    {
                        insertCommofityTPCommand.Parameters.Add(new OracleParameter(":COM_ID", COM_ID));
                        Console.WriteLine(":COM_PC_TIME" + timePrice.TIME_POINT);
                        string sourceFormat = "yyyy/M/d H:mm:ss";
                        string targetFormat = "yyyy-MM-dd";

                        if (DateTime.TryParseExact(timePrice.TIME_POINT, sourceFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime parsedDate))
                        {
                            timePrice.TIME_POINT = parsedDate.ToString(targetFormat);
                        }
                        insertCommofityTPCommand.Parameters.Add(new OracleParameter(":COM_PC_TIME", timePrice.TIME_POINT));
                        OracleParameter comPcPriceParam = new OracleParameter(":COM_PC_PRICE", OracleDbType.Decimal);
                        comPcPriceParam.DbType = DbType.Decimal;
                        comPcPriceParam.Precision = 8; // 10 位整数位数
                        comPcPriceParam.Scale = 2; // 2 位小数位数
                        decimal comPcPriceValue = timePrice.PRICE_PERCENT * commodityModel.COM_ORIPRICE / 100;
                        comPcPriceParam.Value = comPcPriceValue;
                        insertCommofityTPCommand.Parameters.Add(comPcPriceParam);
                        //insertCommofityTPCCommand.Parameters.Add(new OracleParameter(":COM_PC_PRICE", timePrice.PRICE_PERCENT*commodityModel.COM_ORIPRICE));
                        insertCommofityTPCommand.ExecuteNonQuery();
                    }
                }
            }
            return Ok("更新成功！");
        }

        [HttpGet("image-path")]
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

        [HttpPost("updateImage")]
        [Consumes("multipart/form-data")]
        public ActionResult postUpdateImage([FromForm] CommodityImageModel updateImageModel )
        {
            Console.WriteLine("update图片ID"+updateImageModel.COM_ID+updateImageModel.key);
            string selectImagePathSQL = "select COM_IMAGE from COMMODITY_IMAGE where com_id = " + updateImageModel.COM_ID;
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
            List<int>imageNum = new List<int>();
            foreach (string imageName in imagePath)
            {
                int num_start_index = imageName.IndexOf("com_image_")+10;
                int num_end_index = imageName.IndexOf('.', 8);
                int num = int.Parse(imageName.Substring(num_start_index,num_end_index-num_start_index));
                //Console.WriteLine("xinde" + num);
                imageNum.Add(num);
            }
            string dstPath = ".\\wwwroot\\commodity_image\\"+updateImageModel.COM_ID;
            string destinationFile = Path.Combine(dstPath, "com_image_"+(imageNum.Max()+1)+".jpg");

            using (var stream = new FileStream(destinationFile, FileMode.Create))
            {
                updateImageModel.file.CopyTo(stream);
            }
            using (OracleCommand insertCommodityImageCommand = new OracleCommand("insert into COMMODITY_IMAGE(COM_ID,COM_IMAGE) VALUES(:COM_ID,:COM_IMAGE)", DBproject.DataBase.oracleCon.con))
            {
                {
                    insertCommodityImageCommand.Parameters.Add(new OracleParameter(":COM_ID", updateImageModel.COM_ID));
                    insertCommodityImageCommand.Parameters.Add(new OracleParameter(":COM_IMAGE", destinationFile));
                    insertCommodityImageCommand.ExecuteNonQuery();
                }
            }

            return Ok(destinationFile);
        }

        [HttpPost("deleteImage")]
        public ActionResult postDeleteImage([FromQuery] int COM_ID, [FromQuery] string COM_IMAGE)
        {
            string deleteFile = COM_IMAGE;
            System.IO.File.Delete(deleteFile);
            using (OracleCommand deleteCommodityImageCommand = new OracleCommand("delete from COMMODITY_IMAGE where COM_ID = :COM_ID and COM_IMAGE = :COM_IMAGE", DBproject.DataBase.oracleCon.con))
            {
                deleteCommodityImageCommand.Parameters.Add(new OracleParameter(":COM_ID",COM_ID));
                deleteCommodityImageCommand.Parameters.Add(new OracleParameter(":COM_IMAGE", COM_IMAGE));
                deleteCommodityImageCommand.ExecuteNonQuery();
            }    //Directory.Delete(COM_IMAGE);

            return Ok();
        }

        [HttpPost("deleteCommodity")]
        public ActionResult postDeleteCommodity([FromQuery] int COM_ID)
        {
            /* string deleteCommodityImageSQL = "delete from COMMODITY_IMAGE where COM_ID = " + COM_ID;
             string deleteCommodityCateSQL = "delete from COMMODITY_CATEGORIES where COM_ID = " + COM_ID;
             string deleteCommodityPCSQL = "delete from COMMODITY_PRICE_CURVE where COM_ID = " + COM_ID;
             string deleteCommoditySQL = "delete from COMMODITY where COM_ID = " + COM_ID;
             string deletePath = ".\\wwwroot\\commodity_image\\" + COM_ID;
             using (OracleCommand deleteCommodityDataCommand = new OracleCommand(deleteCommodityImageSQL, DBproject.DataBase.oracleCon.con))
             {
                 deleteCommodityDataCommand.ExecuteNonQuery();
                 Directory.Delete(deletePath,true);
             }
             using (OracleCommand deleteCommodityDataCommand = new OracleCommand(deleteCommodityCateSQL, DBproject.DataBase.oracleCon.con))
             {
                 deleteCommodityDataCommand.ExecuteNonQuery();
             }
             using (OracleCommand deleteCommodityDataCommand = new OracleCommand(deleteCommodityPCSQL, DBproject.DataBase.oracleCon.con))
             {
                 deleteCommodityDataCommand.ExecuteNonQuery();
             }
             using (OracleCommand deleteCommodityDataCommand = new OracleCommand(deleteCommoditySQL, DBproject.DataBase.oracleCon.con))
             {
                 deleteCommodityDataCommand.ExecuteNonQuery();
             }*/
            string setComLeftZero = "update COMMODITY SET COM_LEFT = 0 WHERE COM_ID = " + COM_ID;
            using (OracleCommand updateCommand = new OracleCommand(setComLeftZero, DBproject.DataBase.oracleCon.con))
            {
                updateCommand.ExecuteNonQuery();
            }
            return Ok();
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
