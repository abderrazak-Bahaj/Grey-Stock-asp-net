using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace store_sale_point.usercontrol
{
    public partial class menu_master : System.Web.UI.UserControl
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = AllUsers.userNames().ToString();
        }

        protected void BtnExit_Click(object sender, EventArgs e)
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

            //Session.Clear();
            Session.Abandon();
            //Response.Cookies["user_id"].Value = string.Empty;
            Response.Redirect("../login.aspx");
        }
    }
}