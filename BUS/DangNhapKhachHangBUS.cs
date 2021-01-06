using DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using System.Data;

namespace BUS
{
    public class DangNhapKhachHangBUS
    {
        public static bool Login(string taikhoan, string matkhau)
        {
            return DangNhapKhachHangDAO.Login(taikhoan, matkhau);
        }
        public static int PhanLoaiKH(string taikhoan, string matkhau)
        {
            return DangNhapKhachHangDAO.PhanLoaiKH(taikhoan, matkhau);
        }
        public static void Them(DangNhapKhachHangDTO kh)
        {
            DangNhapKhachHangDAO.Them(kh);
        }
        public static string LayMaKH()
        {
            return DangNhapKhachHangDAO.MaKH;
        }

    }
}
