using Microsoft.AspNetCore.Mvc;

namespace DBproject.Controllers
{
    [Route("api/pub/[controller]")]
    [ApiController]
    public class GetInformationController : ControllerBase
    {
        [HttpGet("user")]
        public IActionResult GetUserInfo([FromQuery] string user_ID)
        {
            UserInfo userInfo = DataBase.oracleCon.getUserInfo(user_ID);
            return new JsonResult(userInfo);
        }

        [HttpGet("customer")]
        public IActionResult GetCusInfo([FromQuery] string cus_ID)
        {
            CusInfo cusInfo = DataBase.oracleCon.GetCusInfoWithLoves(cus_ID);
            return new JsonResult(cusInfo);
        }

        [HttpGet("store")]
        public IActionResult GetStoInfo([FromQuery] string sto_ID)
        {
            StoInfo stoInfo = DataBase.oracleCon.GetStoInfoWithCategories(sto_ID);
            return new JsonResult(stoInfo);
        }

        [HttpGet("storeimg")]
        public IActionResult GetStoImgInfo([FromQuery] string sto_ID)
        {
            StoImg model = DataBase.oracleCon.GetStoImg(sto_ID);
            return new JsonResult(model);
        }
    }
    public class UserInfo
    {
        public string message { get; set; }
        public string user_ID { get; set; }
        public string user_phone { get; set; }
        public string user_password { get; set; }
        public string user_address { get; set; }
        public string user_balance { get; set; }
        public string user_regTime { get; set; }
        public string user_type { get; set; }
     }
    public class CusInfo
    {
        public string message { get; set; }
        public string cus_ID { get; set; }
        public string cus_nickname { get; set; }
        public string cus_notes { get; set; }
        public string cus_payPassword { get; set; }
        public string cus_state { get; set; }
        public List<string> cus_loves { get; set; }
    }
    public class StoInfo
    {
        public string message { get; set; }
        public string sto_ID { get; set; }
        public string sto_name { get; set; }
        public string sto_introduction { get; set; }
        public string sto_licenseImg { get; set; }
        public string sto_state { get; set; }
        public List<string> categories { get; set; }
    }
    public class StoImg
    {
       public List<string> imageURL { get; set; }
    }
}
