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
    public class LichChieu_controller
    {
        public async Task<DataTable> DatVePhimLichCHieu(string Maphim, DateTime NgayChieu)
        {
            DataTable dta = new DataTable();
            HttpClient client = new HttpClient();
            string format = "yyyy-MM-dd";
            String date;
            date = NgayChieu.ToString(format, DateTimeFormatInfo.InvariantInfo);
            var response = client.GetAsync("https://localhost:5001/LichChieu/DatvePhimNgayChieu/" + Maphim + "/" + date).Result;
            if (response.IsSuccessStatusCode)
            {
                dta = await response.Content.ReadAsAsync<DataTable>();
            }
            Console.WriteLine(date);
            return dta;
        }
    }
}
