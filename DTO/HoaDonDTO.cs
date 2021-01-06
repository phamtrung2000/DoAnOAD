using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class VeDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private string mave;
        public string MaVe { get => mave; set => mave = value; }

        private DateTime ngay_gio_mua;
        public DateTime Ngay_Gio_Mua { get => ngay_gio_mua; set => ngay_gio_mua = value; }

        private string ngay_gio_mua_string;
        public string Ngay_Gio_Mua_String { get => ngay_gio_mua_string; set => ngay_gio_mua_string = value; }

        private string makh;
        public string MaKH { get => makh; set => makh = value; }

        private string malc;
        public string MaLC { get => malc; set => malc = value; }

       
        private string tongcong;
        public string TongCong { get => tongcong; set => tongcong = value; }

        public VeDTO(string mave, DateTime ngay_gio_mua, string makh,string malc, string tongcong)
        {
            MaVe = mave;
            Ngay_Gio_Mua = ngay_gio_mua;
            MaKH = makh;
            MaLC = malc;
            TongCong = tongcong;
        }

        public VeDTO(string stt,string mave, string ngay_gio_mua_string, string makh, string malc, string tongcong)
        {
            STT = stt;
            MaVe = mave;
            Ngay_Gio_Mua_String = ngay_gio_mua_string;
            MaKH = makh;
            MaLC = malc;
            TongCong = tongcong;
        }
    }
}
