using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public  class NhanVienDTO
    {
        public string STT { get; set; }
        public string MaNV { get; set; }
        public string HoTen { get; set; }
        public string ChucVu { get; set; }
        public string SDT { get; set; }
        public string GioiTinh { get; set; }
        public DateTime NgaySinh { get; set; }
        public string NgaySinh_String { get; set; }
        public string DiaChi { get; set; }
        public string Luong { get; set; }
        public DateTime NgayVL { get; set; }
        public string NgayVL_String { get; set; }

        // bản gốc
        public NhanVienDTO(string manv, string hoten, string chucvu, string sdt, string gioitinh, DateTime ngaysinh, string diachi, string luong, DateTime ngayvl)
        {
            MaNV = manv;
            HoTen = hoten;
            ChucVu = chucvu;
            SDT = sdt;
            GioiTinh = gioitinh;
            NgaySinh = ngaysinh;
            DiaChi = diachi;
            Luong = luong;
            NgayVL = ngayvl;
        }

        // có stt để xuất trong datagrid
        public NhanVienDTO(string stt,string manv, string hoten, string chucvu, string sdt, string gioitinh, DateTime ngaysinh, string diachi, string luong, DateTime ngayvl)
        {
            STT=stt;
            MaNV = manv;
            HoTen = hoten;
            ChucVu = chucvu;
            SDT = sdt;
            GioiTinh = gioitinh;
            NgaySinh = ngaysinh;
            DiaChi = diachi;
            Luong = luong;
            NgayVL = ngayvl;
        }

        // chuyển ngày sinh + ngày vl thành string để bỏ cái 12h
        public NhanVienDTO(string manv, string hoten, string chucvu, string sdt, string gioitinh, string ngaysinh_string, string diachi, string luong, string ngayvl_string)
        {
            MaNV = manv;
            HoTen = hoten;
            ChucVu = chucvu;
            SDT = sdt;
            GioiTinh = gioitinh;
            NgaySinh_String = ngaysinh_string;
            DiaChi = diachi;
            Luong = luong;
            NgayVL_String = ngayvl_string;
        }

        // như trên mà có thêm stt để xuất trong datagrid
        public NhanVienDTO(string stt, string manv, string hoten, string chucvu, string sdt, string gioitinh, string ngaysinh_string, string diachi, string luong, string ngayvl_string)
        {
            STT = stt;
            MaNV = manv;
            HoTen = hoten;
            ChucVu = chucvu;
            SDT = sdt;
            GioiTinh = gioitinh;
            NgaySinh_String = ngaysinh_string;
            DiaChi = diachi;
            Luong = luong;
            NgayVL_String = ngayvl_string;
        }

        public NhanVienDTO()
        {

        }
    }
}
