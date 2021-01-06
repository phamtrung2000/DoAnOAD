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
    public class PhimBUS
    {
        PhimDAO PhimDAO = new PhimDAO();
        public  DataTable LoadDSPhim()
        {
            return PhimDAO.LoadDSPhim();
        }
        public void Them(PhimDTO p)
        {
            PhimDAO.Them(p);
        }

        public void Sua(PhimDTO p)
        {
            PhimDAO.Sua(p);
        }

        public void Xoa(string map)
        {
            PhimDAO.Xoa(map);
        }
        public DataTable TimTheoMaP(string map)
        {
            return PhimDAO.TimtheoMaP(map);
        }
        public DataTable TimTheoTenPhim(string tenp)
        {
            return PhimDAO.TimTheoTenPhim(tenp);
        }
        public DataTable LoadTheLoaiPhim(string maphim)
        {
            return PhimDAO.LoadTheLoaiPhim(maphim);
        }
    }
}
