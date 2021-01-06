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


using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using BUS;
using DTO;
using System.Windows.Threading;

namespace QuanLyCinema.Giao_Diện_Khách_hàng
{
    /// <summary>
    /// Interaction logic for frmThongTinDatVe.xaml
    /// </summary>
    public partial class frmChon_NgayChieu_CaChieu : UserControl
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

        public delegate void GuiDiaChiAnh(string diachi); // gửi địa chỉ ảnh
        public GuiDiaChiAnh Sender_DiaChiAnh;
        public static string DiaChi = null;
        private void Get_DiaChiAnh(string diachi)
        {
            DiaChi = diachi;
        }

        public delegate void GuiMaPhim(string maphim);

        public GuiMaPhim Sender;

        public static string MaPhim = null;
        public static string MaCC = null;
        public static string NgayChieu;

        private void GetMaPhim(string maphim)
        {
            MaPhim = maphim;
        }

        public frmChon_NgayChieu_CaChieu()
        {
            InitializeComponent();
            Sender = new GuiMaPhim(GetMaPhim);
            Sender_DiaChiAnh = new GuiDiaChiAnh(Get_DiaChiAnh);
            Sender_MaKH = new GuiMaKH(GetMaKH);
        }
        int soluong_cachieu = 0;
        DateTime ngaychieu;

        void LoadAnhBackground()
        {
            ImageBrush myBrush = new ImageBrush();
            Image image = new Image();
            image.Source = new BitmapImage(new Uri(DiaChi));
            myBrush.ImageSource = image.Source;
            myBrush.Opacity = 0.4;
            Grid_Chon_NgayChieu_CaChieu.Background = myBrush;
        }

        string Monday_Thu2(string a)
        {
            string kq = null;
            switch (a)
            {
                case "Sunday":
                    {
                        kq = "CN"; break;
                    }
                case "Monday":
                    {
                        kq = "Th2"; break;
                    }
                case "Tuesday":
                    {
                        kq = "Th3"; break;
                    }
                case "Wednesday":
                    {
                        kq = "Th4"; break;
                    }
                case "Thursday":
                    {
                        kq = "Th5"; break;
                    }
                case "Friday":
                    {
                        kq = "Th6"; break;
                    }
                case "Saturday":
                    {
                        kq = "Th7"; break;
                    }
            }
            return kq;
        }

        int int_Monday_Thu2(string a)
        {
            int kq = -1;
            switch (a)
            {
                case "Sunday":
                    {
                        kq = 0; break;
                    }
                case "Monday":
                    {
                        kq = 1; break;
                    }
                case "Tuesday":
                    {
                        kq = 2; break;
                    }
                case "Wednesday":
                    {
                        kq = 3; break;
                    }
                case "Thursday":
                    {
                        kq = 4; break;
                    }
                case "Friday":
                    {
                        kq = 5; break;
                    }
                case "Saturday":
                    {
                        kq = 6; break;
                    }
            }
            return kq;
        }

        string string_Monday_Thu2(int a)
        {
            string kq = null;
            switch (a)
            {
                case 0:
                    {
                        kq = "CN"; break;
                    }
                case 1:
                    {
                        kq = "Th2"; break;
                    }
                case 2:
                    {
                        kq = "Th3"; break;
                    }
                case 3:
                    {
                        kq = "Th4"; break;
                    }
                case 4:
                    {
                        kq = "Th5"; break;
                    }
                case 5:
                    {
                        kq = "Th6"; break;
                    }
                case 6:
                    {
                        kq = "Th7"; break;
                    }
            }
            return kq;
        }

        private void Grid_Chon_NgayChieu_CaChieu_Loaded(object sender, RoutedEventArgs e)
        {
            LoadAnhBackground();
            ExpanderCinemaThuDuc.IsExpanded = false;
            DateTime now = DateTime.Now;

            txtNgay1.Text = now.Day.ToString() + '/' + now.Month.ToString();
            txtThu1.Text = Monday_Thu2(now.DayOfWeek.ToString());

            DayOfWeek dayOfWeek = now.DayOfWeek;
            int number_dayofweek = int_Monday_Thu2(dayOfWeek.ToString());

            txtNgay2.Text = (now.Day + 1).ToString() + '/' + now.Month.ToString();
            txtThu2.Text = string_Monday_Thu2((number_dayofweek + 1) % 7);

            txtNgay3.Text = (now.Day + 2).ToString() + '/' + now.Month.ToString();
            txtThu3.Text = string_Monday_Thu2((number_dayofweek + 2) % 7);

            txtNgay4.Text = (now.Day + 3).ToString() + '/' + now.Month.ToString();
            txtThu4.Text = string_Monday_Thu2((number_dayofweek + 3) % 7);

            txtNgay5.Text = (now.Day + 4).ToString() + '/' + now.Month.ToString();
            txtThu5.Text = string_Monday_Thu2((number_dayofweek + 4) % 7);

            txtNgay6.Text = (now.Day + 5).ToString() + '/' + now.Month.ToString();
            txtThu6.Text = string_Monday_Thu2((number_dayofweek + 5) % 7);

            txtNgay7.Text = (now.Day + 6).ToString() + '/' + now.Month.ToString();
            txtThu7.Text = string_Monday_Thu2((number_dayofweek + 6) % 7);

            btnNgay1_Click(sender, e);

            timer_today.Interval = TimeSpan.FromSeconds(1);
            timer_today.Tick += timer_today_Tick;
            timer_today.Start();

            timer_nextday.Interval = TimeSpan.FromSeconds(1);
            timer_nextday.Tick += timer_nextday_Tick;
            timer_nextday.Stop();
        }

