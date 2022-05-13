using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;

namespace store_sale_point.admin
{
    public partial class POS : System.Web.UI.Page
    {
        string SearchString = "";

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        DataTable dtcart = new DataTable();
        DataRow drcart;
        public string order_master_code;
        float order_master_total_price = 0;


        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

            if (!IsPostBack)
            {
                txtorder_master_dicount.Text = "0";
                txtorder_master_tax.Text = "0";
                txtuser_id.Enabled = false;

                showDtCategory();
                Session["addtocart"] = null;
                tblOrderMaster.Visible = false;
                tblPrint.Visible = false;

                loadDatadrppayment_id();
                drppayment_id.SelectedValue = "1";


                loadbranchId();
                drpbranch_id.SelectedValue = AllUsers.branchSession().ToString();
                drpbranch_id.Enabled = false;

                loaddrpStore_id();

                loadDataCustomer();
                Label1.Visible = false;
                findorderid();
            }
        }

        void loaddrpStore_id()
        {
            string sql = @"SELECT [store_id] ,[store_name] FROM [store] where branch_id = '" + drpbranch_id.SelectedValue + "'";
            string name = "store_name";
            string id = "store_id";
            showDrpList(drpstore_id, sql, name, id);
        }

        void showDtCategory()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select category_id,category_name from category", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dtCategory.DataSource = dt;
            dtCategory.DataBind();

        }

        void showProduct(string catId)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select product_id,product_name,product_code,product_barcode,
                                 product_img,product_price,category_id,store_id,unit_id,product_quantity
                                 from product where category_id='" + catId + "' ", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dtProduct.DataSource = dt;
            dtProduct.DataBind();

        }

        protected void dtCategory_ItemCommand(object source, DataListCommandEventArgs e)
        {
            dtCategory.SelectedIndex = e.Item.ItemIndex;
            string lblCat = (dtCategory.SelectedItem.FindControl("lblCat") as Label).Text;
            showProduct(lblCat);

        }

        protected void dtProduct_ItemCommand(object source, DataListCommandEventArgs e)
        {

            dtProduct.SelectedIndex = e.Item.ItemIndex;
            string lblProduct = (dtProduct.SelectedItem.FindControl("lblProduct") as Label).Text;

            SqlDataAdapter sdr1 = new SqlDataAdapter(@"select product_name from product where product_id = '" + lblProduct + "'", sc);
            DataTable dt1 = new DataTable();
            sdr1.Fill(dt1);
            string name = dt1.Rows[0]["product_name"].ToString();

            SqlDataAdapter sdr2 = new SqlDataAdapter(@"select product_price from product where product_id = '" + lblProduct + "'", sc);
            DataTable dt2 = new DataTable();
            sdr2.Fill(dt2);
            string price = dt2.Rows[0]["product_price"].ToString();

            string exsit = "0";

            foreach (GridViewRow rows in grdcart.Rows)
            {
                Label check_lblproduct_id = (rows.FindControl("lblproduct_id") as Label);

                if (check_lblproduct_id.Text == lblProduct)
                {
                    exsit = "1";
                }
            }
            if (exsit == "0")
            {
                int qte = QteProduct.product_Quantity(int.Parse(lblProduct), drpbranch_id.SelectedValue);
                if (qte > 1)
                {
                    addTocart(int.Parse(lblProduct), name, 1, float.Parse(price));
                }
                else
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert(' كمية " + name.ToString() + " هى " + qte + " الموجودة بالمستودع ')", true);

                }

            }
            if (grdcart.Rows.Count > 0)
            {
                grdcart.FooterRow.Cells[4].Text = "الاجمـالى";
                grdcart.FooterRow.Cells[5].Text = grandtotal().ToString();
                txttotalPrice.Text = grandtotal().ToString();

                if (txtorder_master_dicount.Text != string.Empty)
                {

                    if (CheckBox1.Checked == true)
                    {
                        decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                        decimal x = grandtotal();
                        decimal y = x * (txt / 100);
                        decimal res = x - y;
                        txttotalPrice.Text = res.ToString();
                    }
                    else
                    {
                        decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                        decimal x = grandtotal();
                        decimal res = x - txt;
                        txttotalPrice.Text = res.ToString();
                    }
                }

                if (txtorder_master_tax.Text != string.Empty)
                {

                    decimal txt = decimal.Parse(txtorder_master_tax.Text);
                    decimal x = decimal.Parse(txttotalPrice.Text);
                    decimal y = x * (txt / 100);
                    decimal result = x + y;
                    txttotalPrice.Text = (result).ToString();
                }


            }
            tblOrderMaster.Visible = true;
            Label1.Visible = true;
        }

        public decimal grandtotal()
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["addtocart"];
            int nrow = dt.Rows.Count;
            int i = 0;
            decimal gtotal = 0;
            while (i < nrow)
            {
                gtotal = gtotal + Convert.ToDecimal(dt.Rows[i]["total_price"].ToString());

                i = i + 1;
            }

            return gtotal;
        }

        void addTocart(int product_id, string product_name, int product_quantity, float product_price)
        {
            if (Session["addtocart"] == null)
            {
                dtcart.Columns.Add("product_id").GetType();
                dtcart.Columns.Add("product_name").GetType();
                dtcart.Columns.Add("product_quantity").GetType();
                dtcart.Columns.Add("product_price").GetType();
                dtcart.Columns.Add("total_price").GetType();

                drcart = dtcart.NewRow();

                drcart["product_id"] = product_id;
                drcart["product_name"] = product_name;
                drcart["product_quantity"] = product_quantity;
                drcart["product_price"] = product_price;
                drcart["total_price"] = Convert.ToString(float.Parse(product_price.ToString()) * int.Parse(product_quantity.ToString()));
                dtcart.Rows.Add(drcart);
                Session["addtocart"] = dtcart;
            }
            else
            {
                dtcart = (DataTable)Session["addtocart"];
                drcart = dtcart.NewRow();
                drcart["product_id"] = product_id;
                drcart["product_name"] = product_name;
                drcart["product_quantity"] = product_quantity;
                drcart["product_price"] = product_price;
                drcart["total_price"] = Convert.ToString(float.Parse(product_price.ToString()) * int.Parse(product_quantity.ToString()));
                dtcart.Rows.Add(drcart);
                Session["addtocart"] = dtcart;
            }
            grdcart.DataSource = dtcart;
            grdcart.DataBind();
        }

        protected void grdcart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            dtcart = (DataTable)Session["addtocart"];
            dtcart.Rows[e.RowIndex].Delete();
            Session["addtocart"] = dtcart;
            grdcart.DataSource = dtcart;
            grdcart.DataBind();

            grdcart.FooterRow.Cells[4].Text = "الاجمـالى";
            grdcart.FooterRow.Cells[5].Text = grandtotal().ToString();
            txttotalPrice.Text = grandtotal().ToString();

            if (txtorder_master_dicount.Text != string.Empty)
            {

                if (CheckBox1.Checked == true)
                {
                    decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                    decimal x = grandtotal();
                    decimal y = x * (txt / 100);
                    decimal res = x - y;
                    txttotalPrice.Text = res.ToString();
                }
                else
                {
                    decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                    decimal x = grandtotal();
                    decimal res = x - txt;
                    txttotalPrice.Text = res.ToString();
                }
            }


            if (txtorder_master_tax.Text != string.Empty)
            {

                decimal txt = decimal.Parse(txtorder_master_tax.Text);
                decimal x = decimal.Parse(txttotalPrice.Text);
                decimal y = x * (txt / 100);
                decimal result = x + y;
                txttotalPrice.Text = (result).ToString();
            }

        }

        protected void txtproduct_quantity_TextChanged(object sender, EventArgs e)
        {
            int x = 0;
            foreach (GridViewRow rows in grdcart.Rows)
            {
                Label check_lblproduct_id = (rows.FindControl("lblproduct_id") as Label);
                Label lblproduct_name = (rows.FindControl("lblproduct_name") as Label);
                TextBox txt = (rows.FindControl("txtproduct_quantity") as TextBox);
                Label lblproduct_price = (rows.FindControl("lblproduct_price") as Label);
                Label lblTotal = (rows.FindControl("lblTotal") as Label);

                int quantity = 0;
                int.TryParse(txt.Text, out quantity);

                int qte = QteProduct.product_Quantity(int.Parse(check_lblproduct_id.Text), drpbranch_id.SelectedValue);

                if (qte < quantity)
                {
                    //Label2.Text = "  " + lblproduct_name.Text + " تكون " + qte;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert(' كمية " + lblproduct_name.Text.ToString() + " هى " + qte + " الموجودة بالمستودع ')", true);

                }
                else
                {
                    lblTotal.Text = (int.Parse(txt.Text) * float.Parse(lblproduct_price.Text)).ToString();
                    x = int.Parse(txt.Text);
                    txt.Text = x.ToString();
                }
            }

        }

        protected void grdcart_RowDataBound(object sender, GridViewRowEventArgs e)
        {


            //for (int i = 0; i < grdcart.Rows.Count; i++)
            //{
            //    int qty = Convert.ToInt32(grdcart.Rows[i].Cells[3].ToString());
            //    int rate = Convert.ToInt32(grdcart.Rows[i].Cells[4].ToString());

            //    int total = qty * rate;
            //    grdcart.Rows[i].Cells[5].Text = total.ToString();

            //}
        }

        void insertorder_master()
        {
            order_master_code = Label1.Text;
            int branch_id = int.Parse(AllUsers.branchSession().ToString());
            int store_id = int.Parse(drpstore_id.SelectedValue);
            DateTime order_master_datecreation = DateTime.Now;
            float order_master_dicount = float.Parse(txtorder_master_dicount.Text);
            float order_master_tax = float.Parse(txtorder_master_tax.Text);
            int order_master_houre = int.Parse(DateTime.Now.Hour.ToString());
            int emp_id = int.Parse(AllUsers.usersSession().ToString());
            int user_id = int.Parse(txtuser_id.Text);
            float.TryParse(txttotalPrice.Text, out order_master_total_price);
            int payment_id = int.Parse(drppayment_id.SelectedValue);
            int order_kind_id = 1;
            sc.Open();
            SqlCommand cmd = new SqlCommand(@"INSERT INTO order_master(order_master_code,branch_id
           ,order_master_datecreation,order_master_dicount,order_master_tax,order_master_houre
           ,user_id,emp_id,order_master_total_price,payment_id,store_id,order_kind_id)VALUES(@order_master_code,@branch_id,@order_master_datecreation,
            @order_master_dicount,@order_master_tax,@order_master_houre,@user_id,@emp_id,@order_master_total_price,@payment_id,@store_id,@order_kind_id)", sc);
            cmd.Parameters.AddWithValue("@order_master_code", order_master_code);
            cmd.Parameters.AddWithValue("@branch_id", branch_id);
            cmd.Parameters.AddWithValue("@order_master_datecreation", order_master_datecreation);
            cmd.Parameters.AddWithValue("@order_master_dicount", order_master_dicount);
            cmd.Parameters.AddWithValue("@order_master_tax", order_master_tax);
            cmd.Parameters.AddWithValue("@order_master_houre", order_master_houre);
            cmd.Parameters.AddWithValue("@emp_id", emp_id);
            cmd.Parameters.AddWithValue("@user_id", user_id);
            cmd.Parameters.AddWithValue("@order_master_total_price", order_master_total_price);
            cmd.Parameters.AddWithValue("@payment_id", payment_id);
            cmd.Parameters.AddWithValue("@store_id", store_id);
            cmd.Parameters.AddWithValue("@order_kind_id", order_kind_id);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            txtCustomerName.Text = "";
            txtorder_master_dicount.Text = "0";
            txtorder_master_tax.Text = "0";
            txttotalPrice.Text = "";
        }

        void insertorder_details()
        {
            if (grdcart.Rows.Count > 0)
            {
                order_master_code = Label1.Text;
                foreach (GridViewRow grd in grdcart.Rows)
                {

                    int product_id = int.Parse((grd.FindControl("lblproduct_id") as Label).Text);
                    int order_details_quantity = int.Parse(((TextBox)grd.FindControl("txtproduct_quantity")).Text);
                    SqlDataAdapter sda = new SqlDataAdapter(@"select unit_id from product where product_id='" + product_id + "'", sc);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    int unit_id = int.Parse(dt.Rows[0]["unit_id"].ToString());
                    float order_details_product_price = float.Parse((grd.FindControl("lblproduct_price") as Label).Text);
                    float order_details_total_price = float.Parse((grd.FindControl("lblTotal") as Label).Text); ;

                    SqlDataAdapter sdainsertorderDetails = new SqlDataAdapter(@"INSERT INTO order_details
                    (order_master_code,product_id,order_details_quantity
                    ,unit_id,order_details_product_price,order_details_total_price)
                    VALUES ('" + order_master_code + "','" + product_id + "','" + order_details_quantity + "','" + unit_id + "','" + order_details_product_price + "','" + order_details_total_price + "')", sc);
                    DataTable dtinsertorderDetails = new DataTable();
                    sdainsertorderDetails.Fill(dtinsertorderDetails);

                }
            }
        }

        public void findorderid()
        {
            String pass = "abcdefghijklmnopqrstuvwxyz123456789";
            Random r = new Random();

            char[] mypass = new char[5];
            for (int i = 0; i < 5; i++)
            {
                mypass[i] = pass[(int)(35 * r.NextDouble())];
            }
            String orderid;
            orderid = "OS-" + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + new string(mypass);
            Label1.Text = orderid.ToString();
        }

        void loadbranchId()
        {
            string sql = @"select branch_id,branch_name from branch";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(drpbranch_id, sql, name, id);
        }

        void loadDatadrppayment_id()
        {
            string sql = @"select payment_id,payment_name from method_pay";
            string name = "payment_name";
            string id = "payment_id";
            showDrpList(drppayment_id, sql, name, id);
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

        protected void grdCustomer_PageIndexChanged(object sender, EventArgs e)
        {

        }

        protected void grdCustomer_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdCustomer.PageIndex = e.NewPageIndex;
            grdCustomer.SelectedIndex = -1;
            loadDataCustomer();
            upModal.Update();
        }

        protected void grdCustomer_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void grdCustomer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.style.cursor='hand';this.style.backgroundColor='yellow'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='white'");
            }
        }

        protected void grdCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {

            ViewState["idd"] = (grdCustomer.SelectedRow.FindControl("lbluser_id") as Label).Text;
            ViewState["named"] = (grdCustomer.SelectedRow.FindControl("lbluser_fullname") as Label).Text;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePopup", "$('#confirmCustomers').modal('hide')", true);
            txtuser_id.Text = ViewState["idd"].ToString();
            txtCustomerName.Text = ViewState["named"].ToString();
            UpdatePanel1.Update();

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;
            loadDataCustomer();
        }

        void loadDataCustomer()
        {
            //SqlDataAdapter sda = new SqlDataAdapter("select user_id,user_fullname,user_phone,user_email,user_address from all_users where (user_fullname+user_phone+user_email+user_address like '%" + txtSearch.Text + "%') order by user_fullname", sc);
            SqlDataAdapter sda = new SqlDataAdapter("select user_id,user_fullname,user_phone,user_email,user_address from all_users where user_fullname+user_phone+user_email+user_address like '%" + txtSearch.Text + "%'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdCustomer.DataSource = dt;
            grdCustomer.DataBind();
        }

        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            sc.Open();
            SqlCommand cmd = new SqlCommand(@"INSERT INTO [all_users]([user_fullname],[user_phone],[user_email],[user_kind_id])VALUES(@user_fullname,@user_phone,@user_email,@user_kind_id);", sc);
            cmd.Parameters.AddWithValue("@user_fullname", txtadduser_fullname.Text);
            cmd.Parameters.AddWithValue("@user_email", txtadduser_email.Text);
            cmd.Parameters.AddWithValue("@user_kind_id", "3");
            cmd.Parameters.AddWithValue("@user_phone", txtadduser_phone.Text);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            sc.Close();

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Inserted Data !')", true);

            SqlDataAdapter sdagetid = new SqlDataAdapter("select user_id from all_users where user_fullname='" + txtadduser_fullname.Text + "' and user_phone='" + txtadduser_phone.Text + "'", sc);
            DataTable dtgetid = new DataTable();
            sdagetid.Fill(dtgetid);
            if (dtgetid.Rows.Count > 0)
            {
                txtuser_id.Text = dtgetid.Rows[0]["user_id"].ToString();
                txtCustomerName.Text = txtadduser_fullname.Text;
            }
            txtadduser_email.Text = string.Empty;
            txtadduser_phone.Text = string.Empty;
            txtadduser_fullname.Text = string.Empty;

            ClientScript.RegisterStartupScript(this.GetType(), "Close", "add_Customer();", true);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtCustomerName.Text != string.Empty && drpstore_id.SelectedValue != "-1")
            {

                insertorder_master();
                insertorder_details();
                //grdcart.DataSource = null;
                //grdcart.DataBind();
                //ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "clentscript", "alert('Data Inserted Success !'); parent.location.href='Pos.aspx'", true);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Inserted Data !')", true);

                tblPrint.Visible = true;
                loadDatagrdPrint(Label1.Text);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert(' من فضلك ادخل العميل و المخزن المنصرف منه !')", true);
                return;
            }

        }

        void loadDatagrdPrint(string id)
        {

            SqlDataAdapter sdadetails = new SqlDataAdapter(@"SELECT dbo.unit.unit_name,dbo.order_details.product_id,
            dbo.product.product_name,dbo.order_details.order_details_total_price, dbo.order_details.order_details_product_price, 
            dbo.order_details.order_details_quantity, dbo.order_details.order_master_code, dbo.order_details.order_details_id
            FROM dbo.order_details INNER JOIN
                      dbo.product ON dbo.order_details.product_id = dbo.product.product_id INNER JOIN
                      dbo.unit ON dbo.order_details.unit_id = dbo.unit.unit_id 
            where dbo.order_details.order_master_code = '" + id + "'", sc);
            DataTable dt = new DataTable();
            sdadetails.Fill(dt);
            grdPrint.DataSource = dt;
            grdPrint.DataBind();

            SqlDataAdapter sdamaster = new SqlDataAdapter(@"SELECT dbo.order_master.order_master_code, 
            dbo.order_master.branch_id, dbo.order_master.order_master_datecreation,
            dbo.order_master.order_master_dicount,dbo.order_master.order_master_tax, dbo.order_master.order_master_houre,
            dbo.all_users.user_name, dbo.order_master.user_id, dbo.all_users.user_fullname,dbo.order_master.emp_id,
            dbo.order_master.order_master_total_price, dbo.order_master.payment_id, dbo.branch.branch_name 
            FROM dbo.order_master INNER JOIN
                      dbo.all_users ON dbo.order_master.user_id = dbo.all_users.user_id INNER JOIN
                      dbo.branch ON dbo.order_master.branch_id = dbo.branch.branch_id 
            where dbo.order_master.order_master_code = '" + id + "'", sc);
            DataTable dt2s = new DataTable();
            sdamaster.Fill(dt2s);
            lblorder_master_code.Text = dt2s.Rows[0]["order_master_code"].ToString();
            lblorder_master_houre.Text = dt2s.Rows[0]["order_master_houre"].ToString();
            lblorder_master_datecreation.Text = dt2s.Rows[0]["order_master_datecreation"].ToString();
            lbluser_fullname.Text = dt2s.Rows[0]["user_fullname"].ToString();
            lblorder_master_tax.Text = dt2s.Rows[0]["order_master_tax"].ToString();
            lblorder_master_dicount.Text = dt2s.Rows[0]["order_master_dicount"].ToString();
            lblorder_master_total_price.Text = dt2s.Rows[0]["order_master_total_price"].ToString();
            lbluser_name.Text = dt2s.Rows[0]["user_name"].ToString();
            lblbranch_name.Text = dt2s.Rows[0]["branch_name"].ToString();
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {



        }

        protected void txtorder_master_tax_TextChanged(object sender, EventArgs e)
        {
            decimal txt = decimal.Parse(txtorder_master_tax.Text);
            decimal x = decimal.Parse(txttotalPrice.Text);
            decimal y = x * (txt / 100);
            decimal result = x + y;
            txttotalPrice.Text = (result).ToString();
        }

        protected void txttotalPrice_TextChanged(object sender, EventArgs e)
        {
        }

        protected void txtorder_master_dicount_TextChanged(object sender, EventArgs e)
        {
            if (CheckBox1.Checked == true)
            {
                decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                decimal x = grandtotal();
                decimal y = x * (txt / 100);
                decimal res = x - y;
                txttotalPrice.Text = res.ToString();
            }
            else
            {
                decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                decimal x = grandtotal();
                decimal res = x - txt;
                txttotalPrice.Text = res.ToString();
            }
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox1.Checked == true)
            {
                decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                decimal x = grandtotal();
                decimal y = x * (txt / 100);
                decimal res = x - y;
                txttotalPrice.Text = res.ToString();
            }
            else
            {
                decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                decimal x = grandtotal();
                decimal res = x - txt;
                txttotalPrice.Text = res.ToString();
            }
        }

        protected void btnNewOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("POS.aspx");
        }
    }
}