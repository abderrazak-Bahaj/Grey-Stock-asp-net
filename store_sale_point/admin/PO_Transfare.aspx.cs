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
    public partial class PO_Transfare : System.Web.UI.Page
    {
        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        DataTable dtCart = new DataTable();
        DataRow drCart;
        public string transfer_master_code;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Session["addToCart"] = null;
                loadCategory();
                Label1.Visible = false;
                findorderid();
                TblMatser.Visible = false;

                loadDrpemp_id();
                Drpemp_id.SelectedValue = AllUsers.usersSession();
                Drpemp_id.Enabled = false;

                loadDrpbranch_id_From();
                Drpbranch_id_From.SelectedValue = AllUsers.branchSession();
                Drpbranch_id_From.Enabled = false;


                loadDrpstore_id_From();

                loadDrpbranch_id_To();


                tblPrint.Visible = false;
                btnPrint.Visible = false;

            }
        }

        protected void btnNewOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("PO_Transfare.aspx");
        }

        protected void dtcategory_ItemCommand(object source, DataListCommandEventArgs e)
        {
            dtcategory.SelectedIndex = e.Item.ItemIndex;
            string cat_id = (dtcategory.SelectedItem.FindControl("lblcategory_id") as Label).Text;
            loadProducts(cat_id);
        }

        protected void dtproduct_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Label1.Visible = true;
            TblMatser.Visible = true;

            transfer_master_code = Label1.Text;

            dtproduct.SelectedIndex = e.Item.ItemIndex;
            string Product_id = (dtproduct.SelectedItem.FindControl("lblproduct_id") as Label).Text;
            string product_name = (dtproduct.SelectedItem.FindControl("lblproduct_name") as Label).Text;
            int exist = 0;
            foreach (GridViewRow row in grdCart.Rows)
            {
                string lblproduct_id = (row.FindControl("lblproduct_id") as Label).Text;

                TextBox txtproduct_quantity = (row.FindControl("txtproduct_quantity") as TextBox);

                if (lblproduct_id == Product_id)
                {
                    txtproduct_quantity.Text = (int.Parse(txtproduct_quantity.Text) + 1).ToString();
                    exist = 1;
                    (row.FindControl("txtproduct_quantity") as TextBox).Text = txtproduct_quantity.Text;
                }
            }
            if (exist == 0)
            {
                add_to_Cart(Product_id, product_name, 1);
            }

        }

        protected void grdCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            grdCart.Columns[1].Visible = false;
        }

        protected void grdCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            dtCart = (DataTable)Session["addToCart"];
            dtCart.Rows[e.RowIndex].Delete();
            Session["addToCart"] = dtCart;
            grdCart.DataSource = dtCart;
            grdCart.DataBind();


        }

        protected void Drpbranch_id_To_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadDrpDrpstore_id_To();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            if (Drpbranch_id_To.SelectedValue == "-1" || Drpstore_id_To.SelectedValue == "-1" || Drpstore_id_From.SelectedValue == "-1")
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('من فضلك اختر الفروع !')", true);
                return;
            }
            else
            {
                insertMatser();
                insertDetails();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Suceess Inserted Data !')", true);

                btnSave.Enabled = false;
                loadDataPrint(Label1.Text);
                btnPrint.Visible = true;
                tblPrint.Visible = true;
            }
        }



        void insertMatser()
        {
            transfer_master_code = Label1.Text;
            sc.Open();
            SqlCommand cmd = new SqlCommand(@"insert into transfer_master (transfer_master_code,store_from,
                                 store_to,transfer_master_datecreation,user_id) values (@transfer_master_code,@store_from,
                                 @store_to,@transfer_master_datecreation,@user_id)", sc);
            cmd.Parameters.AddWithValue("@transfer_master_code", transfer_master_code);
            cmd.Parameters.AddWithValue("@store_from", Drpstore_id_From.SelectedValue);
            cmd.Parameters.AddWithValue("@store_to", Drpstore_id_To.SelectedValue);
            cmd.Parameters.AddWithValue("@transfer_master_datecreation", DateTime.Now);
            cmd.Parameters.AddWithValue("@user_id", Drpemp_id.SelectedValue);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            sc.Close();
            clearFeild();
        }

        void insertDetails()
        {
            transfer_master_code = Label1.Text;
            if (grdCart.Rows.Count > 0)
            {
                foreach (GridViewRow row in grdCart.Rows)
                {
                    string product_id = (row.FindControl("lblproduct_id") as Label).Text;

                    int unit_id;
                    SqlDataAdapter sdaunit = new SqlDataAdapter(@"select unit_id from product where product_id = '" + product_id + "'", sc);
                    DataTable dtunit = new DataTable();
                    sdaunit.Fill(dtunit);
                    unit_id = int.Parse(dtunit.Rows[0]["unit_id"].ToString());

                    string transfer_details_product_count = (row.FindControl("txtproduct_quantity") as TextBox).Text;

                    SqlDataAdapter sda = new SqlDataAdapter(@"insert into transfer_details(transfer_master_code,product_id,unit_id,
                                    transfer_details_product_count) values 
                                    ('" + transfer_master_code + "','" + product_id + "'," + unit_id + ",'" + transfer_details_product_count + "')", sc);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                }
            }
        }

        void loadDataPrint(string id)
        {

            SqlDataAdapter sdaMaster = new SqlDataAdapter(@"SELECT dbo.all_users.user_name, dbo.transfer_master.transfer_master_code,
                      dbo.transfer_master.store_from, dbo.transfer_master.store_to, 
                      dbo.transfer_master.transfer_master_datecreation FROM dbo.transfer_master INNER JOIN
                      dbo.all_users ON dbo.transfer_master.user_id = dbo.all_users.user_id where transfer_master_code = '" + id + "'", sc);
            DataTable dtMaster = new DataTable();
            sdaMaster.Fill(dtMaster);
            grdPrint.DataSource = dtMaster;

            lbltransfer_master_code.Text = dtMaster.Rows[0]["transfer_master_code"].ToString();
            
            lblstore_from.Text = dtMaster.Rows[0]["store_from"].ToString();

            SqlDataAdapter sda_store_from = new SqlDataAdapter(@"select store_name from store where store_id = '" + lblstore_from.Text + "'", sc);
            DataTable dt_store_from = new DataTable();
            sda_store_from.Fill(dt_store_from);
            lblstore_from.Text = dt_store_from.Rows[0]["store_name"].ToString();

            lblstore_to.Text = dtMaster.Rows[0]["store_to"].ToString();

            SqlDataAdapter sda_store_to = new SqlDataAdapter(@"select store_name from store where store_id = '" + lblstore_to.Text + "'", sc);
            DataTable dt_store_to = new DataTable();
            sda_store_to.Fill(dt_store_to);
            lblstore_to.Text = dt_store_to.Rows[0]["store_name"].ToString();

            lbltransfer_master_datecreation.Text = dtMaster.Rows[0]["transfer_master_datecreation"].ToString();
            lbluser_id.Text = dtMaster.Rows[0]["user_name"].ToString();


            SqlDataAdapter sdaDetails = new SqlDataAdapter(@"SELECT dbo.transfer_details.transfer_master_code, dbo.transfer_details.product_id, dbo.unit.unit_name, dbo.product.product_name, 
                      dbo.transfer_details.transfer_details_product_count FROM dbo.transfer_details INNER JOIN
                      dbo.product ON dbo.transfer_details.product_id = dbo.product.product_id INNER JOIN
                      dbo.unit ON dbo.transfer_details.unit_id = dbo.unit.unit_id where transfer_master_code = '" + id + "' ", sc);
            DataTable dtDetails = new DataTable();
            sdaDetails.Fill(dtDetails);
            grdPrint.DataSource = dtDetails;
            grdPrint.DataBind();

        }

        void loadCategory()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT [category_id],[category_name]FROM [category]", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dtcategory.DataSource = dt;
            dtcategory.DataBind();
        }

        void loadProducts(string product_id)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"SELECT [product_id],[product_name],[product_code],[product_img]
            ,[product_price],[product_quantity],[category_id] FROM [product] where category_id = '" + product_id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            dtproduct.DataSource = dt;
            dtproduct.DataBind();
        }

        void loadDrpbranch_id_From()
        {
            string sql = @"select branch_id,branch_name from branch";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(Drpbranch_id_From, sql, name, id);
        }
        void loadDrpstore_id_From()
        {
            string sql = @"select store_id,store_name from store where branch_id = '" + Drpbranch_id_From.SelectedValue + "'";
            string name = "store_name";
            string id = "store_id";
            showDrpList(Drpstore_id_From, sql, name, id);
        }
        void loadDrpbranch_id_To()
        {
            string sql = @"select branch_id,branch_name from branch";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(Drpbranch_id_To, sql, name, id);
        }
        void loadDrpDrpstore_id_To()
        {
            string sql = @"select store_id,store_name from store where branch_id = '" + Drpbranch_id_To.SelectedValue + "'";
            string name = "store_name";
            string id = "store_id";
            showDrpList(Drpstore_id_To, sql, name, id);
        }
        void loadDrpemp_id()
        {
            string sql = @"select user_id,user_name from all_users";
            string name = "user_name";
            string id = "user_id";
            showDrpList(Drpemp_id, sql, name, id);
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
            orderid = "OrderTransfare-" + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + new string(mypass);
            Label1.Text = orderid.ToString();
        }

        void add_to_Cart(string product_id, string product_name, int product_quantity)
        {
            if (Session["addToCart"] == null)
            {
                dtCart.Columns.Add("product_id").GetType();
                dtCart.Columns.Add("product_name").GetType();
                dtCart.Columns.Add("product_quantity").GetType();

                drCart = dtCart.NewRow();

                drCart["product_id"] = product_id;
                drCart["product_name"] = product_name;
                drCart["product_quantity"] = product_quantity;

                dtCart.Rows.Add(drCart);

                Session["addToCart"] = dtCart;
            }
            else
            {
                dtCart = (DataTable)Session["addToCart"];
                drCart = dtCart.NewRow();
                drCart["product_id"] = product_id;
                drCart["product_name"] = product_name;
                drCart["product_quantity"] = product_quantity;

                dtCart.Rows.Add(drCart);

                Session["addToCart"] = dtCart;
            }
            grdCart.DataSource = dtCart;
            grdCart.DataBind();
        }

        void clearFeild()
        {
            Drpbranch_id_From.SelectedValue = "-1";
            Drpbranch_id_To.SelectedValue = "-1";
            Drpstore_id_From.SelectedValue = "-1";
            Drpstore_id_To.SelectedValue = "-1";
            Drpemp_id.SelectedValue = "-1";
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



    }
}