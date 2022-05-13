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
    public partial class setting_method_pay : System.Web.UI.Page
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
            SqlDataAdapter sda = new SqlDataAdapter(@"select payment_id,payment_name,payment_note from method_pay", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grd.DataSource = dt;
            grd.DataBind();
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"insert into method_pay (payment_id,payment_name,payment_note)values(@payment_id,@payment_name,@payment_note)", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@payment_id", txtpayment_id.Text);
            cmd.Parameters.AddWithValue("@payment_name", txtpayment_name.Text);
            cmd.Parameters.AddWithValue("@payment_note", txtpayment_note.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            clearData();
            loadData();
        }
        void clearData()
        {
            txtpayment_id.Text = string.Empty;
            txtpayment_name.Text = string.Empty;
            txtpayment_note.Text = string.Empty;
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
            SqlCommand cmd = new SqlCommand(@"delete from method_pay where payment_id ='" + id + "'", sc);
            sc.Open();
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Deleted", "alert('تم حذف البيانات بنجاح !');", true);
            loadData();
        }

        protected void grd_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grd.DataKeys[e.RowIndex].Value.ToString();
            TextBox txteditpayment_name = grd.Rows[e.RowIndex].FindControl("txteditpayment_name") as TextBox;
            TextBox txteditpayment_note = grd.Rows[e.RowIndex].FindControl("txteditpayment_note") as TextBox;
            sc.Open();
            SqlCommand cmd = new SqlCommand(@"update method_pay set payment_name='" + txteditpayment_name.Text + "',payment_note='" + txteditpayment_note.Text + "' where payment_id='" + id + "'", sc);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Updated", "alert('تم حفظ البيانات بنجاح !');", true);
            grd.EditIndex = -1;
            loadData();
        }

    }
}