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
    public class LoaiVeDAO
    {
        public static DataTable LoadDSLoaiVe()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "SELECT * " +
            //                      "FROM LOAIVE ORDER BY STT ASC";
            command.CommandText = "EXEC LoadDSLoaiVe";
            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
        public static void Them(LoaiVeDTO loaive)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO PHIM VALUES(@MALV,@TENLV,@LOAICHONGOI,@GIA,@MALP,@NOIDUNG,@NAMSX,@NUOCSX,@THOILUONG)";
            command.CommandText = "EXEC ThemLoaiVe @MALV,@TENLV,@LOAICHONGOI,@GIA";

            command.Parameters.Add("@MALV", SqlDbType.VarChar, 10);
            command.Parameters.Add("@TENLV", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@LOAICHONGOI", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@GIA", SqlDbType.Money);

            // gán giá trị
            command.Parameters["@MALV"].Value = loaive.MaLV;
            command.Parameters["@TENLV"].Value = loaive.TenLV;
            command.Parameters["@LOAICHONGOI"].Value = loaive.LoaiChoNgoi;
            command.Parameters["@GIA"].Value = loaive.Gia;

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static void Sua(LoaiVeDTO loaive)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO NHANVIEN VALUES(@MANV,@HOTEN,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL)";
            command.CommandText = "EXEC SuaLoaiVe @MALV,@TENLV,@LOAICHONGOI,@GIA";

            command.Parameters.Add("@MALV", SqlDbType.VarChar, 10);
            command.Parameters.Add("@TENLV", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@LOAICHONGOI", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@GIA", SqlDbType.Money);

            // gán giá trị
            command.Parameters["@MALV"].Value = loaive.MaLV;
            command.Parameters["@TENLV"].Value = loaive.TenLV;
            command.Parameters["@LOAICHONGOI"].Value = loaive.LoaiChoNgoi;
            command.Parameters["@GIA"].Value = loaive.Gia;


            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static void Xoa(string malv)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC XoaLoaiVe '" + malv + "'";

            command.ExecuteNonQuery();
            connection.Close();
        }
        public static DataTable TimtheoMaLV(string malv)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoMaLV '" + malv + "'";

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
        public static DataTable TimTheoTenLoaiVe(string tenlv)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoTenLV '" + tenlv + "'";
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
