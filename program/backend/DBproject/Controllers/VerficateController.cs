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
    public class VerficateController : Controller
    {
        [HttpPost("")]
        public ActionResult indentVerficate([FromQuery]string IND_VERFICATIONCODE)
        {
            string selectSQL = @"select indent.CUS_ID,indent.IND_ID,indent.COM_ID,commodity.COM_NAME,indent.IND_QUANTITY
                                    from indent join commodity on INDENT.COM_ID = commodity.COM_ID
                                    where indent.IND_STATE = 0 AND indent.IND_VERIFICATIONCODE = :IND_VERFICATIONCODE AND commodity.com_status!=-1";
            ResponseModel responseModel = new ResponseModel();
            using (OracleCommand selectCommand = new OracleCommand(selectSQL, DBproject.DataBase.oracleCon.con))
            {
                selectCommand.Parameters.Add(new OracleParameter(":IND_VERFICATIONCODE", IND_VERFICATIONCODE));
                using (OracleDataReader reader = selectCommand.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        responseModel.CUS_ID = reader.GetInt32("CUS_ID");
                        ResponseModel.List list = new ResponseModel.List();
                        list.IND_ID = reader.GetInt32("IND_ID");
                        list.COM_ID = reader.GetInt32("COM_ID");
                        list.COM_NAME = reader.GetString("COM_NAME");
                        list.IND_QUANTITY = reader.GetInt32("IND_QUANTITY");
                        responseModel.LIST.Add(list);
                    }
                }
            }
            string updateSQL = @"update indent 
                                    set IND_STATE = 1  
                                    where IND_ID IN(
                                    select indent.IND_ID
                                    from indent join commodity on INDENT.COM_ID = commodity.COM_ID
                                    where indent.IND_STATE = 0 AND indent.IND_VERIFICATIONCODE = :IND_VERFICATIONCODE AND commodity.com_status!=-1)";
            using (OracleCommand updateCommand = new OracleCommand(updateSQL, DBproject.DataBase.oracleCon.con))
            {
                updateCommand.Parameters.Add(new OracleParameter(":IND_VERFICATIONCODE", IND_VERFICATIONCODE));
                int rowsUpdated = updateCommand.ExecuteNonQuery();
                Console.WriteLine(IND_VERFICATIONCODE);
                if(rowsUpdated > 0)
                {
                    string response = JsonConvert.SerializeObject(responseModel);
                    Console.WriteLine("核销条目：" + response);
                    return Ok(response);
                }
            }
            return Ok("核销失败");
            
        }
    }

    public class ResponseModel
    {
        public int CUS_ID { get; set; }
        public List<ResponseModel.List> LIST { get; set; }
        public ResponseModel() { LIST = new List<ResponseModel.List>(); }
        public class List
        {
            public int IND_ID { get; set; }
            public int COM_ID { get; set; }
            public string COM_NAME { get; set; }
            public int IND_QUANTITY { get; set; }

            public List() { COM_NAME = ""; }
        }
    }
}
