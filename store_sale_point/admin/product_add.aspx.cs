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
using System.Text.RegularExpressions;

namespace store_sale_point.admin
{
    public partial class product_add : System.Web.UI.Page
    {
        string SearchString = "";
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

            if (!IsPostBack)
            {

                loadDatacategory();
                loadDataunit();
                loadDatabranch();

            }
        }

        protected void removePic_Click(object sender, EventArgs e)
        {

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

        protected void grdcategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdcategory.PageIndex = e.NewPageIndex;
            grdcategory.SelectedIndex = -1;
            loadDatacategory();
            upModal.Update();
        }

        protected void grdcategory_PageIndexChanged(object sender, EventArgs e)
        {

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

        protected void grdcategory_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;

            SqlDataAdapter sda = new SqlDataAdapter("select category_id,category_name,category_notes from category where category_name like '%" + txtSearch.Text + "%'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdcategory.DataSource = dt;
            grdcategory.DataBind();
        }


        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (drpcategoryname.Text == "" || drpunit_id.SelectedIndex == -1 || drpstore_id.SelectedIndex == -1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert(' please Check Data Data !')", true);
                return;
            }
            insertDataproduct();
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

        void insertDataproduct()
        {
            //string insertDate = "CAST(CONVERT(varchar,getdate(),101) AS datetime)";

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
                }
                sc.Open();
                SqlCommand cmd = new SqlCommand(@"insert into product (product_name,product_code,product_barcode," +
                    "product_img,product_price,product_quantity,product_quantity_alert,product_desc," +
                    "unit_id,user_id,store_id,category_id,product_dateadd) values (@product_name,@product_code,@product_barcode," +
                "@product_img,@product_price,@product_quantity,@product_quantity_alert,@product_desc," +
                "@unit_id,@user_id,@store_id,@category_id,@product_dateadd)", sc);

                cmd.Parameters.AddWithValue("@product_name", txtproduct_name.Text);
                cmd.Parameters.AddWithValue("@product_code", txtproduct_code.Text);
                cmd.Parameters.AddWithValue("@product_barcode", txtproduct_barcode.Text);
                cmd.Parameters.AddWithValue("@product_img", FileUpload1.FileName);
                cmd.Parameters.AddWithValue("@product_price", txtproduct_price.Text);
                cmd.Parameters.AddWithValue("@product_quantity", txtproduct_quantity.Text);
                cmd.Parameters.AddWithValue("@product_quantity_alert", txtproduct_quantity_alert.Text);
                cmd.Parameters.AddWithValue("@product_desc", txtproduct_desc.Text);
                cmd.Parameters.AddWithValue("@unit_id", drpunit_id.SelectedValue);
                cmd.Parameters.AddWithValue("@store_id", drpstore_id.SelectedValue);
                cmd.Parameters.AddWithValue("@category_id", drpcategoryid.Text);
                cmd.Parameters.AddWithValue("@product_dateadd", DateTime.Now);
                string usr = AllUsers.usersSession().ToString();
                cmd.Parameters.AddWithValue("@user_id", usr);
                cmd.ExecuteNonQuery();
                sc.Close();
            }
            else
            {

                sc.Open();
                SqlCommand cmd = new SqlCommand(@"insert into product (product_name,product_code,product_barcode," +
                    "product_price,product_quantity,product_quantity_alert,product_desc," +
                    "unit_id,user_id,store_id,category_id,product_dateadd) values (@product_name,@product_code,@product_barcode," +
                "@product_price,@product_quantity,@product_quantity_alert,@product_desc," +
                "@unit_id,@user_id,@store_id,@category_id,@product_dateadd)", sc);

                cmd.Parameters.AddWithValue("@product_name", txtproduct_name.Text);
                cmd.Parameters.AddWithValue("@product_code", txtproduct_code.Text);
                cmd.Parameters.AddWithValue("@product_barcode", txtproduct_barcode.Text);
                cmd.Parameters.AddWithValue("@product_price", txtproduct_price.Text);
                cmd.Parameters.AddWithValue("@product_quantity", txtproduct_quantity.Text);
                cmd.Parameters.AddWithValue("@product_quantity_alert", txtproduct_quantity_alert.Text);
                cmd.Parameters.AddWithValue("@product_desc", txtproduct_desc.Text);
                cmd.Parameters.AddWithValue("@unit_id", drpunit_id.SelectedValue);
                cmd.Parameters.AddWithValue("@store_id", drpstore_id.SelectedValue);
                cmd.Parameters.AddWithValue("@category_id", drpcategoryid.Text);
                //string insertDate = "Cast(Convert(varchar,getdate(),101) as DateTime)";
                cmd.Parameters.AddWithValue("@product_dateadd", DateTime.Now);
                string usr = AllUsers.usersSession().ToString();
                cmd.Parameters.AddWithValue("@user_id", usr);
                cmd.ExecuteNonQuery();
                sc.Close();

            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Inserted Data !')", true);
            loadClearData();
        }

        protected void drpbranch_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDatastore();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            loadClearData();
        }
    }
}