using DTO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class SQLConnectionData
    {
        public static SqlConnection HamKetNoi()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);

            return connection;
        }
    }

   

    public class DangNhapNhanVienDAO
    {
        public static string HoTen;
        public static string ChucVu;
        public static string Mk;
        public static string tk;

        public static bool Login(string user, string pass)
        {

            using (var connection = SQLConnectionData.HamKetNoi())
            {
                connection.Open();

                using (var command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandText = "EXEC Dangnhapnhanvien '" + user + "','" + pass + "'";
                    // command.CommandText = "SELECT * FROM NGUOIDUNG WHERE TAIKHOAN=@user AND MATKHAU=@pass";
                    command.Parameters.AddWithValue("@user", user);
                    command.Parameters.AddWithValue("@pass", pass);
                    command.CommandType = CommandType.Text;
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows == true)
                    {
                        while (reader.Read())
                        {
                            tk = user;
                            Mk = pass;
                            HoTen = reader.GetString(0);
                            ChucVu = reader.GetString(1);
                        }
                        return true;
                    }
                    else
                        return false;
                }
            }
        }

       
        

        public static int Phanquyen(string user, string pass)
        {
            using (var connection = SQLConnectionData.HamKetNoi())
            {
                connection.Open();

                // using (SqlCommand cmd = new SqlCommand("EXEC Phanquyennhanvien '"+user+"','"+pass+"'", connection))
                using (SqlCommand cmd = new SqlCommand("EXEC PhanQuyen '" + user + "','" + pass + "'", connection))
                {
                    cmd.CommandType = CommandType.Text;
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        sda.Fill(ds);
                        string a = "";

                        foreach (DataRow row in ds.Tables[0].Rows)
                        {
                            //a = row["CHUCVU"].ToString();
                            a = row["PHANQUYEN"].ToString();
                        }

                        if (a == "Quản trị")
                        {
                            return 1;
                        }
                        // else if (a == "Nhân viên quản lý phim")
                        else if (a == "Quản lý phim, Quản lý loại phim")
                        {
                            return 2;
                        }
                        // else if (a == "Nhân viên quản lý phòng chiếu")
                        else if (a == "Quản lý phòng chiếu")
                        {
                            return 3;
                        }
                        //     else if (a == "Nhân viên quản lý lịch chiếu")
                        else if (a == "Quản lý lịch chiếu")
                        {
                            return 4;
                        }
                        // else if (a == "Nhân viên bán vé")
                        else if (a == "Quản lý loại vé, Quản lý vé")
                        {
                            return 5;
                        }

                        return 0;
                    }
                }
            }
        }
    }
}
