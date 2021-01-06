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

namespace QuanLyCinema.Giao_Diện_Khách_hàng
{
    /// <summary>
    /// Interaction logic for frmXacNhanThanhToan.xaml
    /// </summary>
    public partial class frmXacNhanThanhToan : Window
    {
        public delegate void Gui_TenPhim_CaChieu_NgayChieu_TenPhongChieu(string tenphim, string cachieu, string ngaychieu, string tenphongchieu);
        public Gui_TenPhim_CaChieu_NgayChieu_TenPhongChieu Sender_TenPhim_CaChieu_NgayChieu_TenPhongChieu;

        public static string TenPhim = null;
        public static string CaChieu = null;
        public static string NgayChieu = null;
        public static string TenPhongChieu = null;

        private void Get_TenPhim_CaChieu_NgayChieu_TenPhongChieu(string tenphim, string cachieu, string ngaychieu, string tenphongchieu)
        {
            TenPhim = tenphim;
            CaChieu = cachieu;
            NgayChieu = ngaychieu;
            TenPhongChieu = tenphongchieu;
        }

        public static List<string> ListMaGhe = new List<string>();

        public delegate void GuiListMaGhe(List<string> a);
        public GuiListMaGhe Sender_ListMaGhe;

        private void GetListMaGhe(List<string> a)
        {
            ListMaGhe = a;
        }

        public static frmThanhToan FrmThanhToan;

        public delegate void GuifrmThanhToan(frmThanhToan FrmThanhToan);
        public GuifrmThanhToan Sender_frmThanhToan;
        private void GetfrmThanhToan(frmThanhToan frmthanhtoan)
        {
            FrmThanhToan = frmthanhtoan;
        }

        public frmXacNhanThanhToan()
        {
            InitializeComponent();
            Sender_TenPhim_CaChieu_NgayChieu_TenPhongChieu = new Gui_TenPhim_CaChieu_NgayChieu_TenPhongChieu(Get_TenPhim_CaChieu_NgayChieu_TenPhongChieu);
            Sender_ListMaGhe = new GuiListMaGhe(GetListMaGhe);
            Sender_frmThanhToan = new GuifrmThanhToan(GetfrmThanhToan);
        }

        string LayChu_SoGhe(string a) // lấy chữ + số từ mã phim : A1PC1CC1 -> A1
        {
            string kq = "";
            kq += a[0];
            int i = 1;
            while (a[i] >= '0' && a[i] <= '9')
            {
                kq += a[i];
                i++;
            }
            return kq;
        }

        private void GridXacNhanThanhToan_Loaded(object sender, RoutedEventArgs e)
        {
            txtTenPhim.Text = TenPhim;
            txtGhe.Text = LayChu_SoGhe(ListMaGhe[0]);
            for (int i = 1; i < ListMaGhe.Count; i++)
            {
                txtGhe.Text += "," + LayChu_SoGhe(ListMaGhe[i]);
            }
            txtCaChieu.Text = CaChieu;
            txtPhongChieu.Text = TenPhongChieu;
            txtNgayChieu.Text = NgayChieu;
            txtNgayMua.Text = DateTime.Now.ToString();
        }

        private void btnXacNhan_Click(object sender, RoutedEventArgs e)
        {
            FrmThanhToan.Sender_XacNhan(true);
            MessageBox.Show("Bạn đã đặt vé thành công", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Close();
        }

        private void btnHuy_Click(object sender, RoutedEventArgs e)
        {
            FrmThanhToan.Sender_XacNhan(false);
            this.Close();
        }
    }
}
