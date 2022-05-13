using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Windows.Resources;

namespace store_sale_point.admin
{
    public partial class Test2 : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        string Country;
        string ContactName;
        string City;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GetData();
        }

        private void GetData()
        {
            //SqlConnection con = new SqlConnection(constring);
            SqlCommand cmd = new SqlCommand("SELECT * from TestCustomer", sc);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvCustomers.DataSource = dt;
            gvCustomers.DataBind();
        }
        protected void gvCustomers_DataBound(object sender, EventArgs e)
        {
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);
            for (int i = 0; i <= gvCustomers.HeaderRow.Cells.Count - 1; i++)
            {
                TableHeaderCell cell = new TableHeaderCell();
                TextBox txtsearch = new TextBox();
                txtsearch.Attributes["Placeholder"] = gvCustomers.HeaderRow.Cells[i].Text;
                txtsearch.ID = "txt-" + gvCustomers.HeaderRow.Cells[i].Text;
                txtsearch.CssClass = "textbox";
                txtsearch.TextChanged += new EventHandler(txtsearch_TextChanged);
                txtsearch.AutoPostBack = true;
                txtsearch.EnableViewState = true;
                cell.Controls.Add(txtsearch);
                row.Controls.Add(cell);
            }

            gvCustomers.HeaderRow.Parent.Controls.AddAt(1, row);
        }

        protected void txtsearch_TextChanged(object sender, EventArgs e)
        {
            //SqlConnection con = new SqlConnection(constring);
            GridViewRow row = ((sender as TextBox).NamingContainer as GridViewRow);

            string HeaderName = ((System.Web.UI.Control)(sender)).ID.Split('-')[1];

            switch (HeaderName.ToUpper())
            {
                case "ContactName":
                    //ContactName = Convert.ToInt32((row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim());
                    ContactName = (row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim();
                    break;

                case "City":
                    City = (row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim();
                    break;

                case "Country":
                    Country = (row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim();
                    break;

                default:
                    break;
            }

            string query = "SELECT [ContactName],[City],[Country] FROM [TestCustomer]";

            string whereCondition = string.Empty;
            if (!string.IsNullOrEmpty(ContactName))
            {
                whereCondition = "ContactName ='" + ContactName + "'";
            }

            if (!string.IsNullOrEmpty(City))
            {
                if (!string.IsNullOrEmpty(whereCondition))
                {
                    whereCondition += "And City LIKE '%" + City + "%'";
                }
                else
                {
                    whereCondition += "City LIKE '%" + City + "%'";
                }
            }

            if (!string.IsNullOrEmpty(Country))
            {
                if (!string.IsNullOrEmpty(whereCondition))
                {
                    whereCondition += "And Country LIKE '%" + Country + "%'";
                }
                else
                {
                    whereCondition += "Country LIKE '%" + Country + "%'";
                }
            }

            whereCondition = !string.IsNullOrEmpty(whereCondition) ? " WHERE " + whereCondition : whereCondition;

            query += whereCondition;

            using (SqlCommand cmd = new SqlCommand(query, sc))
            {
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvCustomers.DataSource = dt;
                gvCustomers.DataBind();
            }
        }

        protected void onclick(object sender, EventArgs e)
        {
            this.GetData();
        }

        protected void txtnik_TextChanged(object sender, EventArgs e)
        {

        }
    }
}