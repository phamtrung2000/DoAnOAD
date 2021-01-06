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
    public class BUS_BOOK
    {
        DAL_Sach dalBook = new DAL_Sach();
        public DataTable loadBook()
        {
            return dalBook.GetBook();
        }
        public DataTable searchBook(string str)
        {
            return dalBook.SearchBook(str);
        }
        public bool themBook(DTO_Sach Book)
        {
            return dalBook.AddBook(Book);
        }

        public bool suaBook(DTO_Sach Book)
        {
            return dalBook.UpdateBook(Book);
        }
        public DataTable GetBookWithID(string id)
        {
            return dalBook.GetBookWithID(id);
        }
        public DataTable GetBook()
        {
            return dalBook.GetBookVer2();
        }
        public DataTable searchBookVer2(string str)
        {
            return dalBook.SearchBookVer2(str);
        }
    }
}
