using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace DAO
{
    public class NhanVienDAO
    {
        //private SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString);
        //Load danh sách sv từ database
        public static DataTable LoadDSNV()
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "LoadNhanVien";

            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

       

        public bool Xoa_NhanVien(string manv)
        {
            SqlConnection conn = new SqlConnection(@"Data Source=;Initial Catalog=DOAN;Integrated Security=True");
            conn.Open();
            string query = "XoaNhanVien";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter sqlParameter = new SqlParameter("@manv", manv);
            cmd.Parameters.Add(sqlParameter);
            cmd.ExecuteNonQuery();

            return true;
        }

        public void Sua_NhanVien(string manv, NhanVienDTO nv)
        {
            SqlConnection conn = new SqlConnection(@"Data Source=;Initial Catalog=DOAN;Integrated Security=True");
            conn.Open();
            string query = "SuaNhanVien";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("@MaNV", nv.MaNV),
                new SqlParameter("@HoTen",nv.HoTen),
                new SqlParameter("@ChucVu", nv.ChucVu),
                new SqlParameter("@Sdt",nv.SDT),
                new SqlParameter("@GioiTinh", nv.GioiTinh),
                new SqlParameter("@NgaySinh",nv.NgaySinh),
                new SqlParameter("@DiaChi", nv.DiaChi),
                new SqlParameter("@Luong",nv.Luong),
                new SqlParameter("@NgayVL",nv.NgayVL),
            };
            cmd.Parameters.AddRange(sqlParameters);
            cmd.ExecuteNonQuery();

        }

        public string Add_NhanVien(NhanVienDTO nv)
        {
            SqlConnection conn = new SqlConnection(@"Data Source=;Initial Catalog=DOAN;Integrated Security=True");
            conn.Open();
            string query = "ThemNhanVien";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("@MaNV", nv.MaNV),
                new SqlParameter("@HoTen",nv.HoTen),
                new SqlParameter("@ChucVu", nv.ChucVu),
                new SqlParameter("@Sdt",nv.SDT),
                new SqlParameter("@GioiTinh", nv.GioiTinh),
                new SqlParameter("@NgaySinh",nv.NgaySinh),
                new SqlParameter("@DiaChi", nv.DiaChi),
                new SqlParameter("@Luong",nv.Luong),
                new SqlParameter("@NgayVL",nv.NgayVL),
            };
            cmd.Parameters.AddRange(sqlParameters);
            cmd.ExecuteNonQuery();
            string maNV = cmd.Parameters[0].ToString(); // cột đầu tiên của tham số truyền vào là Mã nhân viên.
            return maNV;
        }

        public static DataTable Get_NhanVien_byMaNV(string manv)
        {
            SqlConnection conn = new SqlConnection(@"Data Source=;Initial Catalog=DOAN;Integrated Security=True");
            conn.Open();
            DataTable dataTable = new DataTable();
            DataSet dataSet = new DataSet();
            string query = "TimTheo_MaNV";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@manv", manv);

            SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
            dataAdapter.Fill(dataTable);

            return dataTable;
        }

        public static DataTable GetAll_table()
        {
            SqlConnection conn = new SqlConnection(@"Data Source=;Initial Catalog=DOAN;Integrated Security=True");
            conn.Open();
            DataTable dataTable = new DataTable();
            DataSet dataSet = new DataSet();
            string query = "SelectAllNhanVien";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
            dataAdapter.Fill(dataTable);

            return dataTable;
        }

        public static void Them(NhanVienDTO nhanvien)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Thêm
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "INSERT INTO NHANVIEN VALUES(@MANV,@HOTEN,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL)";
            command.CommandText = "EXEC Themnhanvien @MANV,@HOTEN,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL";
            command.Parameters.Add("@MANV", SqlDbType.VarChar, 10);
            command.Parameters.Add("@HOTEN", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@CHUCVU", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@SDT", SqlDbType.VarChar, 20);
            command.Parameters.Add("@GIOITINH", SqlDbType.NVarChar, 4);
            command.Parameters.Add("@NGAYSINH", SqlDbType.Date);
            command.Parameters.Add("@DIACHI", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@LUONG", SqlDbType.Money);
            command.Parameters.Add("@NGAYVL", SqlDbType.Date);

            // gán giá trị
            command.Parameters["@MANV"].Value = nhanvien.MaNV;
            command.Parameters["@HOTEN"].Value = nhanvien.HoTen;
            command.Parameters["@CHUCVU"].Value = nhanvien.ChucVu;
            command.Parameters["@SDT"].Value = nhanvien.SDT;
            command.Parameters["@GIOITINH"].Value = nhanvien.GioiTinh;
            command.Parameters["@NGAYSINH"].Value = nhanvien.NgaySinh;
            command.Parameters["@DIACHI"].Value = nhanvien.DiaChi;
            command.Parameters["@LUONG"].Value = nhanvien.Luong;
            command.Parameters["@NGAYVL"].Value = nhanvien.NgayVL;

            command.ExecuteNonQuery();

            // đóng kết nối
            connection.Close();
        }

        public static void Sua(NhanVienDTO nhanvien)
        {
            // mở kết nối
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            // tạo câu lệnh Sửa
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Suanhanvien @MANV,@HOTEN,@CHUCVU,@SDT,@GIOITINH,@NGAYSINH,@DIACHI,@LUONG,@NGAYVL";
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
            command.Parameters.Add("@MANV", SqlDbType.VarChar, 10);
            command.Parameters.Add("@HOTEN", SqlDbType.NVarChar, 40);
            command.Parameters.Add("@CHUCVU", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@SDT", SqlDbType.VarChar, 20);
            command.Parameters.Add("@GIOITINH", SqlDbType.NVarChar, 4);
            command.Parameters.Add("@NGAYSINH", SqlDbType.DateTime);
            command.Parameters.Add("@DIACHI", SqlDbType.NVarChar, 100);
            command.Parameters.Add("@LUONG", SqlDbType.Money);
            command.Parameters.Add("@NGAYVL", SqlDbType.DateTime);

            // gán giá trị
            command.Parameters["@MANV"].Value = nhanvien.MaNV;
            command.Parameters["@HOTEN"].Value = nhanvien.HoTen;
            command.Parameters["@CHUCVU"].Value = nhanvien.ChucVu;
            command.Parameters["@SDT"].Value = nhanvien.SDT;
            command.Parameters["@GIOITINH"].Value = nhanvien.GioiTinh;
            command.Parameters["@NGAYSINH"].Value = nhanvien.NgaySinh;
            command.Parameters["@DIACHI"].Value = nhanvien.DiaChi;
            command.Parameters["@LUONG"].Value = nhanvien.Luong;
            command.Parameters["@NGAYVL"].Value = nhanvien.NgayVL;

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
            command.CommandText = "EXEC Xoanhanvien'" + manv + "'";
            //command.CommandText = "DELETE NV FROM NHANVIEN NV " +
            //                      "WHERE NV.MANV='" + manv + "'";
            //command.Parameters.Add("@MANV", SqlDbType.VarChar, 10);
            // gán giá trị
            //command.Parameters["@MANV"].Value = manv;
            command.ExecuteNonQuery();
            connection.Close();
        }

        public static DataTable TimTheoMaNV(string manv)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Timtheo_manv '" + manv + "'";
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

        public static DataTable TimTheoHoTen(string hoten)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Timtheo_hoten N'" + hoten + "'";
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

        public static DataTable TimTheoSDT(string sdt)
        {
            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();

            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "EXEC Timtheo_sdt '" + sdt + "'";
            //command.CommandText = "SELECT * FROM NHANVIEN " +
            //                     "WHERE SDT LIKE'" + sdt + "%'";

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
