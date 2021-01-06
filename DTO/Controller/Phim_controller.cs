using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http;
using System.Net;
using System.Data;
namespace DTO
{
    public class Phim_controller
    {
        public async Task<bool> AddPHIM(PhimDTO phim)
        {
            bool str = false;
            HttpClient client = new HttpClient();
            var response = client.PostAsJsonAsync("https://localhost:5001/PHIM/AddPHIM/", phim).Result;
            if (response.IsSuccessStatusCode)
            {
                str = await response.Content.ReadAsAsync<bool>();
            }
            return str;
        }
        public async Task<bool> UpdatePHIM(PhimDTO phim)
        {
            bool str = false;
            HttpClient client = new HttpClient();
            var response = client.PutAsJsonAsync("https://localhost:5001/PHIM/UpdatePHIM", phim).Result;
            if (response.IsSuccessStatusCode)
            {
                str = await response.Content.ReadAsAsync<bool>();
            }
            return str;
        }
        public async Task<bool> DeletePHIM(int ID)
        {
            bool str = false;
            HttpClient client = new HttpClient();
            var response = client.DeleteAsync("https://localhost:5001/PHim/DeletePHIM/" + ID.ToString()).Result;
            if (response.IsSuccessStatusCode)
            {
                str = await response.Content.ReadAsAsync<bool>();
            }
            return str;
        }
        public async Task<DataTable> GetPHIM()
        {
            DataTable dta = new DataTable();
            HttpClient client = new HttpClient();
            var response = client.GetAsync("https://localhost:5001/Phim").Result;
            if (response.IsSuccessStatusCode)
            {
                dta = await response.Content.ReadAsAsync<DataTable>();
            }
            return dta;
        }

        public async Task<DataTable> GetPHIMTheoID(string ID)
        {
            DataTable dta = new DataTable();
            HttpClient client = new HttpClient();
            var response = client.GetAsync("https://localhost:5001/PHIM/SearchPHIM/" + ID).Result;
            if (response.IsSuccessStatusCode)
            {
                dta = await response.Content.ReadAsAsync<DataTable>();
            }
            return dta;
        }

        public async Task<DataTable> GetPHIMTheoTen(string Name)
        {
            DataTable dta = new DataTable();
            HttpClient client = new HttpClient();
            var response = client.GetAsync("https://localhost:5001/PHIM/SearchPHIM/" + Name).Result;
            if (response.IsSuccessStatusCode)
            {
                dta = await response.Content.ReadAsAsync<DataTable>();
            }
            return dta;
        }
    }
}
