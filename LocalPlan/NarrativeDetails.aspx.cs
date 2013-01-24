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
using Telerik.WebControls;


public partial class LocalPlan_NarrativeDetails : System.Web.UI.Page
{

    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
        try
        {
            hfLevel.Value = Request.QueryString.Get("level").ToString();
        }
        catch { hfLevel.Value = "-1"; }
        GearBox_NarrativeDetails_Security();

    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ddStatus.DataBind();

            //Add attributes
            //btnEditResponse.Attributes.Add("onclick", "TextEdit()");

            lblId.Text = Request.QueryString.Get("nid").ToString();
            String ssId = "TextEditor" + Request.QueryString["nid"].ToString();

            DataAccess obj = new DataAccess();
            SqlDataReader dr = obj.getNarrativeDetails(Convert.ToInt32(Request.QueryString["nid"].ToString()));


            if (dr.HasRows)
                while (dr.Read())
                {
                    lp_local_plan lpObj = new lp_local_plan();

                    if (lpObj.LoadByPrimaryKey(Convert.ToInt32(dr["key_local_plan_id"].ToString())))
                    {
                        lblCollege.Text = lpObj.Txt_college_name;
                        lblFiscalYear.Text = lpObj.Nbr_fiscal_year.ToString();
                    }

                    lblId.Text = dr["key_local_plan_narrative_id"].ToString();
                    hfNid.Value = dr["key_local_plan_narrative_id"].ToString();
                    lblSection.Text = dr["txt_narrative_section_title"].ToString();
                    lblDescription.Text = dr["txt_narrative_desc"].ToString();

                    if (Session[ssId] == null)
                    {
                        lblResponse.Text = dr["txt_narrative_response"].ToString();
                        Session.Add(ssId, lblResponse.Text);
                        //Session[ssId] = ;
                    }
                    else
                        lblResponse.Text = (String)Session[ssId];

                    this.txtSystemOfficeNotes.Text = dr["txt_system_office_notes"].ToString();

                    try
                    {
                        cbLocked.Checked = (bool)dr["flg_locked"];

                    }
                    catch
                    {
                        cbLocked.Checked = false;
                    }
                    try
                    {
                        cbApproved.Checked = (bool)dr["flg_approved"];
                    }
                    catch
                    {
                        cbApproved.Checked = false;
                    }

                    ddStatus.SelectedIndex = ddStatus.Items.IndexOf(ddStatus.Items.FindByValue(dr["key_level_id"].ToString()));

                    if ((bool)dr["flg_optional"] == true)
                        lblResponsOpt.Text = "Response Optional";
                    else
                        lblResponsOpt.Text = "Response Required";
                    try
                    {
                        lblDateUpdated.Text = string.Format("{0:d}", dr["dte_updated_date"]);
                    }
                    catch
                    {
                        lblDateUpdated.Text = "";
                    }

                    try
                    {
                        lblUpdatedBy.Text = dr["txt_updated_user"].ToString();
                    }
                    catch
                    {
                        lblUpdatedBy.Text = "";
                    }

                }            
        }
        
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
            Save(true);
    }

    protected void Save(bool displayMsg)
    {
        lp_local_plan_narrative lpnObj = new lp_local_plan_narrative();
        lpnObj.ConnectionString = DataAccess.getConnStr();
        try
        {

            if (lpnObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("nid").ToString())))
            {
                lpnObj.Txt_narrative_response = lblResponse.Text;
                lpnObj.Txt_system_office_notes = txtSystemOfficeNotes.Text;
                lpnObj.Flg_locked = cbLocked.Checked;
                lpnObj.Flg_approved = cbApproved.Checked;
                lpnObj.Dte_updated_date = DateTime.Now;
                lblDateUpdated.Text = DateTime.Now.ToShortDateString();
                lpnObj.Txt_updated_user = HttpContext.Current.User.Identity.Name.ToString();
                lblUpdatedBy.Text = HttpContext.Current.User.Identity.Name.ToString();
                //Check with Warren for key_level_id

                lpnObj.Key_level_id = Convert.ToInt32(ddStatus.SelectedValue);
                lpnObj.Save();
            }
            scs_error_dictionary errObj = new scs_error_dictionary();

            if (errObj.LoadByPrimaryKey("200"))
            {
                if (displayMsg)
                    lblErr.Text = errObj.Txt_message;
                else
                    lblErr.Text = "";
            }
        }
        catch (Exception ex)
        {
            lblErr.Text = ex.ToString();
        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            Session.Remove("TextEditor" + Request.QueryString["nid"].ToString());
        }
        catch { }
    }
    protected void btnEditResponse_Click(object sender, EventArgs e)
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }

    protected void Lock_SO()
    {
        cbApproved.Enabled = false;
        cbLocked.Enabled = false;
        ddStatus.Enabled = false;
        disable_textBoxes(txtSystemOfficeNotes);
    }

    protected void UnLock_SO()
    {
        cbApproved.Enabled = true;
        cbLocked.Enabled = true;
        ddStatus.Enabled = true;
        txtSystemOfficeNotes.Enabled = true;
    }

    protected void Lock_Page()
    {
        LinkButton1.Visible= false;
        Lock_SO();
    }

    protected void UnLock_Page()
    {
        LinkButton1.Visible = true;
        UnLock_SO();
    }




    protected void GearBox_NarrativeDetails_Security()
    {
      
        lp_local_plan lpObj = new lp_local_plan();
        lpObj.ConnectionString = DataAccess.getConnStr();
        try
        {
            lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString()));
      


        string roleid = Session[Session.SessionID + "roleid"].ToString();
        switch (lpObj.Key_local_plan_level_id.ToString())
        {
            case "101":
                //Level 0 Awaiting CO Admin

                switch (roleid)
                {
                    case "103":
                        //CO Admin
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnClose.Enabled = true;
                        btnPrint.Enabled = true;

                        disable_textBoxes(txtSystemOfficeNotes);

                        
                        ddStatus.Enabled = false; 
                        break;
                    case "102":
                        //CAO
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnClose.Enabled = true;
                        btnPrint.Enabled = true;
                        disable_textBoxes(txtSystemOfficeNotes);
                        ddStatus.Enabled = false;

                        break;
                    case "101":
                        //SO Admin
                        cbLocked.Enabled = true;
                        cbApproved.Enabled = true;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnClose.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = true;
                        txtSystemOfficeNotes.ReadOnly = false;
                        break;
                    case "104":
                        //View Only
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        btnClose.Enabled = true;
                        btnPrint.Enabled = true;
                        disable_textBoxes(txtSystemOfficeNotes);
                        ddStatus.Enabled = false;
                        LinkButton1.Visible = false;
                        break;
                }

                break;
            case "102":
                //Level 1 Awaiting CAO
                switch (roleid)
                {
                    case "103":
                        //CO Admin
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnClose.Enabled = true;
                        btnPrint.Enabled = true;
                        disable_textBoxes(txtSystemOfficeNotes);
                        ddStatus.Enabled = false;

                        break;
                    case "102":
                        //CAO
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnClose.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false; 
                        disable_textBoxes(txtSystemOfficeNotes);
                        break;
                    case "101":
                        //SO Admin
                        cbLocked.Enabled = true;
                        cbApproved.Enabled = true;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnClose.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = true;
                        txtSystemOfficeNotes.ReadOnly = false;
                        break;
                    case "104":
                        //View Only
                        LinkButton1.Enabled = true;
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                }
                break;
            case "103":
                //Review by So
                switch (roleid)
                {
                    case "103":
                        //CO Admin
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false;
                        txtSystemOfficeNotes.ReadOnly = true;
                        LinkButton1.Visible = false;

                        break;
                    case "102":
                        //CAO
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;

                        break;
                    case "101":
                        //SO Admin
                        cbLocked.Enabled = true;
                        cbApproved.Enabled = true;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;
                        break;
                    case "104":
                        //View Only
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                   //10-8-2009 RL BtnPrint no longer Disables     btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                }
                break;

            case "104":
                //So 3 Revision Requested by So
                switch (roleid)
                {
                    case "103":
                        //CO Admin
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);

                        break;
                    case "102":
                        //CAO
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);


                        break;
                    case "101":
                        //SO Admin
                        cbLocked.Enabled = true;
                        cbApproved.Enabled = true;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;
                        break;
                    case "104":
                        //View Only
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        //10-8-2009 RL btnprint button no longer disables  btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                }
                break;

            case "105":
                //Level 4 Pending SDE Review
                switch (roleid)
                {
                    case "103":
                        //CO Admin
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;

                        break;
                    case "102":
                        //CAO
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                    case "101":
                        //SO Admin

                        cbLocked.Enabled = true;
                        cbApproved.Enabled = true;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;
                        break;
                    case "104":
                        //View Only
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                }
                break;

            case "106":
                //Level 5 Approved
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        //10-8-2009 RL btnprint button no longer disables    btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                    case "102":
                        //CAO
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        //10-8-2009 RL btnprint button no longer disables        btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                    case "101":
                        //SO Admin
                        cbLocked.Enabled = true;
                        cbApproved.Enabled = true;
                        btnEditResponse.Enabled = true;
                        btnUpdate.Enabled = true;
                        btnPrint.Enabled = true;
                        ddStatus.Enabled = true; 
                        txtSystemOfficeNotes.Enabled = true;
                        LinkButton1.Enabled = true;
                        break;
                    case "104":
                        //View Only
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;   
                    //10-8-2009 RL btnprint button no longer disables    btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                }
                break;

            case "107":
                //Level 6 Closed
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        //10-8-2009 RL btnprint button no longer disables   btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                    case "102":
                        //CAO
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        //10-8-2009 RL btnprint button no longer disables  btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;

                        break;
                    case "101":
                        //SO Admin
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        //10-8-2009 RL btnprint button no longer disables  btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;

                        break;
                    case "104":
                        //View Only
                        cbLocked.Enabled = false;
                        cbApproved.Enabled = false;
                        btnEditResponse.Enabled = false;
                        btnUpdate.Enabled = false;
                        //10-8-2009 RL btnprint button no longer disables  btnPrint.Enabled = false;
                        ddStatus.Enabled = false;
                        disable_textBoxes(txtSystemOfficeNotes);
                        LinkButton1.Visible = false;
                        break;
                }
                break;
            default:
                // View Only, and anything not covered

                break;


        }
    }
    catch
    {
    }
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        if(btnUpdate.Enabled == true)        
            if (Page.IsValid)
            {
                Save(false);
                //lblPrintTrigger.Text = "<script>Print()</" + "script>";
            }
    }

    protected void disable_textBoxes(TextBox mybox)
    {
        if (mybox.TextMode == TextBoxMode.MultiLine)
        {
            mybox.ReadOnly = true;
            mybox.ForeColor = System.Drawing.Color.Gray;
        }
        else
            mybox.Attributes.Add("ReadOnly", "ReadOnly");
    }
}
