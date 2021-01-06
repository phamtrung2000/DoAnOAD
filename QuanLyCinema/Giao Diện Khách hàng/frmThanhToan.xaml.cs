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

using System.Data.SqlClient;
using System.Configuration;
using BUS;
using DTO;
using System.Data;

namespace QuanLyCinema.Giao_Diện_Khách_hàng
{
    /// <summary>
    /// Interaction logic for frmThanhToan.xaml
    /// </summary>
    public partial class frmThanhToan : UserControl
    {
        public delegate void GuiDiaChiAnh(string diachi); // gửi địa chỉ ảnh
        public GuiDiaChiAnh Sender_DiaChiAnh;
        public static string DiaChi = null;
        private void Get_DiaChiAnh(string diachi)
        {
            DiaChi = diachi;
        }

        public static bool XacNhan = false;
        public delegate void GuiXacNhan(bool xacnhan);
        public GuiXacNhan Sender_XacNhan;
        private void GetXacNhan(bool a)
        {
            XacNhan = a;
        }

        public static string MaKH, MaPhim, MaCC = null;
        public delegate void GuiMaKH_MaPhim_MaCC(string makh, string maphim, string macc);
        public GuiMaKH_MaPhim_MaCC Sender_MaKH_MaPhim_MaCC;
        private void Get_MaKH_MaPhim_MaCC(string makh, string maphim, string macc)
        {
            MaKH = makh;
            MaPhim = maphim;
            MaCC = macc;
        }

        public static string MaPC = null;

        public delegate void GuiMaPC(string mapc);
        public GuiMaPC Sender_MaPC;
        private void GetMaPC(string mapc)
        {
            MaPC = mapc;
        }

        public static int SL_VeThuong, SL_VeVip, SL_VeCouple = 0;

        public delegate void Gui_SL_VeThuong_SL_VeVip_SL_VeCouple(int a, int b, int c);
        public Gui_SL_VeThuong_SL_VeVip_SL_VeCouple Sender_SL_VeThuong_SL_VeVip_SL_VeCouple;
        private void Get_SL_VeThuong_SL_VeVip_SL_VeCouple(int a, int b, int c)
        {
            SL_VeThuong = a;
            SL_VeVip = b;
            SL_VeCouple = c;
        }

        public static List<string> ListMaGhe = new List<string>();

        public delegate void GuiListMaGhe(List<string> a);
        public GuiListMaGhe Sender_ListMaGhe;

        private void GetListMaGhe(List<string> a)
        {
            ListMaGhe = a;
        }

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

        private void GridThanhToan_Loaded(object sender, RoutedEventArgs e)
        {
            ImageBrush myBrush = new ImageBrush();
            Image image = new Image();
            image.Source = new BitmapImage(new Uri(DiaChi));
            myBrush.ImageSource = image.Source;
            myBrush.Opacity = 0.4;
            GridThanhToan.Background = myBrush;

            if (SL_VeThuong > 0)
            {
                DockPanel dockPanel = new DockPanel();
                dockPanel.Name = "panelVeThuong";
                dockPanel.Width = 780;
                dockPanel.Height = 50;

                Label label_VeThuong = new Label
                {
                    Name = "lblVeThuong",
                    Content = "Vé thường",
                    Height = 50,
                    Width = 385,
                    FontSize = 20,
                    Foreground = Brushes.White
                };

                Label label_SLVeThuong = new Label
                {
                    Name = "lblSLVeThuong",
                    Content = SL_VeThuong.ToString(),
                    Height = 50,
                    Width = 195,
                    FontSize = 20,
                    Foreground = Brushes.White
                };
                Label label_VeThuong_ThanhTien = new Label
                {
                    Name = "lblGiaVeThuong",
                    Content = Money((40000 * SL_VeThuong).ToString()),
                    Height = 50,
                    Width = 200,
                    FontSize = 20,
                    Foreground = Brushes.White
                };
                dockPanel.Children.Add(label_VeThuong);
                dockPanel.Children.Add(label_SLVeThuong);
                dockPanel.Children.Add(label_VeThuong_ThanhTien);
                gridChiTietThanhToan.Children.Add(dockPanel);
            }

            if (SL_VeVip > 0)
            {
                DockPanel dockPanel = new DockPanel();
                dockPanel.Name = "panelVeVip";
                dockPanel.Width = 780;
                dockPanel.Height = 50;

                Label label_VeVip = new Label
                {
                    Name = "lblVeVip",
                    Content = "Vé VIP",
                    Height = 50,
                    Width = 385,
                    FontSize = 20,
                    Foreground = Brushes.White
                };

                Label label_SLVeVip = new Label
                {
                    Name = "lblSLVeVip",
                    Content = SL_VeVip.ToString(),
                    Height = 50,
                    Width = 195,
                    FontSize = 20,
                    Foreground = Brushes.White
                };
                Label label_VeVip_ThanhTien = new Label
                {
                    Name = "lblGiaVeVip",
                    Content = Money((50000 * SL_VeVip).ToString()),
                    Height = 50,
                    Width = 200,
                    FontSize = 20,
                    Foreground = Brushes.White
                };
                dockPanel.Children.Add(label_VeVip);
                dockPanel.Children.Add(label_SLVeVip);
                dockPanel.Children.Add(label_VeVip_ThanhTien);
                gridChiTietThanhToan.Children.Add(dockPanel);
            }

            if (SL_VeCouple > 0)
            {
                DockPanel dockPanel = new DockPanel();
                dockPanel.Name = "panelVeCouple";
                dockPanel.Width = 780;
                dockPanel.Height = 50;

                Label label1 = new Label
                {
                    Name = "lblVeCouple",
                    Content = "Vé Couple",
                    Height = 50,
                    Width = 385,
                    FontSize = 20,
                    Foreground = Brushes.White
                };

                Label label2 = new Label
                {
                    Name = "lblSLVeCouple",
                    Content = SL_VeCouple.ToString(),
                    Height = 50,
                    Width = 195,
                    FontSize = 20,
                    Foreground = Brushes.White
                };
                Label label3 = new Label
                {
                    Name = "lblGiaVeCouple",
                    Content = Money((110000 * SL_VeCouple).ToString()),
                    Height = 50,
                    Width = 200,
                    FontSize = 20,
                    Foreground = Brushes.White
                };
                dockPanel.Children.Add(label1);
                dockPanel.Children.Add(label2);
                dockPanel.Children.Add(label3);
                gridChiTietThanhToan.Children.Add(dockPanel);

            }

        }

