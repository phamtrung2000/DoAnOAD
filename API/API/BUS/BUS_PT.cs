using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using API.DAL;
using API.DTO;

namespace API.BUS
{
    public class BUS_PT
    {
        DAL_PhieuTra dalphieutra = new DAL_PhieuTra();
        public DataTable GetPT(string idpm)
        {
            return dalphieutra.GetPT(idpm);
        }
        public bool addPT(DTO_PhieuTra pt)
        {
            return dalphieutra.AddPT(pt);
        }
    }
}
