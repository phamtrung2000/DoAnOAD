using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{

    public class PhongChieuDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private string mapc;
        public string MaPC { get => mapc; set => mapc = value; }

        private string tenpc;
        public string TenPC { get => tenpc; set => tenpc = value; }

        private int socho;
        public int SoCho { get => socho; set => socho = value; }

        private string maychieu;
        public string MayChieu { get => maychieu; set => maychieu = value; }

        private string loa;
        public string Loa { get => loa; set => loa = value; }

        private int dientich;
        public int DienTich { get => dientich; set => dientich = value; }

        private string tinhtrang;
        public string TinhTrang { get => tinhtrang; set => tinhtrang = value; }

        private string trangthietbikhac;
        public string TrangThietBiKhac { get => trangthietbikhac; set => trangthietbikhac = value; }


        public PhongChieuDTO(string mapc, string tenpc, int socho, string maychieu, string loa, int dientich, string tinhtrang, string trangthietbikhac)
        {
            MaPC = mapc;
            TenPC = tenpc;
            SoCho = socho;
            MayChieu = maychieu;
            Loa = loa;
            DienTich = dientich;
            TinhTrang = tinhtrang;
            TrangThietBiKhac = trangthietbikhac;
        }

        public PhongChieuDTO(string stt, string mapc, string tenpc, int socho, string maychieu, string loa, int dientich, string tinhtrang, string trangthietbikhac)
        {
            STT = stt;
            MaPC = mapc;
            TenPC = tenpc;
            SoCho = socho;
            MayChieu = maychieu;
            Loa = loa;
            DienTich = dientich;
            TinhTrang = tinhtrang;
            TrangThietBiKhac = trangthietbikhac;
        }
    }
}
