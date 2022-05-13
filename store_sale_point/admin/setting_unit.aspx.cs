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
    public partial class setting_unit : System.Web.UI.Page
    {

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadunitData();
            }
        }

        void loadunitData()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select unit_id,unit_name,unit_notes from unit", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdsetting_unit.DataSource = dt;
            grdsetting_unit.DataBind();
        }

        void clearData()
        {
            txtunit_name.Text = string.Empty;
            txtunit_notes.Text = string.Empty;
            txtunit_name.Focus();
        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"insert into unit (unit_name,unit_notes) " +
                " values(@unit_name,@unit_notes)", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@unit_name", txtunit_name.Text);
            cmd.Parameters.AddWithValue("@unit_notes", txtunit_notes.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            loadunitData();
            clearData();
        }

        protected void grdsetting_branch_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdsetting_unit.EditIndex = e.NewEditIndex;
            loadunitData();
        }

        protected void grdsetting_branch_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdsetting_unit.EditIndex = -1;
            loadunitData();
        }

        protected void grdsetting_branch_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grdsetting_unit.DataKeys[e.RowIndex].Value.ToString();
            SqlDataAdapter sda = new SqlDataAdapter(@"delete from unit where unit_id = '" + id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حذف البيانات بنجاح !');", true);
            loadunitData();
        }

        protected void grdsetting_branch_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grdsetting_unit.DataKeys[e.RowIndex].Value.ToString();

            TextBox txteditunit_name = grdsetting_unit.Rows[e.RowIndex].FindControl("txteditunit_name") as TextBox;
            TextBox txteditunit_notes = grdsetting_unit.Rows[e.RowIndex].FindControl("txteditunit_notes") as TextBox;

            SqlCommand cmd = new SqlCommand(@"update unit set unit_name=@unit_name,unit_notes=@unit_notes where unit_id='" + id + "'", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@unit_name", txteditunit_name.Text);
            cmd.Parameters.AddWithValue("@unit_notes", txteditunit_notes.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            grdsetting_unit.EditIndex = -1;
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Updated", "alert('تم تعديل البيانات بنجاح !');", true);
            loadunitData();
        }

        protected void grdsetting_branch_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.Footer)
            //{
            //    e.Row.Cells[0].Text = (grdsetting_branch.PageIndex + 1) + " of " + grdsetting_branch.PageCount;
            //}


        }

        protected void grdsetting_branch_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdsetting_unit.PageIndex = e.NewPageIndex;
            loadunitData();
        }

    }
}