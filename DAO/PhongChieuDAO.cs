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

    public class PhongChieuDAO
    {
        //Load danh sách sv từ database
        public static DataTable LoadDSPC()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC LoadDSPhongChieu ";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static void Them(PhongChieuDTO phongchieu)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO NHANVIEN VALUES(@MAPC,@TENPC,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL)";
            command.CommandText = "EXEC ThemPhongChieu @MAPC,@TENPC,@SOCHO,@MAYCHIEU,@LOA,@DIENTICH,@TINHTRANG,@TRANGTHIETBIKHAC";

            command.Parameters.Add("@MAPC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@TENPC", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@SOCHO", SqlDbType.Int);
            command.Parameters.Add("@MAYCHIEU", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@LOA", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@DIENTICH", SqlDbType.Int);
            command.Parameters.Add("@TINHTRANG", SqlDbType.NVarChar, 20);
            command.Parameters.Add("@TRANGTHIETBIKHAC", SqlDbType.NVarChar, 100);


            // gán giá trị
            command.Parameters["@MAPC"].Value = phongchieu.MaPC;
            command.Parameters["@TENPC"].Value = phongchieu.TenPC;
            command.Parameters["@MAYCHIEU"].Value = phongchieu.MayChieu;
            command.Parameters["@SOCHO"].Value = phongchieu.SoCho;
            command.Parameters["@LOA"].Value = phongchieu.Loa;
            command.Parameters["@DIENTICH"].Value = phongchieu.DienTich;
            command.Parameters["@TINHTRANG"].Value = phongchieu.TinhTrang;
            command.Parameters["@TRANGTHIETBIKHAC"].Value = phongchieu.TrangThietBiKhac;

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }

        public static void Sua(PhongChieuDTO phongchieu)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Sửa
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC SuaPhongChieu @MAPC,@TENPC,@SOCHO,@MAYCHIEU,@LOA,@DIENTICH,@TINHTRANG,@TRANGTHIETBIKHAC";

            command.Parameters.Add("@MAPC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@TENPC", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@SOCHO", SqlDbType.Int);
            command.Parameters.Add("@MAYCHIEU", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@LOA", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@DIENTICH", SqlDbType.Int);
            command.Parameters.Add("@TINHTRANG", SqlDbType.NVarChar, 20);
            command.Parameters.Add("@TRANGTHIETBIKHAC", SqlDbType.NVarChar, 100);


            // gán giá trị
            command.Parameters["@MAPC"].Value = phongchieu.MaPC;
            command.Parameters["@TENPC"].Value = phongchieu.TenPC;
            command.Parameters["@MAYCHIEU"].Value = phongchieu.MayChieu;
            command.Parameters["@SOCHO"].Value = phongchieu.SoCho;
            command.Parameters["@LOA"].Value = phongchieu.Loa;
            command.Parameters["@DIENTICH"].Value = phongchieu.DienTich;
            command.Parameters["@TINHTRANG"].Value = phongchieu.TinhTrang;
            command.Parameters["@TRANGTHIETBIKHAC"].Value = phongchieu.TrangThietBiKhac;

            // thực hiện câu lệnh
            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }

        public static void Xoa(string mapc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC XoaPhongChieu '" + mapc + "'";

            command.ExecuteNonQuery();
            connection.Close();
        }

        public static DataTable TimTheoMaPC(string mapc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoMaPC '" + mapc + "'";

            command.ExecuteNonQuery();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable TimTheoTenPhongChieu(string tenpc)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TimTheoTenPhongChieu N'" + tenpc + "'";
            //command.CommandText = "SELECT * FROM NHANVIEN " +
            //                      "WHERE TENPC LIKE N'" + tenpc + "%'";

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
