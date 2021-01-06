using API.DAL;
using API.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace API.BUS
{
    public class NhanVien_Bus
    {
        //public bool Login(DTO_NhanVien account)
        //{
        //    DAL_NhanVien NhanVien = new DAL_NhanVien();
        //    return NhanVien.Login(account);
        //}
        public DataTable GetAllAccount()
        {
            DAL_NhanVien NhanVien = new DAL_NhanVien();
            return NhanVien.GetNV();
        }
    }
}
