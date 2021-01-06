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
    public class CaChieuDAO
    {
        public static DataTable LoadDSCaChieu()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = " EXEC LoadDSCaChieu ";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
        public static void Them(CaChieuDTO cachieu)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;

            command.CommandText = "EXEC ThemCaChieu @MACC,@TENCC,@BATDAU,@KETTHUC";
            command.Parameters.Add("@MACC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@TENCC", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@BATDAU", SqlDbType.DateTime);
            command.Parameters.Add("@KETTHUC", SqlDbType.DateTime);

            // gán giá trị
            command.Parameters["@MACC"].Value = cachieu.MaCC;
            command.Parameters["@TENCC"].Value = cachieu.TenCC;
            command.Parameters["@BATDAU"].Value = cachieu.BatDau.ToLongTimeString();
            command.Parameters["@KETTHUC"].Value = cachieu.KetThuc.ToLongTimeString();

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static void Sua(CaChieuDTO cachieu)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;

            command.CommandText = "EXEC SuaCaChieu @MACC,@TENCC,@BATDAU,@KETTHUC";
            command.Parameters.Add("@MACC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@TENCC", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@BATDAU", SqlDbType.DateTime);
            command.Parameters.Add("@KETTHUC", SqlDbType.DateTime);

            // gán giá trị
            command.Parameters["@MACC"].Value = cachieu.MaCC;
            command.Parameters["@TENCC"].Value = cachieu.TenCC;
            command.Parameters["@BATDAU"].Value = cachieu.BatDau.ToLongTimeString();
            command.Parameters["@KETTHUC"].Value = cachieu.KetThuc.ToLongTimeString();

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static void Xoa(string macc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC XoaCaChieu '" + macc + "'";
            command.ExecuteNonQuery();
            connection.Close();
        }
        public static DataTable TimtheoMacc(string macc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoMacc '" + macc + "'";
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
        public static DataTable TimtheoTencc(string tencc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoTencc '" + tencc + "'";
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
