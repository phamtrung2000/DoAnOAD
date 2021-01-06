using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
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
    public class PhieuTraController
    {
        BUS_PT bus = new BUS_PT();
        [Route("AddPT")]
        [HttpPost]
        public bool AddPT([FromBody] DTO_PhieuTra PT)
        {
            return bus.addPT(PT);
        }

        [Route("GetPT/{ID}")]
        [HttpGet]
        public DataTable GetPT(int ID)
        {
            return bus.GetPT(ID.ToString());
        }
    }
}
