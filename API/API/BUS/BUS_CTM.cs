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
    public class BUS_CTM
    {
        DAL_ChiTietMuon dalctmuon = new DAL_ChiTietMuon();

        public DataTable GetCTM(string idpm)
        {
            return dalctmuon.GetCTM(idpm);
        }
        public bool addCTM(DTO_ChiTietMuon ctm)
        {
            return dalctmuon.AddCTM(ctm);
        }
        public bool suaCTM(DTO_ChiTietMuon ctm)
        {
            return dalctmuon.suaCTM(ctm);
        }
    }
}
