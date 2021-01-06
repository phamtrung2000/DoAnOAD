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
    public class LichChieuBUS
    {
        public static DataTable LoadDSLC()
        {
            return LichChieuDAO.LoadDSLC();
        }

        public static DataTable LoadDSNgayChieu()
        {
            return LichChieuDAO.LoadDSNgayChieu();
        }

        public static DataTable HienLichChieuPhim(DateTime ngaychieu, string macc)
        {
            return LichChieuDAO.HienLichChieuPhim(ngaychieu, macc);
        }

        public static DataTable HienLichChieuPhim_NgayChieu_MaCC_MaPC(DateTime ngaychieu, string macc, string mapc)
        {
            return LichChieuDAO.HienLichChieuPhim_NgayChieu_MaCC_MaPC(ngaychieu, macc, mapc);
        }

        public static DataTable DatVe_Phim_NgayChieu(string maphim, string ngaychieu)
        {
            return LichChieuDAO.DatVe_Phim_NgayChieu(maphim, ngaychieu);
        }


        public static void Them(LichChieuDTO lc)
        {
            LichChieuDAO.Them(lc);
        }

        public static void Sua(LichChieuDTO lc)
        {
            LichChieuDAO.Sua(lc);
        }

        public static void Xoa(DateTime ngaychieu, string maphim, string macc, string mapc)
        {
            LichChieuDAO.Xoa(ngaychieu, maphim, macc, mapc);
        }
        public static DataTable TimTheongaychieu(DateTime ngaychieu)
        {
            return LichChieuDAO.Timtheongaychieu(ngaychieu);
        }
        public static DataTable TimTheomacclc(string macc)
        {
            return LichChieuDAO.Timtheomacc(macc);
        }
        public static DataTable Timtheomapc(string mapc)
        {
            return LichChieuDAO.Timtheomapc(mapc);
        }
    }
}
