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
    public class PhieuMuonController
    {
        BUS_PM bus = new BUS_PM();

        [Route("AddPM")]
        [HttpPost]
        public bool AddPM([FromBody] DTO_PhieuMuon PM)
        {
            return bus.addPM(PM);
        }

        [Route("UpdatePM")]
        [HttpPut]
        public bool UpdatePM([FromBody] DTO_PhieuMuon PM)
        {
            return bus.suaPM(PM);
        }

        [Route("GetPM/{ID}")]
        [HttpGet]
        public DataTable GetPM(int ID)
        {
            return bus.GetPM(ID.ToString());
        }

        [Route("GetNewPM")]
        [HttpGet]
        public int GetNewPM()
        {
            return bus.GetNewPM();
        }
    }
}
