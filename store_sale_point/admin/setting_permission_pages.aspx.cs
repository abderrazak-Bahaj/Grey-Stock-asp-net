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
    public partial class setting_permission_pages : System.Web.UI.Page
    {

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDatapermission_page();
            }
        }

        void loadDatapermission_page()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select page_id,page_name,page_url from permission_page", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdpermission_page.DataSource = dt;
            grdpermission_page.DataBind();
        }

        void clearData()
        {
            txtpage_name.Text = string.Empty;
            txtpage_url.Text = string.Empty;
            txtpage_name.Focus();
        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"insert into permission_page (page_name,page_url)values(@page_name,@page_url)", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@page_name", txtpage_name.Text);
            cmd.Parameters.AddWithValue("@page_url", txtpage_url.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            loadDatapermission_page();
            clearData();
        }

        protected void grdpermission_page_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdpermission_page.EditIndex = e.NewEditIndex;
            loadDatapermission_page();
        }

        protected void grdpermission_page_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdpermission_page.EditIndex = -1;
            loadDatapermission_page();
        }

        protected void grdpermission_page_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grdpermission_page.DataKeys[e.RowIndex].Value.ToString();
            SqlDataAdapter sda = new SqlDataAdapter(@"delete from permission_page where page_id = '" + id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حذف البيانات بنجاح !');", true);
            loadDatapermission_page();
        }

        protected void grdpermission_page_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grdpermission_page.DataKeys[e.RowIndex].Value.ToString();

            TextBox txtEditpage_name = grdpermission_page.Rows[e.RowIndex].FindControl("txtEditpage_name") as TextBox;
            TextBox txtEditpage_url = grdpermission_page.Rows[e.RowIndex].FindControl("txtEditpage_url") as TextBox;


            SqlCommand cmd = new SqlCommand(@"update permission_page set page_name=@page_name,page_url=@page_url where page_id='" + id + "'", sc);
            sc.Open();

            cmd.Parameters.AddWithValue("@page_name", txtEditpage_name.Text);
            cmd.Parameters.AddWithValue("@page_url", txtEditpage_url.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            grdpermission_page.EditIndex = -1;
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Updated", "alert('تم تعديل البيانات بنجاح !');", true);
            loadDatapermission_page();
        }

        protected void grdpermission_page_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.Footer)
            //{
            //    e.Row.Cells[0].Text = (grdsetting_branch.PageIndex + 1) + " of " + grdsetting_branch.PageCount;
            //}


        }

        protected void grdpermission_page_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdpermission_page.PageIndex = e.NewPageIndex;
            loadDatapermission_page();
        }

    }
}