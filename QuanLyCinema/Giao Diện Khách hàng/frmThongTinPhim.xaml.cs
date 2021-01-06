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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Threading;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using BUS;
using DTO;

namespace QuanLyCinema.Giao_Diện_Khách_hàng
{
    /// <summary>
    /// Interaction logic for frmThongtinPhim.xaml
    /// </summary>
    public partial class frmThongTinPhim : UserControl
    {
        List<PhimDTO> listPhim = new List<PhimDTO>();

        public delegate void GuiDiaChiAnh(string diachi); // gửi địa chỉ ảnh

        public GuiDiaChiAnh Sender;

        public static string DiaChi = null;

        private void Get_DiaChiAnh(string diachi)
        {
            DiaChi = diachi;
        }

        public delegate void GuiMaPhim(string diachi); // gửi địa chỉ ảnh

        public GuiMaPhim Sender_MaPhim;

        public static string MaPhim = null;

        private void Get_MaPhim(string maphim)
        {
            MaPhim = maphim;
        }

        public frmThongTinPhim()
        {
            InitializeComponent();
            Sender = new GuiDiaChiAnh(Get_DiaChiAnh);
            Sender_MaPhim = new GuiMaPhim(Get_MaPhim);
        }

        void Load_Data(DataTable dataTable)
        {
            object[] a = new object[9];
            a = dataTable.Rows[0].ItemArray;
            string maphim = a[1].ToString();
            lblTenPhim.Text = a[2].ToString();
            txtDaoDien.Text = a[3].ToString();
            txtDienVien.Text = a[4].ToString();
            txtND.Text = a[5].ToString();
            txtNamSX.Text = a[6].ToString();
            txtNuocSX.Text = a[7].ToString();
            txtThoiLuong.Text = a[8].ToString();

            DataTable dataTable_theloai = PhimBUS.LoadTheLoaiPhim(maphim);
            object[] b = new object[2];
            b = dataTable_theloai.Rows[0].ItemArray;
            txtTheLoai.Text += b[1].ToString();
            for (int j = 0; j <= dataTable_theloai.Rows.Count - 1; j++)
            {
                b = new object[2];
                b = dataTable_theloai.Rows[j].ItemArray;
                txtTheLoai.Text += ", " + b[1].ToString();
            }
        }

        private void GridfrmThongTinPhim_Loaded(object sender, RoutedEventArgs e)
        {
            Image carImg = new Image();
            BitmapImage carBitmap = new BitmapImage(new Uri(DiaChi, UriKind.Absolute));
            carImg.Width = 165;
            carImg.Height = 260;
            carImg.Source = carBitmap;
            carImg.Stretch = Stretch.Fill;
            canvas1.Children.Add(carImg);

            ImageBrush myBrush = new ImageBrush();
            Image image = new Image();
            image.Source = new BitmapImage(new Uri(DiaChi));
            myBrush.ImageSource = image.Source;
            myBrush.Opacity = 0.4;
            GridfrmThongTinPhim.Background = myBrush;

            DataTable dataTable = new DataTable();
            dataTable = PhimBUS.TimTheoMaP(MaPhim);
            Load_Data(dataTable);

        }

        private void btBack_Click(object sender, RoutedEventArgs e)
        {
            GridfrmThongTinPhim.Children.Clear();
            GridfrmThongTinPhim.Children.Add(new frmXemThongTinPhim());
        }

    }
}
