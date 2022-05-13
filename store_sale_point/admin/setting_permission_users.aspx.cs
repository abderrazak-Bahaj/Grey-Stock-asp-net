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
    public partial class setting_permission_users : System.Web.UI.Page
    {
        string SearchString = "";
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");
            if (!IsPostBack)
            {
                loadDataUsers();
                loaddrpBranch_id();

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
            }

        }
        void loadDataUsers()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT dbo.all_users.user_id, dbo.all_users.user_fullname, 
                            dbo.all_users.user_phone, dbo.all_users.user_email, dbo.all_users.user_code, 
                            dbo.all_users.user_datecreation, dbo.all_users.user_address, 
                            dbo.all_users.user_active_or_no, dbo.all_users.user_name, dbo.all_users.user_password,
                            dbo.all_users.user_kind_id, dbo.all_users.group_id, dbo.all_users.branch_id, 
                            dbo.permission_group.group_name, dbo.branch.branch_name FROM dbo.all_users FULL OUTER JOIN
                            dbo.permission_group ON dbo.all_users.group_id = dbo.permission_group.group_id FULL OUTER JOIN
                            dbo.branch ON dbo.all_users.branch_id = dbo.branch.branch_id 
                            WHERE (dbo.all_users.user_kind_id = 2) and 
                            user_fullname+user_phone+user_code+user_email+user_name+user_active_or_no LIKE '%" + txtSearch.Text + "%'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdUsers.DataSource = dt;
            grdUsers.DataBind();

            grdUsers.EmptyDataText = "لاتوجد بيانات";

        }

        void loaddrpBranch_id()
        {
            string sql = @"select branch_name,branch_id from branch";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(Drpbranch_id, sql, name, id);
            showDrpList(drpEditbranch_id, sql, name, id);

        }

        // ده اوبجكت اوريانتد عشان مفضلش اعمل ليست بوكس كل شوى
        void showDrpList(DropDownList dropName, string sql, string name, string id)
        {
            SqlDataAdapter sda = new SqlDataAdapter(sql, sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dropName.Items.Clear();
            ListItem drpListChoose = new ListItem("اختر", "-1");
            dropName.Items.Insert(0, drpListChoose);
            foreach (DataRow dr in dt.Rows)
            {
                dropName.Items.Add(dr[name].ToString());
                dropName.Items[dropName.Items.Count - 1].Value = dr[id].ToString();
            }
            dropName.DataBind();
        }

        protected void grdUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdUsers.PageIndex = e.NewPageIndex;
            loadDataUsers();
        }

        protected void grdUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grdUsers.DataKeys[e.RowIndex].Value.ToString();
            deleteUsers(id);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حذف البيانات بنجاح !');", true);
            loadDataUsers();
        }

        void deleteUsers(string id)
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

        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;
            loadDataUsers();
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
            GridViewRow row = grdUsers.Rows[rowIndex];

            hiddenId.Value = (row.FindControl("lbluser_id") as Label).Text;
            txtEdituser_fullname.Text = (row.FindControl("lbluser_fullname") as Label).Text;
            txtEdituser_code.Text = (row.FindControl("lbluser_code") as Label).Text;
            txtEdituser_name.Text = (row.FindControl("lbluser_name") as Label).Text;
            txtEdituser_password.Text = (row.FindControl("lbluser_password") as Label).Text;
            drpEditbranch_id.SelectedValue = (row.FindControl("lblbranch_idd") as Label).Text;
            //drpEditbranch_id.SelectedValue = (row.FindControl("lblbranch_id") as Label).Text;
            txtEdituser_phone.Text = (row.FindControl("lbluser_phone") as Label).Text;
            txtEdituser_email.Text = (row.FindControl("lbluser_email") as Label).Text;
            txtEdituser_address.Text = (row.FindControl("lbluser_address") as Label).Text;


            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$(function () {");
            sb.Append(" $('#ShowEdit').modal('show');});");
            sb.Append("</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ModelScript", sb.ToString(), false);
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            DateTime times = DateTime.Now;              // Use current time
            string formats = "yyyy-MM-dd HH:mm:ss";  // modify the format depending upon input required in the column in database


            SqlCommand cmd = new SqlCommand(@"insert into all_users (user_fullname,user_phone,user_email,user_code,
            user_datecreation,user_address,user_active_or_no,user_name,user_password,branch_id,user_kind_id) 
                                 values (@user_fullname,@user_phone,@user_email,@user_code,@user_datecreation,
             @user_address,@user_active_or_no,@user_name,@user_password,@branch_id,@user_kind_id)", sc);

            cmd.Parameters.AddWithValue("@user_fullname", txtadduser_fullname.Text);
            cmd.Parameters.AddWithValue("@user_phone", txtuser_phone.Text);
            cmd.Parameters.AddWithValue("@user_email", txtadduser_email.Text);
            cmd.Parameters.AddWithValue("@user_code", txtuser_code.Text);
            cmd.Parameters.AddWithValue("@user_datecreation", times.ToString(formats));
            cmd.Parameters.AddWithValue("@user_address", txtadduser_address.Text);
            cmd.Parameters.AddWithValue("@user_active_or_no", "غير نشط");
            cmd.Parameters.AddWithValue("@user_name", txtuser_name.Text);
            cmd.Parameters.AddWithValue("@user_password", txtuser_password.Text);
            cmd.Parameters.AddWithValue("@branch_id", Drpbranch_id.SelectedValue);
            cmd.Parameters.AddWithValue("@user_kind_id", 2);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم ادخال البيانات بنجاح !');", true);
            loadDataUsers();
            clearData();
            Response.Redirect("setting_permission_users.aspx");
        }

        void clearData()
        {
            txtadduser_fullname.Text = string.Empty;
            txtuser_code.Text = string.Empty;
            txtuser_name.Text = string.Empty;
            txtuser_password.Text = string.Empty;
            Drpbranch_id.SelectedIndex = -1;
            txtadduser_address.Text = string.Empty;
            txtadduser_email.Text = string.Empty;
            txtuser_phone.Text = string.Empty;

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"Update all_users set user_fullname=@user_fullname,
                                 user_phone=@user_phone,user_email=@user_email,user_code=@user_code,
user_address=@user_address,user_name=@user_name,user_password=@user_password,branch_id=@branch_id
                                 where user_id=@user_id", sc);
            cmd.Parameters.AddWithValue("@user_id", hiddenId.Value);
            cmd.Parameters.AddWithValue("@user_fullname", txtEdituser_fullname.Text);
            cmd.Parameters.AddWithValue("@user_phone", txtEdituser_phone.Text);
            cmd.Parameters.AddWithValue("@user_email", txtEdituser_email.Text);
            cmd.Parameters.AddWithValue("@user_code", txtEdituser_code.Text);
            cmd.Parameters.AddWithValue("@user_address", txtEdituser_address.Text);
            cmd.Parameters.AddWithValue("@user_name", txtEdituser_name.Text);
            cmd.Parameters.AddWithValue("@user_password", txtEdituser_password.Text);
            cmd.Parameters.AddWithValue("@branch_id", drpEditbranch_id.SelectedValue);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            loadDataUsers();
            Response.Redirect("setting_permission_users.aspx");
        }

    }
}