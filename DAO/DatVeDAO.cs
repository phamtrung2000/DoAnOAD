using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO;
using System.Data;
using System.Data.SqlClient;

namespace DAO
{

    public class DatVeDAO
    {
        public static DataTable DatVe_Load_ChonChoNgoi(string maphim, string ngaychieu, string macc)
        {
            // string date = ngaychieu.Day.ToString() + '/' + ngaychieu.Month.ToString() + '/' + ngaychieu.Year.ToString();

            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            //command.CommandText = "set dateformat dmy\n EXEC DatVe_Load_ChonChoNgoi '" + maphim + "'" + ",'" + date + "'" + ",'" + macc + "'";
            command.CommandText = "set dateformat dmy\n EXEC DatVe_Load_ChonChoNgoi '" + maphim + "'" + ",'" + ngaychieu + "'" + ",'" + macc + "'";
            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable DatVe_LoadDSChoNgoi(string maphim, string ngaychieu, string macc)
        {
            //string date = ngaychieu.Day.ToString() + '/' + ngaychieu.Month.ToString() + '/' + ngaychieu.Year.ToString();

            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "set dateformat dmy\n EXEC Load_DSGhe '" + ngaychieu + "'" + ",'" + macc + "'" + ",'" + maphim + "'";
            // exec Load_DSGhe  '02/01/2021','CC1','PHIM1'
            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

        public static DataTable DatVe_GetMALC(string maphim, string ngaychieu, string macc)
        {
            // string date = ngaychieu.Day.ToString() + '/' + ngaychieu.Month.ToString() + '/' + ngaychieu.Year.ToString();

            SqlConnection connection = SQLConnectionData.HamKetNoi();
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = "set dateformat dmy\n EXEC GetMALC '" + ngaychieu + "'" + ",'" + macc + "'" + ",'" + maphim + "'";
            DataTable dataTable = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
            dataAdapter.Fill(dataTable);
            connection.Close();
            return dataTable;
        }

    }
}
