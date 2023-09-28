using Microsoft.AspNetCore.Mvc;
using DBproject;
namespace WebApplication3.Controllers
{
    [Route("api/cus/[controller]")]
    [ApiController]
    public class StoreController : Controller
    {

        //用于获取商家的详细信息，用于商家详情展示页面
        [HttpGet("detail")]
        [Consumes("application/json")]
        public IActionResult GetStoreDetail(int sto_id,int cus_id)
        {
            
            try
            {
                int data = sto_id;
                Console.WriteLine("Get into  GetStoreDetail function");
                return StatusCode(200, (DataBase.oracleCon.sqlSearchStoreByID(data, cus_id)));
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = ex });
            }
        }
        public class StoreDetailModel
        {
            //private string _com_expirationDate = "0000-00-00";
            //需要分离写，不然会重复调用，需要写一个  _变量 来存 变量的值
            //private static int defaultValueCom_Id = -1;
            //日期字符串和日期对象，日期字符串转为日期对象：DateTime.parse(string s)
            // 日期对象转为日期字符串：date.ToString("yyyy-mm-dd")
            public double sto_id { get; set; } = 111;
            public string sto_introduction { get; set; } = "-1";

            public string sto_name { get; set; } = "-1";

            public List<string> com_categories { get; set; } = new List<string>();


            public string user_address { get; set; } = "-1";

            public string sto_licenseImg { get; set; } = "-1";


            public List<string> sto_imageList { get; set; } = new List<string>();

            public List<NoticeModel> sto_notice { get; set; } = new List<NoticeModel>();

            public List<SubCommodityListModel> com_list { get; set; } = new List<SubCommodityListModel>();
            

            public string notice { get; set; } = "-1";

        };

        public class NoticeModel
        { 
            public string ntc_time { get; set; }

            public string ntc_content { get; set; }
        }
    }
}
