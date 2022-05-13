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
    public partial class product_historyPrice : System.Web.UI.Page
    {
        string SearchString = "";
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        public int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

            if (!IsPostBack)
            {
                loadDatarecentPrice();
            }
        }
        void loadDatarecentPrice()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT product.product_name,recentPrice.recentPrice_ProductCode, 
                                     recentPrice.recentPrice_productPriceOld,recentPrice.recentPrice_productPriceNew,
                                     recentPrice_productDateEdit,recentPrice.recentPrice_productNotes,recentPrice.recentPrice_id
                                     FROM product JOIN recentPrice ON recentPrice.recentPrice_productId = product.product_id
                                     where product.product_name + recentPrice.recentPrice_ProductCode LIKE '%" + txtSearch.Text + "%' order by recentPrice_productDateEdit Desc", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdrecentPrice.DataSource = dt;
            grdrecentPrice.DataBind();
            grdrecentPrice.EmptyDataText = "لا توجد بيانات";
        }

        protected void grdrecentPrice_DataBound(object sender, EventArgs e)
        {
            grdrecentPrice.Columns[1].Visible = false;
        }

        protected void grdrecentPrice_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            int id = int.Parse(grdrecentPrice.DataKeys[e.RowIndex].Value.ToString());
            SqlCommand cmd = new SqlCommand(@"delete from recentPrice where recentPrice_id = @recentPrice_id", sc);
            sc.Open();
            cmd.Parameters.AddWithValue("@recentPrice_id", id);
            cmd.ExecuteNonQuery();
            sc.Close();
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حذف البيانات بنجاح !');", true);
            loadDatarecentPrice();

        }

        protected void grdrecentPrice_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdrecentPrice.PageIndex = e.NewPageIndex;
            loadDatarecentPrice();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            //int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
            //GridViewRow row = grdrecentPrice.Rows[rowIndex];
            //hiddenId.Value = (row.FindControl("lblrecentPrice_id") as Label).Text;
            ////string id = (row.FindControl("lblrecentPrice_id") as Label).Text;
            //txtrecentPrice_productNotes.Text = (row.FindControl("lblrecentPrice_productNotes") as Label).Text;



            int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
            GridViewRow row = grdrecentPrice.Rows[rowIndex];

            hiddenId.Value = (row.FindControl("lblrecentPrice_id") as Label).Text;
            txtrecentPrice_productNotes.Text = (row.FindControl("lblrecentPrice_productNotes") as Label).Text;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$(function () {");
            sb.Append(" $('#showNotes').modal('show');});");
            sb.Append("</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ModelScript", sb.ToString(), false);

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"update recentPrice set recentPrice_productNotes = '" + txtrecentPrice_productNotes.Text + "' where recentPrice_id = '" + hiddenId.Value + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            //System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('تم حفظ البيانات بنجاح !');", true);

            ClientScript.RegisterStartupScript(this.GetType(), "Close", "ClosePopup();", true);
            loadDatarecentPrice();
            Response.Redirect("product_historyPrice.aspx");
        }

        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;
            loadDatarecentPrice();
        }
    }
}