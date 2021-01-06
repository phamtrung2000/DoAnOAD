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
    public class BUS_PM
    {
        DAL_PhieuMuon dalphieumuon = new DAL_PhieuMuon();

        public DataTable GetPM(string idtv)
        {
            return dalphieumuon.GetPM(idtv);
        }
        public int GetNewPM()
        {
            return dalphieumuon.GetNewPM();
        }
        public bool addPM(DTO_PhieuMuon pm)
        {
            return dalphieumuon.AddPM(pm);
        }
        public bool suaPM(DTO_PhieuMuon pm)
        {
            return dalphieumuon.suaPM(pm);
        }
    }
}
