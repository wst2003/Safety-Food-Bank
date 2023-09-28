using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Cors;
using System;


namespace DBproject.Controllers
{
    [Route("api/pub/[controller]")]
    [ApiController]
    public class ResetpasswordController : ControllerBase
    {
        [HttpPost("sendnewpassword")]
        [Consumes("application/json")]
        public IActionResult ResetPost([FromBody] ResetModel model)
        {
            Console.WriteLine("修改信息如下");
            Console.WriteLine("user_phonenumber:" + model.user_phonenumber);
            Console.WriteLine("user_new_password:" + model.user_new_password);
            string message = DataBase.oracleCon.ResetPassword(model.user_phonenumber, model.user_new_password);

            ResetReturnModel returnmodel = new ResetReturnModel();
            returnmodel.message = message;

            return new JsonResult(returnmodel);
        }

        [HttpPost("verify")]
        [Consumes("application/json")]
        public IActionResult VerifyPhone([FromBody] VerifyModel model)
        {
            Console.WriteLine("需要检查是否存在的手机号码如下：");
            Console.WriteLine("user_phone：" + model.user_phone);
            ResetReturnModel returnmodel = new ResetReturnModel();
            if( DataBase.oracleCon.IsUserPhoneExist(model.user_phone))
            {
                returnmodel.message = "success";
            }
            else
            {
                returnmodel.message = "电话号码不存在";
            }
            return new JsonResult (returnmodel);
        }
    }

    public class ResetModel
    {
        public string user_phonenumber { get; set; }
        public string user_new_password { get; set; }
    }
    public class VerifyModel
    {
        public string user_phone { get; set; }
    }
    public class ResetReturnModel
    {
        public string message { get; set; }
    }
}
