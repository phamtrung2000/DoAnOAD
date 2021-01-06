using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using API.BUS;
using DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic.CompilerServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using BUS;

namespace API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class LichChieuController : ControllerBase
    {
        LichChieuBUS bus = new LichChieuBUS();
        [Route("DatvePhimNgayChieu/{MaPhim}/{NgayChieu}")]
        [HttpGet]
        public DataTable SearchByID(string MaPhim, DateTime NgayChieu)
        {
            return bus.DatVe_Phim_NgayChieu(MaPhim, NgayChieu);
        }
       
    }
}
