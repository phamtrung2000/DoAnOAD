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
    public class DTO_Sach
    {
        private string book_ID;
        private string tacGia_ID;
        private string nXB_ID;
        private string tenSach;
        private string theLoai;
        private string viTri;
        private int soLuong;
        private int sLHienTai;
        private float giaSach;
        public string Book_ID { get => book_ID; set => book_ID = value; }
        public string TacGia_ID { get => tacGia_ID; set => tacGia_ID = value; }
        public string NXB_ID { get => nXB_ID; set => nXB_ID = value; }
        public string TenSach { get => tenSach; set => tenSach = value; }
        public string TheLoai { get => theLoai; set => theLoai = value; }
        public string ViTri { get => viTri; set => viTri = value; }
        public int SoLuong { get => soLuong; set => soLuong = value; }
        public int SLHienTai { get => sLHienTai; set => sLHienTai = value; }
        public float GiaSach { get => giaSach; set => giaSach = value; }

        public DTO_Sach()
        {

        }

        public DTO_Sach(string id, string idTG, string idNXB, string ten, string tl, string vt, int sl, int slht, float gs)
        {
            this.book_ID = id;
            this.tacGia_ID = idTG;
            this.nXB_ID = idNXB;
            this.tenSach = ten;
            this.theLoai = tl;
            this.viTri = vt;
            this.soLuong = sl;
            this.sLHienTai = slht;
            this.giaSach = gs;
        }
    }
}
