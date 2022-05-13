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
    public partial class product_view : System.Web.UI.Page
    {

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDataBranch();
                loadDataCatgory();
                loadSearchProduct();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loadSearchProduct();
        }

        void loadDataBranch()
        {
            string sql = @"select branch_id,branch_name from branch";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(drpbranch_id, sql, name, id);
        }
        void loadDataStore()
        {
            string sql = @"select store_id,store_name,branch_id from store where branch_id = '" + drpbranch_id.SelectedValue + "'";
            string name = "store_name";
            string id = "store_id";
            showDrpList(drpstore_id, sql, name, id);
        }
        void loadDataCatgory()
        {
            string sql = @"select category_id,category_name from category";
            string name = "category_name";
            string id = "category_id";
            showDrpList(drpcategory_id, sql, name, id);
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

        protected void drpbranch_id_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDataStore();
        }

        void loadSearchProduct()
        {
            string condition = "";

            if (txtproduct_name.Text != "")
            {
                condition += " and product.product_name = '" + txtproduct_name.Text + "'";
            }
            if (txtproduct_code.Text != "")
            {
                condition += " and product.product_code ='" + txtproduct_code.Text + "'";
            }
            if (txtproduct_code.Text != "")
            {
                condition += " and product.product_code ='" + txtproduct_code.Text + "'";
            }
            if (drpbranch_id.SelectedItem.Value != "-1")
            {
                condition += " and branch.branch_id ='" + drpbranch_id.SelectedValue + "'";
            }

            if (drpstore_id.SelectedValue != "")
            {
                if (drpstore_id.SelectedItem.Value != "-1")
                {
                    condition += " and product.store_id ='" + drpstore_id.SelectedValue + "'";
                }
            }

            if (drpcategory_id.SelectedItem.Value != "-1")
            {
                condition += " and product.category_id ='" + drpcategory_id.SelectedValue + "'";
            }


            string sql = @"SELECT     dbo.product.product_name, dbo.product.product_code, dbo.store.store_name, dbo.category.category_name, dbo.unit.unit_name, dbo.product.store_id, 
                      dbo.product.unit_id, dbo.product.product_barcode, dbo.product.product_price, dbo.product.product_quantity, dbo.product.category_id, dbo.branch.branch_name, 
                      dbo.product.product_id, dbo.product.user_id
FROM         dbo.product INNER JOIN
                      dbo.category ON dbo.product.category_id = dbo.category.category_id INNER JOIN
                      dbo.store ON dbo.product.store_id = dbo.store.store_id INNER JOIN
                      dbo.unit ON dbo.product.unit_id = dbo.unit.unit_id INNER JOIN
                      dbo.branch ON dbo.store.branch_id = dbo.branch.branch_id where 1=1 " + condition + " ";

            SqlDataAdapter sda = new SqlDataAdapter(sql, sc);

            DataTable dt = new DataTable();
            //dt.Rows.Clear();
            sda.Fill(dt);
            grdProduct.DataSource = dt;
            grdProduct.DataBind();

        }

        protected void btnShowImg_Click(object sender, EventArgs e)
        {
            int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
            GridViewRow row = grdProduct.Rows[rowIndex];
            string id = (row.FindControl("lblproduct_id") as Label).Text;
            SqlDataAdapter sda = new SqlDataAdapter(@"select product_img from product where product_id ='"+id+"'", sc);

            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ImgProduct.ImageUrl = "~/Upload/Product/" + dt.Rows[0]["product_img"];
            }
            else {
                ImgProduct.ImageUrl = "~/Upload/noimage.png";
            }
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append(@"<script type='text/javascript'>");
            sb.Append("$(function () {");
            sb.Append(" $('#showImg').modal('show');});");
            sb.Append("</script>");
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ModelScript", sb.ToString(), false);
        }

        protected void grdProduct_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            grdProduct.Columns[1].Visible = false;
        }

        protected void grdProduct_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdProduct.PageIndex = e.NewPageIndex;
            loadSearchProduct();
        }

        protected void grdProduct_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grdProduct.DataKeys[e.RowIndex].Value.ToString();
            SqlDataAdapter sda = new SqlDataAdapter(@"delete from product where product_id = '"+id+"'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Delete", "alert('تم حذف البيانات بنجاح !');", true);
            loadSearchProduct();
        }
    }
}