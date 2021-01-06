using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{

    public class NguoiDungDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private string mand;
        public string MaND { get => mand; set => mand = value; }

        private string hoten;
        public string HoTen { get => hoten; set => hoten = value; }

        private string chucvu;
        public string ChucVu { get => chucvu; set => chucvu = value; }

        private string phanquyen;
        public string PhanQuyen { get => phanquyen; set => phanquyen = value; }

        public NguoiDungDTO(string mand, string hoten, string chucvu, string phanquyen)
        {
            MaND = mand;
            HoTen = hoten;
            ChucVu = chucvu;
            PhanQuyen = phanquyen;
        }

        public NguoiDungDTO(string stt, string mand, string hoten, string chucvu, string phanquyen)
        {
            STT = stt;
            MaND = mand;
            HoTen = hoten;
            ChucVu = chucvu;
            PhanQuyen = phanquyen;
        }
    }
}
