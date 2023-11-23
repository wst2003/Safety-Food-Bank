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
    public class StoreIndentListController : Controller
    {
        [HttpGet("indentbox")]
        public ActionResult getIndentWithBox([FromQuery] BoxQueryModel boxQueryModel)
        {
            string sorted_option = "";
            if (boxQueryModel.TIME_ORDER == 0) sorted_option = "DESC";
            else sorted_option = "ASC";
            string sql = @"
                WITH COMMODITY_WITH_IMAGE AS (
                    SELECT commodity.*, ci.COM_IMAGE
                    FROM commodity
                    JOIN(
                        SELECT COM_ID, MAX(COM_IMAGE) AS COM_IMAGE
                        FROM commodity_image
                        GROUP BY COM_ID
                    ) ci ON commodity.COM_ID = ci.COM_ID
                ),
                NUMBERED_RESULTS AS (
                    SELECT 
                        A.*,
                        CASE 
                            WHEN LAG(IND_VERIFICATIONCODE) OVER (ORDER BY IND_CREATIONTIME DESC, IND_VERIFICATIONCODE) = IND_VERIFICATIONCODE THEN 0
                            ELSE 1
                        END AS IS_NEW_GROUP
                    FROM (
                        SELECT 
                            INDENT.IND_ID, INDENT.COM_ID, INDENT.IND_QUANTITY, INDENT.IND_MONEY, COMMODITY_WITH_IMAGE.COM_NAME, INDENT.IND_VERIFICATIONCODE,
                            COMMODITY_WITH_IMAGE.COM_IMAGE, INDENT.IND_NOTES, INDENT.IND_RATING, INDENT.CUS_ID, INDENT.IND_CREATIONTIME, USERS.USER_PHONE, CUSTOMER.CUS_NICKNAME
                        FROM INDENT
                        JOIN COMMODITY_WITH_IMAGE ON INDENT.COM_ID = COMMODITY_WITH_IMAGE.COM_ID
                        JOIN CUSTOMER ON INDENT.CUS_ID = CUSTOMER.CUS_ID
                        JOIN USERS ON INDENT.CUS_ID = USERS.USER_ID
                        WHERE COMMODITY_WITH_IMAGE.STO_ID = :STO_ID
                            AND USERS.USER_PHONE LIKE :USER_PHONE
                            AND INDENT.IND_STATE = :IND_STATE " + (boxQueryModel.IND_STATE == -1 ? @" and commodity_with_image.com_status = -1" : "") + (boxQueryModel.IND_STATE == 0 ? @" and commodity_with_image.com_status != -1" : "") + @"
                        ORDER BY INDENT.IND_CREATIONTIME " + sorted_option + @",INDENT.IND_VERIFICATIONCODE
                    ) A
                )
                SELECT * FROM(
                SELECT 
                    IND_ID, COM_ID, IND_QUANTITY, IND_MONEY, COM_NAME, IND_VERIFICATIONCODE,
                    COM_IMAGE, IND_NOTES, IND_RATING, CUS_ID, IND_CREATIONTIME, USER_PHONE, CUS_NICKNAME,
                    SUM(IS_NEW_GROUP) OVER (ORDER BY IND_CREATIONTIME " + sorted_option + @", IND_VERIFICATIONCODE) AS GROUP_NUMBER
                FROM NUMBERED_RESULTS
                ORDER BY IND_CREATIONTIME " + sorted_option + @", IND_VERIFICATIONCODE,IND_ID)
                where group_number>=:BOX_BEGIN AND group_number<=:BOX_END";

            List<BoxResponseModel> responseModel = new List<BoxResponseModel>();
            using (OracleCommand selectCommand = new OracleCommand(sql, DBproject.DataBase.oracleCon.con))
            {
                selectCommand.Parameters.Add(new OracleParameter(":STO_ID", boxQueryModel.STO_ID));
                boxQueryModel.USER_PHONE = boxQueryModel.USER_PHONE.Equals("null") ? "" : boxQueryModel.USER_PHONE;
                selectCommand.Parameters.Add(new OracleParameter(":USER_PHONE", "%" + boxQueryModel.USER_PHONE + "%"));
                selectCommand.Parameters.Add(new OracleParameter(":IND_STATE", boxQueryModel.IND_STATE == 1 ? 1 : 0));
                if (boxQueryModel.BOX_BEGIN == 1) boxQueryModel.BOX_BEGIN = 0;
                selectCommand.Parameters.Add(new OracleParameter(":BOX_BEGIN", boxQueryModel.BOX_BEGIN));
                selectCommand.Parameters.Add(new OracleParameter(":BOX_END", boxQueryModel.BOX_END));

                int group_number = 0;
                using (OracleDataReader reader = selectCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader.GetInt32("GROUP_NUMBER") != group_number)
                        {
                            responseModel.Add(new BoxResponseModel());
                            group_number = reader.GetInt32("GROUP_NUMBER");
                            responseModel[responseModel.Count - 1].CUS_ID = reader.GetInt32("CUS_ID");
                            responseModel[responseModel.Count - 1].USER_PHONE = reader.GetString("USER_PHONE");
                            responseModel[responseModel.Count - 1].IND_CREATIONTIME = reader.GetDateTime("IND_CREATIONTIME").ToString("yyyy-MM-dd HH:mm:ss");
                            responseModel[responseModel.Count - 1].CUS_NICKNAME = reader.GetString("CUS_NICKNAME");
                            responseModel[responseModel.Count - 1].BOX = new List<BoxResponseModel.BoxModel>();
                        }
                        BoxResponseModel.BoxModel abox = new BoxResponseModel.BoxModel();
                        abox.IND_ID = reader.GetInt32("IND_ID");
                        abox.COM_ID = reader.GetInt32("COM_ID");
                        abox.IND_QUANTITY = reader.GetInt32("IND_QUANTITY");
                        abox.IND_MONEY = reader.GetDouble("IND_MONEY");
                        abox.COM_NAME = reader.GetString("COM_NAME");
                        abox.COM_IMAGE = reader.GetString("COM_IMAGE");
                        abox.IND_NOTES = reader.IsDBNull(reader.GetOrdinal("IND_NOTES")) ? "" : reader.GetString("IND_NOTES");
                        abox.IND_RATING = reader.IsDBNull(reader.GetOrdinal("IND_RATING")) ? -1 : reader.GetInt32("IND_RATING");
                        responseModel[responseModel.Count - 1].BOX.Add(abox);
                        Console.WriteLine(reader.GetInt32("IND_ID"));
                    }
                }
            }

            string response = JsonConvert.SerializeObject(responseModel);
            Console.WriteLine(response);
            return Ok(response);
        }

        [HttpGet("refundlist")]
        public ActionResult getRefundList([FromQuery] int STO_ID, [FromQuery] int TIME_ORDER, [FromQuery] string USER_PHONE, [FromQuery] int BEGIN_NUMBER, [FromQuery] int END_NUMBER)
        {
            string sorted_option = "";
            if (TIME_ORDER == 0) sorted_option = "DESC";
            else sorted_option = "ASC";
            string sql = @"WITH COMMODITY_WITH_IMAGE AS (
                                SELECT commodity.*, ci.COM_IMAGE
                                FROM commodity
                                JOIN(
                                    SELECT COM_ID, MAX(COM_IMAGE) AS COM_IMAGE
                                    FROM commodity_image
                                    GROUP BY COM_ID
                                ) ci ON commodity.COM_ID = ci.COM_ID
                            )
                            SELECT * FROM(
                            SELECT subquery.*, ROWNUM as row_num FROM (
                            SELECT INDENT.IND_ID,INDENT.IND_QUANTITY,INDENT.COM_ID,INDENT.CUS_ID,COMMODITY_WITH_IMAGE.COM_NAME,COMMODITY_WITH_IMAGE.COM_IMAGE,INDENT.IND_MONEY,INDENT.IND_RMONEY,INDENT.IND_CREATIONTIME,INDENT.IND_RTIME,IND_RNOTES
                            FROM INDENT
                                    JOIN COMMODITY_WITH_IMAGE ON INDENT.COM_ID = COMMODITY_WITH_IMAGE.COM_ID
                                    JOIN USERS ON INDENT.CUS_ID = USERS.USER_ID
                            WHERE STO_ID = :STO_ID AND IND_STATE = 2 AND USERS.USER_PHONE like :USER_PHONE 
                            order by INDENT.IND_CREATIONTIME " + sorted_option + @" ) subquery)
                            where row_num>=:BEGIN_NUMBER and row_num<=:END_NUMBER";
            List<RefundResponseModel> refundResponseModels = new List<RefundResponseModel>();
            using (OracleCommand selectCommand = new OracleCommand(sql, DBproject.DataBase.oracleCon.con))
            {
                selectCommand.Parameters.Add(new OracleParameter(":STO_ID", STO_ID));
                USER_PHONE = USER_PHONE.Equals("null") ? "" : USER_PHONE;
                selectCommand.Parameters.Add(new OracleParameter(":USER_PHONE", "%" + USER_PHONE + "%"));
                selectCommand.Parameters.Add(new OracleParameter(":BOX_BEGIN", BEGIN_NUMBER));
                selectCommand.Parameters.Add(new OracleParameter(":BOX_END", END_NUMBER));


                using (OracleDataReader reader = selectCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        RefundResponseModel refundResponseModel = new RefundResponseModel();
                        refundResponseModel.IND_ID = reader.GetInt32("IND_ID");
                        refundResponseModel.COM_ID = reader.GetInt32("COM_ID");
                        refundResponseModel.CUS_ID = reader.GetInt32("CUS_ID");
                        refundResponseModel.IND_QUANTITY = reader.GetInt32("IND_QUANTITY");
                        refundResponseModel.IND_MONEY = reader.GetDouble("IND_MONEY");
                        refundResponseModel.IND_RMONEY = reader.GetDouble("IND_RMONEY");
                        refundResponseModel.COM_NAME = reader.GetString("COM_NAME");
                        refundResponseModel.IND_CREATIONTIME = reader.GetDateTime("IND_CREATIONTIME").ToString("yyyy-MM-dd HH:mm:ss");
                        refundResponseModel.IND_RTIME = reader.GetDateTime("IND_RTIME").ToString("yyyy-MM-dd HH:mm:ss");
                        refundResponseModel.COM_IMAGE = reader.GetString("COM_IMAGE");
                        refundResponseModel.IND_RNOTES = reader.IsDBNull(reader.GetOrdinal("IND_RNOTES")) ? "" : reader.GetString("IND_RNOTES");
                        refundResponseModels.Add(refundResponseModel);
                    }
                }
            }
            string response = JsonConvert.SerializeObject(refundResponseModels);
            Console.WriteLine(response);
            return Ok(response);

        }
    }

    public class BoxQueryModel
    {
        public int STO_ID { get; set; }
        public int TIME_ORDER { get; set; }
        public int BOX_BEGIN { get; set; }
        public int BOX_END { get; set; }

        public string USER_PHONE { get; set; }
        public int IND_STATE { get; set; }
        public BoxQueryModel()
        {
            USER_PHONE = "";
        }

    }

    public class BoxResponseModel
    {
        public BoxResponseModel() { }
        public int CUS_ID { get; set; }
        public string IND_CREATIONTIME { get; set; }
        public string USER_PHONE { set; get; }
        public string CUS_NICKNAME { get; set; }

        public List<BoxModel> BOX { get; set; }
        public class BoxModel
        {
            public BoxModel() { }
            public int IND_ID { get; set; }
            public int COM_ID { get; set; }
            public int IND_QUANTITY { get; set; }
            public double IND_MONEY { get; set; }
            public string COM_NAME { get; set; }
            public string COM_IMAGE { get; set; }
            public string IND_NOTES { get; set; }
            public int IND_RATING { get; set; }
        }
    }

    public class RefundResponseModel
    {
        public RefundResponseModel() { }
        public int IND_ID { get; set; }
        public int IND_QUANTITY { get; set; }
        public int COM_ID { get; set; }
        public string COM_NAME { get; set; }
        public string COM_IMAGE { get; set; }
        public double IND_MONEY { get; set; }
        public double IND_RMONEY { get; set; }
        public string IND_CREATIONTIME { get; set; }
        public string IND_RTIME { get; set; }
        public string IND_RNOTES { get; set; }
        public int CUS_ID { get; set; }
    }
}

