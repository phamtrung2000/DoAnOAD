using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace DTO
{
    public class CaChieuDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private string macc;
        public string MaCC { get => macc; set => macc = value; }

        private string tencc;
        public string TenCC { get => tencc; set => tencc = value; }

        private DateTime batdau;
        public DateTime BatDau { get => batdau; set => batdau = value; }

        private string batdau_string;
        public string BatDau_String { get => batdau_string; set => batdau_string = value; }

        private DateTime ketthuc;
        public DateTime KetThuc { get => ketthuc; set => ketthuc = value; }

        private string ketthuc_string;
        public string KetThuc_String { get => ketthuc_string; set => ketthuc_string = value; }


        public CaChieuDTO(string macc, string tencc, DateTime batdau, DateTime ketthuc)
        {
            MaCC = macc;
            TenCC = tencc;
            BatDau = batdau;
            KetThuc = ketthuc;
        }

        public CaChieuDTO(string stt, string macc, string tencc, DateTime batdau, DateTime ketthuc)
        {
            STT = stt;
            MaCC = macc;
            TenCC = tencc;
            BatDau = batdau;
            KetThuc = ketthuc;
        }

        public CaChieuDTO(string macc, string tencc, string batdau, string ketthuc)
        {
            MaCC = macc;
            TenCC = tencc;
            BatDau_String = batdau;
            KetThuc_String = ketthuc;
        }

        public CaChieuDTO(string stt, string macc, string tencc, string batdau, string ketthuc)
        {
            STT = stt;
            MaCC = macc;
            TenCC = tencc;
            BatDau_String = batdau;
            KetThuc_String = ketthuc;
        }

    }
}

