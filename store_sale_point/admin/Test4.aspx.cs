using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace store_sale_point.admin
{
    public partial class Test4 : System.Web.UI.Page
    {
        public string sortDirection
        {
            get
            {
                return ViewState["sortDirection"] == null ? "ASC" : ViewState["sortDirection"].ToString(); // your default sort direction i.e. ASC.
            }
            set
            {
                ViewState["sortDirection"] = value;
            }
        }

        public string sortExpression
        {
            get
            {
                return ViewState["SortExpression"] == null ? "CustomerID" : ViewState["SortExpression"].ToString(); //Your by default sort expression. i.e. ColumnName
            }
            set
            {
                ViewState["SortExpression"] = value;
            }
        }

        string constr = ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                LinkButton lnkCustomerID = e.Row.FindControl("lnkCustomerID") as LinkButton;
                LinkButton lnkCompanyName = e.Row.FindControl("lnkCompanyName") as LinkButton;
                LinkButton lnkContactName = e.Row.FindControl("lnkContactName") as LinkButton;
                LinkButton lnkCity = e.Row.FindControl("lnkCity") as LinkButton;
                LinkButton lnkCountry = e.Row.FindControl("lnkCountry") as LinkButton;
                Label lblCustomerID = e.Row.FindControl("lblCustomerID") as Label;
                Label lblCompanyName = e.Row.FindControl("lblCompanyName") as Label;
                Label lblContactName = e.Row.FindControl("lblContactName") as Label;
                Label lblCity = e.Row.FindControl("lblCity") as Label;
                Label lblCountry = e.Row.FindControl("lblCountry") as Label;

                if (!string.IsNullOrEmpty(hfClassApplied.Value))
                {
                    if (sortExpression == lblCustomerID.Text)
                    {
                        lnkCustomerID.CssClass = hfClassApplied.Value;
                    }
                    if (sortExpression == lblCompanyName.Text)
                    {
                        lnkCompanyName.CssClass = hfClassApplied.Value;
                    }
                    if (sortExpression == lblContactName.Text)
                    {
                        lnkContactName.CssClass = hfClassApplied.Value;
                    }
                    if (sortExpression == lblCity.Text)
                    {
                        lnkCity.CssClass = hfClassApplied.Value;
                    }
                    if (sortExpression == lblCountry.Text)
                    {
                        lnkCountry.CssClass = hfClassApplied.Value;
                    }
                }
            }
        }

        public void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT TOP 30 [id],[ContactName],[City],[Country],[PostalCode] FROM [TestCustomer]";
                    cmd.Connection = con;
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    if (ViewState["GridView"] == null)
                    {
                        ViewState["GridView"] = dt;
                    }
                    gvCustomers.DataSource = ViewState["GridView"] as DataTable;
                    gvCustomers.DataBind();
                }
            }
        }

        protected void gvCustomers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCustomers.PageIndex = e.NewPageIndex;
            SortGridView(sortExpression);
        }

        protected void Sort(object sender, EventArgs e)
        {
            string assignedClass = (sender as LinkButton).CssClass.Split('-')[2];
            if (assignedClass.ToUpper() == "UP")
            {
                sortDirection = "ASC";
                hfClassApplied.Value = "glyphicon glyphicon-arrow-down";
            }
            else
            {
                sortDirection = "DESC";
                hfClassApplied.Value = "glyphicon glyphicon-arrow-up";
            }
            string selectedId = (sender as LinkButton).ID;
            Label lblCustomerID = (sender as LinkButton).FindControl("lblCustomerID") as Label;
            Label lblCompanyName = (sender as LinkButton).FindControl("lblCompanyName") as Label;
            Label lblContactName = (sender as LinkButton).FindControl("lblContactName") as Label;
            Label lblCity = (sender as LinkButton).FindControl("lblCity") as Label;
            Label lblCountry = (sender as LinkButton).FindControl("lblCountry") as Label;
            LinkButton lnkCustomerID = (sender as LinkButton).FindControl("lnkCustomerID") as LinkButton;
            LinkButton lnkCompanyName = (sender as LinkButton).FindControl("lnkCompanyName") as LinkButton;
            LinkButton lnkContactName = (sender as LinkButton).FindControl("lnkContactName") as LinkButton;
            LinkButton lnkCity = (sender as LinkButton).FindControl("lnkCity") as LinkButton;
            LinkButton lnkCountry = (sender as LinkButton).FindControl("lnkCountry") as LinkButton;

            if (lnkCustomerID.ID == selectedId)
            {
                sortExpression = lblCustomerID.Text;
            }
            if (lnkCompanyName.ID == selectedId)
            {
                sortExpression = lblCompanyName.Text;
            }
            if (lnkContactName.ID == selectedId)
            {
                sortExpression = lblContactName.Text;
            }
            if (lnkCity.ID == selectedId)
            {
                sortExpression = lblCity.Text;
            }
            if (lnkCountry.ID == selectedId)
            {
                sortExpression = lblCountry.Text;
            }
            SortGridView(sortExpression);
        }

        private void SortGridView(string sortExpression)
        {
            DataTable dt = new DataTable();

            if (ViewState["GridView"] != null)
            {
                dt = ViewState["GridView"] as DataTable;
            }
            DataView dv = new DataView(dt);
            if (sortDirection == "ASC")
            {
                dv.Sort = sortExpression + " " + "ASC";
            }
            else
            {
                dv.Sort = sortExpression + " " + "DESC";
            }
            gvCustomers.DataSource = dv;
            gvCustomers.DataBind();
        }

        protected void TextChanged(object sender, EventArgs e)
        {
            GridViewRow row = ((sender as TextBox).NamingContainer as GridViewRow);
            TextBox txtCustomerID = row.FindControl("txtCustomerID") as TextBox;
            TextBox txtCompanyName = row.FindControl("txtCompanyName") as TextBox;
            TextBox txtContactName = row.FindControl("txtContactName") as TextBox;
            TextBox txtCity = row.FindControl("txtCity") as TextBox;
            TextBox txtCountry = row.FindControl("txtCountry") as TextBox;
            string query = "SELECT [id],[ContactName],[City],[Country],[PostalCode] FROM [TestCustomer]";
            string whereQuery = string.Empty;
            using (SqlConnection con = new SqlConnection(constr))
            {
                if (!string.IsNullOrEmpty(txtCustomerID.Text))
                {
                    whereQuery += " id LIKE '" + txtCustomerID.Text.Trim() + "%'";
                }
                if (!string.IsNullOrEmpty(txtCompanyName.Text))
                {
                    if (!string.IsNullOrEmpty(whereQuery))
                    {
                        whereQuery += " AND ContactName LIKE '" + txtCompanyName.Text.Trim() + "%'";
                    }
                    else
                    {
                        whereQuery += " ContactName LIKE '" + txtCompanyName.Text.Trim() + "%'";
                    }
                }
                if (!string.IsNullOrEmpty(txtContactName.Text))
                {
                    if (!string.IsNullOrEmpty(whereQuery))
                    {
                        whereQuery += " AND City LIKE '" + txtContactName.Text.Trim() + "%'";
                    }
                    else
                    {
                        whereQuery += " City LIKE '" + txtContactName.Text.Trim() + "%'";
                    }
                }
                if (!string.IsNullOrEmpty(txtCity.Text))
                {
                    if (!string.IsNullOrEmpty(whereQuery))
                    {
                        whereQuery += " AND Country LIKE '" + txtCity.Text.Trim() + "%'";
                    }
                    else
                    {
                        whereQuery += " Country LIKE '" + txtCity.Text.Trim() + "%'";
                    }
                }
                if (!string.IsNullOrEmpty(txtCountry.Text))
                {
                    if (!string.IsNullOrEmpty(whereQuery))
                    {
                        whereQuery += " AND PostalCode LIKE '" + txtCountry.Text.Trim() + "%'";
                    }
                    else
                    {
                        whereQuery += " PostalCode LIKE '" + txtCountry.Text.Trim() + "%'";
                    }
                }

                whereQuery = !string.IsNullOrEmpty(whereQuery) ? " WHERE " + whereQuery : whereQuery;

                query += whereQuery;
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        if (ViewState["GridView"] != null)
                        {
                            ViewState["GridView"] = dt;
                        }
                        gvCustomers.DataSource = ViewState["GridView"] as DataTable;
                        gvCustomers.DataBind();
                    }
                    else
                    {
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "alert('No Records Found!!')", true);
                    }
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            BindGrid();
        }
    }
}