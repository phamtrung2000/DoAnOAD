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

namespace QuanLyCinema.Giao_Diện_Khách_hàng
{
    /// <summary>
    /// Interaction logic for frmXemLichChieu.xaml
    /// </summary>
    public partial class frmXemLichChieu : UserControl
    {
        public frmXemLichChieu()
        {
            InitializeComponent();
        }
        List<LichChieuDTO> listLichChieu = new List<LichChieuDTO>();
        List<string> listNgayChieu_String = new List<string>();
        List<string> listThu = new List<string>();
        List<string> listThoiGian = new List<string>();
        List<DateTime> listNgayChieu_DateTime = new List<DateTime>();

        string Monday_Thu2(string a)
        {
            string kq = null;
            switch (a)
            {
                case "Sunday":
                    {
                        kq = "Chủ nhật"; break;
                    }
                case "Monday":
                    {
                        kq = "Thứ 2"; break;
                    }
                case "Tuesday":
                    {
                        kq = "Thứ 3"; break;
                    }
                case "Wednesday":
                    {
                        kq = "Thứ 4"; break;
                    }
                case "Thursday":
                    {
                        kq = "Thứ 5"; break;
                    }
                case "Friday":
                    {
                        kq = "Thứ 6"; break;
                    }
                case "Saturday":
                    {
                        kq = "Thứ 7"; break;
                    }
            }
            return kq;
        }

        int index_ngaychieu = 0;
        int index_cachieu = 0;
        int soluong_phongchieu = 0;
        string[] tenphim;
        int n = 0;

        void AddColumPhongChieu()
        {
            // lấy số lượng phòng chiếu của rạp, từ đó datagrid sẽ thêm số lượng cột là số lượng phòng chiếu
            DataTable DT_PhongChieu = new DataTable();
            DT_PhongChieu = PhongChieuBUS.LoadDSPC();
            soluong_phongchieu = DT_PhongChieu.Rows.Count;
            tenphim = new string[soluong_phongchieu];
            for (int i = 0; i < soluong_phongchieu; i++)
            {
                tenphim[i] = "";
            }

            for (int i = 0; i < soluong_phongchieu; i++)
            {
                DataGridTextColumn dataGridTextColumn = new DataGridTextColumn();
                dataGridTextColumn.Header = "Phòng chiếu " + (i + 1).ToString();
                dataGridTextColumn.Binding = new Binding("TenPhim[" + i.ToString() + "]");
                dtgDSLichChieu.Columns.Add(dataGridTextColumn);
            }
        }