        void AddButtonCaChieu_Today()
        {
            // lấy số lượng phòng chiếu của rạp, từ đó datagrid sẽ thêm số lượng cột là số lượng phòng chiếu
            DataTable DT_DatVe = new DataTable();
            DT_DatVe = LichChieuBUS.DatVe_Phim_NgayChieu(MaPhim, NgayChieu);
            soluong_cachieu = DT_DatVe.Rows.Count;

            if (soluong_cachieu == 0)
            {
                MessageBox.Show("Hiện tại chưa có lịch chiếu của ngày bạn đã chọn");
            }
            else
            {
                for (int i = 0; i < soluong_cachieu; i++)
                {
                    object[] a = new object[6];
                    a = DT_DatVe.Rows[i].ItemArray;
                    Button button = new Button();

                    button.Name = a[3].ToString();
                    DateTime batdau_temp = DateTime.Parse(a[4].ToString());
                    string batdau = batdau_temp.TimeOfDay.ToString();
                    button.Content = batdau;
                    button.FontSize = 17;
                    button.Width = 140;
                    button.Height = 45;
                    button.Margin = new Thickness(5, 5, 10, 5);
                    button.Click += Button_Click;
                    if(batdau_temp.Hour <= DateTime.Now.Hour)
                    {
                        button.IsEnabled = false;
                    }
                    panelChonNgayChieu_CaChieu_ThuDuc.Children.Add(button);
                }
            }

        }

        void AddButtonCaChieu_NextDay()
        {
            // lấy số lượng phòng chiếu của rạp, từ đó datagrid sẽ thêm số lượng cột là số lượng phòng chiếu
            DataTable DT_DatVe = new DataTable();
            DT_DatVe = LichChieuBUS.DatVe_Phim_NgayChieu(MaPhim, NgayChieu);
            soluong_cachieu = DT_DatVe.Rows.Count;

            if (soluong_cachieu == 0)
            {
                MessageBox.Show("Hiện tại chưa có lịch chiếu của ngày bạn đã chọn");
            }
            else
            {
                for (int i = 0; i < soluong_cachieu; i++)
                {
                    object[] a = new object[6];
                    a = DT_DatVe.Rows[i].ItemArray;
                    Button button = new Button();

                    button.Name = a[3].ToString();

                    DateTime batdau_temp = DateTime.Parse(a[4].ToString());
                    string batdau = batdau_temp.TimeOfDay.ToString();
                    button.Content = batdau;
                    button.FontSize = 17;
                    button.Width = 140;
                    button.Height = 45;
                    button.Margin = new Thickness(5, 5, 10, 5);
                    button.Click += Button_Click;
                  
                    panelChonNgayChieu_CaChieu_ThuDuc.Children.Add(button);
                }
            }

        }

        private void bt_back_Click(object sender, RoutedEventArgs e)
        {
            Grid_Chon_NgayChieu_CaChieu.Children.Clear();
            Grid_Chon_NgayChieu_CaChieu.Children.Add(new frmDatVe());
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Button temp = (Button)sender;
            MaCC = temp.Name;
            Grid_Chon_NgayChieu_CaChieu.Children.Clear();

            frmChonChoNgoi frmChonChoNgoi = new frmChonChoNgoi();
            frmChonChoNgoi.Sender_DiaChiAnh(DiaChi);
            frmChonChoNgoi.Sender(MaPhim, NgayChieu, MaCC);
            frmChonChoNgoi.Sender_MaKH(MaKH);
            //Grid_Chon_NgayChieu_CaChieu.Children.Add(new frmChonChoNgoi());
            Grid_Chon_NgayChieu_CaChieu.Children.Add(frmChonChoNgoi);
        }

