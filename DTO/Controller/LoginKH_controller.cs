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
    public class DangNhapKH_controller
    {
        public async Task<string> Login(DangNhapKhachHangDTO kh)
        {
            string str = "";
            HttpClient client = new HttpClient();
            var response = client.PostAsJsonAsync("https://localhost:5001/Login",kh).Result;
            if (response.IsSuccessStatusCode)
            {
                str = await response.Content.ReadAsStringAsync();
            }
            return str;
        }
    }
}