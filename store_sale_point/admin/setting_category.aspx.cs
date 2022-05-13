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
    public partial class setting_category : System.Web.UI.Page
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
            SqlDataAdapter sda = new SqlDataAdapter(@"select category_id,category_name,category_notes from category", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grd.DataSource = dt;
            grd.DataBind();
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"insert into category (category_name,category_notes)values(@category_name,@category_notes)", sc);
            sc.Open();

            cmd.Parameters.AddWithValue("@category_name", txtcategory_name.Text);
            cmd.Parameters.AddWithValue("@category_notes", txtcategory_notes.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            clearData();
            loadData();
        }
        void clearData()
        {
            
            txtcategory_name.Text = string.Empty;
            txtcategory_notes.Text = string.Empty;
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
            SqlCommand cmd = new SqlCommand(@"delete from category where category_id ='" + id + "'", sc);
            sc.Open();
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Deleted", "alert('تم حذف البيانات بنجاح !');", true);
            loadData();
        }

        protected void grd_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grd.DataKeys[e.RowIndex].Value.ToString();
            TextBox txteditcategory_name = grd.Rows[e.RowIndex].FindControl("txteditcategory_name") as TextBox;
            TextBox txteditcategory_notes = grd.Rows[e.RowIndex].FindControl("txteditcategory_notes") as TextBox;
            sc.Open();
            SqlCommand cmd = new SqlCommand(@"update category set category_name='" + txteditcategory_name.Text + "',category_notes='" + txteditcategory_notes.Text + "' where category_id='" + id + "'", sc);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Updated", "alert('تم حفظ البيانات بنجاح !');", true);
            grd.EditIndex = -1;
            loadData();
        }

    }
}