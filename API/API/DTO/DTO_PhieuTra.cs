using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace API.DTO
{
    public class DTO_PhieuTra
    {
        private string iDPT;
        private string iDTV;
        private string iDNV;
        private DateTime ngayTra;
        private string tienPhat;

        public string IDPT { get => iDPT; set => iDPT = value; }
        public string IDTV { get => iDTV; set => iDTV = value; }
        public string IDNV { get => iDNV; set => iDNV = value; }
        public DateTime NgayTra { get => ngayTra; set => ngayTra = value; }
        public string TienPhat { get => tienPhat; set => tienPhat = value; }

        public DTO_PhieuTra()
        { }

        public DTO_PhieuTra(string idpt, string idtv, string idnv, DateTime ngaytra, string tienphat)
        {
            this.IDPT = idpt;
            this.IDTV = idtv;
            this.IDNV = idnv;
            this.NgayTra = ngaytra;
            this.TienPhat = tienphat;
        }
    }
}
