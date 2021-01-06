using System;
using System.Collections.Generic;
using System.Text;

namespace DTO
{
    public partial class DangNhapKhachHangDTO
    {
        private string _MAKH;
        public string MaKH { get => _MAKH; set => _MAKH = value; }

        private string _TAIKHOAN;
        public string TAIKHOAN { get => _TAIKHOAN; set => _TAIKHOAN = value; }

        private string _MATKHAU;
        public string MATKHAU { get => _MATKHAU; set => _MATKHAU = value; }

        public DangNhapKhachHangDTO(string makh, string taikhoan, string matkhau)
        {
            MaKH = makh;
            TAIKHOAN = taikhoan;
            MATKHAU = matkhau;
        }
    }
}


