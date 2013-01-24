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
using Telerik.WebControls;
using System.Data.SqlClient;
using BLL;

public partial class LocalPlan_FundingPlan_FundingPlan : System.Web.UI.Page
{
    protected string emailfundplanbody = string.Empty;
    protected string emailfundplansubject = string.Empty;
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        try
        {
            
            if (Session[Session.SessionID.ToString() + "PlanID"].ToString() == "-1")
            {
                scs_error_dictionary errObj = new scs_error_dictionary();

                hfLocal_plan_id.Value = "-1";
                if (errObj.LoadByPrimaryKey("100"))
                {
                    lblErr.Text = errObj.Txt_message;
                }
                Panel1.Visible = false;
            }
            else
            {
                if (hfLocal_plan_id.Value.ToString() != Session[Session.SessionID.ToString() + "PlanID"].ToString())
                {
                    hfLocal_plan_id.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
                    FundPlanChange();
                }                
                
                lblErr.Text = "";
                Panel1.Visible = true;
             
            }

            SqlDataReader dr = FundingPlan.get_Header_Info(Convert.ToInt32(cbFundPlanVersion.SelectedValue.ToString()));

            if (dr.HasRows)
            {
                while (dr.Read())
                    FundingPlan_GearBox(dr["key_funding_plan_level_id"].ToString());
            }
        }
        catch
        {
            scs_error_dictionary errObj = new scs_error_dictionary();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = "<image src='../../images/msgIcons/stop.jpg' style='WIDTH: 25px;VERTICAL-ALIGN: middle; valign=middle; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 26px; BORDER-BOTTOM-STYLE: none' />  There is no local plan for this selection! Please contact system office.";
            }
            Panel1.Visible = false;
        }        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToInt16(hf_fundingPlanid.Value) > 0)
            {
            }
            else
            {
                txtComments.Enabled = false;
                btn_Comments.Enabled = false;
            }

        }
            catch
        {
            }

        lblVersion.Attributes.Add("visibility", "hidden");
        HL_ErrorMessage.Visible = false;
        if (!Page.IsPostBack)
        {
            
        }       
    }
    //protected void RadComboBox1_DataBound(object sender, EventArgs e)
    //{
    //    RadComboBoxItem li = new RadComboBoxItem("", "-1");
    //    if (cbFundPlanVersion.Items.IndexOf(li) < 0)
    //        cbFundPlanVersion.Items.Insert(0, li);
    //}
    protected void cbFundPlanVersion_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (cbFundPlanVersion.SelectedIndex > 0)
        {
            String nextLevel = "-1"; 
            panFundPlan.Visible = true;
            gvFundingPlan.DataBind();
            tsFundPlan.SelectedIndex = 0;
            RadMultiPage1.SelectedIndex = 0;

            SqlDataReader dr = FundingPlan.get_Header_Info(Convert.ToInt32(cbFundPlanVersion.SelectedValue.ToString()));
            
            if(dr.HasRows)
            {
                while(dr.Read())
                {
                    lblVersion.Text = dr["nbr_version_nbr"].ToString();
                    txtComments.Text = dr["txt_Comments"].ToString();
                    lblLevel.Text = dr["txt_funding_plan_level_desc"].ToString();
                    nextLevel = dr["key_funding_plan_level_id"].ToString();
                }
            }

            if (dsNextLevel.SelectParameters.Count > 0)
            {
                dsNextLevel.SelectParameters.RemoveAt(0);
            }
            dsNextLevel.SelectParameters.Add(new Parameter("p_nbr_current_lp_next_level_nbr", TypeCode.Int32, nextLevel));
            dsNextLevel.DataBind();
            ddNextLevel.DataBind();
        }
        else
        {   
            panFundPlan.Visible = false;
        }
    }
    protected void cbFundPlanVersion_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (cbFundPlanVersion.Items.IndexOf(li) < 0)
            cbFundPlanVersion.Items.Insert(0, li);

         }
    protected void cbFundPlanVersion_SelectedIndexChanged1(object sender, EventArgs e)
    {
        string planVersion = "0";
        if (cbFundPlanVersion.SelectedIndex > 0)
        {
            String fpLevel = "-1";   
            panFundPlan.Visible = true;
            gvFundingPlan.DataBind();
            tsFundPlan.SelectedIndex = 0;
            RadMultiPage1.SelectedIndex = 0;
            
            SqlDataReader dr = FundingPlan.get_Header_Info(Convert.ToInt32(cbFundPlanVersion.SelectedValue.ToString()));

            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    lblVersion.Text = dr["nbr_version_nbr"].ToString();
                    txtComments.Text = dr["txt_Comments"].ToString();
                    lblLevel.Text = dr["txt_funding_plan_level_desc"].ToString();
                    fpLevel = dr["key_funding_plan_level_id"].ToString();
                    planVersion = dr["nbr_version_nbr"].ToString();
                }
            }


            FundingPlan_GearBox(fpLevel);
            if (dsNextLevel.SelectParameters.Count > 0)
            {
                dsNextLevel.SelectParameters.RemoveAt(0);
            }
            dsNextLevel.SelectParameters.Add(new Parameter("p_nbr_current_lp_next_level_nbr", TypeCode.Int32, fpLevel));
            dsNextLevel.DataBind();
            ddNextLevel.DataBind();

            //Change Grid FundingPlan
            if (fpLevel == "106")
            {
                dsFundPlan106.DataBind();
                gvFundingPlan.DataSource = dsFundPlan106;
            }
            else
            {
                dsFundPlan.DataBind();
                gvFundingPlan.DataSource = dsFundPlan;
            }
            gvFundingPlan.Rebind();

