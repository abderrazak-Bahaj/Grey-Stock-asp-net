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
    public partial class setting_box_kind : System.Web.UI.Page
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
            SqlDataAdapter sda = new SqlDataAdapter(@"select box_kind_id,box_kind_name,box_kind_notes from box_kind", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grd.DataSource = dt;
            grd.DataBind();
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"insert into box_kind (box_kind_id,box_kind_name,box_kind_notes) values (@box_kind_id,@box_kind_name,@box_kind_notes)", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@box_kind_id", txtbox_kind_id.Text);
            cmd.Parameters.AddWithValue("@box_kind_name", txtbox_kind_name.Text);
            cmd.Parameters.AddWithValue("@box_kind_notes", txtbox_kind_notes.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            clearData();
            loadData();
        }
        void clearData()
        {
            txtbox_kind_id.Text = string.Empty;
            txtbox_kind_name.Text = string.Empty;
            txtbox_kind_notes.Text = string.Empty;
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
            SqlCommand cmd = new SqlCommand(@"delete from box_kind where box_kind_id ='" + id + "'", sc);
            sc.Open();
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Deleted", "alert('تم حذف البيانات بنجاح !');", true);
            loadData();
        }

        protected void grd_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grd.DataKeys[e.RowIndex].Value.ToString();
            TextBox txteditbox_kind_name = grd.Rows[e.RowIndex].FindControl("txteditbox_kind_name") as TextBox;
            TextBox txteditbox_kind_notes = grd.Rows[e.RowIndex].FindControl("txteditbox_kind_notes") as TextBox;
            sc.Open();
            SqlCommand cmd = new SqlCommand(@"update box_kind set box_kind_name='" + txteditbox_kind_name.Text + "',box_kind_notes='" + txteditbox_kind_notes.Text + "' where box_kind_id='" + id + "'", sc);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Updated", "alert('تم حفظ البيانات بنجاح !');", true);
            grd.EditIndex = -1;
            loadData();
        }

    }
}