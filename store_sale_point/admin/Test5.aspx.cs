using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data.SqlClient;

namespace store_sale_point.admin
{
    public partial class Test5 : System.Web.UI.Page
    {
        SqlConnection  piscon = new SqlConnection(ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString);
        int SubjectCode = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSubjectGrid();
                btnUpdate.CssClass = "btn btn-warning btn-block disabled";
                btnDelete.CssClass = "btn btn-danger btn-block disabled";
                btnUpdate.Enabled = false;
                btnDelete.Enabled = false;
                this.Page.Title = "ContactName";
            }
        }

        /* Bind Employee Grid*/
        private void BindSubjectGrid()
        {
            /* Code For Bind Employee Grid*/
            string query = "Select id,ContactName,City, Country,PostalCode from TestCustomer order by ContactName desc ";
            SqlCommand cmd = new SqlCommand(query);
            string constr = ConfigurationManager.ConnectionStrings["constore_sale_point"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlDataAdapter sda = new SqlDataAdapter();
            cmd.Connection = con;
            sda.SelectCommand = cmd;
            DataSet ds = new DataSet();
            sda.Fill(ds);
            grdSubject.DataSource = ds;
            grdSubject.DataBind();
        }

        /* Clear controls values and Set default value to controls */
        private void ClearAll()
        {
            btnSave.CssClass = "btn btn-success btn-block";
            btnUpdate.CssClass = "btn btn-warning btn-block disabled";
            btnDelete.CssClass = "btn btn-danger btn-block disabled ";
            btnSave.Enabled = true;
            btnUpdate.Enabled = false;
            btnDelete.Enabled = false;

            for (int i = 0; i < grdSubject.Rows.Count; i++)
            {
                GridViewRow gr = grdSubject.Rows[i];
                CheckBox rdo = gr.Cells[0].FindControl("chkSelect") as CheckBox;
                if (rdo.Checked == true)
                {
                    rdo.Checked = false;
                }
            }
            txtSubject.Text = "";
            txtHqrsSubCode.Text = "";
            txtHqrsSubDesc.Text = "";
        }

        public void IncrementSubjectCode()
        {
            try
            {
                int AID = 0;
                int lastID = 0;
                string sql = "select ContactName  from TestCustomer";
                piscon.Open();
                SqlCommand cmd = new SqlCommand(sql, piscon);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    AID = Convert.ToInt32(dr["ContactName"]);

                }
                piscon.Close();
                if (AID != 0)
                {
                    String query11 = "SELECT MAX(id) FROM TestCustomer";
                    piscon.Open();
                    SqlCommand cmdid = new SqlCommand(query11, piscon);
                    lastID = int.Parse(cmdid.ExecuteScalar().ToString()) + 1;
                    SubjectCode = Convert.ToInt16(lastID.ToString());
                    piscon.Close();
                }
                else
                {
                    SubjectCode = Convert.ToInt16((lastID + 1).ToString());
                }
            }
            catch (Exception ex)
            {
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            CultureInfo culterinfo = Thread.CurrentThread.CurrentCulture;
            TextInfo objtxtSerName = culterinfo.TextInfo;
            var InSubjectName = objtxtSerName.ToUpper(txtSubject.Text);
            var InHqrsSubCode = objtxtSerName.ToUpper(txtHqrsSubCode.Text);
            var InHqrsSubDesc = objtxtSerName.ToUpper(txtHqrsSubDesc.Text);
            try
            {
                IncrementSubjectCode();
                piscon.Open();
                string queryInsert = "Insert into Subject_Table ( SubjectCode ,Subject,HQRS_SUB_CODE, HQRS_SUB_DESC) values ('" + SubjectCode + "','" + InSubjectName + "','" + InHqrsSubCode + "','" + InHqrsSubDesc + "')";
                SqlCommand cmdInsert = new SqlCommand(queryInsert, piscon);
                cmdInsert.ExecuteNonQuery();
                piscon.Close();
                BindSubjectGrid();

                AlertMsg.Attributes["class"] = "alert alert-success";
                lblmsg.Text = "Subject Details Added Successfully!!!";
                mpeMessageBox.Show();

                ClearAll();
            }
            catch (Exception)
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occured !! ";
                mpeMessageBox.Show();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            CultureInfo culterinfo = Thread.CurrentThread.CurrentCulture;
            TextInfo objtxtSerName = culterinfo.TextInfo;
            var UpSubjectName = objtxtSerName.ToUpper(txtSubject.Text);
            var UpHqrsSubCode = objtxtSerName.ToUpper(txtHqrsSubCode.Text);
            var UpHqrsSubDesc = objtxtSerName.ToUpper(txtHqrsSubDesc.Text);

            string UpSubjectCode = lblSubjectCode.Text;

            try
            {
                SqlCommand cmdUpdate = new SqlCommand("Update Subject_Table set Subject='" + UpSubjectName + "',HQRS_SUB_CODE='" + UpHqrsSubCode + "',HQRS_SUB_DESC='" + UpHqrsSubDesc + "' where SubjectCode='" + UpSubjectCode + "'", piscon);
                piscon.Open();
                cmdUpdate.ExecuteNonQuery();
                piscon.Close();
                BindSubjectGrid();
                ClearAll();

                AlertMsg.Attributes["class"] = "alert alert-success";
                lblmsg.Text = "Subject Details Updated Successfully!!";
                mpeMessageBox.Show();
            }
            catch (Exception)
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occured !!";
                mpeMessageBox.Show();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string DelSubjectCode = lblSubjectCode.Text;
            mpeDeleteSubject.Show();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearAll();
        }

        #region Grid Bind Methods and Events

        protected void BindGridBySerCode()
        {
            string SearchCode = txtSerCode.Text;
            try
            {
                {
                    piscon.Open();
                    string query = "Select id,ContactName,City,Country,PostalCode HQRS_SUB_DESC from TestCustomer  where id  like '%" + SearchCode + "%'  order by id desc";
                    SqlCommand cmd1 = new SqlCommand(query, piscon);
                    SqlDataAdapter da1 = new SqlDataAdapter();
                    da1.SelectCommand = cmd1;
                    DataSet ds = new DataSet();
                    da1.Fill(ds);
                    if (txtPageSize.Text != "")
                    {
                        if (ds.Tables[0].Rows.Count < Convert.ToInt64(txtPageSize.Text))
                        {
                            txtPageSize.Text = ds.Tables[0].Rows.Count.ToString();
                        }
                    }
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
                        grdSubject.DataSource = ds;
                        grdSubject.DataBind();
                        int columncount = grdSubject.Rows[0].Cells.Count;
                        grdSubject.Rows[0].Cells.Clear();
                        grdSubject.Rows[0].Cells.Add(new TableCell());
                        grdSubject.Rows[0].Cells[0].ColumnSpan = columncount;
                        grdSubject.Rows[0].Cells[0].Text = "No Record To Display!!!";

                    }
                    else
                    {
                        grdSubject.DataSource = ds;
                        grdSubject.DataBind();
                    }
                }
                piscon.Close();
            }
            catch
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occured ";
                mpeMessageBox.Show();
            }
        }

        protected void BindGridBySerName()
        {
            CultureInfo culterinfo = Thread.CurrentThread.CurrentCulture;
            TextInfo objtxtSerName = culterinfo.TextInfo;
            var SearchName = objtxtSerName.ToUpper(txtSerName.Text);

            try
            {
                {
                    piscon.Open();
                    string query = "Select id,ContactName,City,Country,PostalCode HQRS_SUB_DESC from TestCustomer  where ContactName  like '%" + SearchName + "%'  order by id desc";
                    SqlCommand cmd1 = new SqlCommand(query, piscon);
                    SqlDataAdapter da1 = new SqlDataAdapter();
                    da1.SelectCommand = cmd1;
                    DataSet ds = new DataSet();
                    da1.Fill(ds);
                    if (txtPageSize.Text != "")
                    {
                        if (ds.Tables[0].Rows.Count < Convert.ToInt64(txtPageSize.Text))
                        {
                            txtPageSize.Text = ds.Tables[0].Rows.Count.ToString();
                        }
                    }
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
                        grdSubject.DataSource = ds;
                        grdSubject.DataBind();
                        int columncount = grdSubject.Rows[0].Cells.Count;
                        grdSubject.Rows[0].Cells.Clear();
                        grdSubject.Rows[0].Cells.Add(new TableCell());
                        grdSubject.Rows[0].Cells[0].ColumnSpan = columncount;
                        grdSubject.Rows[0].Cells[0].Text = "No Record To Display!!!";

                    }
                    else
                    {
                        grdSubject.DataSource = ds;
                        grdSubject.DataBind();
                    }
                }
                piscon.Close();
            }
            catch
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occurred!!";
                mpeMessageBox.Show();
            }
        }

        protected void BindGridBySerHqrsCode()
        {
            try
            {
                {
                    CultureInfo culterinfo = Thread.CurrentThread.CurrentCulture;
                    TextInfo objtxtSerName = culterinfo.TextInfo;
                    var SearchHqrsCode = objtxtSerName.ToUpper(txtSerHqrsCode.Text);
                    piscon.Open();
                    string query = "select id,ContactName,City,Country,PostalCode HQRS_SUB_DESC from TestCustomer  where City  like '%" + SearchHqrsCode + "%'  order by id desc";
                    SqlCommand cmd1 = new SqlCommand(query, piscon);
                    SqlDataAdapter da1 = new SqlDataAdapter();
                    da1.SelectCommand = cmd1;
                    DataSet ds = new DataSet();
                    da1.Fill(ds);
                    if (txtPageSize.Text != "")
                    {
                        if (ds.Tables[0].Rows.Count < Convert.ToInt64(txtPageSize.Text))
                        {
                            txtPageSize.Text = ds.Tables[0].Rows.Count.ToString();
                        }
                    }
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
                        grdSubject.DataSource = ds;
                        grdSubject.DataBind();
                        int columncount = grdSubject.Rows[0].Cells.Count;
                        grdSubject.Rows[0].Cells.Clear();
                        grdSubject.Rows[0].Cells.Add(new TableCell());
                        grdSubject.Rows[0].Cells[0].ColumnSpan = columncount;
                        grdSubject.Rows[0].Cells[0].Text = "No Record To Display!!!";

                    }
                    else
                    {
                        grdSubject.DataSource = ds;
                        grdSubject.DataBind();
                    }
                }
                piscon.Close();
            }
            catch
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occurred!!";
                mpeMessageBox.Show();
            }
        }

        protected void BindGridByHqrsDesc()
        {
            try
            {
                {
                    CultureInfo culterinfo = Thread.CurrentThread.CurrentCulture;
                    TextInfo objtxtSerName = culterinfo.TextInfo;
                    var SearchText = objtxtSerName.ToUpper(txtSerHqrsDesc.Text);

                    piscon.Open();
                    string query = "select id,ContactName,City,Country,PostalCode HQRS_SUB_DESC from TestCustomer  where Country  like '%" + SearchText + "%'  order by id desc";
                    SqlCommand cmd1 = new SqlCommand(query, piscon);
                    SqlDataAdapter da1 = new SqlDataAdapter();
                    da1.SelectCommand = cmd1;
                    DataSet ds = new DataSet();
                    da1.Fill(ds);
                    if (txtPageSize.Text != "")
                    {
                        if (ds.Tables[0].Rows.Count < Convert.ToInt64(txtPageSize.Text))
                        {
                            txtPageSize.Text = ds.Tables[0].Rows.Count.ToString();
                        }

                    }
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
                        grdSubject.DataSource = ds;
                        grdSubject.DataBind();
                        int columncount = grdSubject.Rows[0].Cells.Count;
                        grdSubject.Rows[0].Cells.Clear();
                        grdSubject.Rows[0].Cells.Add(new TableCell());
                        grdSubject.Rows[0].Cells[0].ColumnSpan = columncount;
                        grdSubject.Rows[0].Cells[0].Text = "No Record To Display!!!";

                    }
                    else
                    {
                        grdSubject.DataSource = ds;
                        grdSubject.DataBind();
                    }
                }
                piscon.Close();
            }
            catch
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occurred!!";
                mpeMessageBox.Show();
            }
        }

        #endregion

        /* If Select Yes on Delete Modal Popup */
        protected void Yes(object sender, EventArgs e)
        {
            try
            {
                string DelSubjectCode = lblSubjectCode.Text;
                SqlCommand cmd = new SqlCommand("DELETE FROM Subject_Table WHERE Subjectcode = '" + DelSubjectCode + "'");
                cmd.Connection = piscon;
                piscon.Open();
                cmd.ExecuteNonQuery();
                piscon.Close();

                BindSubjectGrid();
                mpeDeleteSubject.Hide();

                AlertMsg.Attributes["class"] = "alert alert-success";
                lblmsg.Text = "Subject Deleted Successfully!!!";
                mpeMessageBox.Show();

                btnSave.CssClass = "btn btn-success btn-block";
                btnUpdate.CssClass = "btn btn-warning btn-block disabled";
                btnDelete.CssClass = "btn btn-danger btn-block disabled ";
                btnSave.Enabled = true;
                btnUpdate.Enabled = false;
                btnDelete.Enabled = false;

                for (int i = 0; i < grdSubject.Rows.Count; i++)
                {
                    GridViewRow gr = grdSubject.Rows[i];
                    CheckBox rdo = gr.Cells[0].FindControl("chkSelect") as CheckBox;
                    if (rdo.Checked == true)
                    {
                        rdo.Checked = false;
                    }
                }
                txtSubject.Text = "";
                txtHqrsSubCode.Text = "";
                txtHqrsSubDesc.Text = "";

                btnClear_Click(null, null);
            }
            catch (Exception)
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occurred!!";
                mpeMessageBox.Show();
            }

        }

        protected void grdSubject_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                if (txtPageSize.Text != "")
                {
                    if (txtSerCode.Text != "")
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindGridBySerCode();

                        txtSerName.Text = "";
                        txtSerHqrsCode.Text = "";
                        txtSerHqrsDesc.Text = "";
                    }
                    else if (txtSerName.Text != "")
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindGridBySerName();

                        txtSerCode.Text = "";
                        txtSerHqrsCode.Text = "";
                        txtSerHqrsDesc.Text = "";

                    }
                    else if (txtSerHqrsCode.Text != "")
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindGridBySerHqrsCode();

                        txtSerName.Text = "";
                        txtSerCode.Text = "";
                        txtSerHqrsDesc.Text = "";

                    }
                    else if (txtSerHqrsDesc.Text != "")
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindGridByHqrsDesc();

                        txtSerName.Text = "";
                        txtSerHqrsCode.Text = "";
                        txtSerCode.Text = "";
                    }
                    else
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindSubjectGrid();
                    }
                }
                else
                {
                    if (txtSerCode.Text != "")
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindGridBySerCode();

                        txtSerName.Text = "";
                        txtSerHqrsCode.Text = "";
                        txtSerHqrsDesc.Text = "";
                    }
                    else if (txtSerName.Text != "")
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindGridBySerName();

                        txtSerCode.Text = "";
                        txtSerHqrsCode.Text = "";
                        txtSerHqrsDesc.Text = "";

                    }
                    else if (txtSerHqrsCode.Text != "")
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindGridBySerHqrsCode();

                        txtSerName.Text = "";
                        txtSerCode.Text = "";
                        txtSerHqrsDesc.Text = "";

                    }
                    else if (txtSerHqrsDesc.Text != "")
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindGridByHqrsDesc();

                        txtSerName.Text = "";
                        txtSerHqrsCode.Text = "";
                        txtSerCode.Text = "";
                    }
                    else
                    {
                        grdSubject.PageIndex = e.NewPageIndex;
                        BindSubjectGrid();
                        txtSerCode.Text = "";
                        txtSerName.Text = "";
                        txtSerHqrsCode.Text = "";
                        txtHqrsSubDesc.Text = "";

                    }
                }
            }
            catch (Exception)
            {
            }
        }

        protected void grdSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = int.Parse(grdSubject.DataKeys[grdSubject.SelectedRow.RowIndex].Value.ToString());

            for (int i = 0; i < grdSubject.Rows.Count; i++)
            {
                CheckBox rb = (CheckBox)grdSubject.Rows[i].Cells[0].FindControl("chkSelect");
                if (rb.Checked)
                {
                    ViewState["chkSelect"] = rb.Checked;
                    break;
                }
            }
        }

        protected void chkSelect_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i < grdSubject.Rows.Count; i++)
                {
                    GridViewRow gr = grdSubject.Rows[i];
                    CheckBox rdo = gr.Cells[0].FindControl("chkSelect") as CheckBox;

                    if (rdo.Checked)
                    {
                        int SubjectCode = Convert.ToInt32(gr.Cells[2].Text);
                        lblSubjectCode.Text = SubjectCode.ToString();
                        string ReadSubjectInfo = "Select id,ContactName,City,Country,PostalCode from TestCustomer where id='" + SubjectCode + "'";
                        SqlCommand cmdReadGroupInfo = new SqlCommand(ReadSubjectInfo, piscon);
                        piscon.Open();
                        SqlDataReader dr = cmdReadGroupInfo.ExecuteReader();
                        if (dr.Read())
                        {
                            txtSubject.Text = dr["id"].ToString();
                            txtHqrsSubCode.Text = dr["ContactName"].ToString();
                            txtHqrsSubDesc.Text = dr["ContactName"].ToString();

                            dr.Close();
                            piscon.Close();
                            btnSave.CssClass = "btn btn-success btn-block disabled";
                            btnUpdate.CssClass = "btn btn-warning btn-block ";
                            btnDelete.CssClass = "btn btn-danger btn-block ";
                            btnSave.Enabled = false;
                            btnUpdate.Enabled = true;
                            btnDelete.Enabled = true;
                        }

                        piscon.Close();
                        break;
                    }
                    else
                    {
                        txtSubject.Text = "";
                        txtHqrsSubCode.Text = "";
                        txtHqrsSubDesc.Text = "";

                        rdo.Checked = false;
                        btnSave.CssClass = "btn btn-success btn-block";
                        btnUpdate.CssClass = "btn btn-warning btn-block disabled";
                        btnDelete.CssClass = "btn btn-danger btn-block disabled ";
                        btnSave.Enabled = true;
                        btnUpdate.Enabled = false;
                        btnDelete.Enabled = false;
                    }
                }
            }
            catch (Exception)
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occured !! ";
                mpeMessageBox.Show();
            }
        }

        protected void grdSubject_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            #region Color the Search Text in cells
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //For Search GroupName
                //else
                if (txtSerName.Text != "")
                {

                    e.Row.Cells[3].Text = Regex.Replace(e.Row.Cells[3].Text, txtSerName.Text.Trim(), delegate (Match match)
                    {
                        return string.Format("<span style = 'color:red'>{0}</span>", match.Value);
                    }, RegexOptions.IgnoreCase);

                }
                //For Search Group Name full
                else if (txtSerHqrsCode.Text != "")
                {
                    e.Row.Cells[4].Text = Regex.Replace(e.Row.Cells[4].Text, txtSerHqrsCode.Text.Trim(), delegate (Match match)
                    {
                        return string.Format("<span style = 'color:red'>{0}</span>", match.Value);
                    }, RegexOptions.IgnoreCase);
                }
                //For Search HOD
                else if (txtSerHqrsDesc.Text != "")
                {
                    e.Row.Cells[5].Text = Regex.Replace(e.Row.Cells[5].Text, txtSerHqrsDesc.Text.Trim(), delegate (Match match)
                    {
                        return string.Format("<span style = 'color:red'>{0}</span>", match.Value);
                    }, RegexOptions.IgnoreCase);
                }
            }

            #endregion
        }

        #region TextBox TextChanged Event
        protected void txtSerCode_TextChanged(object sender, EventArgs e)
        {
            txtSerName.Text = "";
            txtSerHqrsCode.Text = "";
            txtSerHqrsDesc.Text = "";
            grdSubject.PageIndex = 0;
            BindGridBySerCode();
        }

        protected void txtSerName_TextChanged(object sender, EventArgs e)
        {
            txtSerCode.Text = "";
            txtSerHqrsCode.Text = "";
            txtSerHqrsDesc.Text = "";
            grdSubject.PageIndex = 0;
            BindGridBySerName();
        }

        protected void txtSerHqrsCode_TextChanged(object sender, EventArgs e)
        {
            txtSerCode.Text = "";
            txtSerHqrsDesc.Text = "";
            grdSubject.PageIndex = 0;
            BindGridBySerHqrsCode();
        }

        protected void txtSerHqrsDesc_TextChanged(object sender, EventArgs e)
        {
            txtSerCode.Text = "";
            txtSerHqrsCode.Text = "";
            txtSerName.Text = "";
            grdSubject.PageIndex = 0;
            BindGridByHqrsDesc();
        }
        #endregion

        protected void txtPageSize_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (txtPageSize.Text != "")
                {
                    if (txtSerCode.Text != "")
                    {
                        grdSubject.PageSize = Convert.ToInt16(txtPageSize.Text);
                        grdSubject.PageIndex = 0;
                        BindGridBySerCode();
                    }
                    else if (txtSerName.Text != "")
                    {
                        grdSubject.PageSize = Convert.ToInt16(txtPageSize.Text);
                        grdSubject.PageIndex = 0;
                        BindGridBySerName();
                    }

                    else if (txtSerHqrsCode.Text != "")
                    {
                        grdSubject.PageSize = Convert.ToInt16(txtPageSize.Text);
                        grdSubject.PageIndex = 0;
                        BindGridBySerHqrsCode();
                    }
                    else if (txtSerHqrsDesc.Text != "")
                    {
                        grdSubject.PageSize = Convert.ToInt16(txtPageSize.Text);
                        grdSubject.PageIndex = 0;
                        BindGridByHqrsDesc();
                    }
                    else
                    {
                        grdSubject.PageSize = Convert.ToInt16(txtPageSize.Text);
                        grdSubject.PageIndex = 0;
                        BindSubjectGrid();
                    }
                }
                else
                {
                    if (txtSerCode.Text != "")
                    {
                        grdSubject.PageSize = Convert.ToInt16(5);
                        grdSubject.PageIndex = 0;
                        BindGridBySerCode();
                    }
                    else if (txtSerName.Text != "")
                    {
                        grdSubject.PageSize = Convert.ToInt16(5);
                        grdSubject.PageIndex = 0;
                        BindGridBySerName();
                    }

                    else if (txtSerHqrsCode.Text != "")
                    {
                        grdSubject.PageSize = Convert.ToInt16(5);
                        grdSubject.PageIndex = 0;
                        BindGridBySerHqrsCode();
                    }
                    else if (txtSerHqrsDesc.Text != "")
                    {
                        grdSubject.PageSize = Convert.ToInt16(5);
                        grdSubject.PageIndex = 0;
                        BindGridByHqrsDesc();
                    }
                    else
                    {
                        grdSubject.PageSize = Convert.ToInt16(5);
                        grdSubject.PageIndex = 0;
                        BindSubjectGrid();
                    }

                }
            }
            catch (Exception)
            {
                AlertMsg.Attributes["class"] = "alert alert-danger";
                lblmsg.Text = "Error Occured ";
                mpeMessageBox.Show();
            }
        }
    }
}