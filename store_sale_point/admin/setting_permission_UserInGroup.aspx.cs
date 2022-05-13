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
    public partial class setting_permission_UserInGroup : System.Web.UI.Page
    {
        string SearchString = "";
        public string statues;
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");
            if (!IsPostBack)
            {
                loaduser_id();
                loadpermission_group();
                loadDataUsers();
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
            }

        }
        void loadDataUsers()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT dbo.permission_group.group_name, dbo.all_users.group_id, 
            dbo.all_users.user_code, dbo.all_users.user_id, dbo.all_users.user_name,dbo.all_users.user_fullname
            FROM dbo.all_users FULL OUTER JOIN
            dbo.permission_group ON dbo.all_users.group_id = dbo.permission_group.group_id
            WHERE (dbo.all_users.user_kind_id = 2) and 
            user_phone+user_fullname+user_code+user_name+user_active_or_no LIKE '%" + txtSearch.Text + "%'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdUsers.DataSource = dt;
            grdUsers.DataBind();

            grdUsers.EmptyDataText = "لاتوجد بيانات";

        }
        protected void grdUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdUsers.PageIndex = e.NewPageIndex;
            loadDataUsers();
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"update all_users set group_id='" + drpgroup_id.SelectedValue + "' where user_id='" + drpuser_id.SelectedValue + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ المتغيرات بنجاح !');", true);
            loadDataUsers();
        }

        void loaduser_id()
        {
            string sql = @"select  user_id,user_fullname from all_users where user_kind_id=2";
            string name = "user_fullname";
            string id = "user_id";
            showDrpList(drpuser_id, sql, name, id);
        }
        void loadpermission_group()
        {
            string sql = @"select  group_id,group_name from permission_group";
            string name = "group_name";
            string id = "group_id";
            showDrpList(drpgroup_id, sql, name, id);
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

    }
}