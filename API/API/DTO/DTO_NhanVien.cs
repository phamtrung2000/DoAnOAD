using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
namespace API.DTO
{
    public class DTO_NhanVien
    {
        private string iDNV;
        private string hoTen_NV;
        private string sDT_NV;
        private string diaChi_NV;
        private DateTime ngayVLam;
        private DateTime ngaySinh;
        private string userName_NV;
        private string passWord_NV;
        private string iD_CV;
        private int active;
        public string IDNV { get => iDNV; set => iDNV = value; }
        public string HoTen_NV { get => hoTen_NV; set => hoTen_NV = value; }
        public string SDT_NV { get => sDT_NV; set => sDT_NV = value; }
        public string DiaChi_NV { get => diaChi_NV; set => diaChi_NV = value; }
        public DateTime NgayVLam { get => ngayVLam; set => ngayVLam = value; }
        public string UserName_NV { get => userName_NV; set => userName_NV = value; }
        public string PassWord_NV { get => passWord_NV; set => passWord_NV = value; }
        public string ID_CV { get => iD_CV; set => iD_CV = value; }
        public int Active { get => active; set => active = value; }
        public DateTime NgaySinh { get => ngaySinh; set => ngaySinh = value; }

        public DTO_NhanVien() { }
        public DTO_NhanVien(string ID, string Name, string phone, string DiaChi, DateTime NgayVL, DateTime Birth, string UserNV, string PassNV, string IDCV, int activate)
        {
            this.IDNV = ID;
            this.HoTen_NV = Name;
            this.SDT_NV = phone;
            this.DiaChi_NV = DiaChi;
            this.NgayVLam = NgayVL;
            this.NgaySinh = Birth;
            this.UserName_NV = UserNV;
            this.PassWord_NV = PassNV;
            this.ID_CV = IDCV;
            this.Active = activate;
        }
    }
}


