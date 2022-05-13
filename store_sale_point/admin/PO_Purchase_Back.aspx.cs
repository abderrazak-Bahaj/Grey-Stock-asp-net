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
    public partial class PO_Purchase_Back : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        DataRow dr;

        int qtex = 0;
        int qtey = 0;

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnReturn.Visible = false;
                findorderid();
                Show.Visible = false;
                tblMasterOrder.Visible = false;
                loadDrpreturnBranch_id();
                DrpreturnBranch_id.SelectedValue = AllUsers.branchSession();

                loadDrpreturnStore_id();
            }
        }
        void loadDataGrid(string id)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select * from View_order_POS_Back where order_master_code = '" + id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                grdCartItem.DataSource = dt;
                grdCartItem.DataBind();
                //Session["getItemCart"] = dt;

                lbl1.Text = dt.Rows[0]["order_master_code"].ToString();
                lbl2.Text = dt.Rows[0]["order_master_datecreation"].ToString();
                lbl3.Text = dt.Rows[0]["order_master_tax"].ToString();
                lbl4.Text = dt.Rows[0]["order_master_dicount"].ToString();
                lbl5.Text = dt.Rows[0]["order_master_total_price"].ToString();
                lbl6.Text = dt.Rows[0]["user_id"].ToString();
                drpBranchId.Items.Clear();
                drpBranchId.Items.Add(dt.Rows[0]["branch_name"].ToString());
                drpStoreId.Items.Clear();
                drpStoreId.Items.Add(dt.Rows[0]["store_name"].ToString());
                drpEmpId.Items.Clear();
                drpEmpId.Items.Add(dt.Rows[0]["user_fullname"].ToString());
                drpMethodPay.Items.Clear();
                drpMethodPay.Items.Add(dt.Rows[0]["payment_name"].ToString());

                SqlDataAdapter sdauser_id = new SqlDataAdapter(@"SELECT dbo.all_users.user_fullname, dbo.order_master.user_id
                                        FROM dbo.all_users INNER JOIN
            dbo.order_master ON dbo.all_users.user_id = dbo.order_master.user_id where all_users.user_id='" + lbl6.Text + "'", sc);
                DataTable dtuser_id = new DataTable();
                sdauser_id.Fill(dtuser_id);
                lbl6.Text = dtuser_id.Rows[0]["user_fullname"].ToString();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('رقم الفاتورة غير موجود!')", true);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtSerachId.Text != string.Empty)
            {
                loadDataGrid(txtSerachId.Text);

                btnReturn.Visible = true;
                tblMasterOrder.Visible = true;
            }
            else
            {
                //tblMasterOrder.Visible = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('من فضلك ادخل رقم الفاتورة !')", true);
                return;
            }
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            dt.Columns.Add("product_id").GetType();
            dt.Columns.Add("product_name").GetType();
            dt.Columns.Add("quantity").GetType();
            dt.Columns.Add("unit_id").GetType();
            dt.Columns.Add("unit_name").GetType();
            dt.Columns.Add("order_details_product_price").GetType();
            dt.Columns.Add("order_details_total_price").GetType();

            for (int i = 0; i < grdCartItem.Rows.Count; i++)
            {
                CheckBox ChkSelect = grdCartItem.Rows[i].FindControl("ChkSelect") as CheckBox;
                dr = dt.NewRow();
                if (ChkSelect.Checked)
                {
                    dr["product_id"] = (grdCartItem.Rows[i].FindControl("lblproduct_id") as Label).Text;
                    dr["product_name"] = (grdCartItem.Rows[i].FindControl("lblproduct_name") as Label).Text;
                    dr["quantity"] = (grdCartItem.Rows[i].FindControl("lblproduct_quantity") as TextBox).Text;
                    qtex = int.Parse((grdCartItem.Rows[i].FindControl("lblproduct_quantity") as TextBox).Text);
                    qtey += qtex;
                    dr["unit_id"] = (grdCartItem.Rows[i].FindControl("lblunit_id") as Label).Text;
                    dr["unit_name"] = (grdCartItem.Rows[i].FindControl("lblunit_name") as Label).Text;
                    dr["order_details_product_price"] = (grdCartItem.Rows[i].FindControl("lblproduct_price") as Label).Text;
                    dr["order_details_total_price"] = (grdCartItem.Rows[i].FindControl("lblTotal") as Label).Text;
                    dt.Rows.Add(dr);
                    grdCartItem.Rows[i].Visible = false;

                }

            }
            Session["getItemCart"] = dt;
            if (dt.Rows.Count > 0)
            {
                grdItemReturn.DataSource = dt;
                grdItemReturn.DataBind();

                grdItemReturn.FooterRow.Cells[2].Text = "اجمالى المرتجع";
                grdItemReturn.FooterRow.Cells[3].Text = qtey.ToString();

                Show.Visible = true;
            }
        }


        public void findorderid()
        {
            String pass = "abcdefghijklmnopqrstuvwxyz0123456789";
            Random r = new Random();

            char[] mypass = new char[5];
            for (int i = 0; i < 5; i++)
            {
                mypass[i] = pass[(int)(35 * r.NextDouble())];
            }
            String orderid;
            orderid = "PB-" + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + new string(mypass);
            Label1.Text = orderid.ToString();
        }

        void insertOrderMaster()
        {
            int branch_id = Convert.ToInt32(DrpreturnBranch_id.SelectedValue);
            int store_id = Convert.ToInt32(DrpreturnStore_id.SelectedValue);
            int emp_id = Convert.ToInt32(AllUsers.usersSession().ToString());
            int order_kind_id = 4;
            float order_master_total_price = 0;
            int user_id = 0;
            int order_master_houre = DateTime.Now.Hour;
            float order_master_tax = 0;
            float order_master_dicount = 0;
            DateTime order_master_datecreation = DateTime.Now;
            int payment_id = 1;

            SqlCommand cmd = new SqlCommand(@"INSERT INTO [order_master]([order_master_code],[branch_id],
            [store_id],[order_master_datecreation],[order_master_dicount],[order_master_tax],[order_master_houre]
            ,[user_id],[emp_id],[order_master_total_price],[payment_id],[order_kind_id]) VALUES (@order_master_code,
            @branch_id,@store_id,@order_master_datecreation,@order_master_dicount,@order_master_tax
            ,@order_master_houre,@user_id,@emp_id,@order_master_total_price,@payment_id,@order_kind_id)", sc);
            cmd.Parameters.AddWithValue("@order_master_code", Label1.Text);
            cmd.Parameters.AddWithValue("@branch_id", branch_id);
            cmd.Parameters.AddWithValue("@store_id", store_id);
            cmd.Parameters.AddWithValue("@order_master_datecreation", order_master_datecreation);
            cmd.Parameters.AddWithValue("@order_master_dicount", order_master_dicount);
            cmd.Parameters.AddWithValue("@order_master_tax", order_master_tax);
            cmd.Parameters.AddWithValue("@order_master_houre", order_master_houre);
            cmd.Parameters.AddWithValue("@user_id", user_id);
            cmd.Parameters.AddWithValue("@emp_id", emp_id);
            cmd.Parameters.AddWithValue("@order_master_total_price", order_master_total_price);
            cmd.Parameters.AddWithValue("@payment_id", payment_id);
            cmd.Parameters.AddWithValue("@order_kind_id", order_kind_id);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
        }
        void insertOrderDetails()
        {
            if (grdItemReturn.Rows.Count > 0)
            {
                foreach (GridViewRow row in grdItemReturn.Rows)
                {
                    int lblproduct_id = int.Parse((row.FindControl("lblproduct_id") as Label).Text);
                    int lblproduct_quantity = int.Parse((row.FindControl("lblproduct_quantity") as TextBox).Text);
                    int lblunit_id = int.Parse((row.FindControl("lblunit_id") as Label).Text);
                    float lblproduct_price = float.Parse((row.FindControl("lblproduct_price") as Label).Text);
                    float lblTotal = float.Parse((row.FindControl("lblTotal") as Label).Text);

                    SqlDataAdapter sda = new SqlDataAdapter(@"insert into order_details (order_master_code,product_id,
                    order_details_quantity,unit_id,order_details_product_price,order_details_total_price) values
('" + Label1.Text + "','" + lblproduct_id + "','" + lblproduct_quantity + "','" + lblunit_id + "','" + lblproduct_price + "','" + lblTotal + "')", sc);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                }
            }
        }
        protected void grdItemReturn_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            dt = (DataTable)Session["getItemCart"];
            dt.Rows[e.RowIndex].Delete();
            Session["getItemCart"] = dt;

            grdItemReturn.DataSource = dt;
            grdItemReturn.DataBind();

        }

        void loadDrpreturnBranch_id()
        {
            string sql = "SELECT [branch_id],[branch_name] FROM [branch] ";
            string name = "branch_name";
            string id = "branch_id";
            showDrpList(DrpreturnBranch_id, sql, name, id);
        }
        void loadDrpreturnStore_id()
        {
            string sql = "SELECT [store_id],[store_name],[branch_id] FROM [store] where branch_id = '" + AllUsers.usersSession() + "'";
            string name = "store_name";
            string id = "store_id";
            showDrpList(DrpreturnStore_id, sql, name, id);
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (DrpreturnStore_id.SelectedValue != "-1")
            {
                insertOrderMaster();
                insertOrderDetails();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert(' تم حفظ فاتورة المرتجع بنجاح !')", true);
                btnSave.Enabled = false;

                loadPrintReturn(Label1.Text);
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$(function () {");
                sb.Append(" $('#confirmPrint').modal('show');});");
                sb.Append("</script>");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ModelScript", sb.ToString(), false);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert(' من فضلك اختر المخزن !')", true);
                return;
            }
        }

        protected void btnPrintreturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("POS_Back.aspx");
        }
        void loadPrintReturn(string id)
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select * from View_order_POS_Back where order_master_code = '" + id + "'", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdPrint.DataSource = dt;
            grdPrint.DataBind();
        }
    }

}
