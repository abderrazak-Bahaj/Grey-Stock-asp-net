using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace store_sale_point
{
    public class Global : System.Web.HttpApplication
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            try
            {
                //Session.Clear();
                //Session.Abandon();

                //Session.Abandon();
                //Response.Cookies["user_id"].Value = string.Empty;
                //Session.Abandon();

                //            SqlCommand cmd = new SqlCommand(@"insert into historyInOut_User(history_DateTimeOut) 
                //                    values (@history_DateTimeOut)", sc);
                //            cmd.Parameters.AddWithValue("@history_DateTimeOut", DateTime.Now);

                //            SqlDataAdapter sdaa = new SqlDataAdapter(cmd);
                //            DataTable dta = new DataTable();
                //            sdaa.Fill(dta);

                SqlDataAdapter sda = new SqlDataAdapter(@"select max(history_id) as id from historyInOut_User where user_id = '" + Session["user_id"] + "'", sc);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                string id = dt.Rows[0]["id"].ToString();

                SqlCommand cmd = new SqlCommand(@"update historyInOut_User set history_DateTimeOut=@history_DateTimeOut where history_id = '" + id + "'", sc);
                cmd.Parameters.AddWithValue("@history_DateTimeOut", DateTime.Now);
                SqlDataAdapter sdas = new SqlDataAdapter(cmd);
                DataTable dtupdate = new DataTable();
                sdas.Fill(dtupdate);
                //Response.Redirect("../login.aspx");
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void Application_End(object sender, EventArgs e)
        {
            try
            {
                SqlDataAdapter sda = new SqlDataAdapter(@"select max(history_id) as id from historyInOut_User where user_id = '" + Session["user_id"] + "'", sc);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                string id = dt.Rows[0]["id"].ToString();


                SqlCommand cmd = new SqlCommand(@"update historyInOut_User set history_DateTimeOut=@history_DateTimeOut where history_id = '" + id + "'", sc);
                cmd.Parameters.AddWithValue("@history_DateTimeOut", DateTime.Now);
                SqlDataAdapter sdas = new SqlDataAdapter(cmd);
                DataTable dtupdate = new DataTable();
                sdas.Fill(dtupdate);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
    }
}