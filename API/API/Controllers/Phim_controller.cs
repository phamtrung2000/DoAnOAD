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
using DAO;
using BUS;
using DTO;
namespace API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PhimController : ControllerBase
    {
        PhimBUS bus = new PhimBUS();
        //Get Thanh Vien
        [HttpGet]
        public DataTable Get()
        {

            return bus.LoadDSPhim();
        }
        //Search Thanh Vien
        [Route("SearchPHIM/{Name}")]
        [HttpGet]
        public DataTable SearchByName(string Name)
        {
            return bus.TimTheoTenPhim(Name);
        }
        [Route("SearchPHIMID/{ID}")]
        [HttpGet]
        public DataTable SearchByID(string ID)
        {
            return bus.TimTheoMaP(ID);
        }
        //Them Thanh vien
        [Route("AddPHIM")]
        [HttpPost]
        public void AddThanhVien([FromBody] PhimDTO phim)
        {
            bus.Them(phim);
        }

        [Route("DeletePHIM/{ID}")]
        [HttpDelete]
        public void DeleteThanhVien(string ID)
        {
            bus.Xoa(ID);
        }

        [Route("UpdatePHIM")]
        [HttpPut]
        public void UpdateThanhVien([FromBody] PhimDTO phim)
        {
            bus.Sua(phim);
        }
    }
}
