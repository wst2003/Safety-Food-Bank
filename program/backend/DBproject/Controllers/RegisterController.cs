using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Cors;
using System;

namespace DBproject.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class RegisterController : ControllerBase
    {
        [HttpPost()]
        [Consumes("application/json")]
        public IActionResult PostRegister([FromBody] RegisterModel model)
        {
            Console.WriteLine("注册信息如下:");
            Console.WriteLine("user_phone: " + model.user_phone);
            Console.WriteLine("user_password: " + model.user_password);
            Console.WriteLine("user_address: " + model.user_address);
            Console.WriteLine("user_type (0顾客1商家): " + model.user_type);

            string message = DataBase.oracleCon.RegisterUser(model.user_phone, model.user_password, model.user_address, model.user_type);
            RegisterReturnModel returnmodel = new RegisterReturnModel();
            if (message=="success")
            {
                returnmodel.user_ID = DataBase.oracleCon.GetNewUserID(model.user_phone);
                returnmodel.user_type = model.user_type;
                returnmodel.message = "success";
            }
            else
            {
                returnmodel.user_ID = "0000000";
                returnmodel.user_type = model.user_type;
                returnmodel.message = message;
            }
            return new JsonResult(returnmodel);
        }


        [HttpPost("store")]
        [Consumes("multipart/form-data")]
        public IActionResult PostStoreRegister([FromForm] RegisterStoreModel model)
        {
            RegisterStoreReturnModel returnmodel = new RegisterStoreReturnModel();
            try
            {
                // 使用 model 对象中的属性来访问表单数据
                Console.WriteLine("接收到商家基本信息如下：");
                Console.WriteLine("sto_ID：" + model.sto_ID);
                Console.WriteLine("sto_name：" + model.sto_name);
                Console.WriteLine("sto_introduction：" + model.sto_introduction);
                Console.WriteLine("sto_licenseImage名称：" + model.sto_licenseImage.FileName);
                if (model.com_categories != null && model.com_categories.Count > 0)
                {
                    Console.WriteLine("com_categories:");
                    foreach (string category in model.com_categories)
                    {
                        Console.WriteLine(category);
                    }
                }

                // 判断sto_licenseImage文件格式是否正确
                string fileExtension = Path.GetExtension(model.sto_licenseImage.FileName);
                if (fileExtension != ".jpg" && fileExtension != ".png" && fileExtension != ".gif")
                {
                    returnmodel.message = "图片格式不正确";
                    Console.WriteLine(returnmodel.message);
                    return new JsonResult(returnmodel);
                }

                string uploadPath = ".\\wwwroot\\licenses";
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }
                string newFileName = model.sto_ID + "_license" + fileExtension;
                string filePath = Path.Combine(uploadPath, newFileName);
                string fileURL = "licenses\\" + newFileName;

                returnmodel.message = DataBase.oracleCon.RegisterSto(model.sto_ID, model.sto_name, model.sto_introduction, fileURL);
                if (returnmodel.message != "success")
                {
                    if (returnmodel.message.Contains("违反唯一约束条件") && returnmodel.message.Contains("STORE_PK"))
                    {
                        returnmodel.message = "商家已经存在，无法重新创建";
                    }
                    Console.WriteLine(returnmodel.message);
                    return new JsonResult(returnmodel);
                }


                // 将商家执照保存到指定路径
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    model.sto_licenseImage.CopyTo(stream);
                }

                // 处理商家图片
                List<string> fileURLs = new List<string>();
                foreach (var pictureFile in model.sto_picture)
                {
                    string pictureFileExtension = Path.GetExtension(pictureFile.FileName);
                    if (pictureFileExtension != ".jpg" && pictureFileExtension != ".png" && pictureFileExtension != ".gif")
                    {
                        returnmodel.message = "图片格式不正确";
                        Console.WriteLine(returnmodel.message);
                        return new JsonResult(returnmodel);
                    }

                    string uploadPath1 = ".\\wwwroot\\store_image";
                    if (!Directory.Exists(uploadPath1))
                    {
                        Directory.CreateDirectory(uploadPath1);
                    }
                    string newFileName1 = $"{model.sto_ID}_picture_{Guid.NewGuid()}{pictureFileExtension}";
                    string filePath1 = Path.Combine(uploadPath1, newFileName1);
                    string fileURL1 = $"store_image\\{newFileName1}";
                    fileURLs.Add(fileURL1);

                    using (var stream = new FileStream(filePath1, FileMode.Create))
                    {
                        pictureFile.CopyTo(stream);
                    }
                }
                
                // 添加商家图片
                foreach (var url in fileURLs)
                {
                    returnmodel.message = DataBase.oracleCon.AddStoreImage(model.sto_ID, url);
                    if (returnmodel.message != "success")
                    {
                        // Handle error
                        Console.WriteLine(returnmodel.message);
                        return new JsonResult(returnmodel);
                    }
                }

                returnmodel.message = DataBase.oracleCon.EditStoCategories(model.sto_ID, model.com_categories);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"图片处理失败：{ex.Message}");
                returnmodel.message = $"图片处理失败：{ex.Message}";
            }
            return new JsonResult(returnmodel);
        }


        [HttpPost("customer")]
        [Consumes("application/json")]
        public IActionResult PostCustomerRegister([FromBody] RegisterCustomerModel model)
        {
            Console.WriteLine("Received customer data:");
            Console.WriteLine($"cus_ID: {model.cus_ID}");
            Console.WriteLine($"cus_nickname: {model.cus_nickname}");
            Console.WriteLine($"cus_notes: {model.cus_notes}");
            Console.WriteLine($"cus_payPassword: {model.cus_payPassword}");
            if (model.cus_category != null && model.cus_category.Count > 0)
            {
                Console.WriteLine("cus_category:");
                foreach (string category in model.cus_category)
                {
                    Console.WriteLine(category);
                }
            }

            RegisterCustomerReturnModel returnmodel = new RegisterCustomerReturnModel();
            returnmodel.message = DataBase.oracleCon.RegisterCus(model.cus_ID, model.cus_nickname, model.cus_notes, model.cus_payPassword);
            if (returnmodel.message == "success")
            {
                Console.WriteLine("顾客注册成功");
                returnmodel.message = DataBase.oracleCon.EditCusLove(model.cus_ID, model.cus_category);
            }
            return new JsonResult(returnmodel);
        }

    }
    public class RegisterModel
    {
        public string user_phone { get; set; }
        public string user_password { get; set; }
        public string user_address { get; set; }
        public string user_type { get; set; }
    }
    public class RegisterReturnModel
    {
        public string user_ID { get; set; } 
        public string user_type { get; set; }
        public string message { get; set; }
    }
    public class RegisterStoreModel
    {
        public string sto_ID { get; set; }
        public string sto_name { get; set; }
        public string sto_introduction { get; set; }
        public IFormFile sto_licenseImage { get; set; }
        public List<string> com_categories { get;set; }
        public List<IFormFile> sto_picture { get; set; }
    }
    public class RegisterStoreReturnModel
    {
        public string message { get; set; } 
    }
    public class RegisterCustomerModel
    {
        public string cus_ID { get; set; }
        public string cus_nickname { get; set; }//个人昵称
        public string cus_notes { get; set; }//个人备注
        public string cus_payPassword { get; set; }//支付密码
        public List<string> cus_category { get; set; } // 客户类别列表
    }
    public class RegisterCustomerReturnModel
    {
        public string message { get; set; }
    }
}
