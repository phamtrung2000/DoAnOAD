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
    public class DTO_ChiTietMuon
    {
        private string iDPM;
        private string iDSACH;
        private string sL;
        private string checkTra;

        public string IDPM { get => iDPM; set => iDPM = value; }
        public string IDSACH { get => iDSACH; set => iDSACH = value; }
        public string SL { get => sL; set => sL = value; }
        public string CHECKTRA { get => checkTra; set => checkTra = value; }

        public DTO_ChiTietMuon()
        { }

        public DTO_ChiTietMuon(string idpm, string idsach, string sl, string checktra)
        {
            this.IDPM = idpm;
            this.IDSACH = idsach;
            this.SL = sl;
            this.CHECKTRA = checktra;
        }
    }
}
