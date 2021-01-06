using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace DTO
{
    public class LichChieuDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private DateTime ngaychieu;
        public DateTime NgayChieu { get => ngaychieu; set => ngaychieu = value; }

        private string ngaychieu_string;
        public string NgayChieu_String { get => ngaychieu_string; set => ngaychieu_string = value; }

        private string maphim;
        public string MaPhim { get => maphim; set => maphim = value; }

        private string macc;
        public string MaCC { get => macc; set => macc = value; }

        private string mapc;
        public string MaPC { get => mapc; set => mapc = value; }

        private string thoigian;
        public string ThoiGian { get => thoigian; set => thoigian = value; }

        public LichChieuDTO(DateTime ngaychieu, string maphim, string macc, string mapc)
        {
            NgayChieu = ngaychieu;
            MaPhim = maphim;
            MaCC = macc;
            MaPC = mapc;
        }

        public LichChieuDTO(string stt, DateTime ngaychieu, string maphim, string macc, string mapc)
        {
            STT = stt;
            NgayChieu = ngaychieu;
            MaPhim = maphim;
            MaCC = macc;
            MaPC = mapc;
        }

        public LichChieuDTO(string ngaychieu, string maphim, string macc, string mapc)
        {
            NgayChieu_String = ngaychieu;
            MaPhim = maphim;
            MaCC = macc;
            MaPC = mapc;
        }

        public LichChieuDTO(string stt, string ngaychieu, string maphim, string macc, string mapc)
        {
            STT = stt;
            NgayChieu_String = ngaychieu;
            MaPhim = maphim;
            MaCC = macc;
            MaPC = mapc;
        }

        public LichChieuDTO(string ngaychieu, string thoigian, string tenphim)
        {
            NgayChieu_String = ngaychieu;
            ThoiGian = thoigian;
            MaPhim = tenphim;
        }


        private string[] tenphim;
        public string[] TenPhim { get => tenphim; set => tenphim = value; }

        public LichChieuDTO(string thoigian, string[] tenphim)
        {
            ThoiGian = thoigian;
            TenPhim = tenphim;
        }
    }
}
