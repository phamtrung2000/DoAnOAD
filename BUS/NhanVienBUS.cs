using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAO;
using DTO;
using System.Data;

namespace BUS
{
    // lớp kết nối giữa lớp Presentation và DAO
    public class NhanVienBUS
    {
        private NhanVienDAO nvDAO;
        public NhanVienBUS()
        {
            nvDAO = new NhanVienDAO();
        }
        public IEnumerable<NhanVienDTO> get_AllNhanVien()
        {
            List<NhanVienDTO> list_nv = new List<NhanVienDTO>();
            DataTable dataTable = new DataTable();
            dataTable = NhanVienDAO.GetAll_table();

            foreach (DataRow dr in dataTable.Rows)
            {
                NhanVienDTO nv = new NhanVienDTO();
                nv.MaNV = dr["MaNV"].ToString();
                nv.HoTen = dr["HoTen"].ToString();
                nv.ChucVu = dr["ChucVu"].ToString();
                nv.SDT = dr["SDT"].ToString();
                nv.GioiTinh = dr["GioiTinh"].ToString();
                nv.NgaySinh = DateTime.Parse(dr["NgaySinh"].ToString());
                nv.DiaChi = dr["DiaChi"].ToString();
                nv.Luong = dr["Luong"].ToString();
                nv.NgayVL = DateTime.Parse(dr["NgayVL"].ToString());

                list_nv.Add(nv);
            }
            return list_nv;
        }

        public void Sua_NhanVien(string manv, NhanVienDTO nv)
        {
            nvDAO.Sua_NhanVien(manv, nv);
        }

        public string ThemNhanVien(NhanVienDTO nv)
        {
            return nvDAO.Add_NhanVien(nv);
        }

        public bool Xoa_NhanVien(string manv)
        {
            return nvDAO.Xoa_NhanVien(manv);
        }

        public IEnumerable<NhanVienDTO> Get_NhanVien_byMaNV(string manv)
        {
            List<NhanVienDTO> list_nv = new List<NhanVienDTO>();
            DataTable dataTable = new DataTable();
            dataTable = NhanVienDAO.Get_NhanVien_byMaNV(manv);

            foreach (DataRow dr in dataTable.Rows)
            {
                NhanVienDTO nv = new NhanVienDTO();
                nv.MaNV = dr["MaNV"].ToString();
                nv.HoTen = dr["HoTen"].ToString();
                nv.ChucVu = dr["ChucVu"].ToString();
                nv.SDT = dr["SDT"].ToString();
                nv.GioiTinh = dr["GioiTinh"].ToString();
                nv.NgaySinh = DateTime.Parse(dr["NgaySinh"].ToString());
                nv.DiaChi = dr["DiaChi"].ToString();
                nv.Luong = dr["Luong"].ToString();
                nv.NgayVL = DateTime.Parse(dr["NgayVL"].ToString());

                list_nv.Add(nv);
            }
            return list_nv;
        }

        public static DataTable LoadDSNV()
        {
            return NhanVienDAO.LoadDSNV();
        }

        public static void Them(NhanVienDTO nv)
        {
            NhanVienDAO.Them(nv);
        }

        public static void Sua(NhanVienDTO nv)
        {
            NhanVienDAO.Sua(nv);
        }

        public static void Xoa(string manv)
        {
            NhanVienDAO.Xoa(manv);
        }
        public static DataTable TimTheoMaNV(string manv)
        {
            return NhanVienDAO.TimTheoMaNV(manv);
        }
        public static DataTable TimTheoHoTen(string hoten)
        {
            return NhanVienDAO.TimTheoHoTen(hoten);
        }

        public static DataTable TimTheoSDT(string sdt)
        {
            return NhanVienDAO.TimTheoSDT(sdt);
        }
    }
}
