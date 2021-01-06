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
    public class KhachHangDAO
    {
        public static DataTable LoadDSKH()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT * " +
                                  "FROM KHACHHANGTHANTHIET ORDER BY STT ASC";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
        public static void Them(KhachHangDTO khachhang)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Them_khachhang @MAKH,@HOTEN,@DIACHI,@NGAYSINH,@GIOITINH,@SDT,@LOAIKH,@NGAYDK";
            //command.CommandText = "INSERT INTO KHACHHANGTHANTHIET VALUES(@MAKH,@HOTEN,@DIACHI,@NGAYSINH,@GIOITINH,@SDT,@LOAIKH,@NGAYDK)";

            command.Parameters.Add("@MAKH", SqlDbType.VarChar, 10);
            command.Parameters.Add("@HOTEN", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@DIACHI", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@NGAYSINH", SqlDbType.Date);
            command.Parameters.Add("@GIOITINH", SqlDbType.NVarChar, 4);
            command.Parameters.Add("@SDT", SqlDbType.VarChar, 20);
            command.Parameters.Add("@LOAIKH", SqlDbType.NVarChar, 50);
            command.Parameters.Add("@NGAYDK", SqlDbType.Date);

            // gán giá trị
            command.Parameters["@MAKH"].Value = khachhang.MaKH;
            command.Parameters["@HOTEN"].Value = khachhang.HoTen;
            command.Parameters["@DIACHI"].Value = khachhang.DiaChi;
            command.Parameters["@NGAYSINH"].Value = khachhang.Ngaysinh;
            command.Parameters["@GIOITINH"].Value = khachhang.GioiTinh;
            command.Parameters["@SDT"].Value = khachhang.SDT;
            command.Parameters["@LOAIKH"].Value = khachhang.LoaiKH;
            command.Parameters["@NGAYDK"].Value = khachhang.Ngaydk;
            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static void Xoa(string makh)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Xoakhachhang '"+makh+"'";
            //command.CommandText = "DELETE KH FROM KHACHHANGTHANTHIET KH " +
            //                      "WHERE KH.MAKH='" + makh + "'";
            //command.Parameters.Add("@MANV", SqlDbType.VarChar, 10);
            // gán giá trị
            //command.Parameters["@MANV"].Value = manv;
            command.ExecuteNonQuery();
            connection.Close();
        }
        public static void Sua(KhachHangDTO khachhang)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Sửa
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "EXEC SuaKhachHang @MAKH,@HOTEN,@DIACHI,@NGAYSINH,@GIOITINH,@SDT,@LOAIKH,@NGAYDK";
            command.CommandText = "set dateformat dmy\n EXEC SuaKhachHang '" + khachhang.MaKH + "'" + ",N'"
                + khachhang.HoTen + "'" + ",N'"
                + khachhang.DiaChi + "'" + ",'"
                + khachhang.NgaySinh_String + "'" + ",N'"
                + khachhang.GioiTinh + "'" + ",'"
                + khachhang.SDT + "'" + ",N'"
                + khachhang.LoaiKH + "'" + ",'"
                + khachhang.NgayDK_String + "'";
          
            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
        public static DataTable TimTheoMaKH(string makh)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimKH_theo_MAKH '" + makh+"'";
          
            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoHoTen(string hoten)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Timkhachhang_hoten N'"+hoten+"'";
            //command.CommandText = "SELECT * FROM KHACHHANGTHANTHIET " +
            //                      "WHERE HOTEN LIKE N'" + hoten + "%'";

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoSDT(string sdt)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Timkhachhang_sdt '"+sdt+"'";
            //command.CommandText = "SELECT * FROM KHACHHANGTHANTHIET " +
            //                     "WHERE SDT LIKE'" + sdt + "%'";

            // gán giá trị

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable LoadDataGrid_LichSuDatVe(string makh)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC LoadDataGrid_LichSuDatVe '" + makh + "'";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable LichSuDatVe_LayThongTinChiTiet(string makh,string mave)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC LichSuDatVe_LayThongTinChiTiet '" + makh + "','" + mave +"'";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable LichSuDatVe_LayDSGhe(string makh, string mave)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC LichSuDatVe_LayDSGhe '" + makh + "','" + mave + "'";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }
    }

}

