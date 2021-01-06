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
        public static DataTable LoadDSHoaDon()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "LoadDSVe";

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

            command.CommandText = "EXEC ThemVe @MAVE,@MALC,@NGAY_GIO_MUA,@TONGCONG,@MAKH";
          
            command.Parameters.Add("@MAVE", SqlDbType.VarChar, 10);
            command.Parameters.Add("@MALC", SqlDbType.VarChar, 10);
            command.Parameters.Add("@NGAY_GIO_MUA", SqlDbType.DateTime);
            command.Parameters.Add("@TONGCONG", SqlDbType.Money);
            command.Parameters.Add("@MAKH", SqlDbType.VarChar, 10);

            // gán giá trị
            command.Parameters["@MAVE"].Value = ve.MaVe;
            command.Parameters["@MALC"].Value = ve.MaLC;
            command.Parameters["@NGAY_GIO_MUA"].Value = ve.Ngay_Gio_Mua;
            command.Parameters["@TONGCONG"].Value = ve.TongCong;
            command.Parameters["@MAKH"].Value = ve.MaKH;

            command.ExecuteNonQuery();
            connection.Close();
        }

        public static void Sua(VeDTO ve)
        {
            //// mở kết nối
            //SqlConnection connection = SQLConnectionData.HamKetNoi();
            //connection.Open();

            //// tạo câu lệnh Sửa
            //SqlCommand command = connection.CreateCommand();
            //command.CommandType = CommandType.Text;

            //command.CommandText = "UPDATE HOADON " +
            //    "SET SOHD=@SOHD ," +
            //    "NGAY_GIO_HD=@NGAY_GIO_HD," +
            //    "MAKH=@MAKH," +
            //    "TONGCONG=@TONGCONG" +
            //    "WHERE SOHD=@SOHD";

            //command.Parameters.Add("@SOHD", SqlDbType.VarChar, 10);
            //command.Parameters.Add("@NGAY_GIO_HD", SqlDbType.DateTime);
            //command.Parameters.Add("@MAKH", SqlDbType.VarChar, 10);
            //command.Parameters.Add("@TONGCONG", SqlDbType.Money);
            //// gán giá trị
            //command.Parameters["@SOHD"].Value = ve.SoHD;
            //command.Parameters["@NGAYHD"].Value = ve.Ngay_Gio_HD;
            //command.Parameters["@MAKH"].Value = ve.MaKH;
            //command.Parameters["@TONGCONG"].Value = ve.TongCong;

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

        public static DataTable TimTheoSoHD(string sohd)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "SELECT HD.STT,HD.SOHD,HD.NGAYHD,HD.GIOHD,KH.HOTEN,QTN.TENQTN,NV.HOTEN,HD.TONGCONG " +
                                 " FROM HOADON HD JOIN KHACHHANGTHANTHIET KH ON KH.MAKH=HD.MAKH " +
                                 " JOIN QUAYTN QTN ON QTN.MAQTN=HD.MAQTN " +
                                 " JOIN NHANVIEN NV ON NV.MANV=QTN.MANV " +
                                 " WHERE SOHD LIKE'" + sohd + "%'";

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
            command.CommandText = "SELECT HD.STT,HD.SOHD,HD.NGAYHD,HD.GIOHD,KH.HOTEN,QTN.TENQTN,NV.HOTEN,HD.TONGCONG " +
                                 " FROM HOADON HD JOIN KHACHHANGTHANTHIET KH ON KH.MAKH=HD.MAKH " +
                                 " JOIN QUAYTN QTN ON QTN.MAQTN=HD.MAQTN " +
                                 " JOIN NHANVIEN NV ON NV.MANV=QTN.MANV " +
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
            command.CommandText = "SELECT HD.STT,HD.SOHD,HD.NGAYHD,HD.GIOHD,KH.HOTEN,QTN.TENQTN,NV.HOTEN,HD.TONGCONG " +
                                " FROM HOADON HD JOIN KHACHHANGTHANTHIET KH ON KH.MAKH=HD.MAKH " +
                                " JOIN QUAYTN QTN ON QTN.MAQTN=HD.MAQTN " +
                                " JOIN NHANVIEN NV ON NV.MANV=QTN.MANV " +
                                " WHERE GIOHD BETWEEN '" + tugio.TimeOfDay + "' AND '" + dengio.TimeOfDay + "'";

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
            command.CommandText = "SELECT HD.STT,HD.SOHD,HD.NGAYHD,HD.GIOHD,KH.HOTEN,QTN.TENQTN,NV.HOTEN,HD.TONGCONG " +
                               " FROM HOADON HD JOIN KHACHHANGTHANTHIET KH ON KH.MAKH=HD.MAKH " +
                               " JOIN QUAYTN QTN ON QTN.MAQTN=HD.MAQTN " +
                               " JOIN NHANVIEN NV ON NV.MANV=QTN.MANV " +
                               " WHERE TRIGIA  BETWEEN " + gia_min + " AND " + gia_max;

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
            command.CommandText = "SELECT HD.STT,HD.SOHD,HD.NGAYHD,HD.GIOHD,KH.HOTEN,QTN.TENQTN,NV.HOTEN,HD.TONGCONG " +
                             " FROM HOADON HD JOIN KHACHHANGTHANTHIET KH ON KH.MAKH=HD.MAKH " +
                             " JOIN QUAYTN QTN ON QTN.MAQTN=HD.MAQTN " +
                             " JOIN NHANVIEN NV ON NV.MANV=QTN.MANV " +
                             " WHERE TRIGIA >= " + gia_min;

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
            command.CommandText = "SELECT HD.STT,HD.SOHD,HD.NGAYHD,HD.GIOHD,KH.HOTEN,QTN.TENQTN,NV.HOTEN,HD.TONGCONG " +
                            " FROM HOADON HD JOIN KHACHHANGTHANTHIET KH ON KH.MAKH=HD.MAKH " +
                            " JOIN QUAYTN QTN ON QTN.MAQTN=HD.MAQTN " +
                            " JOIN NHANVIEN NV ON NV.MANV=QTN.MANV " +
                            " WHERE TRIGIA <= " + gia_max;

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
            command.CommandText = "SELECT HD.STT,HD.SOHD,HD.NGAYHD,HD.GIOHD,KH.HOTEN,QTN.TENQTN,NV.HOTEN,HD.TONGCONG " +
                           " FROM HOADON HD JOIN KHACHHANGTHANTHIET KH ON KH.MAKH=HD.MAKH " +
                           " JOIN QUAYTN QTN ON QTN.MAQTN=HD.MAQTN " +
                           " JOIN NHANVIEN NV ON NV.MANV=QTN.MANV " +
                           " WHERE MAKH LIKE '" + makh + "%'";

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
