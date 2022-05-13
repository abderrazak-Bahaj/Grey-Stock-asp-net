using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;

namespace store_sale_point.admin
{
    public partial class c_s_customer : System.Web.UI.Page
    {

        string SearchString = "";
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

            if (!IsPostBack)
            {
                loadDataCustomer();

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
            }
        }
        void loadDataCustomer()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select user_id,user_fullname,user_phone,user_email,user_address from all_users where user_kind_id=3 and user_fullname+user_phone+user_address+user_email LIKE '%" + txtSearch.Text + "%'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdCustomer.DataSource = dt;
            grdCustomer.DataBind();
        }

        protected void grdSupplier_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdCustomer.PageIndex = e.NewPageIndex;
            loadDataCustomer();
        }

        protected void grdSupplier_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grdCustomer.DataKeys[e.RowIndex].Value.ToString();
            deleteSupplier(id);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حذف البيانات بنجاح !');", true);
            loadDataCustomer();
        }

        void deleteSupplier(string id)
        {
            SqlCommand cmd = new SqlCommand(@"delete from all_users where user_id = @user_id", sc);
            if (sc.State == ConnectionState.Closed)
            {
                sc.Open();
            }
            cmd.Parameters.AddWithValue("@user_id", id);
            cmd.ExecuteNonQuery();
            if (sc.State == ConnectionState.Open)
            {
                sc.Close();
            }
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
            GridViewRow row = grdCustomer.Rows[rowIndex];

            hiddenId.Value = (row.FindControl("lbluser_id") as Label).Text;
            txtEdituser_fullname.Text = (row.FindControl("lbluser_fullname") as Label).Text;
            txtEdituser_phone.Text = (row.FindControl("lbluser_phone") as Label).Text;
            txtEdituser_email.Text = (row.FindControl("lbluser_email") as Label).Text;
            txtedituser_address.Text = (row.FindControl("lbluser_address") as Label).Text;


            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$(function () {");
            sb.Append(" $('#ShowEdit').modal('show');});");
            sb.Append("</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ModelScript", sb.ToString(), false);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"Update all_users set user_fullname=@user_fullname,
                                 user_phone=@user_phone,user_email=@user_email,user_address=@user_address
                                 where user_id=@user_id", sc);
            cmd.Parameters.AddWithValue("@user_id", hiddenId.Value);
            cmd.Parameters.AddWithValue("@user_fullname", txtEdituser_fullname.Text);
            cmd.Parameters.AddWithValue("@user_phone", txtEdituser_phone.Text);
            cmd.Parameters.AddWithValue("@user_email", txtEdituser_email.Text);
            cmd.Parameters.AddWithValue("@user_address", txtedituser_address.Text);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            loadDataCustomer();
            Response.Redirect("c_s_customer.aspx");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            DateTime times = DateTime.Now;              // Use current time
            string formats = "yyyy-MM-dd HH:mm:ss";  // modify the format depending upon input required in the column in database


            SqlDataAdapter sda = new SqlDataAdapter(@"insert into all_users (user_fullname,user_phone,user_email,user_address,user_datecreation,user_kind_id) 
                                 values ('" + txtadduser_fullname.Text + "','" + txtadduser_phone.Text + "','" + txtadduser_email.Text + "','" + txtadduser_address.Text + "','" + times.ToString(formats) + "',3)", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم ادخال البيانات بنجاح !');", true);
            loadDataCustomer();
            clearData();
            Response.Redirect("c_s_customer.aspx");
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$(function () {");
            sb.Append(" $('#ShowAdd').modal('show');});");
            sb.Append("</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ModelScript", sb.ToString(), false);
        }
        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;
            loadDataCustomer();
        }
        void clearData()
        {
            txtadduser_address.Text = string.Empty;
            txtadduser_email.Text = string.Empty;
            txtadduser_fullname.Text = string.Empty;
            txtadduser_phone.Text = string.Empty;

            txtedituser_address.Text = "";
            txtEdituser_email.Text = "";
            txtEdituser_fullname.Text = "";
            txtEdituser_phone.Text = "";
        }
    }
}