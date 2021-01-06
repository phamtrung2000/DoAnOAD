using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class CTVE_DTO
    {
        private string mave;
        public string MaVe { get => mave; set => mave = value; }

        private string maghe;
        public string MaGhe { get => maghe; set => maghe = value; }

        private string ngaychieu_string;
        public string NgayChieu_String { get => ngaychieu_string; set => ngaychieu_string = value; }

        private string thanhtien;
        public string ThanhTien { get => thanhtien; set => thanhtien = value; }

        public CTVE_DTO(string mave, string maghe,string ngaychieu, string thanhtien)
        {
            MaVe = mave;
            MaGhe = maghe;
            NgayChieu_String = ngaychieu;
            ThanhTien = thanhtien;
        }
    }
}
