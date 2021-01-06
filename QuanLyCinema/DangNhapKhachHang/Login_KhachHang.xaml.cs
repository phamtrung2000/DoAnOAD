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
using BUS;

namespace QuanLyCinema.DangNhapKhachHang
{
    /// <summary>
    /// Interaction logic for Login_KhachHang.xaml
    /// </summary>
    public partial class Login_KhachHang : Window
    {
        public Login_KhachHang()
        {
            InitializeComponent();
        }
        string tk = null;
        string mk = null;
        private void btDangnhap_Click(object sender, RoutedEventArgs e)
        {
            string MaKH = null;
            tk = txtTaiKhoan.Text;
            mk = txtMatKhau.Password;
            if (tk == "" && mk == "")
            {
                // khách hàng đăng nhập không tài khoản

                this.Hide();
                GiaoDienChinh_KhachHang giaoDienChinh_KhachHang = new GiaoDienChinh_KhachHang();
                MaKH = DangNhapKhachHangBUS.LayMaKH();
                giaoDienChinh_KhachHang.Sender_MaKH(MaKH);
                giaoDienChinh_KhachHang.Show();
            }
            else
            {
                var DANGNHAP = false;
                DANGNHAP = DangNhapKhachHangBUS.Login(tk, mk);
                if (DANGNHAP == true)
                {
                    GiaoDienChinh_KhachHang giaoDienChinh_KhachHang = new GiaoDienChinh_KhachHang();
                    MaKH = DangNhapKhachHangBUS.LayMaKH();
                    giaoDienChinh_KhachHang.Sender_MaKH(MaKH);
                    giaoDienChinh_KhachHang.Show();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("Tài khoản/Mật khẩu bạn đã nhập không chính xác! Vui lòng kiểm tra lại.",
                        "Lỗi đăng nhập");
                    txtTaiKhoan.Focus();
                    txtMatKhau.Password = "";
                }
            }
        }

        private void Window_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ChangedButton == MouseButton.Left)
            {
                DragMove();

            }
        }

        private void btExit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void btTaoTaikhoan_Click(object sender, RoutedEventArgs e)
        {
            this.Hide();
            frmDangKy taiKhoan = new frmDangKy();
            taiKhoan.Show();
        }
    }
}
