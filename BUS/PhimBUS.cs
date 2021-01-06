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
    public class PhimBUS
    {
        public static DataTable LoadDSPhim()
        {
            return PhimDAO.LoadDSPhim();
        }
        public static void Them(PhimDTO p)
        {
            PhimDAO.Them(p);
        }

        public static void Sua(PhimDTO p)
        {
            PhimDAO.Sua(p);
        }

        public static void Xoa(string map)
        {
            PhimDAO.Xoa(map);
        }
        public static DataTable TimTheoMaP(string map)
        {
            return PhimDAO.TimtheoMaP(map);
        }
        public static DataTable TimTheoTenPhim(string tenp)
        {
            return PhimDAO.TimTheoTenPhim(tenp);
        }
        public static DataTable LoadTheLoaiPhim(string maphim)
        {
            return PhimDAO.LoadTheLoaiPhim(maphim);
        }
    }
}
