using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{

    public class LoaiVeDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private string malv;
        public string MaLV { get => malv; set => malv = value; }

        private string tenlv;
        public string TenLV { get => tenlv; set => tenlv = value; }

        private string loaichongoi;
        public string LoaiChoNgoi { get => loaichongoi; set => loaichongoi = value; }

        private string gia;
        public string Gia { get => gia; set => gia = value; }

        public LoaiVeDTO(string malv, string tenlv, string loaichongoi, string gia)
        {
            MaLV = malv;
            TenLV = tenlv;
            LoaiChoNgoi = loaichongoi;
            Gia = gia;
        }

        public LoaiVeDTO(string stt, string malv, string tenlv, string loaichongoi, string gia)
        {
            STT = stt;
            MaLV = malv;
            TenLV = tenlv;
            LoaiChoNgoi = loaichongoi;
            Gia = gia;
        }

    }
}
