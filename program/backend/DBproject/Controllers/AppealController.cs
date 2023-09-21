using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;
using System.Collections.Generic;
using System.Xml.Linq;
using DBproject;
namespace WebApplication3.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AppealController : Controller
    {

        //用于接收调整商品收藏状态请求
        [HttpPost("createAppeal")]
        [Consumes("application/json")]
        public IActionResult CreateAppeal([FromBody] GetAppealModel model)
        {
            try
            {
                DataBase.oracleCon.sqlCreateAppeal(model);
                return StatusCode(200, new { msg = "插入申诉成功" });
            }
            catch (Exception ex)
            {
             
                Console.WriteLine(ex.ToString());
                return StatusCode(200, new { msg = "插入申诉错误" });
            }

        }


     
        public class GetAppealModel
        {
            /*
             - 商品信息不实1、食品安全问题2(订单和商品详情页的申诉按钮)
            - 商家资质不全3（商家详情页）
            - 恶意评论4（评论区）
            */
            public int app_matters { get ; set; }   
            public string app_content { get; set; }
            public int app_userID { get; set;}

            public int user_ID { get; set; }
            public int com_ID { get; set; }

            public int cmt_ID { get; set; }

      
            public List<string> sct_images { get; set; }
        }
            
    }
}







