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
    public partial class setting_permission_Activation_users : System.Web.UI.Page
    {
        string SearchString = "";
        public string statues;
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");
            if (!IsPostBack)
            {
                loadDataUsers();
                GetActiveOrNo();
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
                            user_phone+user_code+user_name+user_active_or_no LIKE '%" + txtSearch.Text + "%'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdUsers.DataSource = dt;
            grdUsers.DataBind();

            grdUsers.EmptyDataText = "لاتوجد بيانات";

        }

        void GetActiveOrNo()
        {
            foreach (GridViewRow row in grdUsers.Rows)
            {
                string lbl = (row.FindControl("lbluser_active_or_no") as Label).Text;
                CheckBox ch = (row.FindControl("ChkActive") as CheckBox);
                if (lbl == "نشط")
                {
                    ch.Checked = true;
                }
                else
                {
                    ch.Checked = false;
                }
            }
        }
        protected void grdUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdUsers.PageIndex = e.NewPageIndex;
            loadDataUsers();
        }

        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";
            GetActiveOrNo();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;
            loadDataUsers();
            GetActiveOrNo();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in grdUsers.Rows)
            {
                string id = (row.FindControl("lbluser_id") as Label).Text;
                CheckBox ch = (row.FindControl("ChkActive") as CheckBox);
                if (ch.Checked == true)
                {
                    statues = "نشط";
                }
                if (ch.Checked == false)
                {
                    statues = "غير نشط";
                }
                SqlDataAdapter sda = new SqlDataAdapter(@"update all_users set user_active_or_no ='" + statues + "' where user_id = '" + id + "'", sc);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم التنشيط بنجاح !');", true);
                loadDataUsers();
                GetActiveOrNo();
            }
        }

    }
}