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
using System.Web.Services;

namespace store_sale_point.Rpt
{
    public partial class Rpt_Frm : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sql"] != null)
            {
                if (!IsPostBack)
                {
                    SqlDataAdapter sda = new SqlDataAdapter(Session["sql"].ToString(), sc);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    //DataSet ds = new DataSet();
                    Ds ds = new Ds();
                    ds.Tables["Ds_1_Product"].Merge(dt);
                    ReportViewer1.ProcessingMode = ProcessingMode.Local;
                    ReportViewer1.LocalReport.ReportPath = Server.MapPath("rpt_Product.rdlc");
                    ReportDataSource datasource = new ReportDataSource("DataSet1", ds.Tables[0]);
                    ReportViewer1.LocalReport.DataSources.Clear();

                    ReportViewer1.LocalReport.DataSources.Add(datasource);
                }
            }
            else
            {
                Session.Abandon();
            }
        }
        [WebMethod]

        public static void AbandonSession()
        {
            HttpContext.Current.Session.Abandon();
        }
    }
}