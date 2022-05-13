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
using System.Text.RegularExpressions;

namespace store_sale_point.admin
{
    public partial class Test3 : System.Web.UI.Page
    {
        string SearchString = "";
        TextBox txtsearch = new TextBox();
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        string Country;
        string ContactName;
        string City;


        //protected void Page_Init()
        //{
        //    AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
        //    trigger.EventName = "TextChanged";
        //    trigger.ControlID = gvCustomers.UniqueID.ToString();
        //    UpdatePanel1.Triggers.Add(trigger);
        //}


        //protected void Page_Init()
        //{
        //    AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
        //    trigger.EventName = "TextChanged";
        //    trigger.ControlID = gvCustomers.UniqueID.ToString();
        //    UpdatePanel1.Triggers.Add(trigger);
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            txtsearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtsearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

            this.GetData();

            txtsearch.AutoPostBack = false;
            ScriptManager1.RegisterAsyncPostBackControl(txtsearch);
            //adddropdownlist();
            txtsearch.TextChanged += new EventHandler(txtSearch_TextChanged);
            //Dropdownlist1.AutoPostBack = true;
            //ScriptManager1.RegisterAsyncPostBackControl(Dropdownlist1);
            //Dropdownlist1.SelectedIndexChanged += new EventHandler(DropDownList1_SelectedIndexChanged);
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
                
                txtsearch.Attributes["Placeholder"] = gvCustomers.HeaderRow.Cells[i].Text;
                txtsearch.ID = "txt-" + gvCustomers.HeaderRow.Cells[i].Text;
                txtsearch.CssClass = "textbox";
                txtsearch.TextChanged += new EventHandler(txtsearch_TextChanged);
                txtsearch.AutoCompleteType = AutoCompleteType.Disabled;
                txtsearch.AutoPostBack = false;
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

           
            
            switch (HeaderName)
            {
                case "ContactName":
                    ContactName = (row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim();
                    break;
                case "City":
                    City = (row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim();
                    break;
                default:
                    break;
            }
            //switch (HeaderName.ToUpper())
            //{
            //    case "ContactName":
            //        //ContactName = Convert.ToInt32((row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim());
            //        ContactName = (row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim();
            //        break;

            //    //case "City":
            //    //    City = (row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim();
            //    //    break;

            //    //case "Country":
            //    //    Country = (row.FindControl("txt-" + HeaderName + "") as TextBox).Text.Trim();
            //    //    break;

            //    default:
            //        break;
            //}

            string condition = "";

            if (ContactName !="")
            {
                if (!string.IsNullOrEmpty(condition))
                {
                    condition += " and TestCustomer.ContactName LIKE '%" + ContactName + "%'";
                }
                else {
                    condition += "TestCustomer.ContactName LIKE '%" + ContactName + "%'";
                }
            }

            if (City != "")
            {
                if (!string.IsNullOrEmpty(condition))
                {
                    condition += " and TestCustomer.City LIKE '%" + City + "%'";
                }
                else {
                    condition += "TestCustomer.City LIKE '%" + City + "%'";
                }
            }

            //if (!string.IsNullOrEmpty(City))
            //{
            //    if (!string.IsNullOrEmpty(whereCondition))
            //    {
            //        whereCondition += "And City LIKE '%" + City + "%'";
            //    }
            //    else
            //    {
            //        whereCondition += "City LIKE '%" + City + "%'";
            //    }
            //}

            //if (!string.IsNullOrEmpty(Country))
            //{
            //    if (!string.IsNullOrEmpty(whereCondition))
            //    {
            //        whereCondition += "And Country LIKE '%" + Country + "%'";
            //    }
            //    else
            //    {
            //        whereCondition += "Country LIKE '%" + Country + "%'";
            //    }
            //}

            condition = !string.IsNullOrEmpty(condition) ? " WHERE " + condition : condition;

            //query += whereCondition;
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT [ContactName],[City],[Country] FROM [TestCustomer] " + condition + " ", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            gvCustomers.DataSource = dt;
            gvCustomers.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            this.GetData();
        }

        protected void gvCustomers_PageIndexChanged(object sender, EventArgs e)
        {
           
        }

        protected void gvCustomers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCustomers.PageIndex = e.NewPageIndex;
            GetData();
        }


        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtsearch.Text;
            GetData();
        }
    }

}
