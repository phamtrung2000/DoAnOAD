using BUS;
using DTO;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace QuanLyCinema
{
    /// <summary>
    /// Interaction logic for ThongTinCaNhan.xaml
    /// </summary>
    public partial class frmThongTinCaNhan : UserControl
    {
        public delegate void GuiMaKH(string makh);
        // ví dụ: Mã loại vé đang là LV9 thì soluong sẽ là 9
        // mục đích của cái này là hệ thống tự động tăng mã loại vé lên, người dùng k cần nhập 
        // để tránh trường hợp nhập trùng mã lv
        public GuiMaKH Sender_MaKH;
        string MaKH = null;
        private void GetMaKH(string makh)
        {
            MaKH = makh;
        }

        public frmThongTinCaNhan()
        {
            InitializeComponent();
            Sender_MaKH = new GuiMaKH(GetMaKH);
        }

        string HoTen = null;

        string SDT = null;
        string Email = null;
        string DiaChi = null;
        string NgaySinh = null;
        string NgayDK = null;
        string GioiTinh = null;
        string LoaiKH = null;

        string Money(string money)
        {
            int n = money.Length;
            string kq = "";
            for (int i = n - 1; i >= 3; i -= 3)
            {
                kq = kq.Insert(0, money.Substring(i - 2, 3));
                // kq = 000
                kq = kq.Insert(0, ".");
                // .000
                money = money.Remove(i - 2, 3);
            }
            kq = kq.Insert(0, money);
            return kq;
        }

        string ReMoney(string money)
        {
            string kq = money;
            for (int i = 0; i < kq.Length; i++)
            {
                if (kq[i] == '.')
                    kq = kq.Remove(i, 1);
            }

            return kq;
        }

        private void Grid_ThongTinCaNhan_Loaded(object sender, RoutedEventArgs e)
        {
            DataTable DT_ThongTinCaNhan = new DataTable();
            DT_ThongTinCaNhan = KhachHangBUS.TimTheoMaKH(MaKH);

            object[] a = new object[10];
            a = DT_ThongTinCaNhan.Rows[0].ItemArray;

            string _string = a[1].ToString();
            txtMaKH.Text = "";
            foreach (char s in _string)
            {
                byte temp = (byte)(s);
                txtMaKH.Text += temp.ToString();
            }
            txtHoTen.Text = HoTen = a[2].ToString();
            txtDiaChi.Text = DiaChi = a[3].ToString();
            DateTime ngaychieu = (DateTime)a[4];
            txtNgaySinh.Text = NgaySinh = ngaychieu.Day.ToString() + '/' + ngaychieu.Month.ToString() + '/' + ngaychieu.Year.ToString();
            GioiTinh = a[5].ToString();
            if (GioiTinh == "Nam")
                rdbNam.IsChecked = true;
            else
                rdbNu.IsChecked = true;
            txtSDT.Text = SDT = a[6].ToString();
            txtLoaiKH.Text = LoaiKH = a[7].ToString();
            ngaychieu = (DateTime)a[8];
            txtNgayDK.Text = NgayDK = ngaychieu.Day.ToString() + '/' + ngaychieu.Month.ToString() + '/' + ngaychieu.Year.ToString();
            double tien = double.Parse(a[9].ToString());
            txtTongChiTieu.Text = Money(tien.ToString());
            double phantram = tien / 10000000;
            barTongChiTieu.Value = phantram * 100;
        }

        private void txtHoTen_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                HoTen = txtHoTen.Text;
                KhachHangDTO kh = new KhachHangDTO(MaKH, HoTen, DiaChi, NgaySinh, GioiTinh, SDT, LoaiKH, NgayDK);
                KhachHangBUS.Sua(kh);
                MessageBox.Show("Sửa họ tên thành công");
            }
        }

        private void txtSDT_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                SDT = txtSDT.Text;
                KhachHangDTO kh = new KhachHangDTO(MaKH, HoTen, DiaChi, NgaySinh, GioiTinh, SDT, LoaiKH, NgayDK);
                KhachHangBUS.Sua(kh);
                MessageBox.Show("Sửa số điện thoại thành công");
            }
        }

        private void txtDiaChi_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                DiaChi = txtDiaChi.Text;
                KhachHangDTO kh = new KhachHangDTO(MaKH, HoTen, DiaChi, NgaySinh, GioiTinh, SDT, LoaiKH, NgayDK);
                KhachHangBUS.Sua(kh);
                MessageBox.Show("Sửa địa chỉ thành công");
            }
        }

        private void txtNgaySinh_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                NgaySinh = txtNgaySinh.Text;
                KhachHangDTO kh = new KhachHangDTO(MaKH, HoTen, DiaChi, NgaySinh, GioiTinh, SDT, LoaiKH, NgayDK);
                KhachHangBUS.Sua(kh);
                MessageBox.Show("Sửa ngày sinh thành công");
            }
        }

        private void txtNgayDK_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                NgayDK = txtNgayDK.Text;
                KhachHangDTO kh = new KhachHangDTO(MaKH, HoTen, DiaChi, NgaySinh, GioiTinh, SDT, LoaiKH, NgayDK);
                KhachHangBUS.Sua(kh);
                MessageBox.Show("Sửa ngày sinh thành công");
            }
        }

        private void rdbNam_Click(object sender, RoutedEventArgs e)
        {
            if (GioiTinh == "Nữ")
            {
                GioiTinh = "Nam";
                KhachHangDTO kh = new KhachHangDTO(MaKH, HoTen, DiaChi, NgaySinh, GioiTinh, SDT, LoaiKH, NgayDK);
                KhachHangBUS.Sua(kh);
                MessageBox.Show("Sửa giới tính thành công");
            }
        }

        private void rdbNu_Click(object sender, RoutedEventArgs e)
        {
            if (GioiTinh == "Nam")
            {
                GioiTinh = "Nữ";
                KhachHangDTO kh = new KhachHangDTO(MaKH, HoTen, DiaChi, NgaySinh, GioiTinh, SDT, LoaiKH, NgayDK);
                KhachHangBUS.Sua(kh);
                MessageBox.Show("Sửa giới tính thành công");
            }
        }
    }
}
