using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
namespace API.DAL
{
    class DAL_EX : DBConnect
    {
        private static DAL_EX instance;

        internal static DAL_EX Instance { get { if (DAL_EX.instance == null) { DAL_EX.instance = new DAL_EX(); } return DAL_EX.instance; } set { DAL_EX.instance = value; } }
        public DAL_EX()
        { }
        public DataTable ExecuteQuery(string query, object[] parameter = null)
        {
            connection.Open();
            DataTable dta = new DataTable();
            SqlCommand command = new SqlCommand(query, connection);
            string[] ListPara = query.Split(' ');
            int i = 0;

            foreach (string item in ListPara)
            {
                if (item.Contains('@'))
                {
                    command.Parameters.AddWithValue(item, parameter[i]);
                    i++;
                }
            }
            SqlDataAdapter adpt = new SqlDataAdapter(command);
            adpt.Fill(dta);
            connection.Close();
            return dta;
        }
        public bool ExcuteReader(string query, object[] para = null)
        {
            connection.Open();
            SqlCommand command = new SqlCommand(query, connection);
            if (para != null)
            {
                string[] listpara = query.Split(' ');
                int i = 0;
                foreach (string item in listpara)
                {
                    if (item.Contains('@'))
                    {
                        command.Parameters.AddWithValue(item, para[i]);
                        i++;
                    }
                }
            }

            try
            {
                SqlDataReader dta = command.ExecuteReader();
            }
            catch (Exception e)
            {
                return false;
            }
            finally
            {
                connection.Close();

            }
            return true;
        }

    }
}
