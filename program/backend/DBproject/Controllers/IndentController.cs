using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System;
using DBproject;
using static WebApplication3.Controllers.CommodityController;
using static WebApplication3.Controllers.FavoriteController;
using System.Reflection.Metadata;

namespace WebApplication3.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IndentController : Controller
    {

        //返回商品的详细信息，用于展示商品详情
        [HttpPost("generateIndent")]
        [Consumes("application/json")]
        public IActionResult GenerateIndent([FromBody]SetIndentModel model)
        {
            try
            {
                Console.WriteLine("Get into  GenerateIndent function");
                DataBase.oracleCon.sqlSetIndent(model);
                return StatusCode(200, new { msg = "插入成功" });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = ex });
            }

        }

        [HttpPost("evaluation")]
        [Consumes("application/json")]
        public IActionResult Evaluation([FromBody] EvaluationModel model)
        {
            try
            {
                Console.WriteLine("Get into  GenerateIndent function");
                DataBase.oracleCon.sqlIndentEvaluation(model);
                return StatusCode(200, new { msg = "插入成功" });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = ex });
            }

        }


        [HttpPost("refund")]
        [Consumes("application/json")]
        public IActionResult Refund([FromBody] GetRefundModel model)
        {
           try
            {
                 Console.WriteLine("Get into  Refund function");
                return StatusCode(200, DataBase.oracleCon.sqlRefund(model));
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = "退款失败" });
            }

        }

       
        [HttpPost("getIndentList")]
      
        public IActionResult GetIndentList([FromBody]GetIndentModel model)
        {
            try
            {
                Console.WriteLine("Get into  GetIndentList function");
                
                var list = DataBase.oracleCon.sqlGetIndet(model);

                int total=list.Count();

                int len = 0;

                if (list.Count > model.end_pos)
                    len = model.end_pos - model.begin_pos;
                else
                    len = list.Count - model.begin_pos;

                var subList = list.GetRange(model.begin_pos, len);              
                return StatusCode(200, new {element_arr=subList,total=total });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return StatusCode(200, new { msg = ex });
            }

        }
        public class SetIndentModel
        {
            public int cus_id { get; set; }
           
            public List<IndentArrModel> indent_arr { get; set; }=new List<IndentArrModel>();    
        }
        public class IndentArrModel
        {
            public int sto_id { get; set; }

            public string ind_notes { get; set; } = " ";

            public List<ComArrModel> com_arr { get; set; } = new List<ComArrModel>();

        }

        public class ComArrModel
        {
            public int com_id { get; set; }
            public int ind_quantity { get; set; }

            public double ind_money { get; set; }

        }

        public class RefundModel
        {
            public double price_return { get; set; }

            public double balance { get; set; }

        }

        public class GetRefundModel
        {
            public int ind_ID { get; set; }

            public string ind_rnotes { get; set; }

        }
        public class GetIndentModel
        {
            public int cus_id { get; set; }

            public int ind_state { get; set; } = -1;

            public string search_str { get; set; } = "";

            public int sort_order { get; set; }
          
            public int begin_pos { get; set; }

            public int end_pos { get; set;}


        }

        public class IndentModel
        {
            public int ind_ID { get; set; }

            public string ind_quantity { get; set; } = "";

            public double ind_money { get; set;}

            public int ind_rating{ get; set;}

            public int com_ID { get; set; }

            public string ind_rtime { get; set; } = "";

            public string ind_rnotes {get; set; } = "";

            public double ind_rmoney { get; set; }

            public string com_firstImg { get; set; } = "";

            public string com_name { get; set; } = "";

            public string ind_creationTime { get; set; } = "";

            public string ind_verificationCode { get; set; } = "";

            public string ind_notes { get; set; } = "";


            public int sto_id { get; set; }

            public string sto_name { get; set; } = "";
        }

        public class EleModel
        {
            public List<IndentModel> indent_arr { get; set; }=new List<IndentModel>();

            public string ind_creationTime { get; set; }

            public string ind_verificationCode { get; set; }

            public string  ind_notes { get; set; }

            public int sto_id { get; set; }

            public string sto_name { get; set; } = "";
        }

        public class EvaluationModel
        {
            public int ind_id { get; set; }
            public string cmt_content{ get; set; }

            public double ind_rating { get; set; }


        }
    }
}
