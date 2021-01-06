using API.BUS;
using API.DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic.CompilerServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class AccountController:ControllerBase
    {
        [HttpGet]
        public DataTable Get()
        {
            NhanVien_Bus account_BUS = new NhanVien_Bus();
            return account_BUS.GetAllAccount();
        }
      
      
    }
}
