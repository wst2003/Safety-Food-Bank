using DBproject.Algorithms;
using Microsoft.AspNet.SignalR.Infrastructure;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using Oracle.ManagedDataAccess.Types;
using System.Data;
using System.Diagnostics;

namespace DBproject.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecommendationController : ControllerBase
    {
        [HttpPost()]
        [Consumes("application/json")]
        public IActionResult test([FromBody] RecommendationModel model)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start(); // 开始计时

            ItemCFRecommendation itemCFRecommendation = new ItemCFRecommendation();

            if (int.TryParse(model.user_id, out int userId))
            {
                List<int> items = itemCFRecommendation.RecommendItems(userId);

                string directoryPath = ".\\wwwroot\\ItemCF";
                if (!Directory.Exists(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }
                string filePath = Path.Combine(directoryPath, $"{userId}.txt");
                using (StreamWriter writer = new StreamWriter(filePath))
                {
                    foreach (int item in items)
                    {
                        writer.WriteLine(item);
                    }
                }
            }
            else
            {
                Console.WriteLine("无效的用户 ID");
            }

            TimeSpan elapsed = stopwatch.Elapsed;
            Console.WriteLine($"函数执行时间：{elapsed.TotalMilliseconds} 毫秒");

            return Ok();
        }
    }
    public class RecommendationModel
    {
        public string user_id { get; set; }
    }

}
