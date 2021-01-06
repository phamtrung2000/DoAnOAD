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
   
    public class NguoiDungBUS
    {

        public static DataTable LoadDSND()
        {
            return NguoiDungDAO.LoadDSND();
        }

        public static void Them(NguoiDungDTO nd)
        {
            NguoiDungDAO.Them(nd);
        }

        public static void Sua(NguoiDungDTO nd)
        {
            NguoiDungDAO.Sua(nd);
        }

        public static void Xoa(string manv)
        {
            NguoiDungDAO.Xoa(manv);
        }
        public static DataTable TimTheoMaND(string manv)
        {
            return NguoiDungDAO.TimTheoMaND(manv);
        }
        public static DataTable TimTheoHoTenNguoiDung(string hoten)
        {
            return NguoiDungDAO.TimTheoHoTenNguoiDung(hoten);
        }

        //public static DataTable TimTheoSDTNguoiDung(string sdt)
        //{
        //    return NguoiDungDAO.TimTheoSDTNguoiDung(sdt);
        //}
    }
}
