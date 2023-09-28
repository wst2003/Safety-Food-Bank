using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;
using System.Collections.Generic;
using System.Xml.Linq;
using DBproject;
namespace WebApplication3.Controllers
{
    [Route("api/cus/[controller]")]
    [ApiController]
    public class BalanceController : Controller
    {

        //用于接收调整商品收藏状态请求
        [HttpPost("setBalance")]
        [Consumes("application/json")]
        public IActionResult SetBalance([FromBody] BalanceModel model)
        {
            try
            {
                Console.WriteLine("Get GetBalance function");
                DataBase.oracleCon.sqlSetBalance(model.cus_id, model.balance);

                return StatusCode(200, new { msg = "修改成功" });
            }
            catch (Exception ex)
            {
                Console.WriteLine("In  GetBalance function go wrong.");
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "发生错误" });
            }

        }


        [HttpGet("getBalance")]
        [Consumes("application/json")]
        public IActionResult GetBalance([FromQuery] int cus_id)
        {
            Console.WriteLine(cus_id);

            try
            {
                Console.WriteLine("Get GetBalance function");


                return StatusCode(200, new { balance = DataBase.oracleCon.sqlGetBlance(cus_id) });
            }
            catch (Exception ex)
            {
                Console.WriteLine("In GetFavorCommodity function go wrong.");
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "发生错误" });
            }

        }

        public class BalanceModel
        {
            public int cus_id { get; set; }

        public double balance { get; set; }
    }
}
}
    





