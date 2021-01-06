using DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using System.Data;
using DAO;
namespace BUS
{
    public class DangNhapKhachHangBUS
    {
        DangNhapKhachHangDAO LOGIN = new DangNhapKhachHangDAO();
        public string Login(string taikhoan, string matkhau)
        {
            return LOGIN.Login(taikhoan, matkhau);
        }
        public int PhanLoaiKH(string taikhoan, string matkhau)
        {
            return LOGIN.PhanLoaiKH(taikhoan, matkhau);
        }
        public  void Them(DangNhapKhachHangDTO kh)
        {
            LOGIN.Them(kh);
        }
        public  string LayMaKH()
        {
            return LOGIN.MaKH;
        }

    }
}
