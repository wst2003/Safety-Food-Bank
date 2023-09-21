using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System;
using DBproject;
namespace WebApplication3.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CommodityController : Controller
    {

        //返回商品的详细信息，用于展示商品详情
        [HttpGet("detail")]
        [Consumes("application/json")]
        public IActionResult GetCommodityDetail(int com_id,int cus_id)
        {
            try {
                Console.WriteLine("Get into  GetCommodityDetail function");
                return StatusCode(200, (DataBase.oracleCon.sqlSearchCommodityByID(com_id, cus_id)));
            }
            catch (Exception ex) {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = ex });
            }

        }
        [HttpPost("comment")]
        [Consumes("application/json")]
        public IActionResult PostComment([FromBody] CommentModel model)
        {
            DateTime currentTime = DateTime.Now;
            var sql = $"Insert into COMMODITY_COMMENT(CMT_ID, CMT_FATHER, CMT_CONTENT, CMT_TIME, COM_ID, USER_ID) " +
                $"values(COMMENT_ID_SEQ.NEXTVAL, {model.cmt_father}, '{model.cmt_content}',TO_DATE('{currentTime.ToString("yyyy-MM-dd HH:mm:ss")}','yyyy-MM-dd HH24:mi:ss'),{model.com_id}, {model.user_id})";
            try
            {
                Console.WriteLine("Get into  PostComment function");
                SendCommentModel result = DataBase.oracleCon.sqlGetSingleCmt(model);            
                return StatusCode(200, new { msg = "评论发布成功",comment=result });
      
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "上传失败" });
            }

        }
        [HttpPost("shoppingCart")]
        [Consumes("application/json")]
        public IActionResult ShoppingCart([FromBody] ShoppingCartModel model)
        {
            var list = new List<CommodityListModel>();
            try
            {
                Console.WriteLine("Get into ShoppingCart function");
                foreach (int com_id in model.com_id_arr)
                {
                    Console.WriteLine($"com_id:{com_id}");
                    list.Add(DataBase.oracleCon.sqlSearchShoppingCart(com_id, model.cus_id));
                }
                return StatusCode(200, new { com_list = list });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "上传失败" });
            }

        }
        [HttpGet("getCurve")]
        [Consumes("application/json")]
        public IActionResult GetCommodityPcCurve(int com_id)
        {
            try
            {
                Console.WriteLine("Get into  GetCommodityPcCurve function");
                return StatusCode(200, new { com_prices = DataBase.oracleCon.sqlGetCommodityCurrPriceCurve(com_id)});
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = ex });
            }

        }
        public class ShoppingCartModel{
            public List<int> com_id_arr { get; set; } 

            public int cus_id { get; set; }

        }

        //返回商品的详情，用于展示商品详情
        public class CommodityDetailModel
        {
            //private string _com_expirationDate = "0000-00-00";
            //需要分离写，不然会重复调用，需要写一个  _变量 来存 变量的值
            //private static int defaultValueCom_Id = -1;
            //日期字符串和日期对象，日期字符串转为日期对象：DateTime.parse(string s)
            // 日期对象转为日期字符串：date.ToString("yyyy-mm-dd")
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
            //不知是否需要一个数据结构
            public List<string> com_images { get; set; } = new List<string>();

            public  double com_price { get; set; }
            public List<PriceCurveModel> com_prices { get; set; } = new List<PriceCurveModel>();

            public List<SendCommentModel> comments { get; set; }= new List<SendCommentModel>();

            public int favor_state { get; set; } = -1;

           
            public bool MyIsNull() { return com_id == -1; }
            public int com_status { get; set; } = -2;//-1是过期，0是售罄，1是在售
        };

        public class PriceCurveModel
        {

            public string com_pc_time { get; set; } = "-1";

            public double com_pc_price { get; set; }=-1;
        }


        public class CommentModel
        {

            //public int cmt_id { get; set; }
            public int user_id { get; set;}

            public string cmt_content { get; set; }

            public int cmt_father { get; set; }

            public int com_id { get; set; }

 
        }
        public class SendCommentModel
        {

            public int cmt_id { get; set; } = -1;

            public int cmt_father { get; set; }
            public string cmt_content { get; set; }
            public string cmt_time { get; set; }
            public string cmt_name { get; set; }
            public int user_id { get; set; }

            public int user_type { get; set; }
            public int buying_times { get; set; } = 0;

            public int com_id { get; set; }
        }
    }
}
