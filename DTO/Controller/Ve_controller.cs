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
    public class Ve_controller
    {
        public async Task<DataTable> LoadDSVe()
        {
            DataTable data = new DataTable();
            HttpClient client = new HttpClient();
            var response = client.GetAsync("https://localhost:5001/Ve").Result;
            if (response.IsSuccessStatusCode)
            {
                data = await response.Content.ReadAsAsync<DataTable>();
            }
            return data;
        }
    }
}