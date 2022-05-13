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
    public partial class setting_permission_pagesInGroup : System.Web.UI.Page
    {

        SqlConnection sc = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString.ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loaddrpShowGroup();
                loadDataCheckPage();
            }
        }
        void loaddrpShowGroup()
        {
            string sql = @"select   group_name,group_id from permission_group";
            string name = "group_name";
            string id = "group_id";
            showDrpList(drpShowGroup, sql, name, id);
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

        void loadDataCheckPage()
        {
            SqlDataAdapter sda = new SqlDataAdapter(@"select page_id,page_name,page_url from permission_page", sc);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    ListItem item = new ListItem();
                    item.Text = row["page_name"].ToString();
                    item.Value = row["page_id"].ToString();
                    //item.Selected = Convert.ToBoolean(row["IsSelected"]);
                    chkList.Items.Add(item);
                }
            }
        }

        protected void ChkAll_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkAll.Checked)
            {
                foreach (ListItem item in chkList.Items)
                {
                    item.Selected = true;
                }
            }
            else
            {
                foreach (ListItem item in chkList.Items)
                {
                    item.Selected = false;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (drpShowGroup.SelectedValue != "-1")
            {

                SqlDataAdapter sdaDelete = new SqlDataAdapter(@"delete from permission_group_page where group_id='" + drpShowGroup.SelectedValue + "'", sc);
                DataTable dtDelete = new DataTable();
                sdaDelete.Fill(dtDelete);

                foreach (ListItem item in chkList.Items)
                {
                    if (item.Selected == true)
                    {
                        SqlCommand cmd = new SqlCommand(@"insert into permission_group_page(page_id,group_id) values (@page_id,@group_id)", sc);
                        cmd.Parameters.AddWithValue("@group_id", drpShowGroup.SelectedValue);
                        cmd.Parameters.AddWithValue("@page_id", item.Value);
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                    }

                    if (item.Selected == true)
                    {

                        System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert(' تم الحفظ بنجاح !');", true);
                        item.Selected = false;
                        ChkAll.Checked = false;
                    }
                    //else
                    //{
                    //    System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Inserted", "alert('   من فضلك اختر الصفحات !');", true);
                    //}
                }
            }
            else
            {
                System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "Message Error", "alert('من فضلك اختر الجروب !');", true);
            }
            drpShowGroup.SelectedValue = "-1";
        }

        protected void drpShowGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (drpShowGroup.SelectedValue != "-1")
            {
                foreach (ListItem item in chkList.Items)
                {
                    SqlDataAdapter sda = new SqlDataAdapter(@"select group_id,page_id from permission_group_page where group_id='" + drpShowGroup.SelectedValue + "' and page_id='" + item.Value + "'", sc);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    //string group_id = dt.Rows[0]["group_id"].ToString();
                    if (dt.Rows.Count > 0)
                    {
                        item.Selected = true;
                    }
                    else
                    {
                        item.Selected = false;
                    }
                }
            }
        }
    }
}