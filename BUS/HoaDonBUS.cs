using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using DAO;
using System.Data;

namespace BUS
{
    public class VeBUS
    {
        public static DataTable LoadDSHoaDon()
        {
            return VeDAO.LoadDSHoaDon();
        }

        public static void Them(VeDTO ve)
        {
            VeDAO.Them(ve);
        }

        public static void Sua(VeDTO ve)
        {
            VeDAO.Sua(ve);
        }

        public static void Xoa(string mahd)
        {
            VeDAO.Xoa(mahd);
        }
        public static DataTable TimTheoSoHD(string mahd)
        {
            return VeDAO.TimTheoSoHD(mahd);
        }
        public static DataTable TimTheoNgay(DateTime tungay, DateTime denngay)
        {
            return VeDAO.TimTheoNgay(tungay, denngay);
        }

        public static DataTable TimTheoGio(DateTime tugio, DateTime dengio)
        {
            return VeDAO.TimTheoGio(tugio, dengio);
        }
        public static DataTable TimTheoGia(string gia_min, string gia_max)
        {
            return VeDAO.TimTheoGia(gia_min, gia_max);
        }

        public static DataTable TimTheoGiaMin(string gia_min)
        {
            return VeDAO.TimTheoGiaMin(gia_min);
        }

        public static DataTable TimTheoGiaMax(string gia_max)
        {
            return VeDAO.TimTheoGiaMax(gia_max);
        }

        public static DataTable TimTheoMaKH(string makh)
        {
            return VeDAO.TimTheoMaKH(makh);
        }
    }
}
