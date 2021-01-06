using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using DAO;
using System.Data;

namespace BUS
{
    public class CTHD_BUS
    {
        public static DataTable Load_CTHD(string sohd)
        {
            return CTHD_DAO.Load_CTHD(sohd);
        }

        public static void Them(CTVE_DTO ctve)
        {
            CTHD_DAO.Them(ctve);
        }
    }
}
