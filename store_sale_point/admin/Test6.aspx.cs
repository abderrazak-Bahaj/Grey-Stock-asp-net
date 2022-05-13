using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class Test6 : System.Web.UI.Page
{
    string SearchString = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

        if (!this.IsPostBack)
        {
            //this.SearchCustomers();
            BindGrid();
        }
    }

    public string ReplaceKeyWords(Match m)
    {
        return "<span class=highlight>" + m.Value + "</span>";
    }

    private void SearchCustomers()
    {
        string constr = ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand())
            {

                    string sql = "SELECT id, ContactName, City, Country,PostalCode FROM TestCustomer where ContactName+City+Country  LIKE '%" + txtSearch.Text + "%'";

                    cmd.CommandText = sql;
                    cmd.Connection = con;
                
                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    gvCustomers.DataSource = dt;
                    gvCustomers.DataBind();
                    BindGrid();
                }
            }
        }
    }
    protected void Search(object sender, EventArgs e)
    {
        //BindGrid();
        SearchString = txtSearch.Text;
        this.SearchCustomers();
        

    }
    //protected void OnPaging(object sender, GridViewPageEventArgs e)
    //{
    //    gvCustomers.PageIndex = e.NewPageIndex;
    //    this.SearchCustomers();
    //}

    private void BindDropDownList()
    {
        TableCell cells = gvCustomers.HeaderRow.Cells[0];
        //PopulateDropDown((cells.FindControl("ddlContactName") as DropDownList), (cells.FindControl("lblContactName") as Label).Text);
        //PopulateDropDown((cells.FindControl("ddlCity") as DropDownList), (cells.FindControl("lblCity") as Label).Text);
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

    private void BindGrid()
    {
        DataTable dt = new DataTable();
        String strConnString = System.Configuration.ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString;
        SqlConnection con = new SqlConnection(strConnString);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand("select id,ContactName,City,Country,PostalCode from TestCustomer", con);
        //cmd.CommandType = CommandType.StoredProcedure;
        if (ViewState["ContactName"] != null && ViewState["ContactName"].ToString() != "0")
        {
            cmd = new SqlCommand("select id,ContactName,City,Country,PostalCode from TestCustomer where ContactName=@ContactNameValue ", con);
            cmd.Parameters.AddWithValue("@ContactNameValue", ViewState["ContactName"].ToString());
        }
        if (ViewState["City"] != null && ViewState["City"].ToString() != "0")
        {
            cmd = new SqlCommand("select id,ContactName,City,Country,PostalCode from TestCustomer where City=@CityValue ", con);

            cmd.Parameters.AddWithValue("@CityValue", ViewState["City"].ToString());
        }
        if (ViewState["Country"] != null && ViewState["Country"].ToString() != "0")
        {
            cmd = new SqlCommand("select id,ContactName,City,Country,PostalCode from TestCustomer where Country=@CountryValue ", con);

            cmd.Parameters.AddWithValue("@CountryValue", ViewState["Country"].ToString());
        }
        if (ViewState["PostalCode"] != null && ViewState["PostalCode"].ToString() != "0")
        {
            cmd = new SqlCommand("select id,ContactName,City,Country,PostalCode from TestCustomer where PostalCode=@PostalCodeValue ", con);

            cmd.Parameters.AddWithValue("@PostalCodeValue", ViewState["PostalCode"].ToString());
        }
        cmd.Connection = con;
        sda.SelectCommand = cmd;
        sda.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            dt.Rows.Add("", "", "", "");
        }
        gvCustomers.DataSource = dt;
        gvCustomers.DataBind();
        ViewState["grd"] = dt;

        if (string.IsNullOrEmpty((gvCustomers.Rows[0].FindControl("hfContactName") as HiddenField).Value))
        {
            gvCustomers.Rows[0].Visible = false;
            emptyTable.Visible = true;
        }
        else
        {
            emptyTable.Visible = false;
        }

        this.BindDropDownList();

        TableCell cell = gvCustomers.HeaderRow.Cells[0];
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

    protected void OnPaging(object sender, GridViewPageEventArgs e)
    {
        gvCustomers.PageIndex = e.NewPageIndex;
        this.BindGrid();
    }


    public SortDirection direction
    {
        get
        {
            if (ViewState["directionState"] == null)
            {
                ViewState["directionState"] = SortDirection.Ascending;
            }
            return (SortDirection)ViewState["directionState"];
        }
        set
        {
            ViewState["directionState"] = value;
        }
    }

    protected void gvCustomers_Sorting(object sender, GridViewSortEventArgs e)
    {
        string sortingDirection = string.Empty;
        if (direction == SortDirection.Ascending)
        {
            direction = SortDirection.Descending;
            sortingDirection = "Desc";

        }
        else
        {
            direction = SortDirection.Ascending;
            sortingDirection = "Asc";

        }
        DataTable dt = (DataTable)ViewState["grd"];
        DataView sortedView = new DataView(dt);
        sortedView.Sort = e.SortExpression + " " + sortingDirection;
        Session["SortedView"] = sortedView;
        gvCustomers.DataSource = sortedView;
        gvCustomers.DataBind();
    }
}