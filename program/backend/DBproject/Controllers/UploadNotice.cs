using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Globalization;
using System.IO;
using Newtonsoft.Json;
using static DBproject.Controllers.UploadCommodityController;

namespace DBproject.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UploadNoticeController : Controller
    {
        [HttpPost]
        public ActionResult uploadNotice([FromBody] NoticeModel noticeModel)
        {
            int NTC_ID = 0;
            using (OracleCommand selectComIDCommand = new OracleCommand("SELECT NTC_ID_SEQ.NEXTVAL FROM dual", DBproject.DataBase.oracleCon.con))
            {
                using (OracleDataReader reader = selectComIDCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        NTC_ID = reader.GetInt32(0);
                    }
                }
            }
            Console.WriteLine(NTC_ID);
            string insertCommodity = "insert into NOTICE(NTC_ID,NTC_TIME,NTC_CONTENT,NTC_STATE,STO_ID)" +
                    "values (:NTC_ID,sysdate,:NTC_CONTENT,:NTC_STATE,:STO_ID)";
            using (OracleCommand inserCommoditytCommand = new OracleCommand(insertCommodity, DBproject.DataBase.oracleCon.con))
            {
                Console.WriteLine(noticeModel.STO_ID);
                //inserCommoditytCommand.Parameters.Add(new OracleParameter(":STO_ID", noticeModel.STO_ID));
                inserCommoditytCommand.Parameters.Add(new OracleParameter(":NTC_ID", NTC_ID));
                //inserCommoditytCommand.Parameters.Add(new OracleParameter(":NTC_TIME", "sysdate"));
                inserCommoditytCommand.Parameters.Add(new OracleParameter(":NTC_CONTENT", noticeModel.NTC_CONTENT));
                inserCommoditytCommand.Parameters.Add(new OracleParameter(":NTC_STATE", 1));
                inserCommoditytCommand.Parameters.Add(new OracleParameter(":STO_ID", noticeModel.STO_ID));
                Console.WriteLine(noticeModel.NTC_CONTENT);
                inserCommoditytCommand.ExecuteNonQuery();
            }

            return Ok("插入成功");
        }

        public class NoticeModel
        {
            public int STO_ID { get; set; }
            public string NTC_CONTENT { get; set; }
        }


    }


}
