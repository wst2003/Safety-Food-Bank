using Microsoft.AspNetCore.Mvc;

namespace DBproject.Controllers
{  
    [Route("api/[controller]")]
    [ApiController]
    public class UploadChatImageController:ControllerBase
    {
        [HttpPost()]
        [Consumes("multipart/form-data")]
        public IActionResult uploadImage([FromForm] UploadChatImageModel model)
        {
            UploadChatImageReturnModel returnmodel = new UploadChatImageReturnModel();
            if (model.image == null || model.image.Length == 0)
            {
                returnmodel.message = "请选择要上传的图片";
                return new JsonResult(returnmodel);
            }
            Console.WriteLine("上传图片名称为:" + model.image.FileName);
            try
            {
                string fileExtension = Path.GetExtension(model.image.FileName);
                if (fileExtension != ".jpg" && fileExtension != ".png" && fileExtension != ".gif")
                {
                    returnmodel.message = "图片格式不正确";
                    Console.WriteLine(returnmodel.message);
                    return new JsonResult(returnmodel);
                }
                string uploadPath = ".\\wwwroot\\chat_image";
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }
                string newFileName = Guid.NewGuid().ToString() + fileExtension;  
                string filePath = Path.Combine(uploadPath, newFileName);
                Console.WriteLine("filePath：" + filePath);
                string fileURL = "chat_image\\" + newFileName;
                returnmodel.url = fileURL;
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    model.image.CopyTo(stream);
                    returnmodel.message = "success";
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine($"图片处理失败：{ex.Message}");
                returnmodel.message = $"图片处理失败：{ex.Message}";
                return new JsonResult(returnmodel);
            }
            return new JsonResult(returnmodel);
        }
    }
    public class UploadChatImageModel
        {
            public IFormFile? image { get; set; }
        }

    public class UploadChatImageReturnModel
    {
        public string message { get; set; }
        public string url { get; set; }
    }
}
