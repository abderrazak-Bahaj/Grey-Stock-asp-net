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
    public partial class rep_Dialy_sales : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loaddrpBranch_id();
                loadpayment_id();
                divPrint.Visible = false;
            }
        }

        void loadpayment_id()
        {
            string sql = @"select payment_name,payment_id from method_pay";
            string name = "payment_name";
            string id = "payment_id";
            showDrpList(drppayment_id, sql, name, id);
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


            divPrint.Visible = true;
            SqlDataAdapter sdaCompany = new SqlDataAdapter(@"select [setting_title],[setting_logo],[setting_phone] from [general_setting]", sc);
            DataTable dtCompany = new DataTable();
            sdaCompany.Fill(dtCompany);
            lblCompanyName.Text = dtCompany.Rows[0]["setting_title"].ToString();
            lblDateNow.Text = " Date : " + DateTime.Now.ToShortDateString() + " Time : " + DateTime.Now.ToShortTimeString();

            string condition = "";



            if (drpBranch_id.SelectedItem.Value != "-1")
            {
                condition += " and order_master.branch_id ='" + drpBranch_id.SelectedValue + "'";
            }

            if (drppayment_id.SelectedValue != "")
            {
                if (drppayment_id.SelectedItem.Value != "-1")
                {
                    condition += " and order_master.payment_id ='" + drppayment_id.SelectedValue + "'";
                }
            }

            if (drpStore_id.SelectedValue != "")
            {
                if (drpStore_id.SelectedItem.Value != "-1")
                {
                    condition += " and order_master.store_id ='" + drpStore_id.SelectedValue + "'";
                }
            }

            if (txtDateFrom.Text != "" && txtDateTo.Text != "")
            {
                condition += " and order_master.order_master_datecreation between Convert(DateTime,'" + txtDateFrom.Text + "',101) AND Convert(DateTime,'" + txtDateTo.Text + "',101)";
            }

            if (txtInvoiceSales.Text != "")
            {
                condition += " and order_master.order_master_code ='" + txtInvoiceSales.Text + "'";
            }

            //if (txtDateFrom.Text != "")
            //{

            //    string toDay = Convert.ToDateTime(txtDateFrom.Text).Day.ToString();
            //    string toMonth = Convert.ToDateTime(txtDateFrom.Text).Month.ToString();
            //    string toYear = Convert.ToDateTime(txtDateFrom.Text).Year.ToString();
            //    string dateTxt = toMonth + "-" + toDay + "-" + toYear;

            //    condition += " and order_master.order_master_datecreation >='" + dateTxt + "'";
            //}

            //if (txtDateTo.Text != "")
            //{

            //    string toDay = Convert.ToDateTime(txtDateTo.Text).Day.ToString();
            //    string toMonth = Convert.ToDateTime(txtDateTo.Text).Month.ToString();
            //    string toYear = Convert.ToDateTime(txtDateTo.Text).Year.ToString();
            //    string dateTxt = toMonth + "-" + toDay + "-" + toYear;

            //    condition += " and order_master.order_master_datecreation <='" + dateTxt + "'";
            //}

            //if (txtDateFrom.Text != "" && txtDateTo.Text != "")
            //{
            //    condition += " and order_master.order_master_datecreation >='" + txtDateFrom.Text + "' and order_master.order_master_datecreation <='" + txtDateTo.Text + "'";
            //}

            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT dbo.order_master.order_master_code,
            dbo.order_master.branch_id, dbo.order_master.store_id, dbo.order_master.order_master_datecreation, 
            dbo.order_master.order_master_total_price, dbo.order_master.payment_id, dbo.order_master.order_kind_id, 
            dbo.branch.branch_name, dbo.store.store_name, dbo.method_pay.payment_name
            FROM dbo.order_master INNER JOIN
            dbo.branch ON dbo.order_master.branch_id = dbo.branch.branch_id INNER JOIN
            dbo.store ON dbo.order_master.store_id = dbo.store.store_id INNER JOIN
            dbo.method_pay ON dbo.order_master.payment_id = dbo.method_pay.payment_id
            WHERE (dbo.order_master.order_kind_id = 1)  " + condition + " ", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lbltxt.Text = string.Empty;
                grdSales.DataSource = dt;
                grdSales.DataBind();
                grdSales.FooterRow.Cells[0].Text = "الاجمالى ";
                grdSales.FooterRow.Cells[1].Text = dt.Compute("Count(order_master_code)", "").ToString();
                grdSales.FooterRow.Cells[6].Text = dt.Compute("Sum(order_master_total_price)", "").ToString();
            }
            else
            {
                lbltxt.Text = "لا توجد بيانات";
                grdSales.DataBind();
            }
        }
    }
}