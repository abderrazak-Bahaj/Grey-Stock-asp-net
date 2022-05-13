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
    public partial class box : System.Web.UI.Page
    {

        string SearchString = "";
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

            if (!IsPostBack)
            {
                loadbox();
                loadBranch_id();
                loadbox_kind_id();
                loadbox_account_id();

                AccountFooterData();

                Response.Cache.SetCacheability(HttpCacheability.NoCache);
            }
        }
        void loadbox()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT dbo.branch.branch_name, dbo.box_kind.box_kind_name, 
            dbo.box_account.box_account_name, dbo.box.box_datecreation, dbo.box.box_value, 
                      dbo.box.box_cheknumber, dbo.box.box_chekplace, dbo.box.box_notes, dbo.box.box_file, 
                      dbo.box.box_id, dbo.box.branch_id, dbo.box.box_kind_id, 
                      dbo.box.box_account_id
                      FROM dbo.box INNER JOIN
                      dbo.box_account ON dbo.box.box_account_id = dbo.box_account.box_account_id INNER JOIN
                      dbo.box_kind ON dbo.box.box_kind_id = dbo.box_kind.box_kind_id INNER JOIN
                      dbo.branch ON dbo.box.branch_id = dbo.branch.branch_id where 
            dbo.branch.branch_name+dbo.box_account.box_account_name
            +dbo.box_kind.box_kind_name LIKE '%" + txtSearch.Text + "%'", sc);


            sda.Fill(dt);
            grdBox.DataSource = dt;
            grdBox.DataBind();
        }
        void loadBranch_id()
        {
            string sql = @"select branch_name,branch_id from branch";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(drpbranch_id, sql, name, id);
            showDrpList(drpEditbranch_id, sql, name, id);

        }
        void loadbox_kind_id()
        {
            string sql = @"select box_kind_name,box_kind_id from box_kind";
            string name = "box_kind_name";
            string id = "box_kind_id";
            showDrpList(drpbox_kind_id, sql, name, id);
            showDrpList(drpEditbox_kind_id, sql, name, id);
        }

        void loadbox_account_id()
        {
            string sql = @"select box_account_name,box_account_id from box_account";
            string name = "box_account_name";
            string id = "box_account_id";
            showDrpList(drpbox_account_id, sql, name, id);
            showDrpList(drpEditbox_account_id, sql, name, id);
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

        protected void grdSupplier_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdBox.PageIndex = e.NewPageIndex;
            loadbox();
        }

        protected void grdSupplier_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grdBox.DataKeys[e.RowIndex].Value.ToString();
            deleteBox(id);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حذف البيانات بنجاح !');", true);
            loadbox();
            AccountFooterData();
        }

        void deleteBox(string id)
        {
            SqlCommand cmd = new SqlCommand(@"delete from box where box_id = @box_id", sc);
            if (sc.State == ConnectionState.Closed)
            {
                sc.Open();
            }
            cmd.Parameters.AddWithValue("@box_id", id);
            cmd.ExecuteNonQuery();
            if (sc.State == ConnectionState.Open)
            {
                sc.Close();
            }
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
            GridViewRow row = grdBox.Rows[rowIndex];

            hiddenId.Value = (row.FindControl("lblbox_id") as Label).Text;
            drpEditbranch_id.SelectedValue = (row.FindControl("lblbranch_i") as Label).Text;
            drpEditbox_kind_id.SelectedValue = (row.FindControl("lblbox_kind_i") as Label).Text;
            drpEditbox_account_id.SelectedValue = (row.FindControl("lblbox_account_i") as Label).Text;

            txtEditbox_value.Text = (row.FindControl("lblbox_value") as Label).Text;
            txtEditbox_cheknumber.Text = (row.FindControl("lblbox_cheknumber") as Label).Text;
            txtEditbox_chekplace.Text = (row.FindControl("lblbox_chekplace") as Label).Text;
            txtEditbox_notes.Text = (row.FindControl("lblbox_notes") as Label).Text;


            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$(function () {");
            sb.Append(" $('#ShowEdit').modal('show');});");
            sb.Append("</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ModelScript", sb.ToString(), false);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand(@"UPDATE [box]
            SET [branch_id] =@branch_id ,[box_kind_id] =@box_kind_id ,[box_account_id] =@box_account_id 
            ,[box_datecreation] = @box_datecreation,[box_value] =@box_value ,[box_cheknumber] =@box_cheknumber 
            ,[box_chekplace] =@box_chekplace ,[box_notes] =@box_notes ,[box_file] = @box_file
            WHERE box_id = @box_id ", sc);
            cmd.Parameters.AddWithValue("@box_id", hiddenId.Value);
            cmd.Parameters.AddWithValue("@branch_id", drpEditbranch_id.SelectedValue);
            cmd.Parameters.AddWithValue("@box_kind_id", drpEditbox_kind_id.SelectedValue);
            cmd.Parameters.AddWithValue("@box_account_id", drpEditbox_account_id.SelectedValue);
            cmd.Parameters.AddWithValue("@box_datecreation", DateTime.Now);
            cmd.Parameters.AddWithValue("@box_value", txtEditbox_value.Text);
            cmd.Parameters.AddWithValue("@box_cheknumber", txtEditbox_cheknumber.Text);
            cmd.Parameters.AddWithValue("@box_chekplace", txtEditbox_chekplace.Text);
            cmd.Parameters.AddWithValue("@box_notes", txtEditbox_notes.Text);
            cmd.Parameters.AddWithValue("@box_file", EditFileUpload.FileName);


            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);
            loadbox();
            Response.Redirect("box.aspx");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            //DateTime times = DateTime.Now;              // Use current time
            //string formats = "yyyy-MM-dd HH:mm:ss";  // modify the format depending upon input required in the column in database


            SqlDataAdapter sda = new SqlDataAdapter(@"insert into [box]
           ([branch_id],[box_kind_id],[box_account_id],[box_datecreation],[box_value]
           ,[box_cheknumber],[box_chekplace],[box_notes],[box_file]) 
           values ('" + drpbranch_id.SelectedValue + "','" + drpbox_kind_id.SelectedValue + "','" + drpbox_account_id.SelectedValue + "','" + DateTime.Now + "','" + float.Parse(txtbox_value.Text) + "','" + txtbox_cheknumber.Text + "','" + txtbox_chekplace.Text + "','" + txtbox_notes.Text + "','" + FileUpload1.FileName + "')", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (FileUpload1.HasFile)
            {
                FileUpload1.SaveAs(Server.MapPath("/Upload/File/" + FileUpload1.FileName));
            }
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم ادخال البيانات بنجاح !');", true);
            loadbox();
            clearData();
            Response.Redirect("box.aspx");
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
        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";

            AccountFooterData();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;
            loadbox();
            
            AccountFooterData();

        }
        void clearData()
        {
            txtbox_cheknumber.Text = string.Empty;
            txtbox_chekplace.Text = string.Empty;
            txtbox_notes.Text = string.Empty;
            txtbox_value.Text = string.Empty;


            txtEditbox_cheknumber.Text = "";
            txtEditbox_chekplace.Text = "";
            txtEditbox_notes.Text = "";
            txtEditbox_value.Text = "";
        }
        void AccountFooterData()
        {
            grdBox.FooterRow.Cells[0].Text = "الاجمالى ";
            grdBox.FooterRow.Cells[2].Text = dt.Compute("Count(box_id)", "").ToString();
            grdBox.FooterRow.Cells[6].Text = dt.Compute("Sum(box_value)", "").ToString();

            //if (dt.Rows.Count > 0) {
            //    foreach (DataRow dr in dt.Rows)
            //    {
            //        grdBox.FooterRow.Cells[11].Text += dr["box_kind_name"].ToString() + " : " + "<br/>";
                    
            //    }
            //}
            //grdBox.FooterRow.Cells[11].Text += dts.Rows[0]["box_kind_name"].ToString() + " : " + dts.Rows[0]["sumMount"].ToString() + "<br/>";

            SqlDataAdapter sdas = new SqlDataAdapter(@"SELECT dbo.box_kind.box_kind_name, SUM(dbo.box.box_value) AS sumMount
            FROM dbo.box INNER JOIN
            dbo.box_kind ON dbo.box.box_kind_id = dbo.box_kind.box_kind_id
            GROUP BY dbo.box_kind.box_kind_name", sc);
            DataTable dts = new DataTable();
            sdas.Fill(dts);
            if (dts.Rows.Count > 0)
            {
                string tr = "";
                foreach (DataRow item in dts.Rows)
                {
                    tr += "<tr> " +
                        "<td>" + item["box_kind_name"].ToString() + "</td>" +
                        "<td>" + item["sumMount"].ToString() + "</td>" +
                        "</tr>";
                }
                trBody.InnerHtml = tr;
                trBody.DataBind();
            }
        }
    }
}