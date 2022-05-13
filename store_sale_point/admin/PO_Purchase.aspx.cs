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
    public partial class PO_Purchase : System.Web.UI.Page
    {
        string SearchString = "";

        public string order_master_code;

        float order_master_total_price = 0;

        DataTable dtCart = new DataTable();
        DataRow drCart;

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtSearch.Attributes.Add("onkeyup", "setTimeout('__doPostBack(\\'" + txtSearch.ClientID.Replace("_", "$") + "\\',\\'\\')', 0);");

                loadcategory();

                //load Branch
                loadbranch();
                Drpbranch_id.SelectedValue = AllUsers.branchSession();
                Drpbranch_id.Enabled = false;

                loadStore();

                loadEmp_id();
                Drpemp_id.SelectedValue = AllUsers.usersSession();
                Drpemp_id.Enabled = false;

                loadmethod_pay();
                Drppayment_id.SelectedIndex = 1;


                loadDataSupplier();

                Session["addToCart"] = null;

                findorderid();

                Label1.Visible = false;
                TblMatser.Visible = false;
                tblPrint.Visible = false;

                btnPrint.Enabled = false;

                txtorder_master_dicount.Text = "0";
                txtorder_master_tax.Text = "0";
            }
        }


        protected void dtcategory_ItemCommand(object source, DataListCommandEventArgs e)
        {
            dtcategory.SelectedIndex = e.Item.ItemIndex;
            string category_id = (dtcategory.SelectedItem.FindControl("lblcategory_id") as Label).Text;

            loadproduct(category_id);
        }

        protected void dtproduct_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Label1.Visible = true;
            dtproduct.SelectedIndex = e.Item.ItemIndex;
            string product_id = (dtproduct.SelectedItem.FindControl("lblproduct_id") as Label).Text;

            string name = getProductName(product_id);
            string price = getProductPrice(product_id);

            int exist = 0;
            // اما هنا بيدور على المنتج فى الجريد فيو لو لقاه مش بيضيفة تانى بيزود عدده فقط 
            foreach (GridViewRow row in grdCart.Rows)
            {
                Label lblproduct_id = (Label)row.FindControl("lblproduct_id");

                TextBox txtproduct_quantity = (TextBox)row.FindControl("txtproduct_quantity");

                TextBox txtproduct_price = (TextBox)row.FindControl("txtproduct_price");

                if (lblproduct_id.Text == product_id)
                {
                    txtproduct_quantity.Text = (int.Parse(txtproduct_quantity.Text) + 1).ToString();

                    exist = 1;

                    (row.FindControl("txtproduct_quantity") as TextBox).Text = txtproduct_quantity.Text;

                    // بيضرب العدد فى السعر عشان يجيبلى الاجمالى
                    (row.FindControl("lblTotal") as Label).Text = (int.Parse(txtproduct_quantity.Text) * float.Parse(txtproduct_price.Text)).ToString();


                }

            }
            //اضافة المنتج فى حالة ان هو غير موجود فى الجريد فيو
            if (exist == 0)
            {
                add_to_Cart(int.Parse(product_id), name, float.Parse(price), 1);
            }
            // الجمع التلقائى فى حالة اضافة منتجات مختلفه
            if (grdCart.Rows.Count > 0)
            {
                grdCart.FooterRow.Cells[4].Text = "الاجمـالى";
                grdCart.FooterRow.Cells[5].Text = grandtotal().ToString();

            }


            //الجمع التلقائى فى جالة اضغط كذا مرة على المنتج 
            decimal xs = 0;
            decimal ss = 0;
            foreach (GridViewRow rows in grdCart.Rows)
            {
                Label lblTotal = (rows.FindControl("lblTotal") as Label);

                xs = decimal.Parse(lblTotal.Text);

                ss = ss + xs;

                grdCart.FooterRow.Cells[4].Text = "الاجمـالى";
                grdCart.FooterRow.Cells[5].Text = ss.ToString();

                ///////////////////////////

                if (txtorder_master_dicount.Text != string.Empty)
                {

                    if (CheckBox1.Checked == true)
                    {
                        decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                        decimal x = grandtotal();
                        decimal y = x * (txt / 100);
                        decimal res = x - y;
                        txtorder_master_total_price.Text = res.ToString();
                    }
                    else
                    {
                        decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                        decimal x = grandtotal();
                        decimal res = x - txt;
                        txtorder_master_total_price.Text = res.ToString();
                    }
                }

                if (txtorder_master_tax.Text != string.Empty)
                {

                    decimal txt = decimal.Parse(txtorder_master_tax.Text);
                    decimal x = decimal.Parse(txtorder_master_total_price.Text);
                    decimal y = x * (txt / 100);
                    decimal result = x + y;
                    txtorder_master_total_price.Text = (result).ToString();
                }
                txtorder_master_total_price.Text = grdCart.FooterRow.Cells[5].Text;
            }
            TblMatser.Visible = true;



            //////////////////


        }

        protected void grdCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            grdCart.Columns[1].Visible = false;
        }

        protected void grdCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            dtCart = Session["addToCart"] as DataTable;
            dtCart.Rows[e.RowIndex].Delete();
            Session["addToCart"] = dtCart;
            grdCart.DataSource = dtCart;
            grdCart.DataBind();

            grdCart.FooterRow.Cells[4].Text = "الاجمـالى";
            grdCart.FooterRow.Cells[5].Text = grandtotal().ToString();


            if (txtorder_master_dicount.Text != string.Empty)
            {

                if (CheckBox1.Checked == true)
                {
                    decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                    decimal x = grandtotal();
                    decimal y = x * (txt / 100);
                    decimal res = x - y;
                    txtorder_master_total_price.Text = res.ToString();
                }
                else
                {
                    decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                    decimal x = grandtotal();
                    decimal res = x - txt;
                    txtorder_master_total_price.Text = res.ToString();
                }
            }


            if (txtorder_master_tax.Text != string.Empty)
            {

                decimal txt = decimal.Parse(txtorder_master_tax.Text);
                decimal x = decimal.Parse(txtorder_master_total_price.Text);
                decimal y = x * (txt / 100);
                decimal result = x + y;
                txtorder_master_total_price.Text = (result).ToString();
            }

        }
        public decimal grandtotal()
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["addToCart"];
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

        protected void txtproduct_quantity_TextChanged(object sender, EventArgs e)
        {
            int x = 0;

            foreach (GridViewRow rows in grdCart.Rows)
            {
                Label check_lblproduct_id = (rows.FindControl("lblproduct_id") as Label);

                TextBox txtproduct_quantity = (rows.FindControl("txtproduct_quantity") as TextBox);
                TextBox txtproduct_price = (rows.FindControl("txtproduct_price") as TextBox);
                Label lblTotal = (rows.FindControl("lblTotal") as Label);

                lblTotal.Text = (int.Parse(txtproduct_quantity.Text) * float.Parse(txtproduct_price.Text)).ToString();
                x = int.Parse(txtproduct_quantity.Text);
                txtproduct_quantity.Text = x.ToString();

            }

            decimal xs = 0;
            decimal ss = 0;
            foreach (GridViewRow rows in grdCart.Rows)
            {
                Label lblTotal = (rows.FindControl("lblTotal") as Label);

                xs = decimal.Parse(lblTotal.Text);

                ss = ss + xs;

                grdCart.FooterRow.Cells[4].Text = "الاجمـالى";
                grdCart.FooterRow.Cells[5].Text = ss.ToString();
            }
            txtorder_master_total_price.Text = grdCart.FooterRow.Cells[5].Text;
        }

        protected void txtproduct_price_TextChanged(object sender, EventArgs e)
        {
            int x = 0;

            foreach (GridViewRow rows in grdCart.Rows)
            {
                Label check_lblproduct_id = (rows.FindControl("lblproduct_id") as Label);

                TextBox txtproduct_quantity = (rows.FindControl("txtproduct_quantity") as TextBox);
                TextBox txtproduct_price = (rows.FindControl("txtproduct_price") as TextBox);
                Label lblTotal = (rows.FindControl("lblTotal") as Label);

                lblTotal.Text = (int.Parse(txtproduct_quantity.Text) * float.Parse(txtproduct_price.Text)).ToString();
                x = int.Parse(txtproduct_quantity.Text);
                txtproduct_quantity.Text = x.ToString();

            }

            decimal xs = 0;
            decimal ss = 0;
            foreach (GridViewRow rows in grdCart.Rows)
            {
                Label lblTotal = (rows.FindControl("lblTotal") as Label);

                xs = decimal.Parse(lblTotal.Text);

                ss = ss + xs;

                grdCart.FooterRow.Cells[4].Text = "الاجمـالى";
                grdCart.FooterRow.Cells[5].Text = ss.ToString();
            }
            txtorder_master_total_price.Text = grdCart.FooterRow.Cells[5].Text;
        }

        protected void btnNewOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("PO_Purchase.aspx");
        }


        void add_to_Cart(int product_id, string product_name, float product_price, int product_quantity)
        {
            if (Session["addToCart"] == null)
            {
                dtCart.Columns.Add("product_id").GetType();
                dtCart.Columns.Add("product_name").GetType();
                dtCart.Columns.Add("product_price").GetType();
                dtCart.Columns.Add("product_quantity").GetType();
                dtCart.Columns.Add("total_price").GetType();

                drCart = dtCart.NewRow();

                drCart["product_id"] = product_id;
                drCart["product_name"] = product_name;
                drCart["product_price"] = product_price;
                drCart["product_quantity"] = product_quantity;
                drCart["total_price"] = Convert.ToString(float.Parse(product_price.ToString()) * int.Parse(product_quantity.ToString()));

                dtCart.Rows.Add(drCart);

                Session["addToCart"] = dtCart;
            }
            else
            {

                dtCart = (DataTable)Session["addToCart"];

                drCart = dtCart.NewRow();

                drCart["product_id"] = product_id;
                drCart["product_name"] = product_name;
                drCart["product_price"] = product_price;
                drCart["product_quantity"] = product_quantity;
                drCart["total_price"] = Convert.ToString(float.Parse(product_price.ToString()) * int.Parse(product_quantity.ToString()));

                dtCart.Rows.Add(drCart);

                Session["addToCart"] = dtCart;
            }
            grdCart.DataSource = dtCart;
            grdCart.DataBind();

        }

        string getProductPrice(string product_id)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select product_price from product where product_id='" + product_id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            string price = dt.Rows[0]["product_price"].ToString();
            return price;
        }
        string getProductName(string product_id)
        {
            SqlDataAdapter sdas = new SqlDataAdapter(@"select product_name from product where product_id='" + product_id + "'", sc);
            DataTable dts = new DataTable();
            sdas.Fill(dts);
            string name = dts.Rows[0]["product_name"].ToString();
            return name;
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
            orderid = "OP-" + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + new string(mypass);
            Label1.Text = orderid.ToString();
        }
        void loadcategory()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT [category_id],[category_name] FROM [category]", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dtcategory.DataSource = dt;
            dtcategory.DataBind();
        }
        void loadproduct(string category_id)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT [product_id],[product_name],[product_code],[product_barcode]
                            ,[product_img],[product_price],[product_quantity],[product_quantity_alert],[product_desc]
                            ,[unit_id],[store_id],[category_id]
                            FROM [product] where category_id = '" + category_id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dtproduct.DataSource = dt;
            dtproduct.DataBind();
        }
        void loadbranch()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT [branch_id],[branch_name]FROM [branch]", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            Drpbranch_id.DataSource = dt;
            Drpbranch_id.DataTextField = "branch_name";
            Drpbranch_id.DataValueField = "branch_id";
            Drpbranch_id.DataBind();
        }

        void loadStore()
        {
            string sql = @"SELECT [store_id],[store_name],[branch_id] FROM [store] where branch_id = '" + Drpbranch_id.SelectedValue + "'";
            string name = "store_name";
            string id = "store_id";
            showDrpList(Drpstore_id, sql, name, id);
        }

        void loadmethod_pay()
        {
            string sql = @"SELECT [payment_id],[payment_name] FROM [method_pay]";
            string name = "payment_name";
            string id = "payment_id";
            showDrpList(Drppayment_id, sql, name, id);
        }
        void loadEmp_id()
        {
            string sql = @"SELECT [user_id],[user_fullname],[user_code],[user_name] FROM [all_users]";
            string name = "user_name";
            string id = "user_id";
            showDrpList(Drpemp_id, sql, name, id);
        }



        void loadDataSupplier()
        {
            //SqlDataAdapter sda = new SqlDataAdapter("select user_id,user_fullname,user_phone,user_email,user_address from all_users where (user_fullname+user_phone+user_email+user_address like '%" + txtSearch.Text + "%') order by user_fullname", sc);
            SqlDataAdapter sda = new SqlDataAdapter("select user_id,user_fullname,user_phone,user_email,user_address from all_users where user_fullname+user_phone+user_email+user_address like '%" + txtSearch.Text + "%'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdSupplier.DataSource = dt;
            grdSupplier.DataBind();
        }


        public string ReplaceKeyWords(Match m)
        {
            return "<span class=highlight>" + m.Value + "</span>";
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

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchString = txtSearch.Text;
            loadDataSupplier();
        }



        protected void grdSupplier_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdSupplier.PageIndex = e.NewPageIndex;
            grdSupplier.SelectedIndex = -1;
            loadDataSupplier();
            upModal.Update();
        }

        protected void grdSupplier_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.style.cursor='hand';this.style.backgroundColor='yellow'");
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='white'");
            }
        }

        protected void grdSupplier_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void grdSupplier_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["idd"] = (grdSupplier.SelectedRow.FindControl("lbluser_id") as Label).Text;
            ViewState["named"] = (grdSupplier.SelectedRow.FindControl("lbluser_fullname") as Label).Text;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HidePopup", "$('#confirmSupplier').modal('hide')", true);
            txtuser_id.Text = ViewState["idd"].ToString();
            txtSupplierName.Text = ViewState["named"].ToString();
            UpdatePanel1.Update();
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox1.Checked == true)
            {
                decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                decimal x = decimal.Parse(grdCart.FooterRow.Cells[5].Text);
                decimal y = x * (txt / 100);
                decimal res = x - y;
                txtorder_master_total_price.Text = res.ToString();
            }
            else
            {
                decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                decimal x = decimal.Parse(grdCart.FooterRow.Cells[5].Text);
                decimal res = x - txt;
                txtorder_master_total_price.Text = res.ToString();
            }
        }

        protected void txtorder_master_dicount_TextChanged(object sender, EventArgs e)
        {
            if (CheckBox1.Checked == true)
            {
                decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                decimal x = decimal.Parse(grdCart.FooterRow.Cells[5].Text);
                decimal y = x * (txt / 100);
                decimal res = x - y;
                txtorder_master_total_price.Text = res.ToString();
            }
            else
            {
                decimal txt = decimal.Parse(txtorder_master_dicount.Text);
                decimal x = decimal.Parse(grdCart.FooterRow.Cells[5].Text);
                decimal res = x - txt;
                txtorder_master_total_price.Text = res.ToString();
            }
        }

        protected void txtorder_master_tax_TextChanged(object sender, EventArgs e)
        {
            decimal txt = decimal.Parse(txtorder_master_tax.Text);
            decimal x = decimal.Parse(txtorder_master_total_price.Text);
            decimal y = x * (txt / 100);
            decimal result = x + y;
            txtorder_master_total_price.Text = (result).ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (txtSupplierName.Text != string.Empty && Drpstore_id.SelectedValue != "-1")
            {
                Insertorder_master();
                Insertorder_details();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Inserted Data !')", true);
                tblPrint.Visible = true;
                loadDatagrdPrint(Label1.Text);
                btnSave.Enabled = false;
                btnPrint.Enabled = true;
            }
            else {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert(' من فضلك ادخل اسم المورد والمستودع المدخل فيه الكميات !')", true);
                return;
            }
        }

        void Insertorder_master()
        {
            order_master_code = Label1.Text;
            int branch_id = int.Parse(AllUsers.branchSession().ToString());
            DateTime order_master_datecreation = DateTime.Now;
            float order_master_dicount = float.Parse(txtorder_master_dicount.Text);
            float order_master_tax = float.Parse(txtorder_master_tax.Text);
            int order_master_houre = int.Parse(DateTime.Now.Hour.ToString());
            int emp_id = int.Parse(AllUsers.usersSession().ToString());
            int user_id = int.Parse(txtuser_id.Text);
            float.TryParse(txtorder_master_total_price.Text, out order_master_total_price);
            int payment_id = int.Parse(Drppayment_id.SelectedValue);
            int store_id = int.Parse(Drpstore_id.SelectedValue);
            int order_kind_id = 2;
            sc.Open();
            SqlCommand cmd = new SqlCommand(@"INSERT INTO order_master(order_master_code,branch_id,store_id
           ,order_master_datecreation,order_master_dicount,order_master_tax,order_master_houre
           ,user_id,emp_id,order_master_total_price,payment_id,order_kind_id)VALUES(@order_master_code,@branch_id,@store_id,@order_master_datecreation,
            @order_master_dicount,@order_master_tax,@order_master_houre,@user_id,@emp_id,@order_master_total_price,@payment_id,@order_kind_id)", sc);
            cmd.Parameters.AddWithValue("@order_master_code", order_master_code);
            cmd.Parameters.AddWithValue("@branch_id", branch_id);
            cmd.Parameters.AddWithValue("@store_id", store_id);
            cmd.Parameters.AddWithValue("@order_master_datecreation", order_master_datecreation);
            cmd.Parameters.AddWithValue("@order_master_dicount", order_master_dicount);
            cmd.Parameters.AddWithValue("@order_master_tax", order_master_tax);
            cmd.Parameters.AddWithValue("@order_master_houre", order_master_houre);
            cmd.Parameters.AddWithValue("@emp_id", emp_id);
            cmd.Parameters.AddWithValue("@user_id", user_id);
            cmd.Parameters.AddWithValue("@order_master_total_price", order_master_total_price);
            cmd.Parameters.AddWithValue("@payment_id", payment_id);
            cmd.Parameters.AddWithValue("@order_kind_id", order_kind_id);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            txtSupplierName.Text = "";
            txtorder_master_dicount.Text = "0";
            txtorder_master_tax.Text = "0";
            txtorder_master_total_price.Text = "";
        }
        void Insertorder_details()
        {
            if (grdCart.Rows.Count > 0)
            {
                order_master_code = Label1.Text;

                foreach (GridViewRow grd in grdCart.Rows)
                {

                    int product_id = int.Parse((grd.FindControl("lblproduct_id") as Label).Text);
                    int order_details_quantity = int.Parse(((TextBox)grd.FindControl("txtproduct_quantity")).Text);

                    SqlDataAdapter sda = new SqlDataAdapter(@"select unit_id from product where product_id='" + product_id + "'", sc);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    int unit_id = int.Parse(dt.Rows[0]["unit_id"].ToString());

                    float order_details_product_price = float.Parse((grd.FindControl("txtproduct_price") as TextBox).Text);
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
            dbo.order_master.order_master_total_price, dbo.order_master.payment_id, dbo.branch.branch_name,dbo.store.store_name
            FROM dbo.order_master INNER JOIN
                      dbo.all_users ON dbo.order_master.user_id = dbo.all_users.user_id INNER JOIN
                      dbo.branch ON dbo.order_master.branch_id = dbo.branch.branch_id INNER JOIN
                      dbo.store ON dbo.order_master.store_id = dbo.store.store_id
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
            lblstorename.Text = dt2s.Rows[0]["store_name"].ToString();
        }

        //void loadStore()
        //{
        //    SqlDataAdapter sda = new SqlDataAdapter(@"SELECT [store_id],[store_name],[branch_id] FROM [store] where branch_id = '"+Drpbranch_id.SelectedValue+"'", sc);
        //    DataTable dt = new DataTable();
        //    sda.Fill(dt);
        //    Drpstore_id.DataSource = dt;
        //    Drpstore_id.DataTextField = "store_name";
        //    Drpstore_id.DataValueField = "store_id";
        //    Drpstore_id.DataBind();
        //}

    }
}