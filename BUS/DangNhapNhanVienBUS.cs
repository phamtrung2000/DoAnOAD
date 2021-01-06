using DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BUS
{
    public class DangNhapNhanVienBUS
    {
        public static bool Login(string taikhoan, string matkhau)
        {
            return DangNhapNhanVienDAO.Login(taikhoan, matkhau);
        }
        public static int PhanQuyen(string taikhoan, string matkhau)
        {
            return DangNhapNhanVienDAO.Phanquyen(taikhoan, matkhau);
        }
        public static string LayHoTen()
        {
            return DangNhapNhanVienDAO.HoTen;
        }
        public static string LayChucVu()
        {
            return DangNhapNhanVienDAO.ChucVu;
        }
        public static string LayUser()
        {
            return DangNhapNhanVienDAO.tk;
        }
        public static string LayPass()
        {
            return DangNhapNhanVienDAO.Mk;
        }
    }
}
