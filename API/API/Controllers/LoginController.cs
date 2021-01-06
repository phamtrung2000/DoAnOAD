using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using API.BUS;
using API.DTO;
using API.DAL;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic.CompilerServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using DAO;
using BUS;
using DTO;
namespace API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        [HttpPost]
        public string Login([FromBody] DangNhapKhachHangDTO kh)
        {
            DangNhapKhachHangBUS busLogin = new DangNhapKhachHangBUS();
            return busLogin.Login(kh.TAIKHOAN,kh.MATKHAU);
        }
    }
}