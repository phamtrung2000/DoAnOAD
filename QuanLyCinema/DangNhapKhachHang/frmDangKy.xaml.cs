using System;
using System.Collections.Generic;
using System.Data;
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
using DTO;

namespace QuanLyCinema.DangNhapKhachHang
{
    /// <summary>
    /// Interaction logic for frmDangKy.xaml
    /// </summary>
   
    public partial class frmDangKy : Window
    {
        int SoLuong = 0;
        string MaKH = null;
        string HoTen = null;
        string DiaChi = null;
        string GioiTinh = null;
        string SDT = null;
        string NgaySinh = null;


        void LaySoLuongKH()
        {
            DataTable DT_KhachHang = KhachHangBUS.LoadDSKH();
            SoLuong = DT_KhachHang.Rows.Count;
        }

        public frmDangKy()
        {
            InitializeComponent();
        }

        private void btnLamMoi_Click(object sender, RoutedEventArgs e)
        {
            txtHoTenKH.Clear();
            txtDiaChi.Clear();
            dtpNgaySinh.Text = "";
            rdbNam.IsChecked = rdbNu.IsChecked = false;
            txtSDT.Clear();
        }

        private void btnHuy_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void btnLuu_Click(object sender, RoutedEventArgs e)
        {
            LaySoLuongKH();
            MaKH= "KH" + (SoLuong+ 1).ToString();

           
            if (txtHoTenKH.Text.Length != 0)
            {
                HoTen = txtHoTenKH.Text;
            }

        
           
            if (rdbNam.IsChecked == true)
                GioiTinh = "Nam";
            else if (rdbNu.IsChecked == true)
                GioiTinh = "Nữ";

            NgaySinh = dtpNgaySinh.DisplayDate.ToString();

            
            if (txtSDT.Text.Length != 0)
            {
                SDT = txtSDT.Text;
            }
            
            if (txtDiaChi.Text.Length != 0)
            {
                DiaChi = txtDiaChi.Text;
            }

            KhachHangDTO kh = new KhachHangDTO(MaKH, HoTen, DiaChi, NgaySinh, GioiTinh, SDT, DateTime.Now);

            if (HoTen == null)
            {
                MessageBox.Show("Chưa nhập họ tên");
                txtHoTenKH.Focus();
            }
            else if (DiaChi == null)
            {
                MessageBox.Show("Chưa nhập địa chỉ");
                txtDiaChi.Focus();
            }
            else if (GioiTinh == null)
            {
                MessageBox.Show("Chưa chọn giới tính");
                rdbNam.Focus();
                rdbNam.IsChecked = false;
            }

            else if (SDT == null)
            {
                MessageBox.Show("Chưa nhập số điện thoại");
                txtSDT.Focus();
            }
            else
            {
                KhachHangBUS.Them(kh);
                frmTaoTaiKhoanKhachHang frmTaoTaiKhoanKhachHang1 = new frmTaoTaiKhoanKhachHang();
                frmTaoTaiKhoanKhachHang1.Sender(MaKH, HoTen, DiaChi, GioiTinh, SDT, NgaySinh);
                this.Hide();
                frmTaoTaiKhoanKhachHang1.ShowDialog();
                
            }
        }

        private string ThangTruocNgaySau(string a) // 4 thang 5 -> 5/4
        {
            string kq = null;
            string ngay = null, thang = null, nam = null;
            string[] chuoi_duoc_tach = a.Split(new Char[] { '/' });

            ngay = chuoi_duoc_tach[0];
            thang = chuoi_duoc_tach[1];
            nam = chuoi_duoc_tach[2];
            kq = thang + "/" + ngay + "/" + nam;
            return kq;
        }

        private void dtpNgaySinh_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            if (dtpNgaySinh.Text.Length > 0)
            {
                DateTime a = DateTime.Today;
                DateTime b = dtpNgaySinh.SelectedDate.Value;
                if(a.Year >= b.Year )
                {
                    if (a.Month >= b.Month)
                    {
                        if (a.Date >= b.Date)
                        {
                            txtNgaySinh.Text = ThangTruocNgaySau(dtpNgaySinh.Text);
                        }
                        else
                        {
                            MessageBox.Show("Nhập lại ngày sinh");
                            dtpNgaySinh.Text = "";
                        }
                    }
                    else
                    {
                        MessageBox.Show("Nhập lại ngày sinh");
                        dtpNgaySinh.Text = "";
                    }
                        
                }
                else
                {
                    MessageBox.Show("Nhập lại ngày sinh");
                    dtpNgaySinh.Text = "";
                }
            }
            txtNgaySinh.Focus();
        }

    }
}
