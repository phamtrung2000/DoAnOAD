using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net;
using System.Data;
using System.Windows;
using System.Globalization;
namespace DTO
{
    public class DatVe_controller
    {
        public async Task<DataTable> LoadDSchongoi(string Maphim, DateTime NgayChieu,string MaCC)
        {
            DataTable dta = new DataTable();
            HttpClient client = new HttpClient();
            string format = "yyyy-MM-dd";
            String date;
            date = NgayChieu.ToString(format, DateTimeFormatInfo.InvariantInfo);
            var response = client.GetAsync("https://localhost:5001/DatVe/LoadDSChoNgoi/" + Maphim + "/" + date+"/"+MaCC).Result;
            if (response.IsSuccessStatusCode)
            {
                dta = await response.Content.ReadAsAsync<DataTable>();
            }
            Console.WriteLine(date);
            return dta;
        }

        public async Task<DataTable> Chonchongoi(string Maphim, DateTime NgayChieu, string MaCC)
        {
            DataTable dta = new DataTable();
            HttpClient client = new HttpClient();
            string format = "yyyy-MM-dd";
            String date;
            date = NgayChieu.ToString(format, DateTimeFormatInfo.InvariantInfo);
            var response = client.GetAsync("https://localhost:5001/DatVe/LoadChonNgoi/" + Maphim + "/" + date + "/" + MaCC).Result;
            if (response.IsSuccessStatusCode)
            {
                dta = await response.Content.ReadAsAsync<DataTable>();
            }
            Console.WriteLine(date);
            return dta;
        }
    }
}
