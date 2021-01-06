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
    public class LoaiPhimDAO
    {
        public static DataTable LoadDSLP()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "SELECT * " +
            //                      "FROM LOAIPHIM ORDER BY STT ASC";
            command.CommandText = "EXEC LoadLoaiPhim ";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
        public static void Them(LoaiPhimDTO loaiphim)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO NHANVIEN VALUES(@MANV,@HOTEN,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL)";
            command.CommandText = "EXEC Themloaiphim @MALP,@TENLP,@MOTA";
            command.Parameters.Add("@MALP", SqlDbType.VarChar, 10);
            command.Parameters.Add("@TENLP", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@MOTA", SqlDbType.NVarChar, 1000);


            // gán giá trị
            command.Parameters["@MALP"].Value = loaiphim.MaLP;
            command.Parameters["@TENLP"].Value = loaiphim.TenLP;
            command.Parameters["@MOTA"].Value = loaiphim.MoTa;

            command.ExecuteNonQuery();
            // đóng kết nối
            connection.Close();
        }

        public static void Sua(LoaiPhimDTO loaiphim)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO NHANVIEN VALUES(@MANV,@HOTEN,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL)";
            command.CommandText = "EXEC Sualoaiphim @MALP,@TENLP,@MOTA";
            command.Parameters.Add("@MALP", SqlDbType.VarChar, 10);
            command.Parameters.Add("@TENLP", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@MOTA", SqlDbType.NVarChar, 1000);


            // gán giá trị
            command.Parameters["@MALP"].Value = loaiphim.MaLP;
            command.Parameters["@TENLP"].Value = loaiphim.TenLP;
            command.Parameters["@MOTA"].Value = loaiphim.MoTa;

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static void Xoa(string malp)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Xoaloaiphim '" + malp + "'";
            //command.CommandText = "DELETE NV FROM NHANVIEN NV " +
            //                      "WHERE NV.MANV='" + manv + "'";
            //command.Parameters.Add("@MANV", SqlDbType.VarChar, 10);
            // gán giá trị
            //command.Parameters["@MANV"].Value = manv;
            command.ExecuteNonQuery();
            connection.Close();
        }
        public static DataTable TimtheoMaLP(string malp)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoMaLP '" + malp + "'";
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
        public static DataTable TimTheoTenLoaiPhim(string tenlp)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoTenlp '" + tenlp + "'";
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
