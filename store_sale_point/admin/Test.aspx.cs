using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


namespace store_sale_point.admin
{
    public partial class Test : System.Web.UI.Page
    {
        //SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        private void BindDropDownList()
        {
            TableCell cells = GridView1.HeaderRow.Cells[0];
            PopulateDropDown((cells.FindControl("ddlContactName") as DropDownList), (cells.FindControl("lblContactName") as Label).Text);
            PopulateDropDown((cells.FindControl("ddlCity") as DropDownList), (cells.FindControl("lblCity") as Label).Text);
            PopulateDropDown((cells.FindControl("ddlCountry") as DropDownList), (cells.FindControl("lblCountry") as Label).Text);
            PopulateDropDown((cells.FindControl("ddlPostalCode") as DropDownList), (cells.FindControl("lblPostalCode") as Label).Text);
        }
        private void PopulateDropDown(DropDownList ddl, string columnName)
        {
            ddl.DataSource = BindDropDown(columnName);
            ddl.DataTextField = columnName;
            ddl.DataValueField = columnName;
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("Please Select", "0"));
        }

        private void BindGrid()
        {
            DataTable dt = new DataTable();
            String strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlDataAdapter sda = new SqlDataAdapter();
            SqlCommand cmd = new SqlCommand("GetCustomers");
            cmd.CommandType = CommandType.StoredProcedure;
            if (ViewState["ContactName"] != null && ViewState["ContactName"].ToString() != "0")
            {
                cmd.Parameters.AddWithValue("@ContactNameValue", ViewState["ContactName"].ToString());
            }
            if (ViewState["City"] != null && ViewState["City"].ToString() != "0")
            {
                cmd.Parameters.AddWithValue("@CityValue", ViewState["City"].ToString());
            }
            if (ViewState["Country"] != null && ViewState["Country"].ToString() != "0")
            {
                cmd.Parameters.AddWithValue("@CountryValue", ViewState["Country"].ToString());
            }
            if (ViewState["PostalCode"] != null && ViewState["PostalCode"].ToString() != "0")
            {
                cmd.Parameters.AddWithValue("@PostalCodeValue", ViewState["PostalCode"].ToString());
            }
            cmd.Connection = con;
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                dt.Rows.Add("", "", "", "");
            }
            GridView1.DataSource = dt;
            GridView1.DataBind();

            if (string.IsNullOrEmpty((GridView1.Rows[0].FindControl("hfContactName") as HiddenField).Value))
            {
                GridView1.Rows[0].Visible = false;
                emptyTable.Visible = true;
            }
            else
            {
                emptyTable.Visible = false;
            }

            this.BindDropDownList();

            TableCell cell = GridView1.HeaderRow.Cells[0];
            setDropdownselectedItem(ViewState["ContactName"] != null ? (string)ViewState["ContactName"] : string.Empty, cell.FindControl("ddlContactName") as DropDownList);
            setDropdownselectedItem(ViewState["City"] != null ? (string)ViewState["City"] : string.Empty, cell.FindControl("ddlCity") as DropDownList);
            setDropdownselectedItem(ViewState["Country"] != null ? (string)ViewState["Country"] : string.Empty, cell.FindControl("ddlCountry") as DropDownList);
            setDropdownselectedItem(ViewState["PostalCode"] != null ? (string)ViewState["PostalCode"] : string.Empty, cell.FindControl("ddlPostalCode") as DropDownList);
        }

        private void setDropdownselectedItem(string selectedvalue, DropDownList ddl)
        {
            if (!string.IsNullOrEmpty(selectedvalue))
            {
                ddl.Items.FindByValue(selectedvalue).Selected = true;
            }
        }

        protected void DropDownChange(object sender, EventArgs e)
        {
            DropDownList dropdown = (DropDownList)sender;
            string selectedValue = dropdown.SelectedItem.Value;
            switch (dropdown.ID.ToLower())
            {
                case "ddlcontactname":
                    ViewState["ContactName"] = selectedValue;
                    break;
                case "ddlcity":
                    ViewState["City"] = selectedValue;
                    break;
                case "ddlcountry":
                    ViewState["Country"] = selectedValue;
                    break;
                case "ddlpostalcode":
                    ViewState["PostalCode"] = selectedValue;
                    break;
            }
            this.BindGrid();
        }


        private DataTable BindDropDown(string columnName)
        {
            String strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand("SELECT DISTINCT " + columnName + " FROM TestCustomer WHERE " + columnName + " IS NOT NULL", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return dt;
        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);
            for (int i = 0; i < GridView1.Columns.Count; i++)
            {
                TableHeaderCell cell = new TableHeaderCell();
                TextBox txtSearch = new TextBox();
                txtSearch.Attributes["placeholder"] = GridView1.Columns[i].HeaderText;
                txtSearch.CssClass = "search_textbox";
                cell.Controls.Add(txtSearch);
                row.Controls.Add(cell);
            }
            GridView1.HeaderRow.Parent.Controls.AddAt(1, row);
        }
    }
}