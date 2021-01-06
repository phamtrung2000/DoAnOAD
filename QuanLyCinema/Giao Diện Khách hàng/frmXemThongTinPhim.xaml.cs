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
using Microsoft.Win32;

namespace QuanLyCinema.Giao_Diện_Khách_hàng
{
    /// <summary>
    /// Interaction logic for frmXemThongTinPhim.xaml
    /// </summary>
    public partial class frmXemThongTinPhim : UserControl
    {

        public frmXemThongTinPhim()
        {
            InitializeComponent();
        }

        string DiaChiPoster = null;

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
                stackpanel.Height = stackpanel.MaxHeight = 350;
                //stackpanel.Background = Brushes.Red;
                stackpanel.Margin = new Thickness(5, 5, 10, 5);
                WrapPanel_DanhSachPhim.Children.Add(stackpanel);

                Image image = new Image();
                image.Name = a[1].ToString();
                image.Width = image.MaxWidth = stackpanel.Width;
                image.Height = image.MaxHeight = stackpanel.Height - 50;
                image.Stretch = Stretch.Uniform;
                image.MouseDown += Image_MouseDown;
                string linkPoster = "pack://application:,,,/Resources/";
                image.Source = new BitmapImage(new Uri(linkPoster + a[9].ToString(), UriKind.Absolute));
                image.Margin = new Thickness(5, 5, 10, 5);
                stackpanel.Children.Add(image);

                TextBlock textblock = new TextBlock();
                textblock.Width = stackpanel.Width - 10;
                textblock.Height = stackpanel.Height - 320;
                textblock.Text = a[2].ToString();
                //textblock.Background = Brushes.Blue;
                textblock.Foreground = Brushes.White;
                textblock.Margin = new Thickness(5, 5, 10, 5);
                textblock.TextWrapping = TextWrapping.Wrap;
                stackpanel.Children.Add(textblock);
            }
        }

        int soluong_phim = 0;

        public static string MaPhim = null;

        private void Image_MouseDown(object sender, RoutedEventArgs e)
        {
            Image temp = (Image)sender;
            MaPhim = temp.Name;

            frmThongTinPhim frmThongTinPhim = new frmThongTinPhim();
            DiaChiPoster = temp.Source.ToString();
            frmThongTinPhim.Sender(DiaChiPoster);
            frmThongTinPhim.Sender_MaPhim(MaPhim);
            Grid_hienthi.Children.Clear();
            Grid_hienthi.Children.Add(frmThongTinPhim);
        }
    }
}
