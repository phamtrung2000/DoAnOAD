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

        private string maphim;
        public string MaPhim { get => maphim; set => maphim = value; }

        private string mapc;
        public string MaPC { get => mapc; set => mapc = value; }

        private string malv;
        public string MaLV { get => malv; set => malv = value; }

        private string soluong;
        public string SoLuong { get => soluong; set => soluong = value; }

        public VeDTO(string maphim, string mapc, string malv, string soluong)
        {
            MaPhim = maphim;
            MaPC = mapc;
            MaLV = malv;
            SoLuong = soluong;
        }

        public VeDTO(string stt, string maphim, string mapc, string malv, string soluong)
        {
            STT = stt;
            MaPhim = maphim;
            MaPC = mapc;
            MaLV = malv;
            SoLuong = soluong;
        }
    }
}
