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
    public class AdminController : Controller
    {
        [HttpGet("userlist")]
        public ActionResult userlist([FromQuery] QueryModel queryModel)
        {
            List<UserModel> users = new List<UserModel>();
            string sql = "";
            if (queryModel.USER_TYPE == 0)
            {
                string orderOption = "";
                if (queryModel.NAME_ORDER == 0) orderOption = "order by NLSSORT(CUS_NICKNAME,'NLS_SORT=SCHINESE_PINYIN_M') DESC) ";
                else if (queryModel.NAME_ORDER == 1) orderOption = "order by NLSSORT(CUS_NICKNAME,'NLS_SORT=SCHINESE_PINYIN_M') ASC) ";
                else if (queryModel.ID_ORDER == 0) orderOption = "order by CUS_ID DESC) ";
                else if (queryModel.ID_ORDER == 1) orderOption = "order by CUS_ID ASC) ";
                sql = @"SELECT CUS_ID,CUS_NICKNAME,USER_REGTIME,USER_STATE FROM(
                        SELECT CUS_ID,CUS_NICKNAME,USER_REGTIME,USER_STATE ,ROWNUM as row_num FROM(
                        SELECT CUS_ID,CUS_NICKNAME,USER_REGTIME,USER_STATE
                        FROM CUSTOMER  JOIN USERS ON customer.cus_id = USERS.USER_ID
                        where CUS_NICKNAME like :USER_NAME " + orderOption +
                        ")where row_num>=:BEGIN_NUMBER and row_num<=:END_NUMBER";
                using (OracleCommand selectCommand = new OracleCommand(sql, DBproject.DataBase.oracleCon.con))
                {
                    if (queryModel.USER_NAME.Equals("NULL")) queryModel.USER_NAME = "";
                    selectCommand.Parameters.Add(new OracleParameter(":USER_NAME", "%" + queryModel.USER_NAME + "%"));
                    selectCommand.Parameters.Add(new OracleParameter(":BEGIN_NUMBER", queryModel.BEGIN_NUMBER));
                    selectCommand.Parameters.Add(new OracleParameter(":END_NUMBER", queryModel.END_NUMBER));
                    using (OracleDataReader reader = selectCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UserModel userModel = new UserModel();
                            userModel.USER_ID = reader.GetInt32("CUS_ID");
                            userModel.USER_NAME = reader.GetString("CUS_NICKNAME");
                            userModel.USER_REGTIME = reader.GetDateTime("USER_REGTIME").ToString("yyyy-MM-dd");
                            userModel.USER_STATE = reader.GetInt32("USER_STATE");
                            userModel.STO_IMAGE = "NULL";
                            users.Add(userModel);
                        }
                    }
                }
            }
            else
            {
                string orderOption = "";
                if (queryModel.NAME_ORDER == 0) orderOption = "order by NLSSORT(STORE_WITH_IMAGE.STO_NAME,'NLS_SORT=SCHINESE_PINYIN_M') DESC) ";
                else if (queryModel.NAME_ORDER == 1) orderOption = "order by NLSSORT(STORE_WITH_IMAGE.STO_NAME,'NLS_SORT=SCHINESE_PINYIN_M') ASC) ";
                else if (queryModel.ID_ORDER == 0) orderOption = "order by STORE_WITH_IMAGE.STO_ID DESC) ";
                else if (queryModel.ID_ORDER == 1) orderOption = "order by STORE_WITH_IMAGE.STO_ID ASC) ";
                sql = @"WITH STORE_WITH_IMAGE AS (
                    SELECT STORE.*, ci.STO_IMAGE
                    FROM STORE
                    JOIN(
                        SELECT STO_ID, MIN(STO_IMAGE) AS STO_IMAGE
                        FROM STOREIMAGE
                        GROUP BY STO_ID
                    ) ci ON STORE.STO_ID = ci.STO_ID
                )
                SELECT STO_ID,STO_NAME, USER_REGTIME,USER_STATE,STO_IMAGE FROM(
                SELECT STO_ID,STO_NAME, USER_REGTIME,USER_STATE,STO_IMAGE,ROWNUM as row_num FROM(               
                SELECT STORE_WITH_IMAGE.STO_ID,STORE_WITH_IMAGE.STO_NAME,USERS.USER_REGTIME,USERS.USER_STATE,STORE_WITH_IMAGE.STO_IMAGE
                FROM STORE_WITH_IMAGE JOIN USERS ON STORE_WITH_IMAGE.STO_ID = USERS.USER_ID
                WHERE STORE_WITH_IMAGE.STO_NAME LIKE :USER_NAME " + orderOption +
                " )where row_num>=:BEGIN_NUMBER and row_num<=:END_NUMBER";
                using (OracleCommand selectCommand = new OracleCommand(sql, DBproject.DataBase.oracleCon.con))
                {
                    if (queryModel.USER_NAME.Equals("NULL")) queryModel.USER_NAME = "";
                    selectCommand.Parameters.Add(new OracleParameter(":USER_NAME", "%" + queryModel.USER_NAME + "%"));
                    selectCommand.Parameters.Add(new OracleParameter(":BEGIN_NUMBER", queryModel.BEGIN_NUMBER));
                    selectCommand.Parameters.Add(new OracleParameter(":END_NUMBER", queryModel.END_NUMBER));
                    using (OracleDataReader reader = selectCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            UserModel userModel = new UserModel();
                            userModel.USER_ID = reader.GetInt32("STO_ID");
                            userModel.USER_NAME = reader.GetString("STO_NAME");
                            userModel.USER_REGTIME = reader.GetDateTime("USER_REGTIME").ToString("yyyy-MM-dd");
                            userModel.USER_STATE = reader.GetInt32("USER_STATE");
                            userModel.STO_IMAGE = reader.GetString("STO_IMAGE");
                            users.Add(userModel);
                        }
                    }
                }
            }


            string response = JsonConvert.SerializeObject(users);
            Console.WriteLine(response);
            return Ok(response);
        }

        [HttpGet("userstate")]
        public ActionResult userstate([FromQuery] int USER_ID, [FromQuery] int USER_TYPE)
        {
            string result_state = "";
            string sql = "";
            if (USER_TYPE == 0) sql = "select CUS_STATE from customer where CUS_ID = " + USER_ID;
            else sql = "select STO_STATE from STORE where STO_ID = " + USER_ID;
            using (OracleCommand selectCommand = new OracleCommand(sql, DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader reader = selectCommand.ExecuteReader())
                {
                    reader.Read();
                    result_state += reader.GetInt32(0);
                }
            }
            return Ok(result_state);
        }

        [HttpPost("changeuserstate")]
        public ActionResult changeuserstate([FromBody] ChangeUserModel changeUserModel)
        {
            string sql = "";
            bool success = false;
            if (changeUserModel.USER_TYPE == 0) sql = "update customer set CUS_STATE = :TO_STATE where CUS_ID = :USER_ID";
            else sql = "update store set STO_STATE = :TO_STATE where STO_ID = :USER_ID";
            using (OracleCommand updateCommand = new OracleCommand(sql, DBproject.DataBase.oracleCon.con))
            {
                updateCommand.Parameters.Add(new OracleParameter(":TO_STATE", changeUserModel.TO_STATE));
                updateCommand.Parameters.Add(new OracleParameter(":USER_ID", changeUserModel.USER_ID));
                int rowsAffected = updateCommand.ExecuteNonQuery();
                if (rowsAffected > 0) success = true;
                else success = false;
            }
            if (success) return Ok();
            else return Ok("未更新成功");
        }

        [HttpGet("appeallist")]
        public ActionResult appeallist([FromQuery] int TIME_ORDER, [FromQuery] int BEGIN_NUM, [FromQuery] int END_NUM)
        {
            string sql = @"WITH APPEAL_WITH_IMAGE AS(
               SELECT APPEAL.APP_ID, 
               APPEAL.APP_MATTERS,
               APPEAL.APP_CONTENT,
               APPEAL.USER_ID,
               APPEAL.COM_ID,
               APPEAL.CMT_ID,
               APPEAL.APP_USERID,
               APPEAL.APP_TIME,
               LISTAGG(SCREENSHOT.SCT_IMAGE, ';') WITHIN GROUP (ORDER BY SCREENSHOT.SCT_IMAGE) AS IMAGESET
                FROM APPEAL 
                LEFT JOIN SCREENSHOT ON APPEAL.APP_ID = SCREENSHOT.APP_ID
                GROUP BY APPEAL.APP_ID, 
                       APPEAL.APP_MATTERS,
                       APPEAL.APP_CONTENT,
                       APPEAL.USER_ID,
                       APPEAL.COM_ID,
                       APPEAL.CMT_ID,
                       APPEAL.APP_USERID,
                        APPEAL.APP_TIME
                ORDER BY APPEAL.APP_TIME " + (TIME_ORDER == 1 ? "ASC" : "DESC") + @" )
                SELECT * FROM(
                SELECT APPEAL_WITH_IMAGE.* ,commodity_comment.CMT_CONTENT,ROWNUM AS row_num
                FROM APPEAL_WITH_IMAGE 
                LEFT JOIN commodity_comment 
                ON APPEAL_WITH_IMAGE.CMT_ID = commodity_comment.CMT_ID)
                WHERE row_num >= :BEGIN_NUM and row_num <= :END_NUM";
            List<AppealModel> responseModel = new List<AppealModel>();
            using (OracleCommand selectCommand = new OracleCommand(sql, DBproject.DataBase.oracleCon.con))
            {
                selectCommand.Parameters.Add(new OracleParameter(":BEGIN_NUM", BEGIN_NUM));
                selectCommand.Parameters.Add(new OracleParameter(":END_NUM", END_NUM));
                AppealModel appealModel;
                using (OracleDataReader reader = selectCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Console.WriteLine(1);
                        appealModel = new AppealModel();
                        appealModel.APP_ID = reader.GetInt32("APP_ID");
                        appealModel.APP_TIME = reader.GetDateTime("APP_TIME").ToString("yyyy-MM-dd HH:mm:ss");
                        if (!reader.IsDBNull(reader.GetOrdinal("USER_ID")))
                        {
                            appealModel.USER_ID = reader.GetInt32("USER_ID");
                        }
                        if (!reader.IsDBNull(reader.GetOrdinal("IMAGESET")))
                        {
                            foreach (string image in reader.GetString("IMAGESET").Split(';'))
                            {
                                appealModel.SCT_IMAGE.Add(image);
                            }
                        }
                        if (!reader.IsDBNull(reader.GetOrdinal("COM_ID")))
                        {
                            appealModel.COM_ID = reader.GetInt32(reader.GetOrdinal("COM_ID"));
                        }
                        if (!reader.IsDBNull(reader.GetOrdinal("CMT_ID")))
                        {
                            appealModel.CMT_ID = reader.GetInt32(reader.GetOrdinal("CMT_ID"));
                        }
                        if (!reader.IsDBNull(reader.GetOrdinal("CMT_CONTENT")))
                        {
                            appealModel.CMT_CONTENT = reader.GetString(reader.GetOrdinal("CMT_CONTENT"));
                        }
                        if (!reader.IsDBNull(reader.GetOrdinal("APP_USERID")))
                        {
                            appealModel.APP_USERID = reader.GetInt32(reader.GetOrdinal("APP_USERID"));
                        }
                        appealModel.APP_MATTERS = reader.GetInt32(reader.GetOrdinal("APP_MATTERS"));
                        appealModel.APP_CONTENT = reader.GetString(reader.GetOrdinal("APP_CONTENT"));
                        responseModel.Add(appealModel);
                    }
                }
            }
            return Ok(JsonConvert.SerializeObject(responseModel));
        }
    }

    public class QueryModel
    {
        public int ID_ORDER { get; set; }
        public int NAME_ORDER { get; set; }
        public string USER_NAME { get; set; }
        public int USER_TYPE { get; set; }
        public int BEGIN_NUMBER { get; set; }
        public int END_NUMBER { get; set; }
    }

    public class UserModel
    {
        public int USER_ID { get; set; }
        public string USER_NAME { get; set; }
        public string USER_REGTIME { get; set; }
        public int USER_STATE { get; set; }
        public string STO_IMAGE { get; set; }
        public UserModel() { }
    }

    public class ChangeUserModel
    {
        public int USER_ID { get; set; }
        public int USER_TYPE { get; set; }
        public int TO_STATE { get; set; }
    }

    public class AppealModel
    {
        public int APP_ID { get; set; }
        public string APP_TIME { get; set; }
        public List<string> SCT_IMAGE { get; set; }
        public int USER_ID { get; set; }
        public int COM_ID { get; set; }
        public int CMT_ID { get; set; }
        public string CMT_CONTENT { get; set; }
        public int APP_USERID { get; set; }
        public int APP_MATTERS { get; set; }
        public string APP_CONTENT { get; set; }
        public AppealModel()
        {
            SCT_IMAGE = new List<string>();
            COM_ID = -1;
            CMT_ID = -1;
            USER_ID = -1;
            CMT_CONTENT = "null";
            APP_USERID = -1;
        }

    }
}