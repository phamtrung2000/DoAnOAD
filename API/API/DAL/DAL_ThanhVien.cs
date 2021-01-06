using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
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
    public class DAL_ThanhVien : DBConnect
    {
        /*Load danh sach Thanh Vien*/
        public DataTable GetTV()
        {
            string query = "SELECT * FROM THANH_VIEN ";
            SqlDataAdapter adapt = new SqlDataAdapter(query, connection);
            DataTable DSThanhVien = new DataTable();
            adapt.Fill(DSThanhVien);
            return DSThanhVien;
        }
        /*Them Thanh Vien*/
        public bool AddTV(DTO_ThanhVien TV)
        {


            string SQL = "EXEC USP_INSERT_TV @IDTV , @hoten , @diachi , @sdt , @CMND , @ngaydangki , @ngayhethan , @ngaysinh , @IDLTV , @email , @Image , @Gioitinh ";
            return DAL_EX.Instance.ExcuteReader(SQL, new object[] { TV.ThanhVien_ID,
                                                                        TV.HoTen_TV,
                                                                        TV.DiaChi_TV,
                                                                        TV.SDT_TV,
                                                                        TV.CMND_TV,
                                                                        TV.NgayDangKi,
                                                                        TV.NgayHetHan,
                                                                        TV.NgaySinh,
                                                                        TV.ID_LTV,
                                                                        TV.Email,
                                                                        TV.Image,
                                                                        TV.GioiTinh });
        }
        public bool xoaThanhVien(int TV_ID)
        {

            string SQL = "USP_DELETE_TV @IDTV ";
            return DAL_EX.Instance.ExcuteReader(SQL, new object[] { TV_ID });
        }
        public bool suaThanhVien(DTO.DTO_ThanhVien TV)
        {
            string SQL = "USP_UPDATE_TV @IDTV , @hoten , @diachi , @sdt , @CMND , @ngaydangki , @ngayhethan , @ngaysinh , @IDLTV , @email , @Image , @Gioitinh";
            return DAL_EX.Instance.ExcuteReader(SQL, new object[] {
                TV.ThanhVien_ID,
                TV.HoTen_TV,
                TV.DiaChi_TV,
                TV.SDT_TV,
                TV.CMND_TV,
                TV.NgayDangKi,
                TV.NgayHetHan,
                TV.NgaySinh,
                TV.ID_LTV,
                TV.Email,
                TV.Image,
                TV.GioiTinh
            });
        }
        public DataTable SeacrchTV(int id)
        {
            string SQL = "Select * from THANH_VIEN where IDTV = ' " + id.ToString() + "'";
            DataTable dta = new DataTable();
            SqlCommand cmd = new SqlCommand(SQL, connection);
            SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            adpt.Fill(dta);
            return dta;
        }

    }
}

