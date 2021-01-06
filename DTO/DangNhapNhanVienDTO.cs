using System;
using System.Collections.Generic;
using System.Text;

namespace DTO
{
    public partial class DangNhapNhanVienDTO
    {
        private string _MANV;
        public string MaNV { get => _MANV; set => _MANV = value; }

        private string _TAIKHOAN;
        public string TAIKHOAN { get => _TAIKHOAN; set => _TAIKHOAN = value; }

        private string _MATKHAU;
        public string MATKHAU { get => _MATKHAU; set => _MATKHAU = value; }

        public DangNhapNhanVienDTO(string manv, string taikhoan, string matkhau)
        {
            MaNV = manv;
            TAIKHOAN = taikhoan;
            MATKHAU = matkhau;
        }
    }
}
