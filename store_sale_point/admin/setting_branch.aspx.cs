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
    public partial class setting_branch : System.Web.UI.Page
    {

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadBranchData();
            }
        }

        void loadBranchData()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select branch_id,branch_name,branch_tel,branch_address,branch_notes from branch", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdsetting_branch.DataSource = dt;
            grdsetting_branch.DataBind();
        }

        void clearData()
        {
            txtbranch_name.Text = string.Empty;
            txtbranch_tel.Text = string.Empty;
            txtbranch_address.Text = string.Empty;
            txtbranch_notes.Text = string.Empty;
            txtbranch_name.Focus();
        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"insert into branch (branch_name,branch_tel,branch_address,branch_notes) " +
                " values(@branch_name,@branch_tel,@branch_address,@branch_notes)", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@branch_name", txtbranch_name.Text);
            cmd.Parameters.AddWithValue("@branch_tel", txtbranch_tel.Text);
            cmd.Parameters.AddWithValue("@branch_address", txtbranch_address.Text);
            cmd.Parameters.AddWithValue("@branch_notes", txtbranch_notes.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            loadBranchData();
            clearData();
        }

        protected void grdsetting_branch_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdsetting_branch.EditIndex = e.NewEditIndex;
            loadBranchData();
        }

        protected void grdsetting_branch_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdsetting_branch.EditIndex = -1;
            loadBranchData();
        }

        protected void grdsetting_branch_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grdsetting_branch.DataKeys[e.RowIndex].Value.ToString();
            SqlDataAdapter sda = new SqlDataAdapter(@"delete from branch where branch_id = '" + id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حذف البيانات بنجاح !');", true);
            loadBranchData();
        }

        protected void grdsetting_branch_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grdsetting_branch.DataKeys[e.RowIndex].Value.ToString();

            TextBox txteditbranch_name = grdsetting_branch.Rows[e.RowIndex].FindControl("txteditbranch_name") as TextBox;
            TextBox txteditbranch_tel = grdsetting_branch.Rows[e.RowIndex].FindControl("txteditbranch_tel") as TextBox;
            TextBox txteditbranch_address = grdsetting_branch.Rows[e.RowIndex].FindControl("txteditbranch_address") as TextBox;
            TextBox txteditbranch_notes = grdsetting_branch.Rows[e.RowIndex].FindControl("txteditbranch_notes") as TextBox;

            SqlCommand cmd = new SqlCommand(@"update branch set branch_name=@branch_name,branch_tel=@branch_tel,branch_address=@branch_address,branch_notes=@branch_notes where branch_id='"+id+"'", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@branch_name",txteditbranch_name.Text);
            cmd.Parameters.AddWithValue("@branch_tel", txteditbranch_tel.Text);
            cmd.Parameters.AddWithValue("@branch_address", txteditbranch_address.Text);
            cmd.Parameters.AddWithValue("@branch_notes", txteditbranch_notes.Text);
            cmd.ExecuteNonQuery();
            sc.Close();
            grdsetting_branch.EditIndex = -1;
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Updated", "alert('تم تعديل البيانات بنجاح !');", true);
            loadBranchData();
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
            grdsetting_branch.PageIndex = e.NewPageIndex;
            loadBranchData();
        }

    }
}