using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;

namespace DBproject.Controllers
{
    [Route("api/pub/[controller]")]
    [ApiController]
    public class ModifyController : ControllerBase
    {
        [HttpPost("user")]
        [Consumes("application/json")]
        public IActionResult ModifyUserInfo([FromBody] NewUserInfo model)
        {
            ReturnModel result = new ReturnModel();
            try
            {
                // 调用DataBase.cs中的函数来更新用户信息
                string message = DataBase.oracleCon.UpdateUserInfo(model.user_ID, model.user_phone, model.user_password, model.user_address);
                result.message = message;
            }
            catch (Exception ex)
            {
                result.message = "发生错误：" + ex.Message;
            }

            return new JsonResult(result);
        }

        [HttpPost("customer")]
        [Consumes("application/json")]
        public IActionResult ModifyCusInfo([FromBody] NewCusInfo model)
        {
            ReturnModel returnModel = new ReturnModel();

            string message1 = DataBase.oracleCon.UpdateCustomerInfo(model.cus_ID, model.cus_nickname, model.cus_notes, model.cus_payPassword);
            string message2 = DataBase.oracleCon.EditCusLove(model.cus_ID, model.cus_category);
            if (message1 == "success" && message2 == "success")
                returnModel.message = "success";
            else
                returnModel.message = $"修改顾客基本信息:{message1};\n修改顾客喜好:{message2}";
            return new JsonResult(returnModel);
        }

        [HttpPost("store")]
        [Consumes("multipart/form-data")]
        public IActionResult ModifyStoInfo([FromForm] NewStoInfo model)
        {
            ReturnModel returnModel = new ReturnModel();
            try
            {
                string message1 = DataBase.oracleCon.UpdateStoInfo(model.sto_ID, model.sto_name, model.sto_introduction);
                string message2 = DataBase.oracleCon.EditStoCategories(model.sto_ID, model.categories);

                if (message1 == "success" && message2 == "success")
                {
                    if (model.sto_licenseImg != null && model.sto_licenseImg.Length > 0)
                    {
                        string uploadPath = ".\\wwwroot\\licenses";
                        if (!Directory.Exists(uploadPath))
                        {
                            Directory.CreateDirectory(uploadPath);
                        }
                        string fileExtension = Path.GetExtension(model.sto_licenseImg.FileName);
                        string newFileName = $"{model.sto_ID}_license{fileExtension}";
                        string filePath = Path.Combine(uploadPath, newFileName);
                        using (var stream = new FileStream(filePath, FileMode.Create))
                        {
                            model.sto_licenseImg.CopyTo(stream);
                        }
                    }

                    if (model.sto_picture != null && model.sto_picture.Count > 0)
                    {
                        List<string> fileURLs = new List<string>();
                        foreach (var pictureFile in model.sto_picture)
                        {
                            if (pictureFile != null && pictureFile.Length > 0)
                            {
                                string uploadPath = ".\\wwwroot\\store_image";
                                if (!Directory.Exists(uploadPath))
                                {
                                    Directory.CreateDirectory(uploadPath);
                                }
                                string fileExtension = Path.GetExtension(pictureFile.FileName);
                                string newFileName = $"{model.sto_ID}_picture_{Guid.NewGuid()}{fileExtension}";
                                string filePath = Path.Combine(uploadPath, newFileName);
                                using (var stream = new FileStream(filePath, FileMode.Create))
                                {
                                    pictureFile.CopyTo(stream);
                                }
                                fileURLs.Add($"store_image\\{newFileName}");
                            }
                        }

                        foreach (var url in fileURLs)
                        {
                            returnModel.message = DataBase.oracleCon.AddStoreImage(model.sto_ID, url);
                            if (returnModel.message != "success")
                            {
                                // Handle error
                                Console.WriteLine(returnModel.message);
                                return new JsonResult(returnModel);
                            }
                        }
                    }

                    returnModel.message = "success";
                }
                else
                {
                    returnModel.message = $"修改商家基本信息:{message1};\n修改商家主营类别:{message2}";
                }
            }
            catch (Exception ex)
            {
                returnModel.message = $"操作失败：{ex.Message}";
            }
            return new JsonResult(returnModel);
        }

        [HttpPost("delstoreimg")]
        [Consumes("application/json")]
        public IActionResult DelPicture([FromBody] DelImgModel model)
        {
            DelImgReModel returnmodel = new DelImgReModel();
            if (DataBase.oracleCon.DelStoImg(model.sto_ID, model.url))
            {
                returnmodel.message = "success";
            }
            else
            {
                returnmodel.message = "删除失败";
            }

            return new JsonResult(returnmodel);
        }

    }
    public class NewUserInfo
    {
        public string user_ID { get; set; }
        public string user_phone { get; set; }
        public string user_password { get; set; }
        public string user_address { get; set; }
    }
    public class NewCusInfo
    {
        public string cus_ID { get; set; }
        public string cus_nickname { get; set; }
        public string cus_notes { get; set; }
        public string cus_payPassword { get; set; }
        public List<string> cus_category { get; set; }
    }
    public class NewStoInfo
    {
        public string sto_ID { get; set; }
        public string sto_name { get; set; }
        public string sto_introduction { get; set; }
        public IFormFile? sto_licenseImg { get; set; }
        public List<string> categories { get; set; }
        public List<IFormFile>? sto_picture { get; set; }
    }
    public class ReturnModel
    {
        public string message { get; set; }
    }
    public class DelImgModel
    {
        public string sto_ID { get; set; }
        public string url { get; set; }
    }
    public class DelImgReModel
    {
        public string message { get; set; }
    }
}
