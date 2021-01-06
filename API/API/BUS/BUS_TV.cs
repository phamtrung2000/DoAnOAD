using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using API.DAL;
using API.DTO;

namespace API.BUS
{
    public class BUS_TV
    {
        DAL_ThanhVien dalThanhVien = new DAL_ThanhVien();
        public DataTable GetThanhVien()
        {
            return dalThanhVien.GetTV();
        }
        public bool themThanhVien(DTO_ThanhVien tv)
        {
            return dalThanhVien.AddTV(tv);
        }

        public bool suaThanhVien(DTO_ThanhVien tv)
        {
            return dalThanhVien.suaThanhVien(tv);
        }

        public bool xoaThanhVien(int TV_ID)
        {
            return dalThanhVien.xoaThanhVien(TV_ID);
        }
        public DataTable SearchTV(int id)
        {
            return dalThanhVien.SeacrchTV(id);
        }
    }
}
