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

    public class NguoiDungDAO
    {
        //Load danh sách sv từ database
        public static DataTable LoadDSND()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * " +
                                  "FROM NGUOIDUNG ORDER BY STT ASC";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static void Them(NguoiDungDTO nguoidung)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO NHANVIEN VALUES(@MANV,@HOTEN,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL)";
            command.CommandText = "EXEC ThemNguoiDung @MAND,@HOTEN,@CHUCVU,@PHANQUYEN";
            command.Parameters.Add("@MAND", SqlDbType.VarChar, 10);
            command.Parameters.Add("@HOTEN", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@CHUCVU", SqlDbType.VarChar, 100);
            command.Parameters.Add("@PHANQUYEN", SqlDbType.VarChar, 100);

            // gán giá trị
            command.Parameters["@MANV"].Value = nguoidung.MaND;
            command.Parameters["@HOTEN"].Value = nguoidung.HoTen;
            command.Parameters["@CHUCVU"].Value = nguoidung.ChucVu;
            command.Parameters["@SDT"].Value = nguoidung.PhanQuyen;

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }

        public static void Sua(NguoiDungDTO nguoidung)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Sửa
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC SuaNguoiDung @MAND,@HOTEN,@CHUCVU,@PHANQUYEN";
            //command.CommandText = "UPDATE NHANVIEN " +
            //    "SET MANV=@MANV ," +
            //    "HOTEN=@HOTEN," +
            //    "CHUCVU=@CHUCVU," +
            //    "SDT=@SDT," +
            //    "GIOITINH=@GIOITINH," +
            //    "NGAYSINH=@NGAYSINH," +
            //    "DIACHI=@DIACHI," +
            //    "LUONG=@LUONG," +
            //    "NGAYVL=@NGAYVL " +
            //    "WHERE MANV=@MANV";
            command.Parameters.Add("@MAND", SqlDbType.VarChar, 10);
            command.Parameters.Add("@HOTEN", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@CHUCVU", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@PHANQUYEN", SqlDbType.NVarChar, 100);

            // gán giá trị
            command.Parameters["@MAND"].Value = nguoidung.MaND;
            command.Parameters["@HOTEN"].Value = nguoidung.HoTen;
            command.Parameters["@CHUCVU"].Value = nguoidung.ChucVu;
            command.Parameters["@PHANQUYEN"].Value = nguoidung.PhanQuyen;

            // thực hiện câu lệnh
            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }

        public static void Xoa(string manv)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC XoaNguoiDung '" + manv + "'";
            //command.CommandText = "DELETE NV FROM NHANVIEN NV " +
            //                      "WHERE NV.MANV='" + manv + "'";
            //command.Parameters.Add("@MANV", SqlDbType.VarChar, 10);
            // gán giá trị
            //command.Parameters["@MANV"].Value = manv;
            command.ExecuteNonQuery();
            connection.Close();
        }

        public static DataTable TimTheoMaND(string manv)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoMaND '" + manv + "'";
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

        public static DataTable TimTheoHoTenNguoiDung(string hoten)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoHoTenNguoiDung N'" + hoten + "'";
            //command.CommandText = "SELECT * FROM NHANVIEN " +
            //                      "WHERE HOTEN LIKE N'" + hoten + "%'";

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        //public static DataTable TimTheoSDTNguoiDung(string sdt)
        //{
        //    SqlConnection connection = SQLConnectionData.HamKetNoi();
        //    connection.Open();

        //    SqlCommand command = connection.CreateCommand();
        //    command.CommandType = CommandType.Text;
        //    command.CommandText = "EXEC TimTheoSDTNguoiDung '" + sdt + "'";
        //    //command.CommandText = "SELECT * FROM NHANVIEN " +
        //    //                     "WHERE SDT LIKE'" + sdt + "%'";

        //    // gán giá trị

        //    command.ExecuteNonQuery();
        //    SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
        //    DataTable dataTable = new DataTable();
        //    dataAdapter.Fill(dataTable);
        //    connection.Close();
        //    return dataTable;
        //}

    }
}
