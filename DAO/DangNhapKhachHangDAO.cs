using DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class DangNhapKhachHangDAO
    {
        public static string MaKH;

        public static bool Login(string user, string pass)
        {
            using (var connection = SQLConnectionData.HamKetNoi())
            {
                connection.Open();

                using (var command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "EXEC Dangnhapkhachhang '" + user + "','" + pass + "'";

                    //command.CommandText = "SELECT KHTT.LOAIKH,DNKH.TAIKHOAN,DNKH.MATKHAU FROM KHACHHANGTHANTHIET KHTT INNER JOIN DANGNHAP_KHACHHANG DNKH ON DNKH.MAKH = KHTT.MAKH" +
                    //    " WHERE DNKH.TAIKHOAN=@user AND DNKH.MATKHAU=@pass";

                    // command.CommandText = "SELECT * FROM NGUOIDUNG WHERE TAIKHOAN=@user AND MATKHAU=@pass";
                    command.Parameters.AddWithValue("@user", user);
                    command.Parameters.AddWithValue("@pass", pass);
                    command.CommandType = CommandType.Text;
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.HasRows == true)
                    {
                        while (reader.Read())
                        {
                            MaKH = reader.GetString(0);
                        }

                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }
        public static int PhanLoaiKH(string user, string pass)
        {
            using (var connection = SQLConnectionData.HamKetNoi())
            {
                connection.Open();

                using (SqlCommand cmd = new SqlCommand("EXEC PhanLoaiKH '" + user + "', '" + pass + "'", connection))
                {
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        sda.Fill(ds);
                        string a = "";

                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            a = row["LOAIKH"].ToString();
                        }
                        /// quanly :1   nhanvien ban hang :2 
                        if (a == "Đồng")
                        {
                            return 1;
                        }
                        else if (a == "Bạc")
                        {
                            return 2;
                        }
                        else if (a == "Vàng")
                        {
                            return 3;
                        }
                        else if (a == "Bạch kim")
                        {
                            return 4;
                        }
                        else if (a == "Kim cương")
                        {
                            return 5;
                        }
                        return 0;
                    }
                }
            }
        }

        public static void Them(DangNhapKhachHangDTO khachhang)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC TaoTaiKhoanKH @MAKH,@USER,@PASS";
            //command.CommandText = "INSERT INTO KHACHHANGTHANTHIET VALUES(@MAKH,@HOTEN,@DIACHI,@NGAYSINH,@GIOITINH,@SDT,@LOAIKH,@NGAYDK)";

            command.Parameters.Add("@MAKH", SqlDbType.VarChar, 10);
            command.Parameters.Add("@USER", SqlDbType.VarChar, 50);
            command.Parameters.Add("@PASS", SqlDbType.VarChar, 50);

            // gán giá trị
            command.Parameters["@MAKH"].Value = khachhang.MaKH;
            command.Parameters["@USER"].Value = khachhang.TAIKHOAN;
            command.Parameters["@PASS"].Value = khachhang.MATKHAU;
            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }
    }
}

