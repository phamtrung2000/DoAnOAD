using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using API.DTO;
namespace API.DAL
{
    public class DAL_NhanVien : DBConnect
    {
        /*Load danh sach Nhan vien*/
        public DataTable GetNV()
        {
            string query = "SELECT * FROM NHAN_VIEN ";
            SqlDataAdapter adapt = new SqlDataAdapter(query, connection);
            DataTable DSThanhVien = new DataTable();
            adapt.Fill(DSThanhVien);
            return DSThanhVien;
        }
        public DataTable GetNV(int ID)
        {
            string query = "SELECT * FROM NHAN_VIEN WHERE IDNV = '" + ID.ToString() + "'";
            SqlDataAdapter adapt = new SqlDataAdapter(query, connection);
            DataTable DSThanhVien = new DataTable();
            adapt.Fill(DSThanhVien);
            return DSThanhVien;
        }
        /*Them Nhan vien*/
        public bool AddNV(DTO_NhanVien NV)
        {

            string SQL = "EXEC USP_INSERT_NV @IDNV , @hoten , @diachi , @sdt , @ngayvaolam , @ngaysinh , @username , @password , @IDCV , @Active ";
            return DAL_EX.Instance.ExcuteReader(SQL, new object[] {
                NV.IDNV,
                NV.HoTen_NV,
                NV.DiaChi_NV,
                NV.SDT_NV,
                NV.NgayVLam,
                NV.NgaySinh,
                NV.UserName_NV,
                NV.PassWord_NV,
                NV.ID_CV,
                NV.Active
            });

        }
        /*Xoa nhan vien*/
        public bool DeleteNhanVien(int NV_ID)
        {

            string SQL = "EXEC USP_DELETE_NV @IDNV";
            return DAL_EX.Instance.ExcuteReader(SQL, new object[] { NV_ID });
        }
        public bool SuaNhanVien(DTO.DTO_NhanVien NV)
        {
            string SQL = "USP_UPDATE_NV @IDNV , @hoten , @diachi , @sdt , @ngayvaolam , @ngaysinh , @username , @password , @IDCV , @Active";
            return DAL_EX.Instance.ExcuteReader(SQL, new object[] {
                NV.IDNV,
                NV.HoTen_NV,
                NV.DiaChi_NV,
                NV.SDT_NV,
                NV.NgayVLam,
                NV.NgaySinh,
                NV.UserName_NV,
                NV.PassWord_NV,
                NV.ID_CV,
                NV.Active
            });
        }
    }
}
