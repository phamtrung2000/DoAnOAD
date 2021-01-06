using BUS;
using QuanLyCinema.DangNhapKhachHang;
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
using DTO;
namespace QuanLyCinema
{
    /// <summary>
    /// Interaction logic for Login.xaml
    /// </summary>
                        
    public partial class Login : Window
    {
        DangNhapKH_controller LoginControl = new DangNhapKH_controller();
        string tk = null;
        string mk = null;
        public Login()
        {
            InitializeComponent();
        }

        private void btnDangNhap_Click(object sender, RoutedEventArgs e)
        {
            string MaKH = null;
            tk = txtTaiKhoan.Text;
            mk = txtMatKhau.Password;

            if (tk == "")
            {
                MessageBox.Show("Vui lòng nhập Tài khoản");
            }
            else
            {
                if (mk == "")
                {
                    MessageBox.Show("Vui lòng nhập Mật khẩu");
                }
                else
                {
                    try
                    {
                        string DANGNHAP = "";
                        DangNhapKhachHangDTO kh = new DangNhapKhachHangDTO { TAIKHOAN = tk, MATKHAU = mk };                     
                        DANGNHAP = LoginControl.Login(kh).Result;
                        if (DANGNHAP != "")
                        {
                            GiaoDienChinh_KhachHang giaoDienChinh_KhachHang = new GiaoDienChinh_KhachHang();
                            MaKH = DANGNHAP;
                            Console.WriteLine("Hello"+MaKH);
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
                    catch (Exception)
                    {
                        MessageBox.Show("Lỗi kết nối");
                    }
                }
            }

            //GiaoDienChinh_KhachHang giaoDienChinh_KhachHang = new GiaoDienChinh_KhachHang();
            //MaKH = DangNhapKhachHangBUS.LayMaKH();
            //giaoDienChinh_KhachHang.Sender_MaKH(MaKH);
            //giaoDienChinh_KhachHang.Show();
            //this.Close();
        }

        private void btExit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void btnDangNhapKhachHang_Click(object sender, RoutedEventArgs e)
        {
            this.Hide();
            Login_KhachHang login_KhachHang = new Login_KhachHang();
            login_KhachHang.ShowDialog();

        }

        private void loginWindow_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if(e.ChangedButton == MouseButton.Left)
            {
                DragMove(); 

            }    
        }

        private void btTaoTaikhoan_Click(object sender, RoutedEventArgs e)
        {
            this.Hide();
            frmDangKy taiKhoan = new frmDangKy();
            taiKhoan.Show();
        }
    }
}

