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
    public class VeDAO
    {
        public static DataTable LoadDSVe()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "SELECT * " +
            //                      "FROM LOAIVE ORDER BY STT ASC";
            command.CommandText = "EXEC LoadDSVe";
            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
        public static void Them(VeDTO ve)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO PHIM VALUES(@MALV,@TENLV,@LOAICHONGOI,@GIA,@MALP,@NOIDUNG,@NAMSX,@NUOCSX,@THOILUONG)";
            command.CommandText = "EXEC ThemVe @MAPHIM,@MAPC,@MALV,@SOLUONG";

            command.Parameters.Add("@MAPHIM", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MAPC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MALV", SqlDbType.VarChar, 10);
            command.Parameters.Add("@SOLUONG", SqlDbType.Int);

            // gán giá trị
            command.Parameters["@MAPHIM"].Value = ve.MaPhim;
            command.Parameters["@MAPC"].Value = ve.MaPC;
            command.Parameters["@MALV"].Value = ve.MaLV;
            command.Parameters["@SOLUONG"].Value = ve.SoLuong;

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static void Sua(VeDTO ve)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO NHANVIEN VALUES(@MANV,@HOTEN,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL)";
            command.CommandText = "EXEC SuaVe @MAPHIM,@MAPC,@MALV,@SOLUONG";

            command.Parameters.Add("@MAPHIM", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MAPC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MALV", SqlDbType.VarChar, 10);
            command.Parameters.Add("@SOLUONG", SqlDbType.Int);

            // gán giá trị
            command.Parameters["@MAPHIM"].Value = ve.MaPhim;
            command.Parameters["@MAPC"].Value = ve.MaPC;
            command.Parameters["@MALV"].Value = ve.MaLV;
            command.Parameters["@SOLUONG"].Value = ve.SoLuong;

            command.ExecuteNonQuery();
            // đóng kết nối
            connection.Close();
        }
        public static void Xoa(string maphim, string mapc, string malv)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC XoaVe " + "'" + maphim + "','" + mapc + "','" + malv + "'";


            command.ExecuteNonQuery();
            connection.Close();
        }

        public static DataTable TimTheoTenPhim(string tenphim)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Ve_TimTheoTenPhim N' " + tenphim + "'";

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoTenPC(string tenpc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Ve_TimTheoTenPC N' " + tenpc + "'";

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoTenLV(string tenlv)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Ve_TimTheoTenLV N' " + tenlv + "'";

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoSoLuong(string soluong)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Ve_TimTheoSoLuong '" + soluong + "'";

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
    }
}
