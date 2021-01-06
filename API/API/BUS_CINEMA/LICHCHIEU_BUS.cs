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
        LichChieuDAO LichChieuDAO = new LichChieuDAO();
        public DataTable LoadDSLC()
        {
            return LichChieuDAO.LoadDSLC();
        }

        public DataTable LoadDSNgayChieu()
        {
            return LichChieuDAO.LoadDSNgayChieu();
        }

        public DataTable HienLichChieuPhim(DateTime ngaychieu, string macc)
        {
            return LichChieuDAO.HienLichChieuPhim(ngaychieu, macc);
        }

        public DataTable HienLichChieuPhim_NgayChieu_MaCC_MaPC(DateTime ngaychieu, string macc, string mapc)
        {
            return LichChieuDAO.HienLichChieuPhim_NgayChieu_MaCC_MaPC(ngaychieu, macc, mapc);
        }

        public DataTable DatVe_Phim_NgayChieu(string maphim, DateTime ngaychieu)
        {
            return LichChieuDAO.DatVe_Phim_NgayChieu(maphim, ngaychieu);
        }


        public void Them(LichChieuDTO lc)
        {
            LichChieuDAO.Them(lc);
        }

        public void Sua(LichChieuDTO lc)
        {
            LichChieuDAO.Sua(lc);
        }

        public void Xoa(DateTime ngaychieu, string maphim, string macc, string mapc)
        {
            LichChieuDAO.Xoa(ngaychieu, maphim, macc, mapc);
        }
        public DataTable TimTheongaychieu(DateTime ngaychieu)
        {
            return LichChieuDAO.Timtheongaychieu(ngaychieu);
        }
        public DataTable TimTheomacclc(string macc)
        {
            return LichChieuDAO.Timtheomacc(macc);
        }
        public DataTable Timtheomapc(string mapc)
        {
            return LichChieuDAO.Timtheomapc(mapc);
        }
    }
}
