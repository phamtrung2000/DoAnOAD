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

namespace QuanLyCinema
{
    /// <summary>
    /// Interaction logic for frmLichSuDatVe.xaml
    /// </summary>
    public partial class frmLichSuDatVe : UserControl
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

        public frmLichSuDatVe()
        {
            InitializeComponent();
            Sender_MaKH = new GuiMaKH(GetMaKH);
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

        List<LichSuDatVe> listLSDV = new List<LichSuDatVe>();
        List<string> listMaVe = new List<string>();
        List<string> listMaGhe = new List<string>();
        void Load_Data(DataTable dataTable)
        {
            dtgLSDV.Items.Clear();
            dtgLSDV.ItemsSource = null;
            for (int i = 0; i < dataTable.Rows.Count; i++)
            {
                object[] a = new object[3];
                a = dataTable.Rows[i].ItemArray;
                DateTime ngaychieu = (DateTime)a[0];
                string ngaygiomua = ngaychieu.Day.ToString() + '/' + ngaychieu.Month.ToString() + '/' + ngaychieu.Year.ToString()
                    + " " + ngaychieu.TimeOfDay.ToString();
                double tien = double.Parse(a[1].ToString());
                string tongcong = Money(tien.ToString()) + " VND";
                listLSDV.Add(new LichSuDatVe { STT = (listLSDV.Count + 1).ToString(), NgayGioMua = ngaygiomua, TongCong = tongcong });
                listMaVe.Add(a[2].ToString());
            }
            dtgLSDV.ItemsSource = listLSDV;
            dtgLSDV.Columns[1].Header = "Ngày giờ mua";
            dtgLSDV.Columns[2].Header = "Tổng cộng";

        }

        private void grpLichSuDatVe_Loaded(object sender, RoutedEventArgs e)
        {
            DataTable dataTable = new DataTable();
            dataTable = KhachHangBUS.LoadDataGrid_LichSuDatVe(MaKH);
            Load_Data(dataTable);
        }

        class LichSuDatVe
        {
            public string STT { get; set; }
            public string NgayGioMua { get; set; }
            public string TongCong { get; set; }
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

        int index = -1;
        private void dtgLSDV_SelectedCellsChanged(object sender, SelectedCellsChangedEventArgs e)
        {
            index = dtgLSDV.SelectedIndex;
            listMaGhe.Clear();
            if (index >= 0) // tránh lỗi click vẫn trong datagrid nhưng mà click chỗ k có dòng nào
            {
                txtMaVe.Text = listMaVe[index];
                DataTable dataTable = new DataTable();
                dataTable = KhachHangBUS.LichSuDatVe_LayThongTinChiTiet(MaKH, txtMaVe.Text);
                object[] a = new object[10];
                a = dataTable.Rows[0].ItemArray;
                txtTenPhim.Text = a[0].ToString();
                DateTime ngaychieu = (DateTime)a[1];
                txtNgayChieu.Text = ngaychieu.Day.ToString() + '/' + ngaychieu.Month.ToString() + '/' + ngaychieu.Year.ToString();
                txtPhongChieu.Text = a[2].ToString();
                DateTime batdau_temp = DateTime.Parse(a[3].ToString());
                string batdau = batdau_temp.TimeOfDay.ToString();

                DateTime kethuc_temp = DateTime.Parse(a[4].ToString());
                //  string ketthuc = kethuc_temp.Hour.ToString() + ":" + kethuc_temp.Minute.ToString() + ":" + kethuc_temp.Second.ToString();
                string ketthuc = kethuc_temp.TimeOfDay.ToString();

                txtCaChieu.Text = batdau.ToString() + " - " + ketthuc.ToString();

                dataTable = KhachHangBUS.LichSuDatVe_LayDSGhe(MaKH, txtMaVe.Text);
                for (int i = 0; i < dataTable.Rows.Count; i++)
                {
                    a = new object[1];
                    a = dataTable.Rows[i].ItemArray;
                    listMaGhe.Add(LayChu_SoGhe(a[0].ToString()));
                }
                txtDanhSachGhe.Text = listMaGhe[0];
                if (listMaGhe.Count > 1)
                {
                    for (int i = 1; i < listMaGhe.Count; i++)
                    {
                        txtDanhSachGhe.Text += "," + listMaGhe[i];
                    }
                }
            }
        }
    }
}
