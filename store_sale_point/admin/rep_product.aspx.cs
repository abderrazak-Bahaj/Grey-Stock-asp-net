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
    public partial class rep_product : System.Web.UI.Page
    {

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        public string sql;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loaddrpBranch_id();
                divPrint.Visible = false;
            }
        }

        void loaddrpBranch_id()
        {
            string sql = @"select branch_name,branch_id from branch";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(drpBranch_id, sql, name, id);
        }
        void loaddrpStore_id()
        {
            string sql = @"SELECT [store_id] ,[store_name] FROM [store] where branch_id = '" + drpBranch_id.SelectedValue + "'";
            string name = "store_name";
            string id = "store_id";
            showDrpList(drpStore_id, sql, name, id);
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

        protected void drpBranch_id_SelectedIndexChanged(object sender, EventArgs e)
        {
            loaddrpStore_id();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //try
            //{
            divPrint.Visible = true;
            SqlDataAdapter sdaCompany = new SqlDataAdapter(@"select [setting_title],[setting_logo],[setting_phone] from [general_setting]", sc);
            DataTable dtCompany = new DataTable();
            sdaCompany.Fill(dtCompany);
            lblCompanyName.Text = dtCompany.Rows[0]["setting_title"].ToString();
            lblDateNow.Text = " Date : " + DateTime.Now.ToShortDateString() + " Time : " + DateTime.Now.ToShortTimeString();

            string condition = "";

            if (txtCode_Product.Text != "")
            {
                condition += " and product.product_code ='" + txtCode_Product.Text + "'";
            }

            if (drpBranch_id.SelectedItem.Value != "-1")
            {
                condition += " and branch.branch_id ='" + drpBranch_id.SelectedValue + "'";
            }


            if (drpStore_id.SelectedValue != "")
            {
                if (drpStore_id.SelectedItem.Value != "-1")
                {
                    condition += " and product.store_id ='" + drpStore_id.SelectedValue + "'";
                }
            }
            sql = @"SELECT  dbo.store.store_id,dbo.product.product_id,dbo.category.category_name, dbo.store.store_name, dbo.unit.unit_name, dbo.product.product_name, dbo.product.product_code, dbo.product.product_dateadd, 
                      dbo.product.product_barcode, dbo.product.product_img, dbo.product.product_price, dbo.product.product_quantity, dbo.product.store_id, dbo.product.unit_id, 
                      dbo.product.category_id, dbo.branch.branch_name,dbo.store.branch_id
                      FROM dbo.product INNER JOIN
                      dbo.store ON dbo.product.store_id = dbo.store.store_id INNER JOIN
                      dbo.unit ON dbo.product.unit_id = dbo.unit.unit_id INNER JOIN
                      dbo.category ON dbo.product.category_id = dbo.category.category_id INNER JOIN
                      dbo.branch ON dbo.store.branch_id = dbo.branch.branch_id where 1=1 " + condition + " ";
            SqlDataAdapter sda = new SqlDataAdapter(sql, sc);

            Session["sql"] = sql;

            DataTable dt = new DataTable();
            sda.Fill(dt);

            string tr = "";
            int x = 0;
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    x += 1;
                    tr += "<tr> " +
                    "<td>" + x + "</td>" +
                    "<td>" + dr["product_code"].ToString() + "</td>" +
                    "<td>" + dr["product_name"].ToString() + "</td>" +
                    //"<td>" + dr["product_img"].ToString() + "</td>" +
                    "<td> <img src='/Upload/Product/" + dr["product_img"].ToString() + "' width=\"15\" height=\"30\" /></td>" +
                    "<td>" + dr["product_price"].ToString() + "</td>" +
                    "<td>" + dr["product_quantity"].ToString() + "</td>" +
                    "<td>" + QteProduct.product_Quantity(int.Parse(dr["product_id"].ToString()), dr["branch_id"].ToString()) + "</td>" +
                    "<td>" + dr["branch_name"].ToString() + "</td>" +
                    "<td>" + dr["store_name"].ToString() + "</td>" +
                    "<td>" + dr["unit_name"].ToString() + "</td>" +
                    "<td>" + dr["category_name"].ToString() + "</td>" +
                    "</tr>";


                }
                trBody.InnerHtml = tr;
                trBody.DataBind();

                lbltxt.Text = "الاجمالى";
                lblCount.Text = dt.Rows.Count.ToString();
                LinkButton2.Visible = true;
            }
            else
            {
                trBody.InnerText = "لايوجد بيانات";
                trBody.DataBind();
                lbltxt.Text = "لايوجد بيانات";
                lblCount.Text = "";
                LinkButton2.Visible = false;
                
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            //Session["sql"] = sql;
            Page.RegisterStartupScript("msg", "<script>window.open('../Rpt/Rpt_Frm.aspx','myWin','toolbar=0, directories=no, location=no, status=no, menubar=no,scrollbars=no, resizable=yes, copyhistory=no, width=500, height=600, top=top, left=left');</script>");

        }
    }
}