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
    public partial class Site1 : System.Web.UI.MasterPage
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        //دا متغير لحفظ رابط الصفحة الموجود بها
        //static string PrePageName = String.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //هنا بحفظ كود الصفحة اللى واقف عليها دلوقتى 
                //PrePageName = Request.UrlReferrer.LocalPath;

                checkRolls1();
                SqlDataAdapter sda = new SqlDataAdapter(@"select setting_title from general_setting", sc);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                title.InnerHtml = dt.Rows[0]["setting_title"].ToString();
            }
            if (Session["showmsg"] != null)
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('ليس لديك صلاحية');window.location ='" + PrePageName + "';", true);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('ليس لديك صلاحية');window.location ='" + Request.UrlReferrer.LocalPath + "';", true);
                Session["showmsg"] = null;
            }
        }

        void checkRolls1()
        {
            string current_page = Request.Url.PathAndQuery.ToString().ToLower();

            try
            {
                if (Session["user_id"] == null || Session["user_id"].ToString() == string.Empty || Session["user_id"] == "")
                {
                    Response.Redirect("../login.aspx");
                }
                string user_id = Session["user_id"].ToString();

                SqlDataAdapter sda = new SqlDataAdapter(@"select group_id from all_users where user_id='" + user_id + "'", sc);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                string group_id = dt.Rows[0]["group_id"].ToString();

                if (group_id != "")
                {
                    SqlDataAdapter sda1 = new SqlDataAdapter(@"SELECT dbo.permission_group_page.page_id
                        FROM dbo.permission_group_page INNER JOIN
                              dbo.permission_page ON dbo.permission_group_page.page_id = dbo.permission_page.page_id INNER JOIN
                              dbo.permission_group ON dbo.permission_group_page.group_id = dbo.permission_group.group_id
                        WHERE (dbo.permission_group_page.group_id = '" + group_id + "') AND (dbo.permission_page.page_url = N'" + current_page + "')", sc);
                    DataTable dt1 = new DataTable();

                    sda1.Fill(dt1);
                    string nn = dt1.Rows[0]["page_id"].ToString();
                }
            }
            catch (IndexOutOfRangeException)
            {

                Session["showmsg"] = true;
                Response.Redirect(Request.UrlReferrer.LocalPath);
            }
        }
        //        void checkRolls11()
        //        {
        //            if (Session["user_id"] == null || Session["user_id"].ToString() == string.Empty || Session["user_id"] == "")
        //            {
        //                Response.Redirect("../login.aspx");
        //            }
        //            string user_id = Session["user_id"].ToString();

        //            SqlDataAdapter sda = new SqlDataAdapter(@"select group_id from all_users where user_id='" + user_id + "'", sc);
        //            DataTable dt = new DataTable();
        //            sda.Fill(dt);
        //            string group_id = dt.Rows[0]["group_id"].ToString();

        //            string current_page = Request.Url.PathAndQuery.ToString().ToLower();
        //            if (group_id != "")
        //            {
        //                SqlDataAdapter sda1 = new SqlDataAdapter(@"SELECT dbo.permission_group_page.page_id
        //                FROM dbo.permission_group_page INNER JOIN
        //                      dbo.permission_page ON dbo.permission_group_page.page_id = dbo.permission_page.page_id INNER JOIN
        //                dbo.permission_group ON dbo.permission_group_page.group_id = dbo.permission_group.group_id
        //                WHERE (dbo.permission_group_page.group_id = '" + group_id + "') AND (dbo.permission_page.page_url = N'" + current_page + "')", sc);
        //                DataTable dt1 = new DataTable();

        //                sda1.Fill(dt1);
        //                try
        //                {
        //                    string page_id = dt1.Rows[0]["page_id"].ToString();

        //                }
        //                catch (Exception ex)
        //                {
        //                    //Response.Write("<script>alert('" + ex.Message + "');</script>");
        //                    //Response.Redirect(Request.UrlReferrer.ToString());
        //                    //Response.Redirect("/login.aspx");
        //                    //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "CreateExamError", "alert('" + ex.Message.Replace("'", "") + "');", true);
        //                    Response.Write("<script language='javascript'>window.alert('Your Message');window.location=Response.Redirect(Request.UrlReferrer.ToString());</script>");

        //                    Response.Redirect(Request.UrlReferrer.ToString());
        //                    //Response.Redirect(Request.UrlReferrer.ToString());

        //                }
        //            }
        //        }


//        void checkRolls()
//        {
//            if (Session["user_id"] == null || Session["user_id"].ToString() == string.Empty || Session["user_id"] == "")
//            {
//                Response.Redirect("../login.aspx");
//            }

//            string user_id = Session["user_id"].ToString();
//            string current_page = Request.Url.PathAndQuery.ToString().ToLower();

//            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT dbo.permission_page.page_url, dbo.permission_page.page_name, dbo.permission_group.group_name, dbo.all_users.user_name, dbo.all_users.user_id
//            FROM dbo.permission_group INNER JOIN
//                      dbo.permission_group_page ON dbo.permission_group.group_id = dbo.permission_group_page.group_id INNER JOIN
//                      dbo.permission_page ON dbo.permission_group_page.page_id = dbo.permission_page.page_id INNER JOIN
//                      dbo.all_users ON dbo.permission_group.group_id = dbo.all_users.group_id AND dbo.all_users.user_id = '" + user_id + "' AND dbo.permission_page.page_url = N'" + current_page + "';", sc);

//            DataTable dt = new DataTable();
//            sda.Fill(dt);
//            if (dt.Rows.Count > 0 && dt != null && dt.Rows.Count != 0)
//            {
//                //////
//            }
//            else
//            {
//                //string message = "ليس لديك صلاحية!";
//                //Show the message and then redirect
//                Session["showmsg"] = true;
//                Response.Redirect(PrePageName);



//                //Response.Redirect(Request.UrlReferrer.ToString());

//                // Response.Redirect("../login.aspx");




//                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + message + "');window.location ='" + Request.Url + "';", true);

//                //string message = "You will now be redirected to ASPSnippets Home Page.";
//                //string url = "//www.aspsnippets.com/";
//                //string script = "window.onload = function(){ alert('";
//                //script += message;
//                //script += "');";
//                //script += "window.location = '";
//                //script += url;
//                //script += "'; }";
//                //Page.ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script, true);

//                //Response.Write("<script language='javascript'>alert('hello world');</script>");
//                //Server.Transfer("../login.aspx", true);

//                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", " alert('User details saved sucessfully'); window.open('"+PrePageName+"');", true);
//                //string page = "Login.aspx";
//                //string myStringVariable = "Password Update!";
//                //Page.ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + myStringVariable + "');Response.Redirect('../login.aspx' );", true);
//                //

//                //Response.Write("<script>alert('you are redirected to home page')</script>");

//                //Response.Write("لا يوجد");
//                //Response.Write("<script language='javascript'>window.alert('ليس لديك صلاحية على الصفحة');</script>");
//                //Response.Write("<script language='javascript'>window.alert('ليس لديك صلاحية على الصفحة');window.location=Response.Redirect(PrePageName);</script>");
//                //Response.Write("<script language='javascript'>window.alert('ليس لديك صلاحية على الصفحة');window.location=Page.Response.Redirect(HttpContext.Current.Request.Url.ToString(), true);</script>");
//                //Response.Redirect(Request.Url.LocalPath.ToString(), true);
//                //System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Error", "alert(' ليس لديك صلاحية على هذة الصفحة !');", true);



//                //Response.Redirect(PrePageName,true);

//                //if (1 != 2) {
//                //    Response.Redirect(PrePageName, true);
//                //    return;


//                //}
//            }
//        }
    }
}
