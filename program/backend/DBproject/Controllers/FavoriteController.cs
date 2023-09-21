using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;
using System.Collections.Generic;
using System.Xml.Linq;
using DBproject;
namespace WebApplication3.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FavoriteController : Controller
    {

        //用于接收调整商品收藏状态请求
        [HttpPost("setFavorState")]
        [Consumes("application/json")]
        public IActionResult SetFavorState([FromBody] FavorStateModel model)
        {
            var sqlQuery = $"SELECT * FROM FAVORITE WHERE COM_ID = {model.com_id} AND CUS_ID ={model.cus_id}";
            var sqlInsert = $"INSERT INTO FAVORITE(COM_ID, CUS_ID) VALUES({model.com_id},{model.cus_id})";
            var sqlDele = $"DELETE FROM FAVORITE WHERE COM_ID = {model.com_id} AND CUS_ID ={model.cus_id}";
            var sqlList = new List<string>();
            sqlList.Add(sqlInsert);
            sqlList.Add(sqlDele);
            sqlList.Add(sqlQuery);

            try
            {
                Console.WriteLine("Get into SetFavorState function");
                int last_favor_state = DataBase.oracleCon.sqlSetFavorState(sqlList);
                if (last_favor_state != model.favor_state)
                {
                    Console.WriteLine("In SetFavorState function go wrong.");
                }
                var my_msg = last_favor_state == 0 ? "已收藏" : "已经取消收藏";
                return StatusCode(200, new { msg = my_msg });
            }
            catch (Exception ex)
            {
                Console.WriteLine("In SetFavorState function go wrong.");
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "发生错误" });
            }

        }


        [HttpGet("getFavor")]
        [Consumes("application/json")]
        public IActionResult GetFavorCommodity([FromQuery] StateModel model)
        {
            Console.WriteLine(model.cus_id);

            try
            {
                Console.WriteLine("Get intoGetFavorCommodity function");
                List<CommodityListModel> list = DataBase.oracleCon.sqlSearchFavorCommodity(model.cus_id);

                return StatusCode(200, new { favor_list = list });
            }
            catch (Exception ex)
            {
                Console.WriteLine("In GetFavorCommodity function go wrong.");
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "发生错误" });
            }

        }
    }



    //用于接收收藏状态改变请求的参数
    public class FavorStateModel
    {
        public int com_id { get; set; } = -1;

        public int cus_id { get; set; } = -1;

        public int favor_state { get; set; } = 0;
    }
    public class StateModel
    {
     

        public int cus_id { get; set; } = -1;

     
    }
}

