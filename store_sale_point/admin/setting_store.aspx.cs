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
    public partial class setting_store : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDataBranch();
                loadDataStore();
            }
        }
        void loadDataBranch()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select branch_id,branch_name from branch", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            drpBranch.Items.Clear();

            //foreach (DataRow item in dt.Rows)
            //{
            //    drpBranch.Items.Add(item["branch_name"].ToString());
            //    drpBranch.Items[drpBranch.Items.Count - 1].Value = item["branch_id"].ToString();
            //}

            drpBranch.DataSource = dt;
            drpBranch.DataTextField = "branch_name";
            drpBranch.DataValueField = "branch_id";
            drpBranch.DataBind();

            ListItem drpListCat = new ListItem("اختر الفرع", "-1");
            drpBranch.Items.Insert(0, drpListCat);

            //drpBranch.Items.Insert(0, "اختر");
            //drpBranch.Items[0].Value = "";

        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"insert into store (store_name,store_notes,branch_id) values (@store_name,@store_notes,@branch_id)", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@store_name", txtstore_name.Text);
            cmd.Parameters.AddWithValue("@store_notes", txtstore_notes.Text);
            cmd.Parameters.AddWithValue("@branch_id", drpBranch.SelectedValue);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            loadDataStore();
            clearData();
        }
        void loadDataStore()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT store.store_id,store.store_name,store.store_notes,branch.branch_name,branch.branch_id FROM store INNER JOIN branch ON store.branch_id = branch.branch_id", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdStore.DataSource = dt;
            grdStore.DataBind();
        }
        void clearData()
        {
            txtstore_name.Text = string.Empty;
            txtstore_notes.Text = string.Empty;
            drpBranch.SelectedIndex = -1;
        }

        protected void grdStore_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            grdStore.EditIndex = -1;
            loadDataStore();
        }

        protected void grdStore_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grdStore.DataKeys[e.RowIndex].Value.ToString();
            SqlDataAdapter sda = new SqlDataAdapter(@"delete from store where store_id = '" + id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            loadDataStore();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم الحذف بنجاح !');", true);
            
        }

        protected void grdStore_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdStore.PageIndex = e.NewPageIndex;
            loadDataStore();
        }

        protected void grdStore_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grdStore.EditIndex = e.NewEditIndex;
            loadDataStore();
        }

        protected void grdStore_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = grdStore.DataKeys[e.RowIndex].Value.ToString();
            TextBox txtstore_name = grdStore.Rows[e.RowIndex].FindControl("txtstore_name") as TextBox;
            DropDownList drpBranchEdit = grdStore.Rows[e.RowIndex].FindControl("drpBranchEdit") as DropDownList;
            TextBox txtstore_notes = grdStore.Rows[e.RowIndex].FindControl("txtstore_notes") as TextBox;
            SqlCommand cmd = new SqlCommand(@"update store set store_name=@txtstore_name,branch_id=@branch_id,store_notes=@store_notes where store_id =@store_id", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@txtstore_name", txtstore_name.Text);
            cmd.Parameters.AddWithValue("@branch_id", drpBranchEdit.SelectedValue);
            cmd.Parameters.AddWithValue("@store_notes", txtstore_notes.Text);
            cmd.Parameters.AddWithValue("@store_id", id);

            cmd.ExecuteNonQuery();
            sc.Close();

            grdStore.EditIndex = -1;
            loadDataStore();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم الحفظ بنجاح !');", true);
        }

        protected void grdStore_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    //fill dropDownList
                    DropDownList drpBranchEdit = (DropDownList)e.Row.FindControl("drpBranchEdit");
                    SqlDataAdapter sda = new SqlDataAdapter(@"select branch_id,branch_name from branch", sc);
                    DataTable dts = new DataTable();
                    sda.Fill(dts);
                    drpBranchEdit.DataSource = dts;
                    drpBranchEdit.DataTextField = "branch_name";
                    drpBranchEdit.DataValueField = "branch_id";
                    drpBranchEdit.DataBind();
                    //get branch id
                    string id = grdStore.DataKeys[e.Row.RowIndex].Value.ToString();
                    SqlDataAdapter sdas = new SqlDataAdapter(@"select branch_id from store where store_id='" + id + "'", sc);
                    DataTable dt = new DataTable();
                    sdas.Fill(dt);

                    if (dt.Rows[0]["branch_id"] != "")
                    {
                        drpBranchEdit.SelectedValue = dt.Rows[0]["branch_id"].ToString();
                    }

                }
            }
        }
    }
}