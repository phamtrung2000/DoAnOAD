using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class PhimDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private string maphim;
        public string MaPhim { get => maphim; set => maphim = value; }

        private string tenphim;
        public string TenPhim { get => tenphim; set => tenphim = value; }

        private string daodien;
        public string DaoDien { get => daodien; set => daodien = value; }

        private string dienvien;
        public string DienVien { get => dienvien; set => dienvien = value; }

        private string theloai;
        public string TheLoai { get => theloai; set => theloai = value; }

        private string noidung;
        public string NoiDung { get => noidung; set => noidung = value; }

        private string namsx;
        public string NamSX { get => namsx; set => namsx = value; }

        private string nuocsx;
        public string NuocSX { get => nuocsx; set => nuocsx = value; }

        private string thoiluong;
        public string ThoiLuong { get => thoiluong; set => thoiluong = value; }

        public PhimDTO(string maphim, string tenphim, string daodien, string dienvien, string noidung, string namsx, string nuocsx, string thoiluong)
        {
            MaPhim = maphim;
            TenPhim = tenphim;
            DaoDien = daodien;
            DienVien = dienvien;
            NoiDung = noidung;
            NamSX = namsx;
            NuocSX = nuocsx;
            ThoiLuong = thoiluong;
        }

        public PhimDTO(string stt, string maphim, string tenphim, string daodien, string dienvien, string noidung, string namsx, string nuocsx, string thoiluong)
        {
            STT = stt;
            MaPhim = maphim;
            TenPhim = tenphim;
            DaoDien = daodien;
            DienVien = dienvien;
            NoiDung = noidung;
            NamSX = namsx;
            NuocSX = nuocsx;
            ThoiLuong = thoiluong;
        }

        public PhimDTO(string stt, string maphim, string tenphim, string daodien, string dienvien, string theloai, string noidung, string namsx, string nuocsx, string thoiluong)
        {
            STT = stt;
            MaPhim = maphim;
            TenPhim = tenphim;
            DaoDien = daodien;
            DienVien = dienvien;
            TheLoai = theloai;
            NoiDung = noidung;
            NamSX = namsx;
            NuocSX = nuocsx;
            ThoiLuong = thoiluong;
        }
    }
}
