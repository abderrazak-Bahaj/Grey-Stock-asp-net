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
    public partial class historyInOut_User : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDatahistoryInOut_User();
            }
        }
        void loadDatahistoryInOut_User()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select * from historyInOut_User where user_id = '" + Session["user_id"] + "' order by history_DateTimeIn desc", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdhistoryInOut_User.DataSource = dt;
            grdhistoryInOut_User.DataBind();
        }

        protected void grdhistoryInOut_User_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdhistoryInOut_User.PageIndex = e.NewPageIndex;
            loadDatahistoryInOut_User();
        }
    }
}