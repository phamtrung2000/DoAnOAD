using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using API.DTO;
using System.Data.Common;

namespace API.DAL
{
    public class DAL_PhieuMuon : DBConnect
    {
        public DataTable GetPM(string idtv)
        {
            string query = "SELECT * FROM PHIEU_MUON WHERE IDTV =" + idtv;
            SqlDataAdapter adapt = new SqlDataAdapter(query, connection);
            DataTable DSPM = new DataTable();
            adapt.Fill(DSPM);
            return DSPM;
        }

        public int GetNewPM()
        {
            int idpm = 0;
            connection.Open();
            string query = "select max(IDPM) from PHIEU_MUON ";
            SqlCommand cmd = new SqlCommand(query, connection);
            using (DbDataReader reader = cmd.ExecuteReader())
            {
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (Convert.IsDBNull(reader.GetValue(0)) == true)
                        {
                            idpm = 0;
                        }
                        else
                        {
                            idpm = Convert.ToInt32(reader.GetValue(0));
                        }
                    }
                    reader.Close();
                }
            }
            connection.Close();
            return idpm;
        }

        public bool AddPM(DTO.DTO_PhieuMuon PM)
        {
            string SQL = "EXEC USP_INSERT_PM @IDTV , @IDNV , @NgayMuon , @Tra";
            return DAL_EX.Instance.ExcuteReader(SQL, new object[] {PM.ID_TV,
                                                                   PM.ID_NV,
                                                                   PM.NgayMuon,
                                                                   PM.Tra
            });
        }

        public bool suaPM(DTO.DTO_PhieuMuon PM)
        {
            string SQL = "USP_UPDATE_PM @IDPM , @Tra";
            return DAL_EX.Instance.ExcuteReader(SQL, new object[] {
                   PM.ID_PM,
                   PM.Tra
            });
        }
    }
}
