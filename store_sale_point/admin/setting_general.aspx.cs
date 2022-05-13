using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing.Drawing2D;
using System.Drawing;
using System.IO;

namespace store_sale_point.admin
{
    public partial class setting_general : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadUser();
                loadData();
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select * from general_setting", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                updateGenderalSetting();

            }
            else
            {
                insertGeneralSeetin();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Image1.ImageUrl != "")
            {
                Image1.ImageUrl = "";
                //System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Deleted", "alert('تم الحذف بنجاح !');", true);            

            }
            //else {
            //    System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Deleted", "alert('من فضلك اختر الصورة اولا !');", true);            
            //}
        }
        void updateGenderalSetting()
        {

            sc.Open();
            SqlCommand cmd = new SqlCommand("update general_setting set [setting_title]=@setting_title,[setting_logo]=@setting_logo,[setting_phone]=@setting_phone " +
                                           " ,[user_id]=@user_id,[setting_notes]=@setting_notes", sc);

            cmd.Parameters.AddWithValue("@setting_title", txtsetting_title.Text);
            cmd.Parameters.AddWithValue("@setting_phone", txtsetting_phone.Text);
            cmd.Parameters.AddWithValue("@user_id", drpUser.SelectedValue);
            cmd.Parameters.AddWithValue("@setting_notes", txtsetting_notes.Text);

            if (FileUpload1.HasFile && FileUpload1.PostedFile.ContentLength > 0)
            {
                FileUpload1.SaveAs(Server.MapPath("~/images/" + FileUpload1.FileName));
                cmd.Parameters.AddWithValue("@setting_logo", FileUpload1.FileName);
            }
            else
            {
                cmd.Parameters.AddWithValue("@setting_logo", Image1.AlternateText);
            }
            //SqlDataAdapter sdaas = new SqlDataAdapter(cmd);
            //DataTable dtss = new DataTable();
            //sda.Fill(dtss);
            //sc.Close();
            cmd.ExecuteNonQuery();
            sc.Close();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Updated Data !')", true);

        }
        void insertGeneralSeetin()
        {
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
                        string targetPath = Server.MapPath(@"~\images\") + FileUpload1.FileName;
                        thumbImg.Save(targetPath, image.RawFormat);
                    }
                }

                sc.Open();
                SqlCommand cmd = new SqlCommand(@"insert into general_setting(setting_title,setting_logo,setting_phone,user_id,setting_date_creation,setting_notes) values (@setting_title,@setting_logo,@setting_phone,@user_id,@setting_date_creation,@setting_notes)", sc);
                cmd.Parameters.AddWithValue("@setting_title", txtsetting_title.Text);
                cmd.Parameters.AddWithValue("@setting_phone", txtsetting_phone.Text);
                cmd.Parameters.AddWithValue("@user_id", drpUser.SelectedValue);
                cmd.Parameters.AddWithValue("@setting_date_creation", Convert.ToDateTime(DateTime.Now.ToShortDateString()));
                cmd.Parameters.AddWithValue("@setting_notes", txtsetting_notes.Text);
                //cmd.Parameters.AddWithValue("@setting_logo", "images/" + FileUpload1.FileName);
                cmd.Parameters.AddWithValue("@setting_logo", FileUpload1.FileName);
                cmd.ExecuteNonQuery();
                sc.Close();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Inserted Data !')", true);
                loadData();
            }
            else
            {
                sc.Open();
                SqlCommand cmd = new SqlCommand(@"insert into general_setting(setting_title,setting_phone,user_id,setting_date_creation,setting_notes) values (@setting_title,@setting_phone,@user_id,@setting_date_creation,@setting_notes)", sc);
                cmd.Parameters.AddWithValue("@setting_title", txtsetting_title.Text);
                cmd.Parameters.AddWithValue("@setting_phone", txtsetting_phone.Text);
                cmd.Parameters.AddWithValue("@user_id", drpUser.SelectedValue);
                cmd.Parameters.AddWithValue("@setting_date_creation", Convert.ToDateTime(DateTime.Now.ToShortDateString()));
                cmd.Parameters.AddWithValue("@setting_notes", txtsetting_notes.Text);
                cmd.ExecuteNonQuery();
                sc.Close();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Inserted Data !')", true);
                loadData();
            }
        }

        void loadUser()
        {

            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT user_id,user_name FROM all_users", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            drpUser.Items.Clear();
            drpUser.DataSource = dt;
            drpUser.DataTextField = "user_name";
            drpUser.DataValueField = "user_id";
            drpUser.DataBind();
            drpUser.Items.Insert(0, "اختر");
            drpUser.Items[0].Value = "";
        }
        void loadData()
        {
            SqlCommand cmd = new SqlCommand(@"select setting_id,setting_title,setting_logo,setting_phone,user_id,setting_notes from general_setting", sc);
            sc.Open();
            SqlDataReader sdr = cmd.ExecuteReader();

            if (sdr.Read())
            {
                txtsetting_title.Text = sdr["setting_title"].ToString();
                txtsetting_phone.Text = sdr["setting_phone"].ToString();
                txtsetting_notes.Text = sdr["setting_notes"].ToString();
                drpUser.SelectedValue = sdr["user_id"].ToString();
                Image1.ImageUrl = "~/images/" + sdr["setting_logo"].ToString();
                Image1.AlternateText = sdr["setting_logo"].ToString();
            }
            sdr.Close();
            sc.Close();
        }
    }
}