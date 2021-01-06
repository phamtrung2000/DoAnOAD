using System;
using System.Collections.Generic;
using System.Collections.Specialized;
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
    public partial class frmChonChoNgoi : UserControl
    {
        public delegate void GuiDiaChiAnh(string diachi); // gửi địa chỉ ảnh
        public GuiDiaChiAnh Sender_DiaChiAnh;
        public static string DiaChi = null;
        private void Get_DiaChiAnh(string diachi)
        {
            DiaChi = diachi;
        }

        public static string MaKH = null;

        public delegate void GuiMaKH(string makh);
        public GuiMaKH Sender_MaKH;

        private void GetMaKH(string makh)
        {
            MaKH = makh;
        }


        public delegate void GuiMaPhim_NgayChieu_MaCC(string maphim, string ngaychieu, string macc);
        public GuiMaPhim_NgayChieu_MaCC Sender;

        public static string MaPhim = null;
        public static string MaCC = null;
        public static string NgayChieu;
        public static string MaPC = null;

        private void GetMaPhim_NgayChieu_MaCC(string maphim, string ngaychieu, string macc)
        {
            MaPhim = maphim;
            NgayChieu = ngaychieu;
            MaCC = macc;
        }



        public frmChonChoNgoi()
        {
            InitializeComponent();
            Sender_DiaChiAnh = new GuiDiaChiAnh(Get_DiaChiAnh);
            Sender = new GuiMaPhim_NgayChieu_MaCC(GetMaPhim_NgayChieu_MaCC);
            Sender_MaKH = new GuiMaKH(GetMaKH);
            txtManhinh.IsReadOnly = true;
            txtHienThiGheDaChon.IsReadOnly = true;
        }
        int count = 0;
        // Ghế A1

        void ChuotEnterGhe(object sender, RoutedEventArgs e)
        {
            Button temp = (Button)sender;
            temp.Foreground = Brushes.Black;
        }

        void ChuotLeaveGhe(object sender, RoutedEventArgs e)
        {
            Button temp = (Button)sender;
            temp.Foreground = Brushes.White;
        }

        int SL_VeThuong, SL_VeVip, SL_VeCouple = 0;
        List<string> List_MaGhe = new List<string>();

        void ClickChoNgoi(object sender, RoutedEventArgs e, bool check_temp)
        {
            Button temp = (Button)sender;
            if (check_temp == true)
            {
                temp.Background = Brushes.Green;
                temp.Foreground = Brushes.White;
                count++;
                if (count > 5)
                {
                    MessageBox.Show("Khong duoc dat qua 5 ve");
                }
                else
                {
                    if (txtHienThiGheDaChon.Text.Length == 0)
                    {
                        txtHienThiGheDaChon.Text += temp.Name;
                    }
                    else
                        txtHienThiGheDaChon.Text += ", " + temp.Name;

                    if (temp.Name[0] >= 'A' && temp.Name[0] <= 'D')
                        SL_VeThuong++;
                    else if (temp.Name[0] >= 'E' && temp.Name[0] <= 'G')
                        SL_VeVip++;
                    else if (temp.Name[0] >= 'H' && temp.Name[0] <= 'Z')
                        SL_VeCouple++;
                    List_MaGhe.Add(temp.Name);
                }
            }
            else
            {
                temp.Background = Brushes.White;
                temp.Foreground = Brushes.Black;
                count--;
                int vitrixoa = txtHienThiGheDaChon.Text.IndexOf(temp.Name);
                if (vitrixoa <= 2)
                {
                    if (txtHienThiGheDaChon.Text.Length == 2)

                    {
                        txtHienThiGheDaChon.Text = txtHienThiGheDaChon.Text.Remove(vitrixoa, temp.Name.Length);
                    }
                    else
                        txtHienThiGheDaChon.Text = txtHienThiGheDaChon.Text.Remove(vitrixoa, temp.Name.Length + 2);
                }
                else
                    txtHienThiGheDaChon.Text = txtHienThiGheDaChon.Text.Remove(vitrixoa - 2, temp.Name.Length + 2);
            }
        }

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

        double tongcong = 0;

        private void txtHienThiGheDaChon_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void bt_back_Click(object sender, RoutedEventArgs e)
        {
            GridChonChoNgoi.Children.Clear();
            GridChonChoNgoi.Children.Add(new frmChon_NgayChieu_CaChieu());
        }

        string batdau, ketthuc = null;

        void LoadData_GridThongTin()
        {
            DataTable DT_ChoNgoi = DatVeBUS.DatVe_Load_ChonChoNgoi(MaPhim, NgayChieu, MaCC);
            object[] a = new object[5];
            a = DT_ChoNgoi.Rows[0].ItemArray;
            lblTenPhim.Content = a[3].ToString();

            lblPhongChieu.Content = a[0].ToString();

            DateTime batdau_temp = DateTime.Parse(a[1].ToString());
            batdau = batdau_temp.TimeOfDay.ToString();

            DateTime kethuc_temp = DateTime.Parse(a[2].ToString());
            //  string ketthuc = kethuc_temp.Hour.ToString() + ":" + kethuc_temp.Minute.ToString() + ":" + kethuc_temp.Second.ToString();
            ketthuc = kethuc_temp.TimeOfDay.ToString();

            lblCaChieu.Content = "Suất " + batdau.ToString() + " - " + ketthuc.ToString();
            //DateTime ngaychieu_temp = NgayChieu;
            //string ngaychieu = ngaychieu_temp.Day.ToString() + "/" + ngaychieu_temp.Month.ToString() + "/" + ngaychieu_temp.Year.ToString();
            //lblNgayChieu.Content = ngaychieu;
            lblNgayChieu.Content = NgayChieu;
            MaPC = a[4].ToString();
        }

        List<string> listChoNgoi_MaLV = new List<string>();
        List<string> listChoNgoi_TrangThai = new List<string>();

        string LaySoGhe(string a) // lấy số từ mã phim : A1PC1CC1 -> 1
        {
            string kq = "";
            int i = 1;
            while (a[i] >= '0' && a[i] <= '9')
            {
                kq += a[i];
                i++;
            }
            return kq;
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

        private void Grid_DanhSachGhe_Loaded(object sender, RoutedEventArgs e)
        {
            DataTable DT_DSChoNgoi = new DataTable();
            DT_DSChoNgoi = DatVeBUS.DatVe_LoadDSChoNgoi(MaPhim, NgayChieu, MaCC);
            for (int i = 0; i < DT_DSChoNgoi.Rows.Count; i++)
            {
                // ListGhe_Check[i] = false;
                object[] a = new object[4];
                a = DT_DSChoNgoi.Rows[i].ItemArray;

                Button button = new Button();
                button.Name = a[0].ToString(); // 0/1 : vị trí để làm vụ bool check + giá mỗi ghế
                button.Content = LaySoGhe(a[0].ToString()); // 1
                button.Tag = LayChu_SoGhe(a[0].ToString()); // A1
                button.ToolTip = a[1].ToString();
                if (a[2].ToString() == "Đặt")
                {
                    button.IsEnabled = false;
                }
                else
                    button.IsEnabled = true;

                string gia_string = a[3].ToString();
                double gia = double.Parse(gia_string);
                gia_string = gia.ToString();

                button.Tag += "/" + gia_string + "/" + "false";


                button.Width = button.MaxWidth = 40;
                button.Height = button.MaxHeight = 40;
                button.Background = Brushes.White;
                button.Foreground = Brushes.White;
                button.HorizontalAlignment = HorizontalAlignment.Left;
                button.VerticalAlignment = VerticalAlignment.Top;
                button.FontSize = 7;
                button.Margin = new Thickness(5, 5, 5, 5);
                button.Click += ButtonGhe_Click;
                button.MouseEnter += Button_MouseEnter;
                button.MouseLeave += Button_MouseLeave;
                WrapPanel_DanhSachGhe.Children.Add(button);
            }

        }

        private void ButtonGhe_Click(object sender, RoutedEventArgs e)
        {
            Button button = (Button)sender;
            string[] array = button.Tag.ToString().Split('/');

            if (array[2] == "false")
            {
                button.Background = Brushes.Green;
                button.Foreground = Brushes.White;
                count++;
                if (count > 5)
                {
                    MessageBox.Show("Khong duoc dat qua 5 ve");
                    button.Background = Brushes.White;
                    button.Foreground = Brushes.Black;
                }
                else
                {
                    if (txtHienThiGheDaChon.Text.Length == 0)
                    {
                        txtHienThiGheDaChon.Text += array[0];
                    }
                    else
                    {
                        txtHienThiGheDaChon.Text += ", " + array[0];
                    }

                    if (array[0][0] >= 'A' && array[0][0] <= 'D')
                        SL_VeThuong++;
                    else if (array[0][0] >= 'E' && array[0][0] <= 'G')
                        SL_VeVip++;
                    else if (array[0][0] >= 'H' && array[0][0] <= 'Z')
                        SL_VeCouple++;

                    List_MaGhe.Add(button.Name);
                    button.Tag = array[0] + "/" + array[1] + "/" + "true";

                    string tongcong_string = ReMoney(lblTongCong.Content.ToString());
                    tongcong = Double.Parse(tongcong_string);
                    tongcong += Double.Parse(array[1]);
                    lblTongCong.Content = Money(tongcong.ToString());
                }
            }
            else
            {
                button.Background = Brushes.White;
                button.Foreground = Brushes.Black;
                count--;
                int vitrixoa = txtHienThiGheDaChon.Text.IndexOf(array[0]);
                if (vitrixoa <= 2)
                {
                    if (txtHienThiGheDaChon.Text.Length == 2)

                    {
                        txtHienThiGheDaChon.Text = txtHienThiGheDaChon.Text.Remove(vitrixoa, array[0].Length);
                    }
                    else
                        txtHienThiGheDaChon.Text = txtHienThiGheDaChon.Text.Remove(vitrixoa, array[0].Length + 2);
                }
                else
                    txtHienThiGheDaChon.Text = txtHienThiGheDaChon.Text.Remove(vitrixoa - 2, array[0].Length + 2);
                string tongcong_string = ReMoney(lblTongCong.Content.ToString());
                tongcong = Double.Parse(tongcong_string);
                tongcong -= Double.Parse(array[1]);
                lblTongCong.Content = Money(tongcong.ToString());
                List_MaGhe.Remove(button.Name);
                button.Tag = array[0] + "/" + array[1] + "/" + "false";
            }
        }

        private void Button_MouseLeave(object sender, MouseEventArgs e)
        {
            ChuotLeaveGhe(sender, e);
        }

        private void Button_MouseEnter(object sender, MouseEventArgs e)
        {
            ChuotEnterGhe(sender, e);
        }

        DispatcherTimer timer = new DispatcherTimer();

        private void GridChonChoNgoi_Loaded(object sender, RoutedEventArgs e)
        {
            ImageBrush myBrush = new ImageBrush();
            Image image = new Image();
            image.Source = new BitmapImage(new Uri(DiaChi));
            myBrush.ImageSource = image.Source;
            myBrush.Opacity = 0.4;
            GridChonChoNgoi.Background = myBrush;
            LoadData_GridThongTin();

            timer.Interval = TimeSpan.FromSeconds(1);
            timer.Tick += timer_Tick;
            timer.Start();
        }
        int thoigian = 301;
        void timer_Tick(object sender, EventArgs e)
        {
            thoigian--;
            lblThoiGian.Content = thoigian.ToString();
            if (thoigian == 0)
            {
                timer.Stop();
                GridChonChoNgoi.Children.Clear();
                GridChonChoNgoi.Children.Add(new frmDatVe());
                MessageBox.Show("Bạn đã hết thời gian đặt vé, vui lòng thử lại", "Thông báo", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
        }

        private void btnTiepTuc_Click(object sender, RoutedEventArgs e)
        {
            GridChonChoNgoi.Children.Clear();
            frmThanhToan frmThanhToan = new frmThanhToan();
            frmThanhToan.Sender_DiaChiAnh(DiaChi);
            frmThanhToan.Sender_MaKH_MaPhim_MaCC(MaKH, MaPhim, MaCC);
            frmThanhToan.Sender_MaPC(MaPC);
            frmThanhToan.Sender_SL_VeThuong_SL_VeVip_SL_VeCouple(SL_VeThuong, SL_VeVip, SL_VeCouple);
            frmThanhToan.Sender_ListMaGhe(List_MaGhe);
            frmThanhToan.Sender_TenPhim_CaChieu_NgayChieu_TenPhongChieu(lblTenPhim.Content.ToString(), batdau.ToString() + " - " + ketthuc.ToString(), NgayChieu, lblPhongChieu.Content.ToString());
            GridChonChoNgoi.Children.Add(frmThanhToan);
        }
    }
}
