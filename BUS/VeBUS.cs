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
    public class VeBUS
    {
        public static DataTable LoadDSVe()
        {
            return VeDAO.LoadDSVe();
        }
        public static void Them(VeDTO p)
        {
            VeDAO.Them(p);
        }

        public static void Sua(VeDTO p)
        {
            VeDAO.Sua(p);
        }

        public static void Xoa(string maphim, string mapc, string malv)
        {
            VeDAO.Xoa(maphim, mapc, malv);
        }

        public static DataTable TimTheoTenPhim(string tenphim)
        {
            return VeDAO.TimTheoTenPhim(tenphim);
        }

        public static DataTable TimTheoTenPC(string tenpc)
        {
            return VeDAO.TimTheoTenPC(tenpc);
        }

        public static DataTable TimTheoTenLV(string tenlv)
        {
            return VeDAO.TimTheoTenLV(tenlv);
        }

        public static DataTable TimTheoSoLuong(string soluong)
        {
            return VeDAO.TimTheoSoLuong(soluong);
        }
    }
}
