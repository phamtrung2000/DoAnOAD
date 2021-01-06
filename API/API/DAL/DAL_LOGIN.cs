using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
namespace API.DAL
{
    class DAL_LOGIN
    {

        public DAL_LOGIN()
        { }
        public bool CheckLogin(string username, string password)
        {
            string query = "USP_LOGIN @username , @password";
            //DAL_EX dataprovider = new DAL_EX();
            DataTable result = DAL_EX.Instance.ExecuteQuery(query, new object[] { username, password });
            return result.Rows.Count > 0;
        }
    }
}