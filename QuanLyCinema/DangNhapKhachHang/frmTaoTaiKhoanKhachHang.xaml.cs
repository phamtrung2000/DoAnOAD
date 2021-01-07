using BUS;
using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace QuanLyCinema.DangNhapKhachHang
{
    /// <summary>
    /// Interaction logic for frmTaoTaiKhoan.xaml
    /// </summary>
    public partial class frmTaoTaiKhoanKhachHang : Window
    {
        public delegate void GuiMaKH_HoTen_DiaChi_GioiTinh_SDT_NgaySinh(string makh,string hoten,string diachi,string gioitinh,string sdt,string ngaysinh);

        public GuiMaKH_HoTen_DiaChi_GioiTinh_SDT_NgaySinh Sender;

        public static string MaKH = null;
        public static string HoTen = null;
        public static string DiaChi = null;
        public static string GioiTinh = null;
        public static string SDT = null;
        public static string NgaySinh;

        private void GetMaKH_HoTen_DiaChi_GioiTinh_SDT_NgaySinh(string makh, string hoten, string diachi, string gioitinh, string sdt, string ngaysinh)
        {
            MaKH = makh;
            HoTen = hoten;

            DiaChi = diachi;
            GioiTinh = gioitinh;

            SDT = sdt;
            NgaySinh = ngaysinh;
        }

    

        public frmTaoTaiKhoanKhachHang()
        {
            InitializeComponent();
            Sender = new GuiMaKH_HoTen_DiaChi_GioiTinh_SDT_NgaySinh(GetMaKH_HoTen_DiaChi_GioiTinh_SDT_NgaySinh);
        }

        private void btBack_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            Login_KhachHang lg = new Login_KhachHang();
            lg.Show();
        }
        string TaiKhoan, MatKhau = null;
        private void btnDangKy_Click(object sender, RoutedEventArgs e)
        {

            if (txtTenTaiKhoan.Text.Length != 0)
            {
                TaiKhoan = txtTenTaiKhoan.Text;
            }
            if (txtXacNhanMatKhau.Text.Length != 0)
            {
                if (txtMatKhau.Text == txtXacNhanMatKhau.Text)
                {
                    MatKhau = txtXacNhanMatKhau.Text;
                    DangNhapKhachHangDTO dangNhapKhachHang = new DangNhapKhachHangDTO(MaKH, TaiKhoan, MatKhau);
                    DangNhapKhachHangBUS.Them(dangNhapKhachHang);
                    this.Close();
                    Login login = new Login();
                    login.ShowDialog();

                }
                else
                {

                    MessageBox.Show("Xac nhan mat khau khong dung");
                    txtXacNhanMatKhau.Clear();
                    txtXacNhanMatKhau.Focus();
                }
                    
                
            }
           
        }
    }
}
