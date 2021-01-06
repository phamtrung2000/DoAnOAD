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
   
    public class PhongChieuBUS
    {

        public static DataTable LoadDSPC()
        {
            return PhongChieuDAO.LoadDSPC();
        }

        public static void Them(PhongChieuDTO pc)
        {
            PhongChieuDAO.Them(pc);
        }

        public static void Sua(PhongChieuDTO pc)
        {
            PhongChieuDAO.Sua(pc);
        }

        public static void Xoa(string mapc)
        {
            PhongChieuDAO.Xoa(mapc);
        }
        public static DataTable TimTheoMaPC(string mapc)
        {
            return PhongChieuDAO.TimTheoMaPC(mapc);
        }
        public static DataTable TimTheoTenPhongChieu(string tenpc)
        {
            return PhongChieuDAO.TimTheoTenPhongChieu(tenpc);
        }

        //public static DataTable TimTheoSDTNguoiDung(string sdt)
        //{
        //    return PhongChieuDAO.TimTheoSDTNguoiDung(sdt);
        //}
    }
}
