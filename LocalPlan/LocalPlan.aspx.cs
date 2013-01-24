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

using BLL;

public partial class LocalPlans_GeneralInfo : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);


        ddlLevel.DataBind();
        ddlLpNExtLevel.DataBind();

        ddlLevel.Enabled = true;
        String errType = "";


        try
        {
            DropDownList ddlFiscalYear = Master.FindControl("DropDownList2") as DropDownList;
            lp_local_plan lpObj = new lp_local_plan();
            lpObj.ConnectionString = DataAccess.getConnStr();

            hfLpid.Value = Session[Session.SessionID + "PlanID"].ToString();
            HL_Errors.NavigateUrl = "Javascript:OpenErrors(" + hfLpid.Value + ")";
            HL_RPLIST.NavigateUrl = "javascript:OpenReportLIst(" + hfLpid.Value + "," + ddlFiscalYear.SelectedValue + ")";
            if (lpObj.LoadByPrimaryKey(Convert.ToInt32(hfLpid.Value.ToString())))
            {

                txtLocalPlanId.Text = hfLpid.Value.ToString();
                txtCollegeName.Text = lpObj.Txt_college_name;

                txtFiscalYear.Text = lpObj.Nbr_fiscal_year.ToString();

                try
                {
                    txtFiscalYearAppropiation.Text = string.Format("{0:C}", lpObj.Nbr_yearly_appropiation);
                }
                catch
                {
                    txtFiscalYearAppropiation.Text = string.Format("{0:C}", 0);
                }

                try
                {
                    txtTotalActivities.Text = string.Format("{0:C}", lpObj.nbr_total_activities);
                }
                catch
                {
                    txtTotalActivities.Text = string.Format("{0:C}", 0);
                }

                try
                {
                    txtBalance.Text = string.Format("{0:C}", lpObj.nbr_balance);
                }
                catch
                {
                    txtBalance.Text = string.Format("{0:C}", 0);
                }
                

                try
                {
                    txtExpenditures.Text = string.Format("{0:C}", lpObj.nbr_reimbursements);
                }
                catch
                {
                    txtExpenditures.Text = string.Format("{0:C}", 0);
                }


                
                cbAccepted.Checked = lpObj.Flg_accepted_assurances;
                txtSystemOfficeNotes.Text = "";
                ddlLevel.SelectedIndex = ddlLevel.Items.IndexOf(ddlLevel.Items.FindByValue(lpObj.Key_local_plan_level_id.ToString()));


                lblLevel.Text = ddlLevel.SelectedItem.Text;

                ddlLpNExtLevel.DataBind();

                try
                {
                    txtSystemOfficeNotes.Text = lpObj.Txt_system_office_notes.ToString();
                }
                catch (Exception ex)
                {
                    txtSystemOfficeNotes.Text = "";
                }


            }
            cbAccepted.Enabled = false;
            Panel1.Visible = true;
        }
        //catch (NullReferenceException nex)
        //{
        //    lblErr.Text = nex.ToString();
        //}
        catch (Exception ex)
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();
            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
                //lblErr.Text = ex.ToString();
            }
            else
                lblErr.Text = ex.ToString();
            Panel1.Visible = false;
        }


        GearBox_LocalPlan_Security();

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        lblErr.Text = "";
        if (!Page.IsPostBack)
        {
            
        }
        sqlDsLPNextlevel.DataBind();
    }
    protected void btnSubmitPlan_Click(object sender, EventArgs e)
    {

    }


    private void SendPlanLeveledEmail()
    {
        try
        {
            DataView dv_EmlRecep = (DataView)SQLRL_EMAILRECEP.Select(DataSourceSelectArguments.Empty);
            DataView dv_EmlSub = (DataView)SQLRL_EMAILBODYSUB.Select(DataSourceSelectArguments.Empty);
            string ReCEP_LIST = "";
            Utility myobj = new Utility();
            if (dv_EmlRecep.Table.Rows.Count > 0)
            {
                if (ddlLpNExtLevel.SelectedValue == "102" || ddlLpNExtLevel.SelectedValue == "103")
                {

                    foreach (DataRowView dr in dv_EmlRecep)
                    {
                        ReCEP_LIST += (dr["txt_email"] + ",");
                    }
                    myobj.sendEmail(dv_EmlSub.Table.Rows[0]["txt_subject"].ToString(), dv_EmlSub.Table.Rows[0]["txt_body"].ToString(), ReCEP_LIST.ToString());
                }


            }
        }
        catch
        {
        }

    }
   
    protected void ddlLpNExtLevel_DataBound(object sender, EventArgs e)
    {
 
    }



    protected void GearBox_LocalPlan_Security()
    {
        try{
        
        string roleid = Session[Session.SessionID + "roleid"].ToString();

       
        switch (ddlLevel.SelectedValue.ToString())
        {
            case "101":
                //Level 0 Awaiting CO Admin

                switch (roleid)
                {
                    case "101":
                        // Admin

                        btnSaveNote.Visible = true;
                        btnSaveNote.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true; 
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = true;
                        ddlLpNExtLevel.SelectedIndex = ddlLpNExtLevel.Items.IndexOf(ddlLpNExtLevel.Items.FindByValue("102"));
                        break;
                    case "102":
                        //CAO
                       // txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true; 
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = true;
                        ddlLpNExtLevel.Enabled = true;
                        btnSaveNote.Enabled = false;
                       

                        break;
                    case "103":
                        //Perkins Admin
                    
                        txtSystemOfficeNotes.Enabled = true;
                        txtSystemOfficeNotes.ReadOnly = false ;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSaveNote.Visible = true;
                        btnSaveNote.Enabled = true;
                        btnSubmitPlan.Enabled = true;
                        ddlLpNExtLevel.Enabled = true;
                        break;
                    case "104":
                        //View Only
                        ddlLpNExtLevel.Enabled = false;
                    //    txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true; 
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;

                        break;
                }

                break;
            case "102":
                //Level 1 Awaiting CAO
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        
                      //  txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        //txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = true;
                    
                        break;
                    case "101":
                        //SO Admin
                        //ddlLpNExtLevel.SelectedIndex = ddlLpNExtLevel.Items.IndexOf(ddlLpNExtLevel.Items.FindByValue("103"));
                        btnSaveNote.Visible = true;
                      txtSystemOfficeNotes.Enabled = true;
                     
                        btnSubmitPlan.Enabled = true;
                      
                        break;
                    case "104":
                        //View Only
                        ddlLpNExtLevel.Enabled = false;
                       // txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true; txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;

                        break;
                }
                break;
            case "103":
                //Review by So
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        lnkSubmit.Enabled = false;
                     //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true; 
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        btnSaveNote.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        ddlLpNExtLevel.Enabled = false;
                        lnkSubmit.Enabled = false;
                       // txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        btnSaveNote.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        break;
                    case "101":
                        //SO Admin
                        btnSaveNote.Visible = true;
                        ddlLpNExtLevel.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;
                        btnSubmitPlan.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        ddlLpNExtLevel.Enabled = false;
                       // txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        break;
                }
                break;

            case "104":
                //So 3 Revision Requested by So
                switch (roleid)
                {
                    case "103":
                        //CO Admin


                      //  txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSaveNote.Enabled = false;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        break;
                    case "102":
                        //CAO

                       
                       // txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSaveNote.Enabled = false;
                        btnSubmitPlan.Enabled = true;
                    
                        break;
                    case "101":
                        //SO Admin
                        btnSaveNote.Visible = true;
                        ddlLpNExtLevel.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;
                        btnSubmitPlan.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        ddlLpNExtLevel.Enabled = false;
                        btnSaveNote.Enabled = false;
                     //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        break;
                }
                break;

            case "105":
                //Level 4 Pending SDE Review
                switch (roleid)
                {
                    case "103":
                        //CO Admin
                        btnSaveNote.Enabled = false;
                        lnkSubmit.Enabled  = false;
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        lnkSubmit.Enabled = false;
                        btnSaveNote.Enabled = false;
                        btnSubmitPlan.Enabled = false;
                        lnkSubmit.Enabled = false;
                        break;
                    case "101":
                        //SO Admin
                        btnSaveNote.Visible = true;
                        ddlLpNExtLevel.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;
                        btnSubmitPlan.Enabled = true;
                        btnSaveNote.Enabled = true;
                        break;
                    case "104":
                        //View Only
                        ddlLpNExtLevel.Enabled = false;
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        lnkSubmit.Enabled = false;
                        break;
                }
                break;

            case "106":
                //Level 5 Approved
                switch (roleid)
                {
                    case "103":
                        //CO Admin
                        btnSaveNote.Enabled = false;
                        lnkSubmit.Enabled  = false;
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        lnkSubmit.Enabled = false;
                        btnSaveNote.Enabled = false;
                        break;
                    case "101":
                        //SO Admin
                        btnSaveNote.Visible = true;
                        ddlLpNExtLevel.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;
                        btnSubmitPlan.Enabled = true;
                        btnSaveNote.Enabled = true;
                        break;
                    case "104":
                        //View Only
                        ddlLpNExtLevel.Enabled = false;
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        lnkSubmit.Enabled = false;
                        break;
                }
                break;

            case "107":
                //Level 6 Closed
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        lnkSubmit.Enabled = false;
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true; txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        ddlLpNExtLevel.Enabled = false;
                        lnkSubmit.Enabled = false;

                        break;
                    case "101":
                        //SO Admin
                        ddlLpNExtLevel.Enabled = false;
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true; txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        lnkSubmit.Enabled = false;
                        break;
                    case "104":
                        //View Only
                        ddlLpNExtLevel.Enabled = false;
                        //   txtSystemOfficeNotes.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true; txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                        btnSubmitPlan.Enabled = false;
                        lnkSubmit.Enabled = false;
                        break;
                }
                break;
            default:
                // View Only, and anything not covered
                //   txtSystemOfficeNotes.Enabled = false;
                txtSystemOfficeNotes.ReadOnly = true; txtSystemOfficeNotes.ForeColor = System.Drawing.Color.Gray;
                btnSubmitPlan.Enabled = false;
                ddlLpNExtLevel.Enabled = false;
                break;


        }

            //RL added 5/15/2008
        if (ddlLevel.SelectedValue.ToString() != "107" && roleid == "101")
        {
            btnSaveNote.Enabled = true;
        }
        else
        {
            btnSaveNote.Enabled = false;
        }
        if (ddlLevel.SelectedValue.ToString() != "107" && roleid == "101")
        {
            txtSystemOfficeNotes.Enabled = true;
        }

    }
    catch (Exception ex)
    {
        scs_error_dictionary errObj = new scs_error_dictionary();
        errObj.ConnectionString = DataAccess.getConnStr();
        if (errObj.LoadByPrimaryKey("100"))
        {
            lblErr.Text = errObj.Txt_message;
            //lblErr.Text = ex.ToString();
        }
        else
            lblErr.Text = ex.ToString();
        Panel1.Visible = false;
    }
    }
    protected void lnkSubmit_Click(object sender, EventArgs e)
    {
        lblErr.Text = "";

        if (ddlLevel.SelectedIndex == 6)
        {
            //Do Nothing
            lblErr.Text = "Application Locked, level 6";
        }
        else
        {
            try
            {

                DataAccess daObj = new DataAccess();

                String retVal = daObj.updateLocalPlanLevel(Convert.ToInt32(hfLpid.Value), Convert.ToInt32(ddlLpNExtLevel.SelectedValue));

                if (retVal.Trim() != "")
                {
                    SqlDataReader mydr = daObj.getSysMessage(Convert.ToInt32(retVal));

                    if (mydr.HasRows)
                        while (mydr.Read())
                        {
                            lblErr.Text = mydr["msg"].ToString();
                        }

                    switch (retVal)
                    {
                        case "102":
                            HL_Errors.Visible = true;
                            lblErr.Visible = false;
                            break;
                        default:
                            HL_Errors.Visible = false;
                            SendPlanLeveledEmail();
                            lblErr.Visible = true;
                            break;
                    }



                    ddlLevel.DataBind();
                    ddlLpNExtLevel.DataBind();



                }
                else
                {
                    lblErr.Text = "Fail to Update.";
                    HL_Errors.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblErr.Text = ex.ToString();
                HL_Errors.Visible = true;
            }
            
        }
    }
    protected void btnSaveNote_Click(object sender, EventArgs e)
    {
        SQLRL_SAVENOTES.Update();
    }
}
