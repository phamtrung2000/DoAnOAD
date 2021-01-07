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
    public class CTHD_DAO
    {
        public static DataTable Load_CTHD(string sohd)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText =
                 " SELECT HH.TENHH,HH.DVT,HH.GIA,CTHD.SL, (CTHD.SL * HH.GIA) AS 'THANHTIEN' "
              + " FROM HOADON HD JOIN CTHD ON HD.SOHD = CTHD.SOHD "
              + " JOIN HANGHOA HH ON HH.MAHH = CTHD.MAHH "
              + " WHERE CTHD.SOHD = '" + sohd + "'";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static void Them(CTVE_DTO ctve)
        {

            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;

            command.CommandText = "set dateformat dmy\n EXEC ThemCTVe '" + ctve.MaVe + "'" + ",'"
                + ctve.MaGhe + "'" + ",'"
                + ctve.NgayChieu_String + "'" + ",'"            
                + ctve.ThanhTien + "'";
          
            command.ExecuteNonQuery();
            // đóng kết nối
            connection.Close();
        }

        public static void Sua(CTVE_DTO ctve)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Sửa
            //SqlCommand command = connection.CreateCommand();
            //command.CommandType = CommandType.Text;

            //command.CommandText = "UPDATE HOADON " +
            //    "SET SOHD=@SOHD ," +
            //    "NGAYHD=@NGAYHD," +
            //    "GIOHD=@GIOHD," +
            //    "MAKH=@MAKH," +
            //     "MAQTN=@MAQTN," +
            //    "TRIGIA=@TRIGIA" +
            //    " WHERE SOHD=@SOHD";

            //command.Parameters.Add("@SOHD", SqlDbType.VarChar, 10);
            //command.Parameters.Add("@MAGHE", SqlDbType.VarChar, 10);
            //command.Parameters.Add("@MAPC", SqlDbType.VarChar, 10);
            //command.Parameters.Add("@THANHTIEN", SqlDbType.Money);
            //// gán giá trị
            //command.Parameters["@SOHD"].Value = ctve.MaVe;
            //command.Parameters["@MAGHE"].Value = ctve.MaGhe;
            //command.Parameters["@MAPC"].Value = ctve.MaPC;
            //command.Parameters["@THANHTIEN"].Value = ctve.ThanhTien;

            //// thực hiện câu lệnh
            //command.ExecuteNonQuery();

            //// đóng kết nối
            //connection.Close();
        }

        public static void Xoa(string sohd)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "DELETE FROM HOADON " +
                                  "WHERE SOHD=@SOHD";
            command.Parameters.Add("@SOHD", SqlDbType.VarChar, 10);
            // gán giá trị
            command.Parameters["@SOHD"].Value = sohd;
            command.ExecuteNonQuery();
            connection.Close();
        }

        public static DataTable TimTheoMaVe(string sohd)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;

            command.CommandText = "SELECT * FROM HOADON " +
                                  "WHERE SOHD LIKE'" + sohd + "%'";

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoNgay(DateTime tungay, DateTime denngay)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * FROM HOADON " +
                                  " WHERE NGAYHD BETWEEN '" + tungay + "' AND '" + denngay + "'";

            // gán giá trị
            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoGio(DateTime tugio, DateTime dengio)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * FROM HOADON " +
                                  "WHERE GIOHD BETWEEN '" + tugio.TimeOfDay + "' AND '" + dengio.TimeOfDay + "'";

            // gán giá trị
            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoGia(string gia_min, string gia_max)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * FROM HOADON " +
                                 "WHERE TRIGIA  BETWEEN " + gia_min + " AND " + gia_max;

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoGiaMin(string gia_min)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * FROM HOADON " +
                                 "WHERE TRIGIA >= " + gia_min;

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoGiaMax(string gia_max)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * FROM HOADON " +
                                 "WHERE TRIGIA <= " + gia_max;

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoMaKH(string makh)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * FROM HOADON " +
                                  "WHERE MAKH LIKE '" + makh + "%'";

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
