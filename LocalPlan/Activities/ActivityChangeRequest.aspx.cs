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
using BLL;

public partial class LocalPlan_Activities_FundedActivityChange : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        try
        {
            hfLpId.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
            hfaId.Value = Request.QueryString.Get("aid").ToString();
        }
        catch
        {
        }

        try
        {
            if (Request.QueryString.Get("type").ToString().Equals("activityEquip"))
            {
                Label1.Visible = false;
                Label2.Visible = false;
                RequiredFieldValidator3.Enabled = false;
                txtNewCoreIndicatorDesc.Visible = false;
                CountCharRemain2.Visible = false;
            }
        }
        catch { }
        GearBox_Activity_Funded_Change_Secruity();
        Utility.addPageInfoChange(this.Page, "ActivityFundedChange");
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        txtNewActivityDesc.Attributes.Add("onKeyUp", "calCharNumber1()");
        txtNewCoreIndicatorDesc.Attributes.Add("onKeyUp", "calCharNumber2()");

        if (!Page.IsPostBack)
        {
            SqlDS_RLcoreindi_Get.DataBind();
            cblCoreIndicators.DataBind();
            

            lblMsg.Text = "";
            
            lp_local_plan lpObj = new lp_local_plan();

            if (lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID.ToString() + "PlanID"].ToString())))
            {
                lblCollege.Text = lpObj.Txt_college_name;
                lblFiscalYear.Text = lpObj.Nbr_fiscal_year.ToString();
            }


            act_activity actObj = new act_activity();
            actObj.ConnectionString = DataAccess.getConnStr();

            if (actObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("aid").ToString())))
            {

                lblAvtivityNbr.Text = actObj.Key_activity_id.ToString();
                lblActivityName.Text = actObj.Txt_activity_name;
                

                lblActivityDesc.Text = actObj.Txt_activity_desc;
                
                try
                {
                    lblCoreIndicatorDesc.Text = actObj.Txt_activity_core_indicator_desc;
                    //txtNewCoreIndicatorDesc.Text = actObj.Txt_activity_core_indicator_desc;
                }
                catch
                {
                    lblCoreIndicatorDesc.Text = "";
                    //txtNewCoreIndicatorDesc.Text = "";
                }

                //try
                //{
                //    cbApproved.Checked = actObj.Flg_approved;
                //}
                //catch
                //{
                //    cbApproved.Checked = false;
                //}

            }


            if (Request.QueryString.Get("acrId").ToString().Equals("-1"))
            {
                //Add new 
                btnDelete.Visible = false;
                btnSave.Text = "Add";
                lblAvtivityNbr.Text = "";
                lblDateCreated.Text = DateTime.Now.ToShortDateString();


                txtNewActivityName.Text = actObj.Txt_activity_name;
                //txtNewActivityDesc.Text = actObj.Txt_activity_desc;
                

            }
            else
            {
                // Edit
                btnDelete.Visible = true;
                btnSave.Text = "Save";

                act_change acObj = new act_change();

                if (acObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("acrId").ToString())))
                {
                    txtNewActivityName.Text = acObj.Txt_activity_name_new;

                    try
                    {
                        txtNewCoreIndicatorDesc.Text = acObj.Txt_activity_core_indicator_desc_new;
                    }
                    catch
                    {                        
                        txtNewCoreIndicatorDesc.Text = "";
                    }

                    try
                    {
                        txtNewActivityDesc.Text = acObj.Txt_activity_desc_new;
                    }
                    catch
                    {
                        txtNewActivityDesc.Text = "";
                    }

                    try{
                        cbApproved.Checked = acObj.Flg_approved;                        
                    }
                    catch{
                        cbApproved.Checked = false;
                       
                    }

                    if (cbApproved.Checked)
                    {
                        btnSave.Enabled = false;
                        cbApproved.Enabled = false;
                    }
                    else
                    {
                        btnSave.Enabled = true;
                        cbApproved.Enabled = true;
                    }

                    lblDateCreated.Text = acObj.Dte_create_date.ToShortDateString();
                }
                
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            lblMsg.Text = "";
            hfPageInfo.Value = "0";
            hfFlgSave.Value = "";

            try
            {
                if (Request.QueryString.Get("acrId").Equals("-1"))
                {
                    //Add new Activity Request
                   
                    DataAccess obj = new DataAccess();
                    //Local Plan id will be enter later, use 101 for now
                    int aId = Convert.ToInt32(Request.QueryString.Get("aid").ToString());

                    int key_acId = obj.insertNewActivity(aId,
                                          txtNewActivityName.Text,
                                          txtNewActivityDesc.Text,
                                          txtNewCoreIndicatorDesc.Text);


                    //Insert Core Indicator
                    if (key_acId > 0)
                    {
                        for (int i = 0; i < cblCoreIndicators.Items.Count; i++)
                            if (cblCoreIndicators.Items[i].Selected)
                                obj.insertNewNewCoreInd(key_acId,
                                                        aId,
                                                        Convert.ToInt32(cblCoreIndicators.Items[i].Value));
                    }
                    
                    selectReturnForm(-1);
                }
                else
                {
                    //Update Current Activity Request

                    DataAccess obj = new DataAccess();
                    //Local Plan id will be enter later, use 101 for now
                    int aId = Convert.ToInt32(Request.QueryString.Get("aid").ToString());
                    int acId = Convert.ToInt32(Request.QueryString.Get("acrId").ToString());

                    obj.updateActivityChangeRequest(acId, aId,
                          txtNewActivityName.Text,
                          txtNewActivityDesc.Text,
                          txtNewCoreIndicatorDesc.Text,
                          cbApproved.Checked);


                    //Insert Core Indicator
                    
                        for (int i = 0; i < cblCoreIndicators.Items.Count; i++)
                            if (cblCoreIndicators.Items[i].Selected)
                                obj.insertNewNewCoreInd(acId,
                                                        aId,
                                                        Convert.ToInt32(cblCoreIndicators.Items[i].Value));


                        //Approved by SO
                        if (cbApproved.Checked)
                        {
                            String returnVal = obj.approveChangeRequest(acId, aId);
                        }
                }
                scs_error_dictionary errObj = new scs_error_dictionary();

                if (errObj.LoadByPrimaryKey("200"))
                {
                    lblMsg.Text = errObj.Txt_message;
                }               

            }
            catch
            {
                scs_error_dictionary errObj = new scs_error_dictionary();

                if (errObj.LoadByPrimaryKey("201"))
                {
                    lblMsg.Text = errObj.Txt_message;
                }
            }
        }
    }

    protected void GearBox_Activity_Funded_Change_Secruity()
    {        
        lp_local_plan lpObj = new lp_local_plan();
        lpObj.ConnectionString = DataAccess.getConnStr();
        lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString()));

     //   string mysb;
     //   mysb = "var ddcheck =  document.getElementById('cblCoreIndicators_0');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_1');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_2');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_3');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_4');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_5');ddcheck.disabled =true;";

        string roleid = Session[Session.SessionID + "roleid"].ToString();
        switch (lpObj.Key_local_plan_level_id.ToString())
        {
            case "101":
                //Level 0 Awaiting CO Admin

                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        //cbApproved.Enabled = false;
                        cbApproved.Enabled = false;
                                                                        
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        
                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        
                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        
                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                }

                break;
            case "102":
                //Level 1 Awaiting CAO
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        //cbApproved.Enabled = false;
                        cbApproved.Enabled = false;

                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;

                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                }
                break;
            case "103":
                //Review by So
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        //cbApproved.Enabled = false;
                        cbApproved.Enabled = false;

                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;

                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                }
                break;

            case "104":
                //So 3 Revision Requested by So
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        //cbApproved.Enabled = false;
                        cbApproved.Enabled = false;

                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;

                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                }
                break;

            case "105":
                //Level 4 Pending SDE Review
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        //cbApproved.Enabled = false;
                        cbApproved.Enabled = false;

                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;

                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                }
                break;

            case "106":
                //Level 5 Approved
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        //cbApproved.Enabled = false;
                        cbApproved.Enabled = false;

                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;

                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                }
                break;

            case "107":
                //Level 6 Closed
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        //cbApproved.Enabled = false;
                        cbApproved.Enabled = false;

                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;

                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                }
                break;
            default:
                // View Only, and anything not covered

                break;


        }
    }
    protected void cblCoreIndicators_DataBound(object sender, EventArgs e)
    {
        DataView dx = (DataView)SqlDS_RLcoreindi_Get.Select(DataSourceSelectArguments.Empty);
        foreach (DataRow dr in dx.Table.Rows)
        {
            foreach (ListItem li in cblCoreIndicators.Items)
            {
                if (li.Value.ToString().Trim().ToLower() == dr["key_core_indicator_id"].ToString().ToLower().Trim())
                {
                    li.Selected = true;
                }
            }
        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        selectReturnForm(0);
    }

    protected void selectReturnForm(int option)
    {
        String action = String.Empty;
        if (option == -1 )
        {
            action = "Reload";
        }
        else
        {
            if (cbApproved.Checked && btnSave.Enabled == true)
                action = "Reload";
            else
                action = "Rebind";
        }

        switch (Request.QueryString.Get("type").ToString())
        {
            case "activityFunds":
                InjectScript.Text = "<script>CloseAndRebind('activityFunds','" + action + "');</script>";
                break;
            case "activityEquip":
                InjectScript.Text = "<script>CloseAndRebind('activityEquip','" + action + "');</script>";
                break;
            case "amendmentForm2":
                InjectScript.Text = "<script>CloseAndRebind('amendmentForm2','" + action + "');</script>";
                break;
            default:
                break;
        }      
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        act_change acObj = new act_change();
        
        if (!Request.QueryString.Get("acrid").ToString().Equals("-1"))
        {
            if (hfDelete.Value == "Yes")
            {
                acObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("acrid").ToString()));
                acObj.DeleteCurrentRow();
                acObj.Save();
                InjectScript.Text = "<script>CloseAndRebind()</" + "script>";
            }
        }  
    }
}