        private void dtpNgayChieu_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            //ExpanderCinemaThuDuc.Visibility = Visibility.Visible;
        }

        DispatcherTimer timer_today = new DispatcherTimer();
        DispatcherTimer timer_nextday = new DispatcherTimer();

        void timer_today_Tick(object sender, EventArgs e)
        {
            double a = timer_today.Interval.TotalSeconds;
            if (timer_today.Interval.TotalSeconds >= 1)
            {
                ExpanderCinemaThuDuc.IsExpanded = true;
                timer_today.Stop();
                AddButtonCaChieu_Today();
            }
        }

        void timer_nextday_Tick(object sender, EventArgs e)
        {
            double a = timer_nextday.Interval.TotalSeconds;
            if (timer_today.Interval.TotalSeconds >= 1)
            {
                ExpanderCinemaThuDuc.IsExpanded = true;
                timer_nextday.Stop();
                AddButtonCaChieu_NextDay();
            }
        }

        private void btnNgay1_Click(object sender, RoutedEventArgs e)
        {
            btnNgay1.Background = Brushes.Black;
            btnNgay2.Background = btnNgay3.Background = btnNgay4.Background = btnNgay5.Background = btnNgay6.Background = btnNgay7.Background = Brushes.AliceBlue;
            NgayChieu = txtNgay1.Text + "/" + DateTime.Now.Year.ToString();
            panelChonNgayChieu_CaChieu_ThuDuc.Children.Clear();
            ExpanderCinemaThuDuc.IsExpanded = false;
            timer_today.Start();
        }

        private void btnNgay2_Click(object sender, RoutedEventArgs e)
        {
            btnNgay2.Background = Brushes.Black;
            btnNgay1.Background = btnNgay3.Background = btnNgay4.Background = btnNgay5.Background = btnNgay6.Background = btnNgay7.Background = Brushes.AliceBlue;
            NgayChieu = txtNgay2.Text + "/" + DateTime.Now.Year.ToString();
            panelChonNgayChieu_CaChieu_ThuDuc.Children.Clear();
            ExpanderCinemaThuDuc.IsExpanded = false;
            timer_nextday.Start();
        }

        private void btnNgay3_Click(object sender, RoutedEventArgs e)
        {
            btnNgay3.Background = Brushes.Black;
            btnNgay1.Background = btnNgay2.Background = btnNgay4.Background = btnNgay5.Background = btnNgay6.Background = btnNgay7.Background = Brushes.AliceBlue;
            NgayChieu = txtNgay2.Text + "/" + DateTime.Now.Year.ToString();
            panelChonNgayChieu_CaChieu_ThuDuc.Children.Clear();
            ExpanderCinemaThuDuc.IsExpanded = false;
            timer_nextday.Start();
        }

        private void btnNgay4_Click(object sender, RoutedEventArgs e)
        {
            btnNgay4.Background = Brushes.Black;
            btnNgay1.Background = btnNgay3.Background = btnNgay2.Background = btnNgay5.Background = btnNgay6.Background = btnNgay7.Background = Brushes.AliceBlue;
            NgayChieu = txtNgay2.Text + "/" + DateTime.Now.Year.ToString();
            panelChonNgayChieu_CaChieu_ThuDuc.Children.Clear();
            ExpanderCinemaThuDuc.IsExpanded = false;
            timer_nextday.Start();
        }

        private void btnNgay5_Click(object sender, RoutedEventArgs e)
        {
            btnNgay5.Background = Brushes.Black;
            btnNgay1.Background = btnNgay3.Background = btnNgay4.Background = btnNgay2.Background = btnNgay6.Background = btnNgay7.Background = Brushes.AliceBlue;
            NgayChieu = txtNgay2.Text + "/" + DateTime.Now.Year.ToString();
            panelChonNgayChieu_CaChieu_ThuDuc.Children.Clear();
            ExpanderCinemaThuDuc.IsExpanded = false;
            timer_nextday.Start();
        }

        private void btnNgay6_Click(object sender, RoutedEventArgs e)
        {
            btnNgay6.Background = Brushes.Black;
            btnNgay1.Background = btnNgay3.Background = btnNgay4.Background = btnNgay5.Background = btnNgay2.Background = btnNgay7.Background = Brushes.AliceBlue;
            NgayChieu = txtNgay2.Text + "/" + DateTime.Now.Year.ToString();
            panelChonNgayChieu_CaChieu_ThuDuc.Children.Clear();
            ExpanderCinemaThuDuc.IsExpanded = false;
            timer_nextday.Start();
        }

        private void btnNgay7_Click(object sender, RoutedEventArgs e)
        {
            btnNgay7.Background = Brushes.Black;
            btnNgay1.Background = btnNgay3.Background = btnNgay4.Background = btnNgay5.Background = btnNgay6.Background = btnNgay2.Background = Brushes.AliceBlue;
            NgayChieu = txtNgay2.Text + "/" + DateTime.Now.Year.ToString();
            panelChonNgayChieu_CaChieu_ThuDuc.Children.Clear();
            ExpanderCinemaThuDuc.IsExpanded = false;
            timer_nextday.Start();
        }
    }
}
