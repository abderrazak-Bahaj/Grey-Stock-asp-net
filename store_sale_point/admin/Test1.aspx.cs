using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Windows.Documents;
using System.Windows.Controls;
using TextBox = System.Web.UI.WebControls.TextBox;
using System.Text.RegularExpressions;

namespace store_sale_point.admin
{
    public partial class Test1 : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        public string sql;
        public TextBox txt;
        string SearchString = "";
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                TextBox txt = (GridView1.HeaderRow.FindControl("txtSearch") as TextBox);
                txt.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txt.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");


                load_data();
            }
        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
        }

        void load_data()
        {
            //string condition = "";

            foreach (GridViewRow row in GridView1.Rows)
            {
                 txt = (row.FindControl("txtSearch") as TextBox);
                //    if (txt.Text != "")
                //    {
                //        condition += " and TestCustomer.ContactName ='" + txt.Text + "'";
                //    }
                
            }
            sql = @"select * from TestCustomer where TestCustomer.ContactName LIKE '%" + txt.Text + "%'";
            //sql = @"select * from TestCustomer where 1=1 " + condition + "";

            SqlDataAdapter sda = new SqlDataAdapter(sql, sc);

            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        public string ReplaceKeyWords(Match m)
        {
            return " < span class=highlight>" + m.Value + "</span>";
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

            foreach (GridViewRow row in GridView1.Rows)
            {
                txt = (row.FindControl("txtSearch") as TextBox);
            }
            SearchString = txt.Text;
            load_data();
        }

    }
}