        void Load_Data(DataTable dataTable)
        {
            dtgDSLichChieu.Items.Clear();
            dtgDSLichChieu.ItemsSource = null;

            listLichChieu = new List<LichChieuDTO>();
            listNgayChieu_String = new List<string>();
            listThu = new List<string>();
            listThoiGian = new List<string>();
            listNgayChieu_DateTime = new List<DateTime>();



            int soluong_cachieu = 0;
            DateTime ngaychieu_temp = new DateTime();
            string ngaychieu = null;
            string thoigian = null;



            // lấy danh sách tất cả ngày chiếu
            DataTable DT_LichChieu = LichChieuBUS.LoadDSNgayChieu();
            listLichChieu = new List<LichChieuDTO>();
            n = DT_LichChieu.Rows.Count;
            for (int i = 0; i < DT_LichChieu.Rows.Count; i++)
            {
                object[] a = new object[1];
                a = DT_LichChieu.Rows[i].ItemArray;
                ngaychieu_temp = DateTime.Parse(a[0].ToString());
                listThu.Add(Monday_Thu2(ngaychieu_temp.DayOfWeek.ToString()));
                listNgayChieu_DateTime.Add(ngaychieu_temp);
                ngaychieu = ngaychieu_temp.Day.ToString() + "/" + ngaychieu_temp.Month.ToString() + "/" + ngaychieu_temp.Year.ToString();
                listNgayChieu_String.Add(ngaychieu);
            }
            txtNgayChieu.Text = listThu[index_ngaychieu] + "\n" + listNgayChieu_String[index_ngaychieu];

            DataTable DT_CaChieu = CaChieuBUS.LoadDSCaChieu();
            soluong_cachieu = DT_CaChieu.Rows.Count;
            string batdau = null, ketthuc = null;
            for (int i = 0; i < soluong_cachieu; i++)
            {
                object[] a = new object[5];
                a = DT_CaChieu.Rows[i].ItemArray;
                DateTime batdau_temp = DateTime.Parse(a[3].ToString());
                // string batdau = batdau_temp.Hour.ToString() + ":" + batdau_temp.Minute.ToString() + ":" + batdau_temp.Second.ToString();
                batdau = batdau_temp.TimeOfDay.ToString();

                DateTime kethuc_temp = DateTime.Parse(a[4].ToString());
                //  string ketthuc = kethuc_temp.Hour.ToString() + ":" + kethuc_temp.Minute.ToString() + ":" + kethuc_temp.Second.ToString();
                ketthuc = kethuc_temp.TimeOfDay.ToString();
                thoigian = batdau.ToString() + " - " + ketthuc.ToString();
                listThoiGian.Add(thoigian);
            }


            for (index_cachieu = 0; index_cachieu < soluong_cachieu; index_cachieu++)
            {
                DataTable DT_NgayChieu = LichChieuBUS.HienLichChieuPhim(listNgayChieu_DateTime[index_ngaychieu], "CC" + (index_cachieu + 1).ToString());
                if (DT_NgayChieu.Rows.Count > 0)
                {
                    for (int i = 0; i < soluong_phongchieu; i++)
                    {
                        DataTable DT_NgayChieu_MaCC_MaPC = LichChieuBUS.HienLichChieuPhim_NgayChieu_MaCC_MaPC(listNgayChieu_DateTime[index_ngaychieu], "CC" + (index_cachieu + 1).ToString(), "PC" + (i + 1).ToString());
                        if (DT_NgayChieu_MaCC_MaPC.Rows.Count > 0)
                        {
                            object[] b = new object[5];
                            b = DT_NgayChieu_MaCC_MaPC.Rows[0].ItemArray;
                            tenphim[i] = b[4].ToString();
                        }
                    }
                }
                listLichChieu.Add(new LichChieuDTO(listThoiGian[index_cachieu], tenphim));
                tenphim = new string[soluong_phongchieu];
                dtgDSLichChieu.Items.Add(listLichChieu[index_cachieu]);
            }
        }

        private void GridLichChieu_Loaded(object sender, RoutedEventArgs e)
        {
            btnNgayTruocDo.IsEnabled = false;
            AddColumPhongChieu();
            DataTable dataTable = new DataTable();
            dataTable = LichChieuBUS.LoadDSLC();
            Load_Data(dataTable);
        }

        private void btnNgayTiepTheo_Click(object sender, RoutedEventArgs e)
        {
            index_ngaychieu++;
            if (index_ngaychieu > 0 && index_ngaychieu < n)
            {
                btnNgayTruocDo.IsEnabled = true;
            }
            if (index_ngaychieu >= n - 1)
            {
                btnNgayTiepTheo.IsEnabled = false;
            }
            DataTable dataTable = new DataTable();
            dataTable = LichChieuBUS.LoadDSLC();
            Load_Data(dataTable);

        }

        private void btnNgayTruocDo_Click(object sender, RoutedEventArgs e)
        {
            index_ngaychieu--;
            if (index_ngaychieu == 0)
            {
                btnNgayTruocDo.IsEnabled = false;
            }
            if (index_ngaychieu <= n - 1)
            {
                btnNgayTiepTheo.IsEnabled = true;
            }
            DataTable dataTable = new DataTable();
            dataTable = LichChieuBUS.LoadDSLC();
            Load_Data(dataTable);
        }
    }
}
