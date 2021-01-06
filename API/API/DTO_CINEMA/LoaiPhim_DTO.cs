using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class LoaiPhimDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private string malp;
        public string MaLP { get => malp; set => malp = value; }

        private string tenlp;
        public string TenLP { get => tenlp; set => tenlp = value; }

        private string mota;
        public string MoTa { get => mota; set => mota = value; }



        public LoaiPhimDTO(string malp, string tenlp, string mota)
        {
            MaLP = malp;
            TenLP = tenlp;
            MoTa = mota;
        }

        public LoaiPhimDTO(string stt, string malp, string tenlp, string mota)
        {
            STT = stt;
            MaLP = malp;
            TenLP = tenlp;
            MoTa = mota;
        }
    }
}
