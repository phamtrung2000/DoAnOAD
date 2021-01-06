using QuanLyCinema.Giao_Diện_Khách_hàng;
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

namespace QuanLyCinema
{
    /// <summary>
    /// Interaction logic for GiaoDienChinh_KhachHang.xaml
    /// </summary>
    public partial class GiaoDienChinh_KhachHang : Window
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

        public GiaoDienChinh_KhachHang()
        {
            InitializeComponent();
            Sender_MaKH = new GuiMaKH(GetMaKH);
        }

        private void ListViewItem_Selected(object sender, RoutedEventArgs e)
        {

        }

        private void ListViewMenu_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

            int index = ListViewMenu.SelectedIndex;

            switch (index)
            {
               
                case 0:
                    {
                        GridHienThi.Children.Clear();
                        GridHienThi.Children.Add(new frmXemThongTinPhim());
                    }
                   
                    break;
                case 1:
                    {
                        GridHienThi.Children.Clear();
                        GridHienThi.Children.Add(new frmXemLichChieu());
                    }
                   
                    break;
                case 2:
                    {
                        GridHienThi.Children.Clear();
                        frmDatVe frmDatVe = new frmDatVe();
                        frmDatVe.Sender_MaKH(MaKH);
                        GridHienThi.Children.Add(frmDatVe);
                    }
                    break;
                case 3:
                    {
                        GridHienThi.Children.Clear();
                        frmThongTinCaNhan _frmThongTinCaNhan = new frmThongTinCaNhan();
                        _frmThongTinCaNhan.Sender_MaKH(MaKH);
                        GridHienThi.Children.Add(_frmThongTinCaNhan);
                    }
                    break;
                case 4:
                    {
                        GridHienThi.Children.Clear();
                        frmLichSuDatVe _frmLichSuDatVe = new frmLichSuDatVe();
                        _frmLichSuDatVe.Sender_MaKH(MaKH);
                        GridHienThi.Children.Add(_frmLichSuDatVe);
                    }
                    break;
            }
        }

        private void bt_shutdown_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void bt_logout_Click(object sender, RoutedEventArgs e)
        {
            Login lg = new Login();
            this.Close();
            lg.Show();
        }


    }
}
