using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Text;
using System.Web.Services;

namespace UploadSample
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               
                var guid = Guid.NewGuid().ToString().ToUpper();
                int index = e.Row.RowIndex;

                HtmlGenericControl part_rowclassdiv = new HtmlGenericControl("div"); //class row for bootstrap prevent upload got margin left alignment issue
                part_rowclassdiv.Attributes["class"] = "row";

                HtmlGenericControl part_div = new HtmlGenericControl("div");
                part_div.ID = "|" + index + '#' + guid; //added
                part_div.Attributes["class"] = "partfile col-xs-12";


                HtmlGenericControl part_filediv = new HtmlGenericControl("div"); //after upload file list div
                part_filediv.ID = "part_filediv";
                part_filediv.Attributes["style"] = "margin-top: 10px";

                HtmlGenericControl part_ul = new HtmlGenericControl("ul"); // uploaded file list div
                part_ul.ID = "part_file_ls";
                part_ul.Attributes["class"] = "ulclass";


                e.Row.Cells[GetColumnIndexByName(GridView1, "partzone")].Controls.Add(part_rowclassdiv); // added div class = row
                part_rowclassdiv.Controls.Add(part_div); // added upload panel within div class = row

                e.Row.Cells[GetColumnIndexByName(GridView1, "partzone")].Controls.Add(part_filediv);
                part_filediv.Controls.Add(part_ul); // added list

            }
            }

        private int GetColumnIndexByName(GridView grid, string name)
        {
            for (int i = 0; i < grid.Columns.Count; i++)
            {
                if (grid.Columns[i].HeaderText.ToLower().Trim() == name.ToLower().Trim())
                {
                    return i;
                }
            }

            return -1;
        }

        [WebMethod]
        public static void PassFile(List<uploadlist> uploadfile)
        {
            var t = uploadfile;


            for (var i = 0; i < t.Count(); i++)
            {

                //Part File Insert 

                if (t[i].type == "part")
                {
                    
                }
            }


        }


        public class uploadlist
        {
            public string quotation_uid { get; set; }
            public string quotation_no { get; set; }
            public string part_uid { get; set; }
            public int lsindex { get; set; }
            public string filename { get; set; }
            public string filepath { get; set; }
            public string filesize { get; set; }
            public string type { get; set; }


        }

    }
}