        private void bt_back_Click(object sender, RoutedEventArgs e)
        {
            GridThanhToan.Children.Clear();
            GridThanhToan.Children.Add(new frmChonChoNgoi());
        }

        public frmThanhToan()
        {
            InitializeComponent();
            Sender_DiaChiAnh = new GuiDiaChiAnh(Get_DiaChiAnh);
            Sender_MaKH_MaPhim_MaCC = new GuiMaKH_MaPhim_MaCC(Get_MaKH_MaPhim_MaCC);
            Sender_MaPC = new GuiMaPC(GetMaPC);
            Sender_SL_VeThuong_SL_VeVip_SL_VeCouple = new Gui_SL_VeThuong_SL_VeVip_SL_VeCouple(Get_SL_VeThuong_SL_VeVip_SL_VeCouple);
            Sender_ListMaGhe = new GuiListMaGhe(GetListMaGhe);
            Sender_TenPhim_CaChieu_NgayChieu_TenPhongChieu = new Gui_TenPhim_CaChieu_NgayChieu_TenPhongChieu(Get_TenPhim_CaChieu_NgayChieu_TenPhongChieu);
            Sender_XacNhan = new GuiXacNhan(GetXacNhan);
        }

        string MaLC = null;
        private void btnXacNhan_Click(object sender, RoutedEventArgs e)
        {
            frmXacNhanThanhToan frmXacNhanThanhToan = new frmXacNhanThanhToan();
            frmXacNhanThanhToan.Sender_TenPhim_CaChieu_NgayChieu_TenPhongChieu(TenPhim, CaChieu, NgayChieu, TenPhongChieu);
            frmXacNhanThanhToan.Sender_ListMaGhe(ListMaGhe);
            frmXacNhanThanhToan.Sender_frmThanhToan(this);
            frmXacNhanThanhToan.ShowDialog();

            if (XacNhan == true)
            {
                DataTable DT_HoaDon = VeBUS.LoadDSHoaDon();
                int soluong_hoadon = DT_HoaDon.Rows.Count;
                string SoHD = "HD" + (soluong_hoadon + 1).ToString();
                DateTime Ngay_Gio_HD = DateTime.Now;

                DataTable DT_GetMALC = DatVeBUS.DatVe_GetMALC(MaPhim, NgayChieu, MaCC);
                object[] a = new object[1];
                a = DT_GetMALC.Rows[0].ItemArray;
                MaLC = a[0].ToString();


                VeDTO hd = new VeDTO(SoHD, Ngay_Gio_HD, MaKH, MaLC, "0");
                //VeDTO hd = new VeDTO(SoHD, Ngay_Gio_HD, "KH1", MaLC, "0");
                VeBUS.Them(hd);

                //string date = NgayChieu.Day.ToString() + '/' + NgayChieu.Month.ToString() + '/' + NgayChieu.Year.ToString();
                for (int i = 0; i < ListMaGhe.Count; i++)
                {
                    CTVE_DTO ctve = new CTVE_DTO(SoHD, ListMaGhe[i], NgayChieu, "0");
                    CTHD_BUS.Them(ctve);
                }

                GridThanhToan.Children.Clear();
                GridThanhToan.Children.Add(new frmDatVe());
            }
        }
    }
}