/* 10-29-2008
 * Rick L added section 
 * if the level of the selected funding plan is 106 the disable the next level drop down and the Submit button
 */
            if (fpLevel == "106")
            {
                btnSubmit.Enabled = false;
                ddNextLevel.Enabled = false;

            }
            else
            {
                btnSubmit.Enabled = true;
                ddNextLevel.Enabled = true;
            }
/* end 10-29-2008 RicK L add */

        }
        else
        {
            panFundPlan.Visible = false;
        }       
       
        hf_fundingPlanid.Value = cbFundPlanVersion.SelectedValue.ToString();
/* 6-11-2009 Rick L add for Plan Version check if verion is 1 submit disabled no matter what */
        if (planVersion == "1")
            btnSubmit.Enabled = false;
    }
    private void disableallcontrols()
    {
        btnExportToExcel.Enabled = false;
        btnPrint.Enabled = false;
        btnSubmit.Enabled = false;
     //   cbFundPlanVersion.Enabled = false;
        ddNextLevel.Enabled = false;
    }
    private void FundingPlan_GearBox(string planLevel)
    {
        string roleid = Session[Session.SessionID + "roleid"].ToString();

        switch (planLevel)
        {
            case "101":
                switch (roleid)
                {
                    case "101":
                        // Admin

                        break;
                    case "102":
                        //CAO
                  
                        break;
                    case "103":
                        //Perkins Admin

                        break;
                    case "104":
                        //View Only
                        disableallcontrols();
                        break;
                }

                break;
            case "102":
                switch (roleid)
                {
                    case "101":
                        // Admin

                        break;
                    case "102":
                        //CAO

                        break;
                    case "103":
                        //Perkins Admin

                        break;
                    case "104":
                        //View Only
                        disableallcontrols();
                        break;
                }
                break;
            case "103":
                switch (roleid)
                {
                    case "101":
                        // Admin

                        break;
                    case "102":
                        //CAO
                        btnSubmit.Enabled = false;
                        ddNextLevel.Enabled = false;
                        break;
                    case "103":
                        //Perkins Admin
                        btnSubmit.Enabled = false;
                        ddNextLevel.Enabled = false;
                        break;
                    case "104":
                        //View Only
                        disableallcontrols();
                        break;
                }
                break;
            case "104":
                switch (roleid)
                {
                    case "101":
                        // Admin

                        break;
                    case "102":
                        //CAO

                        break;
                    case "103":
                        //Perkins Admin

                        break;
                    case "104":
                        //View Only
                        disableallcontrols();
                        break;
                }
                break;
            case "105":
                switch (roleid)
                {
                    case "101":
                        // Admin

                        break;
                    case "102":
                        //CAO
                        btnSubmit.Enabled = false;
                        ddNextLevel.Enabled = false;
                        break;
                    case "103":
                        //Perkins Admin
                        btnSubmit.Enabled = false;
                        ddNextLevel.Enabled = false;
                        break;
                    case "104":
                        //View Only
                        disableallcontrols();
                        break;
                }
                break;
            case "106":
                switch (roleid)
                {
                    case "101":
                        // Admin

                        break;
                    case "102":
                        //CAO
                        btnSubmit.Enabled = false;
                        ddNextLevel.Enabled = false;
                        break;
                    case "103":
                        //Perkins Admin
                        btnSubmit.Enabled = false;
                        ddNextLevel.Enabled = false;
                        break;
                    case "104":
                        //View Only
                        disableallcontrols();
                        break;
                }
                break;
            default:
                break;
        }



    }

    protected void FundPlanChange()
    {
        cbFundPlanVersion.DataBind();
        panFundPlan.Visible = false;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Utility uObj = new Utility();
        string st_errorMessage = string.Empty;

        String fpLevel = String.Empty;
        String nextLevel = ddNextLevel.SelectedValue.ToString();
        SqlDataReader dr = FundingPlan.get_Header_Info(Convert.ToInt32(cbFundPlanVersion.SelectedValue.ToString()));

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                fpLevel = dr["key_funding_plan_level_id"].ToString();
            }
        }
        String user = string.Empty;
        try
        {
            user = Session[Session.SessionID + "displayname"].ToString();
        }
        catch { }

        //Submit Funding Plan
        try
        {
            tblRes.Text = FundingPlan.update_FundingPlan(Convert.ToInt32(hfLocal_plan_id.Value), Convert.ToInt32(cbFundPlanVersion.SelectedValue), Convert.ToInt32(nextLevel), user);
        }
        catch
        {
        }

        if (tblRes.Text == "101")
        {
            
            Get_emailbodysubject_for_fundingplan(cbFundPlanVersion.SelectedValue.ToString());
            string revisionreason = "";
            if (ddNextLevel.SelectedValue == "104")
            {
                revisionreason =  System.Environment.NewLine + "<br/><P />Revision Reasons:"  + Server.HtmlEncode(txtComments.Text);
            }
            uObj.sendEmail(emailfundplansubject, emailfundplanbody + revisionreason, Get_emailaddresses_for_fundingplan(cbFundPlanVersion.SelectedValue.ToString()));

            dsFundPlanVersion.DataBind();
            cbFundPlanVersion.DataBind(); 

            if (dsNextLevel.SelectParameters.Count > 0)
            {
                dsNextLevel.SelectParameters.RemoveAt(0);
            }
            dsNextLevel.SelectParameters.Add(new Parameter("p_nbr_current_lp_next_level_nbr", TypeCode.Int32, nextLevel));
            dsNextLevel.DataBind();
            ddNextLevel.DataBind();
          cbFundPlanVersion.DataBind();

          int itemcount = cbFundPlanVersion.Items.Count;
          cbFundPlanVersion.SelectedIndex = cbFundPlanVersion.Items.IndexOf(cbFundPlanVersion.Items[itemcount - 1]);

           
          }
        else
        {
            SqlConnection myerrconn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);
            SqlCommand myerrcomm = new SqlCommand("Select txt_message from scs_perkins_sys_messages where key_perkins_sys_message_id = " + tblRes.Text, myerrconn);
            
            if (myerrconn.State != ConnectionState.Open)
            myerrconn.Open();
        HL_ErrorMessage.Visible = true;
            st_errorMessage = myerrcomm.ExecuteScalar().ToString();

            HL_ErrorMessage.Text = "* Errors";
            HL_ErrorMessage.NavigateUrl="javascript:showerrors('" + st_errorMessage + "');";
            lblErr.Text = st_errorMessage;
            lblErr.Visible = true;
            uObj.sendEmail("Submit Funding Plan: " + cbFundPlanVersion.SelectedValue.ToString(), "fpLevel: " + fpLevel + ", nextLevel: " + nextLevel + "<br />Failed. <br/>" + st_errorMessage, "vu@sctechsystem.edu,durham@sctechsystem.edu,lowryr@sctechsystem.edu");
        }


        // This segment is took out because it disable the Submit button (VV)
        //if (fpLevel == "104")
        //{
        //    btnSubmit.Enabled = false;
        //}
    }

    protected void Get_emailbodysubject_for_fundingplan(string levelid)
    {

        SqlConnection myerrconn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);
        SqlCommand myerrcomm = new SqlCommand("pr_fp_funding_plan_level_email", myerrconn);
        myerrcomm.CommandType = CommandType.StoredProcedure;
        myerrcomm.Parameters.AddWithValue("p_key_funding_plan_hdr_id", levelid);
        if (myerrconn.State != ConnectionState.Open)
            myerrconn.Open();
        SqlDataReader dr = myerrcomm.ExecuteReader(CommandBehavior.CloseConnection);

        while (dr.Read())
        {
            emailfundplanbody = dr["txt_body"].ToString();
            emailfundplansubject = dr["txt_subject"].ToString();

        }

    }

    protected String Get_emailaddresses_for_fundingplan(string levelid)
    {
        String emails = String.Empty;

        SqlConnection myerrconn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);
        SqlCommand myerrcomm = new SqlCommand("pr_funding_plan_level_email_recipient", myerrconn);
        myerrcomm.CommandType = CommandType.StoredProcedure;
        myerrcomm.Parameters.AddWithValue("p_key_funding_plan_hdr_id", levelid);
        if (myerrconn.State != ConnectionState.Open)
            myerrconn.Open();
        SqlDataReader dr = myerrcomm.ExecuteReader(CommandBehavior.CloseConnection);

        while (dr.Read())
        {
            emails += dr["txt_email"].ToString() + ",";
        }
        //emails.Remove(emails.Length - 1);
        string finalrecip="";
        try
        {
            finalrecip = emails.Remove(emails.Length - 1);
        }
        catch (Exception ex)
        {
        }
        return finalrecip;
    }





    double gridtotal = 0;
    double linetotal=0;
    double totalS = 0;
    double totalFC = 0;
    double totalPS = 0;
    double totalIS = 0;
    double totalIC = 0;
    double totalE = 0;

    protected void gvFundingPlan_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            Label tb = (Label)e.Item.FindControl("lblSum");
            if (tb != null)
            {
                linetotal = Convert.ToDouble(Convert.ToDecimal(dataItem["Salary"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Fixed Charges"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Purchased Services"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Instructional Supplies"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Indirect Costs"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Equipment"].Text.Replace("$", "")));
                tb.Text = string.Format("{0:c}", linetotal);
                totalS += Double.Parse(dataItem["Salary"].Text.Replace("$", ""));
                totalFC += Double.Parse(dataItem["Fixed Charges"].Text.Replace("$", ""));
                totalPS += Double.Parse(dataItem["Purchased Services"].Text.Replace("$", ""));
                totalIS += Double.Parse(dataItem["Instructional Supplies"].Text.Replace("$", ""));
                totalIC += Double.Parse(dataItem["Indirect Costs"].Text.Replace("$", ""));
                totalE += Double.Parse(dataItem["Equipment"].Text.Replace("$", ""));

                if (linetotal > 0)
                    dataItem.BackColor = System.Drawing.Color.LightYellow;

                gridtotal += linetotal;
            }
            
        
        }

        if (e.Item is GridFooterItem)
        {
            GridFooterItem footerItem = e.Item as GridFooterItem;
            footerItem["Salary"].Text = string.Format("{0:c}", totalS);
            footerItem["Fixed Charges"].Text = string.Format("{0:c}", totalFC);
            footerItem["Purchased Services"].Text = string.Format("{0:c}", totalPS);
            footerItem["Instructional Supplies"].Text = string.Format("{0:c}", totalIS);
            footerItem["Indirect Costs"].Text = string.Format("{0:c}", totalIC);
            footerItem["Equipment"].Text = string.Format("{0:c}", totalE);

            (footerItem.FindControl("lblFooterSum") as Label).Text = string.Format("{0:c}", gridtotal);
        }
    }
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        if(cbFundPlanVersion.SelectedIndex > 0)        
            switch (tsFundPlan.SelectedIndex)
            {
                case 0:
                    gvFundingPlan.ExportSettings.ExportOnlyData = true;
                    gvFundingPlan.ExportSettings.IgnorePaging = true;
                    gvFundingPlan.ExportSettings.OpenInNewWindow = true;
                    gvFundingPlan.MasterTableView.ExportToExcel2007();
                    break;

                case 1:
                    gvActivities.ExportSettings.ExportOnlyData = true;
                    gvActivities.ExportSettings.IgnorePaging = true;
                    gvActivities.ExportSettings.OpenInNewWindow = true;
                    gvActivities.MasterTableView.ExportToExcel2007();
                    break;

                default:
                    break;
            }
    }
    protected void gvActivities_DataBound(object sender, EventArgs e)
    {
        foreach (GridDataItem item in gvActivities.Items)
        {
            HyperLink mylink = new HyperLink();
            mylink = (HyperLink)item.FindControl("lbView");
        
            if (mylink != null)
                mylink.NavigateUrl = "javascript:popup(" + item["key_activity_id"].Text.Trim().ToLower() + ",'" + item["txt_activity_type_desc"].Text + "','" + item["key_amendment_reason_id"].Text + "');";           
        }
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {

    }
    protected void ddNextLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
        //hf_categoryid.Value = ddNextLevel.SelectedValue;

        if (ddNextLevel.SelectedValue == "104" && txtComments.Text.Length < 1)
        {
            ReqV_Comments.Visible = true;
            btnSubmit.Enabled = false;
        }
        else
        {
            ReqV_Comments.Visible = false;
            btnSubmit.Enabled = true;
        }

    }
    protected void ddNextLevel_DataBound(object sender, EventArgs e)
    {
        if (ddNextLevel.Items.Count == 1)
            hf_categoryid.Value = ddNextLevel.SelectedValue;

        if (ddNextLevel.Items.Count < 1)
            btnSubmit.Enabled = false;
        
    }

    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        base.RaisePostBackEvent(sourceControl, eventArgument);

        if (sourceControl is RadGrid)
        {
            switch (eventArgument)
            {
                case "Rebind":
                    gvActivities.Rebind();
                    gvFundingPlan.Rebind();

                    if(gvActivities.MasterTableView.Items.Count <= 0)
                        Response.Redirect("FundingPlan.aspx");
                    break;
            }
        }
    }
    protected void btn_Comments_Click(object sender, EventArgs e)
    {
        SQLDS_SaveComments.Update();

    
            btnSubmit.Enabled = true;
            ReqV_Comments.Visible = false;
        
       

    }
}
