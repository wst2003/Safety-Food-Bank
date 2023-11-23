using Microsoft.AspNetCore.Mvc;
using System.Reflection;
using DBproject;
namespace WebApplication3.Controllers
{
    [Route("api/cus/[controller]")]
    [ApiController]
    public class HistoryController : Controller
    {
        [HttpPost("getBrowsingHistory")]
        [Consumes("application/json")]
        public IActionResult GetBrowsingHistory([FromBody] GetBrowsingHistoryModel model)
        {
            try
            {
                model.begin_pos += 1;
                model.end_pos += 1;
                Console.WriteLine("Get GetBrowsingHistory function");
                List<HistoryModel> list = DataBase.oracleCon.sqlSearchBrowseHistory(model);

                return StatusCode(200, new {com_list=list, total=list.Count});
            }
            catch (Exception ex)
            {
                Console.WriteLine("In GetBrowsingHistory function go wrong.");
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "发生错误" });
            }

        }

        [HttpPost("getBrowsingHistoryNumber")]
        [Consumes("application/json")]
        public IActionResult GetBrowsingHistoryNumber([FromBody] BrowserIDModel model)
        {
            try
            {
                Console.WriteLine("Get GetBrowsingHistoryNumber function");
                int num = DataBase.oracleCon.sqlSearchBrowseHistoryNumber(model.cus_id);

                return StatusCode(200, new { bro_num = num });
            }
            catch (Exception ex)
            {
                Console.WriteLine("In GetBrowsingHistoryNumber function go wrong.");
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "发生错误" });
            }

        }

        [HttpPost("setBrowsingHistory")]
        [Consumes("application/json")]
        public IActionResult SetBrowsingHistory([FromBody] BrowsingHistoryModel model)
        {
            var sql = $"Insert into BROWSE (BRO_TIME_START,BRO_TIME_END,COM_ID,BROWSER_ID,WHETHER_BUY) " +
                $"values ( TO_DATE('{model.bro_time_start}', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('{model.bro_time_end}', 'YYYY-MM-DD HH24:MI:SS'),{model.com_id},{model.browser_id},{model.whether_buy})";
            try
            {
                Console.WriteLine("Get into   SetBrowsingHistory function");
                int result = DataBase.oracleCon.sqlInsertSingleItem(sql);
                if (result == 1)
                    return StatusCode(200, new { msg = "插入浏览记录成功" });
                else
                    return StatusCode(200, new { msg = "插入浏览记录失败" });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "插入浏览记录失败" });
            }

        }
    }

    public class BrowsingHistoryModel
    {
        public string bro_time_start { get; set; } = "-1";
        public string bro_time_end { get; set; } = "-1";

        public int com_id { get; set; }

        public int browser_id { get; set; }

        public int whether_buy { get; set; }

    };
    public class HistoryModel
    {
        public int com_id { get; set; } = -1;
        public string com_name { get; set; } = "-1";
        public string com_introduction { get; set; } = "-1";
        public double com_oriPrice { get; set; } = -1;
        public string com_expirationDate { get; set; } = "0000-00-00";

        public string com_uploadDate { get; set; } = "0000-00-00";
        public int com_left { get; set; } = -1;
        public double com_rating { get; set; } = -1;
        public string sto_name { get; set; } = "-1";
        public double sto_id { get; set; } = 111;

        public List<string> com_categories { get; set; } = new List<string>();
        public string com_firstImage { get; set; } = "-1";
        public double com_price { get; set; } = 0;

        public int favor_state { get; set; } = 0;
        public int com_status { get; set; } = -2;//-1是过期，0是售罄，1是在售
        public string bro_time_end { get; set; } = "";
    };
    public class GetBrowsingHistoryModel
    {

        public int cus_id { get; set; }

        public int begin_pos { get; set; }

        public int end_pos { get; set; }

        public string search_str { get; set; }

    };
    public class BrowserIDModel
    {

        public int cus_id { get; set; }


    }

}
