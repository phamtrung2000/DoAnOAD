using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic.CompilerServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using BUS;
using DTO;
namespace API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class VeController : ControllerBase
    {


        VeBUS bus = new VeBUS();
        //Get Thanh Vien
        [HttpGet]
        public DataTable Get()
        {

            return bus.LoadDSHoaDon();
        }
    }
}