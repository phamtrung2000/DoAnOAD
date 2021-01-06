using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class KhachHangDTO
    {
        private string stt;
        public string STT { get => stt; set => stt = value; }

        private string maKH;
        public string MaKH { get => maKH; set => maKH = value; }

        private string hoten;
        public string HoTen { get => hoten; set => hoten = value; }

        private string diachi;
        public string DiaChi { get => diachi; set => diachi = value; }

        private DateTime ngaysinh;
        public DateTime Ngaysinh { get => ngaysinh; set => ngaysinh = value; }

        private string ngaysinh_string;
        public string NgaySinh_String { get => ngaysinh_string; set => ngaysinh_string = value; }

        private string gioitinh;
        public string GioiTinh { get => gioitinh; set => gioitinh = value; }

        private string sdt;
        public string SDT { get => sdt; set => sdt = value; }

        private string loaikh;
        public string LoaiKH { get => loaikh; set => loaikh = value; }

        private DateTime ngaydk;
        public DateTime Ngaydk { get => ngaydk; set => ngaydk = value; }

        private string ngaydk_string;
        public string NgayDK_String { get => ngaydk_string; set => ngaydk_string = value; }

        // bản gốc
        public KhachHangDTO(string maKH, string hoten, string diachi, DateTime ngaysinh, string gioitinh, string sdt, string loaikh, DateTime ngaydk)
        {
            MaKH = maKH;
            HoTen = hoten;
            DiaChi = diachi;
            Ngaysinh = ngaysinh;
            GioiTinh = gioitinh;
            SDT = sdt;
            LoaiKH = loaikh;
            Ngaydk = ngaydk;
        }

        // có stt để xuất trong datagrid
        public KhachHangDTO(string stt,string maKH, string hoten, string diachi, DateTime ngaysinh, string gioitinh, string sdt, string loaikh, DateTime ngaydk)
        {
            STT = stt;
            MaKH = maKH;
            HoTen = hoten;
            DiaChi = diachi;
            Ngaysinh = ngaysinh;
            GioiTinh = gioitinh;
            SDT = sdt;
            LoaiKH = loaikh;
            Ngaydk = ngaydk;
        }

        // chuyển ngày sinh + ngày vl thành string để bỏ cái 12h
        public KhachHangDTO(string maKH, string hoten, string diachi, string ngaysinh, string gioitinh, string sdt, string loaikh, string ngaydk)
        {
            MaKH = maKH;
            HoTen = hoten;
            DiaChi = diachi;
            NgaySinh_String = ngaysinh;
            GioiTinh = gioitinh;
            SDT = sdt;
            LoaiKH = loaikh;
            NgayDK_String = ngaydk;
        }

        // như trên mà có thêm stt để xuất trong datagrid
        public KhachHangDTO(string stt, string maKH, string hoten, string diachi, string ngaysinh, string gioitinh, string sdt, string loaikh, string ngaydk)
        {
            STT = stt;
            MaKH = maKH;
            HoTen = hoten;
            DiaChi = diachi;
            NgaySinh_String = ngaysinh;
            GioiTinh = gioitinh;
            SDT = sdt;
            LoaiKH = loaikh;
            NgayDK_String = ngaydk;
        }

    }
}

