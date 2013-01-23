using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Drawing;
using BLL;

public partial class Administration_CollegeAppropiation : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
        Panel panControl = (Panel)Master.FindControl("panControl");
        if (panControl != null)
            panControl.Visible = false;


        Label lblCollege = (Label)Master.FindControl("lblCollege");
        if (lblCollege != null)
            lblCollege.Visible = false;

        DropDownList DropDownList1 = (DropDownList)Master.FindControl("DropDownList1");
        if (DropDownList1 != null)
            DropDownList1.Visible = false;

        Label Label2 = (Label)Master.FindControl("Label2");
        if (Label2 != null)
            Label2.Visible = false;

        DropDownList DropDownList2 = (DropDownList)Master.FindControl("DropDownList2");
        if (DropDownList2 != null)
            DropDownList2.Visible = false;

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            btnCreatePlan.Visible = false;
            btnSave.Visible = false;           

                        
        }
    }
    protected void ddCollege_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddCollege.Items.IndexOf(li) < 0)
            ddCollege.Items.Insert(0, li);
    }
    protected void ddFiscalYear_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddFiscalYear.Items.IndexOf(li) < 0)
            ddFiscalYear.Items.Insert(0, li);
    }
    protected void btnGo_Click(object sender, ImageClickEventArgs e)
    {
        performSelectChange();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (cbLocked.Checked == true)
        {
            if (Convert.ToDecimal(txtAppropiation.Text) > 0)
            {
                DataAccess obj = new DataAccess();
                String updRes = obj.updateLocalPlan(Convert.ToInt32(lblLocalPlan.Text), Convert.ToDecimal(txtAppropiation.Text), cbLocked.Checked);
                int ilp_id;
                try
                {
                    ilp_id = Convert.ToInt32(updRes);
                    if (ilp_id < 0)
                    {
                        lblMsg.Text = updRes.ToString();
                    }
                    else
                    {
                        lblMsg.ForeColor = Color.Green;
                        lblMsg.Text = "Save Successful!";
                        txtAppropiation.Enabled = false;
                        cbLocked.Enabled = false;
                        btnSave.Visible = false;
                    }
                }
                catch
                {
                    lblMsg.Text = updRes.ToString();
                }                
            }
            else
            {
                lblMsg.ForeColor = Color.Red;
                lblMsg.Text = "Invalid input, Yearly Appropiation has to be greater than 0 in order to lock local plan";
            }
        }else{
            DataAccess obj = new DataAccess();
            String updRes = obj.updateLocalPlan(Convert.ToInt32(lblLocalPlan.Text), Convert.ToDecimal(txtAppropiation.Text), cbLocked.Checked);
            int ilp_id;
            try
            {
                ilp_id = Convert.ToInt32(updRes);
                if (ilp_id < 0)
                {
                    lblMsg.Text = updRes.ToString();
                }
                else
                {
                    lblMsg.ForeColor = Color.Green;
                    lblMsg.Text = "Save Successful!";
                }
            }
            catch
            {
                lblMsg.Text = updRes.ToString();
            }                         
        }
    }
    protected void btnCreatePlan_Click(object sender, EventArgs e)
    {
        if (cbLocked.Checked == true)
        {
            if (Convert.ToDecimal(txtAppropiation.Text) > 0)
            {
                DataAccess obj = new DataAccess();
                String insRes = obj.insertLocalPlan(Convert.ToInt32(ddCollege.SelectedValue), 
                                                    Convert.ToInt32(ddFiscalYear.SelectedValue), 
                                                    Convert.ToDecimal(txtAppropiation.Text), 
                                                    cbLocked.Checked,
                                                     HttpContext.Current.User.Identity.Name.ToString());
                int ilp_id;
                try
                {
                    ilp_id = Convert.ToInt32(insRes);
                    if (ilp_id < 0)
                    {
                        if (insRes.Trim() == "-1")
                        {
                            lblMsg.Text = "Error: Narratives have not been Set, Local Plan not saved";
                        }
                        else
                        {
                        lblMsg.Text = insRes.ToString();
                        }
                    }
                    else
                    {
                        lblMsg.ForeColor = Color.Green;
                        lblMsg.Text = "Create Successful!";
                        
                        txtAppropiation.Enabled = false;
                        cbLocked.Enabled = false;

                        btnSave.Visible = false;
                        btnCreatePlan.Visible = false;
                        lblLocalPlan.Text = insRes;

                        scs_local_plan_level lplObj = new scs_local_plan_level();

                        if (lplObj.LoadByPrimaryKey(ilp_id))
                        {
                            lblStatus.Text = lplObj.Txt_local_plan_level_status;
                            lblLevel.Text = lplObj.Txt_local_plan_level_status_desc;
                        }
                    }
                }
                catch
                {
                    if (insRes.Trim() == "-1")
                    {
                        lblMsg.Text = "Error: Narratives have not been Set, Local Plan not saved";
                    }
                    else
                    {
                        lblMsg.Text = insRes.ToString();
                    }



                }
            }
            else
            {
                lblMsg.ForeColor = Color.Red;
                lblMsg.Text = "Invalid input, Yearly Appropiation has to be greater than 0 in order to lock local plan";
            }
        }
        else
        {
            DataAccess obj = new DataAccess();
            String insRes = obj.insertLocalPlan(Convert.ToInt32(ddCollege.SelectedValue), 
                                                Convert.ToInt32(ddFiscalYear.SelectedValue), 
                                                Convert.ToDecimal(txtAppropiation.Text), 
                                                cbLocked.Checked,
                                                HttpContext.Current.User.Identity.Name.ToString());
            int ilp_id;
            try
            {
                ilp_id = Convert.ToInt32(insRes);
                if (ilp_id < 0)
                {
                    if (insRes.Trim() == "-1")
                    {
                        lblMsg.Text = "Error: Narratives have not been Set, Local Plan not saved";
                    }
                    else
                    {
                        lblMsg.Text = insRes.ToString();
                    }
                }
                else
                {
                    lblMsg.ForeColor = Color.Green;
                    lblMsg.Text = "Create Successful!";
                    btnSave.Visible = true;
                    btnCreatePlan.Visible = false;
                    lblLocalPlan.Text = insRes;

                    scs_local_plan_level lplObj = new scs_local_plan_level();

                    if (lplObj.LoadByPrimaryKey(101))
                    {
                        lblStatus.Text = lplObj.Txt_local_plan_level_status;
                        lblLevel.Text = lplObj.Txt_local_plan_level_status_desc;
                    }
                }
            }
            catch
            {
                lblMsg.Text = insRes.ToString();
            }
        }
    }
    protected void ddCollege_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtAppropiation.Enabled = true;
        cbLocked.Enabled = true;
        btnSave.Visible  = true;
        performSelectChange();
    }

    protected void performSelectChange()
    {
        int iCid = Convert.ToInt32(ddCollege.SelectedValue);
        int iFy = Convert.ToInt32(ddFiscalYear.SelectedValue);

        DataAccess obj = new DataAccess();
        SqlDataReader mydr = obj.getLocalPlan(iCid, iFy);
        if (mydr.Read())
        {
            if (mydr.HasRows)
            {
                btnCreatePlan.Visible = false;
                btnSave.Visible = true;


                try
                {
                    cbLocked.Checked = (bool)mydr["flg_locked"];
                }
                catch
                {
                    cbLocked.Checked = false;
                }

                if (cbLocked.Checked == true)
                {
                    txtAppropiation.Enabled = false;
                    cbLocked.Enabled = false;
                    btnSave.Visible  = false;
                }
                else
                {
                    txtAppropiation.Enabled = true;
                    cbLocked.Enabled = true;
                    btnSave.Visible  = true;
                }
                lblLocalPlan.Text = mydr["key_local_plan_id"].ToString();
                txtAppropiation.Text = string.Format("{0:n}",mydr["nbr_yearly_appropiation"]);
                lblTotalAllAct.Text = string.Format("{0:n}", mydr["nbr_total_activities"]);
                lblBalance.Text = string.Format("{0:n}", mydr["nbr_balance"]);
                
                lblStatus.Text = mydr["txt_local_plan_level_status"].ToString();
                lblLevel.Text = mydr["txt_local_plan_level_status_desc"].ToString();
                
            }

        }
        else
        {
            lblLocalPlan.Text = "";
            txtAppropiation.Text = "";
            lblTotalAllAct.Text = "";
            lblBalance.Text = "";
            cbLocked.Checked = false;
            lblStatus.Text = "";
            lblLevel.Text = "";
            btnCreatePlan.Visible = true;
            btnSave.Visible = false;
        }
        lblMsg.Text = "";
    }
    protected void ddFiscalYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtAppropiation.Enabled = true;
        performSelectChange();
    }
}
