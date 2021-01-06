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
    public class VeBUS
    {
        VeDAO VeDAO = new VeDAO();
        public DataTable LoadDSHoaDon()
        {
            return VeDAO.LoadDSHoaDon();
        }
    }
}