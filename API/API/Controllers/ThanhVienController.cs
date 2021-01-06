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
    public class ThanhVienController : ControllerBase
    {

       
        BUS_TV bus = new BUS_TV();
        //Get Thanh Vien
        [HttpGet]
        public DataTable Get()
        {

            return bus.GetThanhVien();
        }
        //Search Thanh Vien
        [Route("SearchTV/{ID}")]
        [HttpGet]
        public DataTable SearchByID(int ID)
        {
            return bus.SearchTV(ID);
        }
        //Them Thanh vien
        [Route("AddTV")]
        [HttpPost]
        public bool AddThanhVien([FromBody] DTO_ThanhVien TV)
        {
            return bus.themThanhVien(TV);
        }

        [Route("DeleteTV/{ID}")]
        [HttpDelete]
         public bool DeleteThanhVien(int ID)
        {
            return bus.xoaThanhVien(ID);
        }

        [Route("UpdateTV")]
        [HttpPut]
        public bool UpdateThanhVien([FromBody] DTO_ThanhVien TV)
        {
            return bus.suaThanhVien(TV);
        }
    }
}
