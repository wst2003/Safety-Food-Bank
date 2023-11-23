using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Converters;

namespace DBproject.Controllers
{

    [Route("api/pub/[controller]")]
    [ApiController]
    public class RechargeController : ControllerBase
    {
        [HttpPost()]
        [Consumes("application/json")]
        public IActionResult RechargeMoney([FromBody] RechargeModel model)
        {
            RechargeReturnModel returnmodel = new RechargeReturnModel();
            if (!DataBase.oracleCon.IsUserExist(model.user_ID))
            {
                returnmodel.message = "用户不存在";
                return new JsonResult(returnmodel);
            }
            if (DataBase.oracleCon.RechargeMoney(model.user_ID, model.amount))
            {
                returnmodel.message = "success";
            }
            else
            {
                returnmodel.message = "数据库操作原因，插入失败";
            }
            return new JsonResult(returnmodel);
        }
    }
    public class RechargeModel
    {
        public string user_ID { get; set; }
        public string amount { get; set; }
    }
    public class RechargeReturnModel
    {
        public string message { get; set; }
    }
}
