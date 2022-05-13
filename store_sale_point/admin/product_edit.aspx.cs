using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Drawing.Drawing2D;
using System.Drawing;

namespace store_sale_point.admin
{
    public partial class product_edit : System.Web.UI.Page
    {
        string SearchString = "";
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["product_id"] == null)
            {
                Response.Redirect("product_view.aspx");
            }

            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

            if (!IsPostBack)
            {

                loadDatacategory();
                loadDataunit();
                loadDatabranch();
                loadShowDataProduct();
            }
        }

        void loadDatacategory()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select category_id,category_name,category_notes from category", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdcategory.DataSource = dt;
            grdcategory.DataBind();
        }

        void loadDataunit()
        {
            string sql = @"select unit_id,unit_name,unit_notes from unit";
            string name = "unit_name";
            string id = "unit_id";
            showDrpList(drpunit_id, sql, name, id);
        }

        void loadDatabranch()
        {
            string sql = @"select branch_id,branch_name from branch";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(drpbranch, sql, name, id);
        }

        void loadDatastore()
        {
            string sql = @"select store_id,store_name,branch_id,store_notes from store where branch_id = '" + drpbranch.SelectedValue + "'";
            string name = "store_name";
            string id = "store_id";
            showDrpList(drpstore_id, sql, name, id);
        }

        void loadClearData()
        {
            txtproduct_name.Text = string.Empty;
            txtproduct_code.Text = string.Empty;
            txtproduct_barcode.Text = string.Empty;
            txtproduct_price.Text = string.Empty;
            txtproduct_quantity.Text = string.Empty;
            txtproduct_quantity_alert.Text = string.Empty;
            drpbranch.SelectedIndex = -1;
            drpstore_id.SelectedIndex = -1;
            drpunit_id.SelectedIndex = -1;
            drpcategoryid.Text = string.Empty;
            drpcategoryname.Text = string.Empty;
            imgproduct_img.ImageUrl = "~/Upload/noimage.png";

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

        protected void grdcategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdcategory.PageIndex = e.NewPageIndex;
            grdcategory.SelectedIndex = -1;
            loadDatacategory();
            upModal.Update();
        }

        protected void grdcategory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.style.cursor='hand';this.style.backgroundColor='yellow'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='white'");
            }
        }

        protected void grdcategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["id"] = (grdcategory.SelectedRow.FindControl("lblcategory_id") as Label).Text;
            ViewState["name"] = (grdcategory.SelectedRow.FindControl("lblcategory_name") as Label).Text;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePopup", "$('#confirmcategory').modal('hide')", true);
            drpcategoryid.Text = ViewState["id"].ToString();
            drpcategoryname.Text = ViewState["name"].ToString();
            updatepanel2.Update();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;

            SqlDataAdapter sda = new SqlDataAdapter("select category_id,category_name,category_notes from category where category_name+category_notes like '%" + txtSearch.Text + "%' order by category_name", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdcategory.DataSource = dt;
            grdcategory.DataBind();
        }

        void loadShowDataProduct()
        {
            sc.Open();
            string sql = @"SELECT dbo.category.category_name, dbo.product.product_id, dbo.product.product_name, dbo.product.product_code, dbo.product.product_dateadd, 
                      dbo.product.product_barcode, dbo.product.product_img, dbo.product.product_price, dbo.product.product_quantity, dbo.product.product_quantity_alert, 
                      dbo.product.product_desc, dbo.product.unit_id, dbo.product.user_id, dbo.product.store_id, dbo.product.category_id
                      FROM dbo.category INNER JOIN
                      dbo.product ON dbo.category.category_id = dbo.product.category_id
                         where product_id='" + Request.QueryString["product_id"] + "'";
            SqlDataAdapter sda = new SqlDataAdapter(sql, sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                txtproduct_name.Text = dt.Rows[0]["product_name"].ToString();
                txtproduct_code.Text = dt.Rows[0]["product_code"].ToString();
                txtproduct_barcode.Text = dt.Rows[0]["product_barcode"].ToString();
                txtproduct_price.Text = dt.Rows[0]["product_price"].ToString();
                txtproduct_quantity.Text = dt.Rows[0]["product_quantity"].ToString();
                txtproduct_quantity_alert.Text = dt.Rows[0]["product_quantity_alert"].ToString();
                txtproduct_desc.Text = dt.Rows[0]["product_desc"].ToString();
                drpunit_id.SelectedValue = dt.Rows[0]["unit_id"].ToString();
                drpcategoryid.Text = dt.Rows[0]["category_id"].ToString();
                drpcategoryname.Text = dt.Rows[0]["category_name"].ToString();


                SqlDataAdapter sds = new SqlDataAdapter("select branch_id from store where store_id='" + dt.Rows[0]["store_id"].ToString() + "'", sc);
                DataTable dts = new DataTable();
                sds.Fill(dts);
                drpbranch.SelectedValue = dts.Rows[0]["branch_id"].ToString();

                loadDatastore();
                drpstore_id.SelectedValue = dt.Rows[0]["store_id"].ToString();

                if (dt.Rows[0]["product_img"].ToString() != null)
                {
                    imgproduct_img.ImageUrl = "~/Upload/Product/" + dt.Rows[0]["product_img"];
                    imglbl.Text = dt.Rows[0]["product_img"].ToString();

                }
                else
                {
                    imgproduct_img.ImageUrl = "~/Upload/noimage.png";

                }
            }
            else
            {
                Response.Redirect("product_view.aspx");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            insertDataproduct();
        }

        void insertDataproduct()
        {
            //string insertDate = "Cast(Convert(varchar,getdate(),101) as DateTime)";
            string img = imglbl.Text;
            if (FileUpload1.HasFile && FileUpload1.PostedFile.ContentLength > 0)
            {
                string extension = Path.GetExtension(FileUpload1.FileName);
                if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg")
                {
                    Stream strm = FileUpload1.PostedFile.InputStream;
                    using (var image = System.Drawing.Image.FromStream(strm))
                    {
                        int newWidth = 240; // New Width of Image in Pixel  
                        int newHeight = 240; // New Height of Image in Pixel  
                        var thumbImg = new Bitmap(newWidth, newHeight);
                        var thumbGraph = Graphics.FromImage(thumbImg);
                        thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
                        thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
                        thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
                        var imgRectangle = new Rectangle(0, 0, newWidth, newHeight);
                        thumbGraph.DrawImage(image, imgRectangle);
                        //
                        string targetPath = Server.MapPath(@"~\Upload\Product\") + FileUpload1.FileName;
                        thumbImg.Save(targetPath, image.RawFormat);
                    }
                    img = FileUpload1.FileName;
                }
            }
                sc.Open();
                SqlCommand cmd = new SqlCommand(@"update product  set product_name=@product_name,product_code=@product_code
                                ,product_barcode=@product_barcode,product_img=@product_img,product_price=@product_price
                                ,product_quantity=@product_quantity,product_quantity_alert=@product_quantity_alert,
                                product_desc=@product_desc,unit_id=@unit_id,user_id=@user_id,store_id=@store_id,
category_id=@category_id where product_id=@product_id", sc);

                cmd.Parameters.AddWithValue("@product_id", Request.QueryString["product_id"]);
                cmd.Parameters.AddWithValue("@product_name", txtproduct_name.Text);
                cmd.Parameters.AddWithValue("@product_code", txtproduct_code.Text);
                cmd.Parameters.AddWithValue("@product_barcode", txtproduct_barcode.Text);
                cmd.Parameters.AddWithValue("@product_img", img);
                cmd.Parameters.AddWithValue("@product_price", txtproduct_price.Text);
                cmd.Parameters.AddWithValue("@product_quantity", txtproduct_quantity.Text);
                cmd.Parameters.AddWithValue("@product_quantity_alert", txtproduct_quantity_alert.Text);
                cmd.Parameters.AddWithValue("@product_desc", txtproduct_desc.Text);
                cmd.Parameters.AddWithValue("@unit_id", drpunit_id.SelectedValue);
                cmd.Parameters.AddWithValue("@store_id", drpstore_id.SelectedValue);
                cmd.Parameters.AddWithValue("@category_id", drpcategoryid.Text);

                //cmd.Parameters.AddWithValue("@product_dateadd", insertDate);
                string usr = AllUsers.usersSession().ToString();
                cmd.Parameters.AddWithValue("@user_id", usr);
                cmd.ExecuteNonQuery();
                sc.Close();
            
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Inserted Data !')", true);
            loadShowDataProduct();
        }


        protected void drpbranch_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDatastore();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            //loadClearData();
            Response.Redirect("product_view.aspx");
        }

        protected void btnDel_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Deleted Data !')", true);
            SqlDataAdapter sda = new SqlDataAdapter("delete from product where product_id = '"+Request.QueryString["product_id"]+"'",sc);
            DataTable dt = new DataTable();
            
            sda.Fill(dt);
            Response.Redirect("product_view.aspx");
        }
    }
}