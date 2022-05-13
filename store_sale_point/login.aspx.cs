using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;

namespace store_sale_point
{
    public partial class login : System.Web.UI.Page
    {
       

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["user_id"] = "";
            if (!IsPostBack) {
                Session.RemoveAll();
                Session.Abandon();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtUserName.Value != "" && txtPassword.Value != "")
            {
                checkUser(txtUserName.Value, txtPassword.Value);
            }
            else
            {
                System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Updated", "alert('من فضلك ادخل البيانات !');", true);

            }
        }
        void checkUser(string userName, string userpassword)
        {

            SqlDataAdapter sda = new SqlDataAdapter(@"select user_id,branch_id,user_name,user_active_or_no from all_users where user_kind_id='2' and user_name='" + userName + "' and user_password='" + userpassword + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["user_active_or_no"].ToString() == "نشط")
                {
                    Session["user_name"] = dt.Rows[0]["user_name"].ToString();
                    Session["user_id"] = dt.Rows[0]["user_id"].ToString();
                    Session["branch_id"] = dt.Rows[0]["branch_id"].ToString();
                    //string insertDate = "CAST(CONVERT(varchar,getdate(),101) AS datetime)";
                    //sc.Open();
                    //string ip = HttpContext.Current.Request.UserHostAddress;                  
                   //string ip = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                    //if (string.IsNullOrEmpty(ip))
                    //{
                    //    ip = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                    //}
                    //string ip = HttpContext.Current.Request.Params["HTTP_CLIENT_IP"] ?? HttpContext.Current.Request.UserHostAddress.ToString();
                    //HttpRequest currentRequest = HttpContext.Current.Request;
                    //String ip = currentRequest.ServerVariables["REMOTE_ADDR"];

                    string ip = GetIP();
                    string name = System.Net.Dns.GetHostEntry(HttpContext.Current.Request.ServerVariables["REMOTE_HOST"]).HostName;


                    SqlCommand cmd = new SqlCommand(@"insert into historyInOut_User(user_id,history_DateTimeIn,history_getIpClient,history_getNameClient) 
                    values (@user_id,@history_DateTimeIn,@history_getIpClient,@history_getNameClient)", sc);
                    cmd.Parameters.AddWithValue("@user_id", Session["user_id"]);
                    cmd.Parameters.AddWithValue("@history_DateTimeIn", DateTime.Now);
                    cmd.Parameters.AddWithValue("@history_getIpClient", ip);
                    cmd.Parameters.AddWithValue("@history_getNameClient", name);

                    SqlDataAdapter sdaa = new SqlDataAdapter(cmd);
                    DataTable dta = new DataTable();
                    sdaa.Fill(dta);

                    Response.Redirect("/admin/home.aspx");
                }
                else
                {
                    System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Permission", "alert(' من فضلك نشط المستخدم !');", true);
                }
            }
            else
            {
                txtUserName.Value = "";
                System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Error", "alert(' اسم المستخدم او كلمة المرور ربما تكون خاطئه !');", true);
            }

        }


        public string GetIP()
        {
            string strHostName = "";
            strHostName = System.Net.Dns.GetHostName();

            IPHostEntry ipEntry = System.Net.Dns.GetHostEntry(strHostName);

            IPAddress[] addr = ipEntry.AddressList;

            return addr[addr.Length - 1].ToString();

        }

    }
}