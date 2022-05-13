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
    public partial class setting_user_kind : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadData();
            }
        }
        void loadData()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select user_kind_id,user_kind_name,user_kind_notes from user_kind", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grd.DataSource = dt;
            grd.DataBind();
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"insert into user_kind (user_kind_id,user_kind_name,user_kind_notes) values (@user_kind_id,@user_kind_name,@user_kind_notes)", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@user_kind_id", txtuser_kind_id.Text);
            cmd.Parameters.AddWithValue("@user_kind_name", txtuser_kind_name.Text);
            cmd.Parameters.AddWithValue("@user_kind_notes", txtuser_kind_notes.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            clearData();
            loadData();
        }
        void clearData()
        {
            txtuser_kind_id.Text = string.Empty;
            txtuser_kind_name.Text = string.Empty;
            txtuser_kind_notes.Text = string.Empty;
        }

        protected void grd_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grd.PageIndex = e.NewPageIndex;
            loadData();
        }

        protected void grd_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grd.EditIndex = -1;
            loadData();
        }

        protected void grd_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grd.EditIndex = e.NewEditIndex;
            loadData();
        }

        protected void grd_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grd.DataKeys[e.RowIndex].Value.ToString();
            SqlCommand cmd = new SqlCommand(@"delete from user_kind where user_kind_id ='" + id + "'", sc);
            sc.Open();
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Deleted", "alert('تم حذف البيانات بنجاح !');", true);
            loadData();
        }

        protected void grd_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grd.DataKeys[e.RowIndex].Value.ToString();
            TextBox txtedituser_kind_name = grd.Rows[e.RowIndex].FindControl("txtedituser_kind_name") as TextBox;
            TextBox txtedituser_kind_notes = grd.Rows[e.RowIndex].FindControl("txtedituser_kind_notes") as TextBox;
            sc.Open();
            SqlCommand cmd = new SqlCommand(@"update user_kind set user_kind_name='" + txtedituser_kind_name.Text + "',user_kind_notes='" + txtedituser_kind_notes.Text + "' where user_kind_id='" + id + "'", sc);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Updated", "alert('تم حفظ البيانات بنجاح !');", true);
            grd.EditIndex = -1;
            loadData();
        }

    }
}