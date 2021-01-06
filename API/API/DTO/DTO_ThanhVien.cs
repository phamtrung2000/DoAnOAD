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
    public class DTO_ThanhVien
    {
        private string thanhVien_ID;
        private string hoTen_TV;
        private string cMND_TV;
        private string diaChi_TV;
        private string sDT_TV;
        private DateTime ngayDangKi;
        private DateTime ngayHetHan;
        private DateTime ngaySinh;
        private string iD_LTV;
        private string email;
        private string image;
        private string gioiTinh;
        public string ThanhVien_ID { get => thanhVien_ID; set => thanhVien_ID = value; }
        public string HoTen_TV { get => hoTen_TV; set => hoTen_TV = value; }
        public string DiaChi_TV { get => diaChi_TV; set => diaChi_TV = value; }
        public string SDT_TV { get => sDT_TV; set => sDT_TV = value; }
        public DateTime NgayHetHan { get => ngayHetHan; set => ngayHetHan = value; }
        public DateTime NgayDangKi { get => ngayDangKi; set => ngayDangKi = value; }
        public string ID_LTV { get => iD_LTV; set => iD_LTV = value; }
        public string CMND_TV { get => cMND_TV; set => cMND_TV = value; }
        public DateTime NgaySinh { get => ngaySinh; set => ngaySinh = value; }
        public string Email { get => email; set => email = value; }
        public string Image { get => image; set => image = value; }
        public string GioiTinh { get => gioiTinh; set => gioiTinh = value; }

        public DTO_ThanhVien()
        {

        }

        public DTO_ThanhVien(string id, string name, string DiaChi, string phone, string CMND, DateTime NgayDK, DateTime NgayHH, DateTime Birth, string IDLTV, string Mail, string anh, string gioitinh)
        {
            this.ThanhVien_ID = id;
            this.HoTen_TV = name;
            this.CMND_TV = CMND;
            this.DiaChi_TV = DiaChi;
            this.SDT_TV = phone;
            this.NgayDangKi = NgayDK;
            this.NgayHetHan = NgayHH;
            this.NgaySinh = Birth;
            this.ID_LTV = IDLTV;
            this.Email = Mail;
            this.Image = anh;
            this.GioiTinh = gioitinh;
        }
    }
}

