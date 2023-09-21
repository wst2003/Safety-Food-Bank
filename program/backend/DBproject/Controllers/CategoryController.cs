

using Microsoft.AspNetCore.Mvc;

namespace DBproject.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryController :ControllerBase
    {
        [HttpGet("getcategories")]
        [Consumes("application/json")]
        public IActionResult GetALLCategory()
        {
            CategoriesReModel returnmodel = new CategoriesReModel();
            returnmodel.categorylist = DataBase.oracleCon.GetAllLoves();
            return new JsonResult(returnmodel);
        }
    }
    public class CategoriesReModel
    {
        public List<string> categorylist { get; set; }
    }
}
