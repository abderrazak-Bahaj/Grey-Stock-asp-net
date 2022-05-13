using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

namespace store_sale_point.admin
{
    public partial class rep_sales_1 : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        DataTable dt = new DataTable();

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
                condition += " and order_master.branch_id ='" + drpBranch_id.SelectedValue + "'";
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

            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT dbo.order_master.order_kind_id, dbo.branch.branch_name, 
            dbo.store.store_name, dbo.order_master.order_master_code, dbo.product.product_name,dbo.order_master.order_master_datecreation,
            dbo.order_details.order_details_quantity,dbo.order_details.order_details_product_price, dbo.unit.unit_name, 
            dbo.order_details.order_details_total_price,dbo.product.product_code FROM dbo.order_details INNER JOIN
                      dbo.order_master INNER JOIN
                      dbo.branch ON dbo.order_master.branch_id = dbo.branch.branch_id INNER JOIN
                      dbo.store ON dbo.order_master.store_id = dbo.store.store_id ON dbo.order_details.order_master_code = dbo.order_master.order_master_code INNER JOIN
                      dbo.product ON dbo.order_details.product_id = dbo.product.product_id INNER JOIN
                      dbo.unit ON dbo.order_details.unit_id = dbo.unit.unit_id
WHERE     (dbo.order_master.order_kind_id = '1')  " + condition + " ", sc);
            
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lbltxt.Text = string.Empty;
                grdSales.DataSource = dt;
                grdSales.DataBind();
                grdSales.FooterRow.Cells[0].Text = "الاجمالى ";
                grdSales.FooterRow.Cells[1].Text = dt.Compute("Count(product_code)", "").ToString();
                grdSales.FooterRow.Cells[5].Text = dt.Compute("Sum(order_details_quantity)", "").ToString();
                grdSales.FooterRow.Cells[6].Text = dt.Compute("Sum(order_details_product_price)", "").ToString();
                grdSales.FooterRow.Cells[7].Text = dt.Compute("Sum(order_details_total_price)", "").ToString();


                show_report();

            }
            else
            {
                lbltxt.Text = "لا توجد بيانات";
                grdSales.DataBind();
            }
        }

        void show_report() {
            ReportViewer1.Reset();

            ReportDataSource rds = new ReportDataSource("DataSet1", dt);
            ReportViewer1.LocalReport.DataSources.Add(rds);
            ReportViewer1.LocalReport.ReportPath = "Reporting/Report1.rdlc";
            ReportParameter [] param = new ReportParameter[]{
            new ReportParameter("branch",drpBranch_id.SelectedValue),new ReportParameter("store",drpStore_id.SelectedValue)
            };
            ReportViewer1.LocalReport.SetParameters(param);
            ReportViewer1.LocalReport.Refresh();
        }
    }
}