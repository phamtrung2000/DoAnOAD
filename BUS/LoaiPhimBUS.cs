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
    public class LoaiPhimBUS
    {
        public static DataTable LoadDSLP()
        {
            return LoaiPhimDAO.LoadDSLP();
        }
        public static void Them(LoaiPhimDTO lp)
        {
            LoaiPhimDAO.Them(lp);
        }

        public static void Sua(LoaiPhimDTO lp)
        {
            LoaiPhimDAO.Sua(lp);
        }

        public static void Xoa(string malp)
        {
            LoaiPhimDAO.Xoa(malp);
        }
        public static DataTable TimTheoMaLP(string malp)
        {
            return LoaiPhimDAO.TimtheoMaLP(malp);
        }
        public static DataTable TimTheoTenLoaiPhim(string tenlp)
        {
            return LoaiPhimDAO.TimTheoTenLoaiPhim(tenlp);
        }

    }
}
