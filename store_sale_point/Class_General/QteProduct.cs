using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


//namespace store_sale_point.Class_General
//{
public class QteProduct
{

    static public int product_Quantity(int product_id, string branch_id)
    {

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());
        SqlDataAdapter sda;
        DataTable dt;

        // STORE - IN 

        // رصيد اول المدة
        sda = new SqlDataAdapter(@" select sum(product_quantity) as qte from product where product_id='" + product_id + "' and store_id in (select store_id from store where branch_id ='" + branch_id + "' )", sc);
        dt = new DataTable();
        sda.Fill(dt);
        string sqlProduct_Qunatity = dt.Rows[0]["qte"].ToString();
        int quantity_first = 0;
        int.TryParse(sqlProduct_Qunatity, out quantity_first);

        // المشتريات
        sda = new SqlDataAdapter(@"SELECT sum(dbo.order_details.order_details_quantity) as qte FROM dbo.order_master INNER JOIN
        dbo.order_details ON dbo.order_master.order_master_code = dbo.order_details.order_master_code
        where order_master.order_kind_id='2' and order_details.product_id = '" + product_id + "' and order_master.branch_id = '" + branch_id + "'", sc);
        dt = new DataTable();
        sda.Fill(dt);
        string sqlpurchase = dt.Rows[0]["qte"].ToString();
        int purchase = 0;
        int.TryParse(sqlpurchase, out purchase);

        //  مردود المبيعات
        sda = new SqlDataAdapter(@"SELECT sum(dbo.order_details.order_details_quantity) as qte FROM dbo.order_master INNER JOIN
        dbo.order_details ON dbo.order_master.order_master_code = dbo.order_details.order_master_code
        where order_master.order_kind_id='3' and order_details.product_id = '" + product_id + "' and order_master.branch_id = '" + branch_id + "'", sc);
        dt = new DataTable();
        sda.Fill(dt);
        string sqlsalesBack = dt.Rows[0]["qte"].ToString();
        int salesBack = 0;
        int.TryParse(sqlsalesBack, out salesBack);


        // STORE - OUT

        // المبيعات
        sda = new SqlDataAdapter(@"SELECT sum(dbo.order_details.order_details_quantity) as qte FROM dbo.order_master INNER JOIN
        dbo.order_details ON dbo.order_master.order_master_code = dbo.order_details.order_master_code
        where order_master.order_kind_id='1' and order_details.product_id = '" + product_id + "' and order_master.branch_id = '" + branch_id + "'", sc);
        dt = new DataTable();
        sda.Fill(dt);
        string sqlsales = dt.Rows[0]["qte"].ToString();
        int sales = 0;
        int.TryParse(sqlsales, out sales);


        // مردود المشتريات
        sda = new SqlDataAdapter(@"SELECT sum(dbo.order_details.order_details_quantity) as qte FROM dbo.order_master INNER JOIN
        dbo.order_details ON dbo.order_master.order_master_code = dbo.order_details.order_master_code
        where order_master.order_kind_id='4' and order_details.product_id = '" + product_id + "' and order_master.branch_id = '" + branch_id + "'", sc);
        dt = new DataTable();
        sda.Fill(dt);
        string sqlpurchaseBack = dt.Rows[0]["qte"].ToString();
        int purchaseBack = 0;
        int.TryParse(sqlpurchaseBack, out purchaseBack);

        // CALC STORE
        int qunatity_in = quantity_first + purchase + salesBack;
        int qunatity_out = sales + purchaseBack;
        int quantity_now = qunatity_in - qunatity_out;
        return quantity_now;
    }
}
//}