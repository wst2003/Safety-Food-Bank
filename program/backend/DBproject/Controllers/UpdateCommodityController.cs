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
    public class UpdateCommodityController : Controller
    {
        [HttpGet("basic")]
        public ActionResult getFormData([FromQuery] int COM_ID)
        {
            UploadCommodityController.CommodityModel commodityModel = new UploadCommodityController.CommodityModel();
            string selectSQL1 = "select STO_ID,COM_NAME,COM_INTRODUCTION,COM_ORIPRICE,COM_LEFT,COM_EXPIRATIONDATE from COMMODITY" +
                " where COM_ID = " + COM_ID;
            decimal COM_ORIPRICE = 0;
            using (OracleCommand selectSQLCommand1 = new OracleCommand(selectSQL1, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader reader1 = selectSQLCommand1.ExecuteReader())
                {
                    while (reader1.Read())
                    {
                        commodityModel.STO_ID = reader1.GetInt32("STO_ID");
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
                        UploadCommodityController.TimePriceModel timePriceModel = new UploadCommodityController.TimePriceModel();
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

        [HttpPost("updatebasic")]
        [Consumes("application/json")]
        public ActionResult updateBasicData([FromQuery] int COM_ID, [FromBody] UploadCommodityController.CommodityModel commodityModel)
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
            foreach (UploadCommodityController.TimePriceModel timePrice in commodityModel.COM_TIME_PRICE)
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

       

        [HttpPost("updateimg")]
        [Consumes("multipart/form-data")]
        public ActionResult postUpdateImage([FromForm] UploadCommodityController.CommodityImageModel updateImageModel)
        {
            Console.WriteLine("update图片ID" + updateImageModel.COM_ID + updateImageModel.key);
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
            List<int> imageNum = new List<int>();
            foreach (string imageName in imagePath)
            {
                int num_start_index = imageName.IndexOf("com_image_") + 10;
                int num_end_index = imageName.IndexOf('.', 8);
                int num = int.Parse(imageName.Substring(num_start_index, num_end_index - num_start_index));
                //Console.WriteLine("xinde" + num);
                imageNum.Add(num);
            }
            string dstPath = ".\\wwwroot\\commodity_image\\" + updateImageModel.COM_ID;
            string destinationFile = Path.Combine(dstPath, "com_image_" + (imageNum.Max() + 1) + ".jpg");

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

        [HttpPost("delimg")]
        public ActionResult postDeleteImage([FromQuery] int COM_ID, [FromQuery] string COM_IMAGE)
        {
            string deleteFile = COM_IMAGE;
            System.IO.File.Delete(deleteFile);
            using (OracleCommand deleteCommodityImageCommand = new OracleCommand("delete from COMMODITY_IMAGE where COM_ID = :COM_ID and COM_IMAGE = :COM_IMAGE", DBproject.DataBase.oracleCon.con))
            {
                deleteCommodityImageCommand.Parameters.Add(new OracleParameter(":COM_ID", COM_ID));
                deleteCommodityImageCommand.Parameters.Add(new OracleParameter(":COM_IMAGE", COM_IMAGE));
                deleteCommodityImageCommand.ExecuteNonQuery();
            }    //Directory.Delete(COM_IMAGE);

            return Ok();
        }


        [HttpPost("delcommodity")]
        public ActionResult postDeleteCommodity([FromQuery] int COM_ID)
        {
            string setComLeftZero = "update COMMODITY SET COM_LEFT = 0 WHERE COM_ID = " + COM_ID;
            using (OracleCommand updateCommand = new OracleCommand(setComLeftZero, DBproject.DataBase.oracleCon.con))
            {
                updateCommand.ExecuteNonQuery();
            }
            return Ok();
        }
    }
}
