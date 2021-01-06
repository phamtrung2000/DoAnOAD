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
    public class DatVecontroller : ControllerBase
    {
        DatVeBUS bus = new DatVeBUS();
        [Route("LoadDSChoNgoi/{MaPhim}/{NgayChieu}/{MaCC}")]
        [HttpGet]
        public DataTable LoadDSchongoi(string MaPhim, DateTime NgayChieu,string MaCC)
        {
            return bus.DatVe_LoadDSChoNgoi(MaPhim, NgayChieu,MaCC);
        }

        [Route("LoadChonNgoi/{MaPhim}/{NgayChieu}/{MaCC}")]
        [HttpGet]
        public DataTable Load_Chonchongoi(string MaPhim, DateTime NgayChieu, string MaCC)
        {
            return bus.DatVe_Load_ChonChoNgoi(MaPhim, NgayChieu, MaCC);
        }
    }
}
