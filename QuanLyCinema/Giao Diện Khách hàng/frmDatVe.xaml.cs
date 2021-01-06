using BUS;
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

namespace QuanLyCinema.Giao_Diện_Khách_hàng
{
    /// <summary>
    /// Interaction logic for frmDatve.xaml
    /// </summary>
    public partial class frmDatVe : UserControl
    {
        public delegate void GuiMaKH(string makh);
        // ví dụ: Mã loại vé đang là LV9 thì soluong sẽ là 9
        // mục đích của cái này là hệ thống tự động tăng mã loại vé lên, người dùng k cần nhập 
        // để tránh trường hợp nhập trùng mã lv
        public GuiMaKH Sender_MaKH;
        public static string MaKH = null;
        private void GetMaKH(string makh)
        {
            MaKH = makh;
        }

        string DiaChiPoster = null;

        public frmDatVe()
        {
            InitializeComponent();
            Sender_MaKH = new GuiMaKH(GetMaKH);
        }

        private void MuaVe_Click(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            DiaChiPoster = button.Tag.ToString();
            frmChon_NgayChieu_CaChieu frmChon_NgayChieu_CaChieu = new frmChon_NgayChieu_CaChieu();
            frmChon_NgayChieu_CaChieu.Sender(button.Name);
            frmChon_NgayChieu_CaChieu.Sender_DiaChiAnh(DiaChiPoster);
            frmChon_NgayChieu_CaChieu.Sender_MaKH(MaKH);
            Grid_hienthi.Children.Clear();
            Grid_hienthi.Children.Add(frmChon_NgayChieu_CaChieu);
        }

        int soluong_phim = 0;
        private void Grid_DanhSachPhim_Loaded(object sender, RoutedEventArgs e)
        {
            // lấy số lượng phòng chiếu của rạp, từ đó datagrid sẽ thêm số lượng cột là số lượng phòng chiếu
            DataTable DT_DSPhim = new DataTable();
            DT_DSPhim = PhimBUS.LoadDSPhim();
            soluong_phim = DT_DSPhim.Rows.Count;

            for (int i = 0; i < soluong_phim; i++)
            {
                object[] a = new object[10];
                a = DT_DSPhim.Rows[i].ItemArray;
                StackPanel stackpanel = new StackPanel();
                stackpanel.Width = stackpanel.MaxWidth = 280;
                stackpanel.Height = stackpanel.MaxHeight = 400;
                stackpanel.Margin = new Thickness(5, 5, 10, 5);
                WrapPanel_DanhSachPhim.Children.Add(stackpanel);

                Image image = new Image();
                image.Width = image.MaxWidth = stackpanel.Width;
                image.Height = image.MaxHeight = (stackpanel.Height * 2 / 3) + 10;
                image.Stretch = Stretch.Uniform;
                string linkPoster = "pack://application:,,,/Resources/";
                image.Source = new BitmapImage(new Uri(linkPoster + a[9].ToString(), UriKind.Absolute));
                image.Margin = new Thickness(0, 5, 0, 5);
                stackpanel.Children.Add(image);

                TextBlock textblock = new TextBlock();
                textblock.Width = stackpanel.Width - 10;
                textblock.Height = stackpanel.Height / 8;
                textblock.Text = a[2].ToString();
                textblock.Foreground = Brushes.White;
                textblock.Margin = new Thickness(5, 5, 10, 5);
                textblock.TextWrapping = TextWrapping.Wrap;
                stackpanel.Children.Add(textblock);

                Button button = new Button();
                button.Name = a[1].ToString();
                button.Content = "Đặt vé";
                button.Tag = linkPoster + a[9].ToString();
                button.Width = button.MaxWidth = textblock.Width;
                button.Height = button.MaxHeight = stackpanel.Height / 10;
                button.Click += MuaVe_Click;
                button.Margin = new Thickness(5, 0, 10, 10);
                stackpanel.Children.Add(button);

            }
        }
    }
}
