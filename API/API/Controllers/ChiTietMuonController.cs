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
    public class ChiTietMuonController
    {
        BUS_CTM bus = new BUS_CTM();

        [Route("AddCTM")]
        [HttpPost]
        public bool AddPM([FromBody] DTO_ChiTietMuon CTM)
        {
            return bus.addCTM(CTM);
        }

        [Route("UpdateCTM")]
        [HttpPut]
        public bool UpdateCTM([FromBody] DTO_ChiTietMuon CTM)
        {
            return bus.suaCTM(CTM);
        }

        [Route("GetCTM/{ID}")]
        [HttpGet]
        public DataTable GetCTM(int ID)
        {
            return bus.GetCTM(ID.ToString());
        }
    }
}
