using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Model
{
    public class NhanVien
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

    }
}
