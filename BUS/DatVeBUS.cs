using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAO;
using DTO;
using System.Data;


namespace BUS
{
    public class DatVeBUS
    {
        public static DataTable DatVe_Load_ChonChoNgoi(string maphim, string ngaychieu, string macc)
        {
            return DatVeDAO.DatVe_Load_ChonChoNgoi(maphim, ngaychieu, macc);
        }
        public static DataTable DatVe_LoadDSChoNgoi(string maphim, string ngaychieu, string macc)
        {
            return DatVeDAO.DatVe_LoadDSChoNgoi(maphim, ngaychieu, macc);
        }
        public static DataTable DatVe_GetMALC(string maphim, string ngaychieu, string macc)
        {
            return DatVeDAO.DatVe_GetMALC(maphim, ngaychieu, macc);
        }
    }
}
