using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using System.Data;
using System.Data.SqlClient;


namespace DAO
{
    public class LichChieuDAO
    {
        public static DataTable LoadDSLC()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = " EXEC LoadDSLichChieu ";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable LoadDSNgayChieu()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = " EXEC LoadDSNgayChieu ";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable HienLichChieuPhim(DateTime ngaychieu, string macc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = " EXEC HienLichChieuPhim '" + ngaychieu + "'" + ",'" + macc + "'";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable HienLichChieuPhim_NgayChieu_MaCC_MaPC(DateTime ngaychieu, string macc, string mapc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = " EXEC HienLichChieuPhim_NgayChieu_MaCC_MaPC '" + ngaychieu + "'" + ",'" + macc + "'" + ",'" + mapc + "'";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable DatVe_Phim_NgayChieu(string maphim, string ngaychieu)
        {
            //string date = ngaychieu.Day.ToString() + '/' + ngaychieu.Month.ToString() + '/' + ngaychieu.Year.ToString();

            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = new SqlCommand("set dateformat dmy\n Exec DatVe_Phim_NgayChieu '" + maphim + "'" + ",'" + ngaychieu + "'", connection);
            command.CommandType = CommandType.Text;

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static void Them(LichChieuDTO lichchieu)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;

            command.CommandText = " EXEC ThemLichChieu @NGAYCHIEU,@MAPHIM,@MACC,@MAPC ";
            command.Parameters.Add("@NGAYCHIEU", SqlDbType.Date);
            command.Parameters.Add("@MAPHIM", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MACC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MAPC", SqlDbType.VarChar, 10);


            // gán giá trị
            command.Parameters["@NGAYCHIEU"].Value = lichchieu.NgayChieu;
            command.Parameters["@MAPHIM"].Value = lichchieu.MaPhim;
            command.Parameters["@MACC"].Value = lichchieu.MaCC;
            command.Parameters["@MAPC"].Value = lichchieu.MaPC;

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static void Sua(LichChieuDTO lichchieu)
        {
            /// mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO CACHIEU VALUES(@MACC,@TENCC,@BATDAU,@KETTHUC)";
            command.CommandText = "EXEC SuaLichChieu @NGAYCHIEU,@MAPHIM,@MACC,@MAPC";
            command.Parameters.Add("@NGAYCHIEU", SqlDbType.Date);
            command.Parameters.Add("@MAPHIM", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MACC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MAPC", SqlDbType.VarChar, 10);


            // gán giá trị
            command.Parameters["@NGAYCHIEU"].Value = lichchieu.NgayChieu;
            command.Parameters["@MAPHIM"].Value = lichchieu.MaPhim;
            command.Parameters["@MACC"].Value = lichchieu.MaCC;
            command.Parameters["@MAPC"].Value = lichchieu.MaPC;

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }

        public static void Xoa(DateTime ngaychieu, string maphim, string macc, string mapc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC XoaLichChieu " + "'" + ngaychieu + "','" + maphim + "','" + macc + "','" + mapc + "'";

            command.ExecuteNonQuery();
            connection.Close();
        }
        public static DataTable Timtheongaychieu(DateTime nc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheongaychieu '" + nc + "'";
            //command.CommandText = "SELECT * FROM NHANVIEN " +
            //                      "WHERE MANV LIKE'" + manv + "%'";

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
        public static DataTable Timtheomacc(string macc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheomacclc '" + macc + "'";
            //command.CommandText = "SELECT * FROM NHANVIEN " +
            //                      "WHERE MANV LIKE'" + manv + "%'";

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
        public static DataTable Timtheomapc(string mapc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Timtheomapc1 '" + mapc + "'";
            //command.CommandText = "SELECT * FROM NHANVIEN " +
            //                      "WHERE MANV LIKE'" + manv + "%'";

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
    }
}

