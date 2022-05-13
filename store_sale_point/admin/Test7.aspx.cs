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
    public partial class Test7 : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                loadData();
                loaddrp();
            }
        }
        void loadData() {
            SqlDataAdapter sda = new SqlDataAdapter(@"select id,ContactName,City from TestCustomer", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        void loaddrp() {
            DropDownList drop = (GridView1.HeaderRow.FindControl("drpId") as DropDownList);
            string sql = "select DISTINCT(id) from TestCustomer";
            string name = "id";
            string id = "id";
            showDrpList(drop, sql, name, id);
        }

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
        protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            loadData();
        }

        protected void drpId_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList drop = (GridView1.HeaderRow.FindControl("drpId") as DropDownList);
            SqlDataAdapter sda = new SqlDataAdapter(@"select * from TestCustomer where id = '" + drop.SelectedValue + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            loaddrp();
            
        }
    }
}