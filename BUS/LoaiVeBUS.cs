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
    public class LoaiVeBUS
    {
        public static DataTable LoadDSLoaiVe()
        {
            return LoaiVeDAO.LoadDSLoaiVe();
        }
        public static void Them(LoaiVeDTO p)
        {
            LoaiVeDAO.Them(p);
        }

        public static void Sua(LoaiVeDTO p)
        {
            LoaiVeDAO.Sua(p);
        }

        public static void Xoa(string map)
        {
            LoaiVeDAO.Xoa(map);
        }
        public static DataTable TimTheoMaLV(string map)
        {
            return LoaiVeDAO.TimtheoMaLV(map);
        }
        public static DataTable TimTheoTenLoaiVe(string tenp)
        {
            return LoaiVeDAO.TimTheoTenLoaiVe(tenp);
        }
    }
}
