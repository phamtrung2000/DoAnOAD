using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAO;
using DTO;
using System.Data;

namespace BUS
{
    public class CaChieuBUS
    {
        public static DataTable LoadDSCaChieu()
        {
            return CaChieuDAO.LoadDSCaChieu();
        }
        public static void Them(CaChieuDTO cc)
        {
            CaChieuDAO.Them(cc);
        }

        public static void Sua(CaChieuDTO cc)
        {
            CaChieuDAO.Sua(cc);
        }

        public static void Xoa(string macc)
        {
            CaChieuDAO.Xoa(macc);
        }
        public static DataTable TimTheoMaCC(string macc)
        {
            return CaChieuDAO.TimtheoMacc(macc);
        }
        public static DataTable TimTheoTenCC(string tencc)
        {
            return CaChieuDAO.TimtheoTencc(tencc);
        }
    }
}

