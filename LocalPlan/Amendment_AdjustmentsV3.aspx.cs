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
using System.Web.Configuration;
using System.Data.SqlClient;

public partial class LocalPlan_Amendment_AdjustmentsV2_V : System.Web.UI.Page
{
   
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        if (!IsPostBack)
        {
            txt_lbl_UseofFunds.Attributes.Add("ReadOnly", "ReadOnly");                                            
            DD_Ins_Blank(ddAmendmentReason, "Select an Amendment Type");
            DD_Ins_Blank(DLB_ActType, "Select an Activity");
            DD_Ins_Blank(DLB_Category, "Select a Category");
            DD_Ins_Blank(DLB_FunCode, "Select a Function Code");
            DD_Ins_Blank(ddlUseOfFunds, "Select a Use of Fund");
            DD_Ins_Blank(ddlProgramType, "Select a Program Type");
            DD_Ins_Blank(DropDownList4, "Select Source of Funds");
            DD_Ins_Blank(DropDownList3, "Select Funds Destination");

        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                //MasterPage myMP = this.Master ;

                HDN_CollegeID.Value = Session[Session.SessionID + "CollegeDD"].ToString();
                HDN_FSYR.Value = Session[Session.SessionID + "FiscalDD"].ToString();
                HDN_PlanID.Value = Request.QueryString.Get("lpId").ToString();
                hfRoleId.Value = Request.QueryString.Get("roleId").ToString();
                hf_Act_id.Value = Request.QueryString.Get("aid").ToString();
                hdn_KeyActivityID.Value = Request.QueryString.Get("aid").ToString();
                txtActid.Text = Request.QueryString.Get("aid").ToString();
                HDN_HEADER_KEY.Value = "-1";
            }
            catch
            {
            }

            //   keyactivityid = -1;
            txtActid.Text = "-1";
            
            //   header_transid = -1;
            txtHeaderTrans.Text = "-1";

            Session.Add(Session.SessionID + "finishstat", "false");
            hdn_finishedStatus.Value = "false";

            if (hfRoleId.Value != "102" && hfRoleId.Value != "103" && hfRoleId.Value != "101")
            {
                Response.Redirect("../default.aspx");
            }


            hdFLD_currenttab.Value = "0";
            hdFLD_toUpdate.Value = "0";
            txtActivityDesc.Attributes.Add("onKeyUp", "calCharNumber1()");
            txtActivityDesc.Attributes.Add("onChange", "calCharNumber1()");


            txtCoreIndicatorsDesc.Attributes.Add("onKeyUp", "calCharNumber_txtCoreIndicatorsDesc()");
            txtCoreIndicatorsDesc.Attributes.Add("onChange", "calCharNumber_txtCoreIndicatorsDesc()");

            txtReductionFundsDesc.Attributes.Add("onKeyUp", "calCharNumber_txtReductionFundsDesc()");
            txtReductionFundsDesc.Attributes.Add("onChange", "calCharNumber_txtReductionFundsDesc()");

            txtAmdChangeInFundsDesc.Attributes.Add("onKeyUp", "calCharNumber_txtAmdChangeInFundsDesc()");
            txtAmdChangeInFundsDesc.Attributes.Add("onChange", "calCharNumber_txtAmdChangeInFundsDesc()");

            txtAmdCoreIndicatorsDesc.Attributes.Add("onKeyUp", "calCharNumber_txtAmdCoreIndicatorsDesc()");
            txtAmdCoreIndicatorsDesc.Attributes.Add("onChange", "calCharNumber_txtAmdCoreIndicatorsDesc()");

            txtAmdReductionDesc.Attributes.Add("onKeyUp", "calCharNumber_txtAmdReductionDesc()");
            txtAmdReductionDesc.Attributes.Add("onChange", "calCharNumber_txtAmdReductionDesc()");
        }

    }

    //Remember Index 5 is for adding a New Item to transfer Funds To

    private void DD_Ins_Blank(DropDownList dd_wb_Cont, string descriptionText)
    {
        ListItem myitem = new ListItem(descriptionText, "-1");
        if (dd_wb_Cont.Items.IndexOf(myitem) < 0)
            dd_wb_Cont.Items.Insert(0, myitem);
        dd_wb_Cont.SelectedIndex = 0;
    }
    protected void Butt_Next_Click(object sender, ImageClickEventArgs e)
    {
        Telerik.WebControls.Tab selectedTab = tabWizard.SelectedTab;
        Telerik.WebControls.Tab tempTab;

        if (selectedTab != null)
        {
            switch (selectedTab.ID)
            {
                case "tabAmendmentType":
                    tempTab = (Tab)tabWizard.FindControl("tabDescription");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }


                    tabWizard.SelectedIndex = 1;
                    multipageWizard.SelectedIndex = 1;
                    break;

                case "tabDescription":

                    tempTab = (Tab)tabWizard.FindControl("tabFundSource");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }

                    ddAmendmentReason.Enabled = false;
                    tabWizard.SelectedIndex = 2;
                    multipageWizard.SelectedIndex = 2;
                    break;

                case "tabFundSource":

                    tempTab = (Tab)tabWizard.FindControl("tabDestination");

                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }

                    tabWizard.SelectedIndex = 3;
                    multipageWizard.SelectedIndex = 3;
                    break;

                case "tabDestination":

                    tempTab = (Tab)tabWizard.FindControl("tabLineItems");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }
                    btnContinue.Visible = false;
                    Button4.Visible = false;
                    tabWizard.SelectedIndex = 5;
                    multipageWizard.SelectedIndex = 5;
                    break;

                case "tabLineItems":

                    tempTab = (Tab)tabWizard.FindControl("tabStatus");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }

                    tabWizard.SelectedIndex = 5;
                    multipageWizard.SelectedIndex = 5;
                    break;





                case "tabStatus":
                    foreach (Tab tTab in tabWizard.Tabs)
                    {
                        tTab.Enabled = false;
                    }
                    tabWizard.SelectedIndex = -1;
                    multipageWizard.SelectedIndex = 5;
                    break;
            }
        }
    }
    protected void Butt_Prev_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void DLB_ActType_SelectedIndexChanged(object sender, EventArgs e)
    {

        SqlDSDestination.Select(DataSourceSelectArguments.Empty);
        DropDownList3.DataBind();

        if (DLB_ActType.SelectedValue == "102")
        {
            Label16.Text = "Equipment Type";
            SDS_Category.SelectParameters.Clear();
            SDS_Category.SelectParameters.Add("p_txt_category_type", "1");
            SDS_Category.Select(DataSourceSelectArguments.Empty);
            DLB_Category.DataBind();

            DLB_Category.SelectedIndex = DLB_Category.Items.IndexOf(DLB_Category.Items.FindByValue("111"));
            DLB_Category.Enabled = false;
            SDS_FunctionCODE.SelectParameters.Clear();
            SDS_FunctionCODE.SelectParameters.Add("p_key_category_id", "111");
            SDS_FunctionCODE.Select(DataSourceSelectArguments.Empty);
            DLB_FunCode.DataBind();
            DLB_FunCode.SelectedIndex = DLB_FunCode.Items.IndexOf(DLB_FunCode.Items.FindByValue("101"));
            DLB_FunCode.Enabled = false;
            ddlProgramType.SelectedIndex = 0;
            ddlProgramType.Enabled = false;
            ddlUseOfFunds.SelectedIndex = 0;
            ddlUseOfFunds.Enabled = false;
            RequiredFieldValidator12.Enabled = false;
            RequiredFieldValidator13.Enabled = false;
        }
        else
        {
            Label16.Text = "Activity Name";

            //     DLB_Category.SelectedIndex = DLB_Category.Items.IndexOf(DLB_Category.Items.FindByValue("-1"));
            SDS_FunctionCODE.SelectParameters.Clear();
            SDS_FunctionCODE.SelectParameters.Add("p_key_category_id", "-1");
            SDS_FunctionCODE.Select(DataSourceSelectArguments.Empty);
            DLB_FunCode.DataBind();
            RequiredFieldValidator12.Enabled = true;
            RequiredFieldValidator13.Enabled = true;
        }
        if (DLB_ActType.SelectedValue == "101")
        {

            DLB_FunCode.Enabled = true;
            ddlProgramType.SelectedIndex = 0;
            ddlProgramType.Enabled = true;
            DLB_Category.SelectedIndex = DLB_Category.Items.IndexOf(DLB_Category.Items.FindByValue("-1"));
            DLB_Category.Enabled = true;
            ddlUseOfFunds.SelectedIndex = 0;
            ddlUseOfFunds.Enabled = true;

        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            RadioButton myradbutton = new RadioButton();

            myradbutton = (RadioButton)e.Row.FindControl("RadioButton1");
            myradbutton.Attributes.Add("onClick", "On_OneLineItem('" + GridView1.ClientID + "','" + e.Row.Cells[1].Text + "');");

            TextBox mytx = new TextBox();

            mytx = (TextBox)e.Row.FindControl("TextBox5");
            mytx.Attributes.Add("onChange", "trackit('" + GridView1.ClientID + "','" + e.Row.Cells[1].Text + "');");

        }

    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[5].Visible = false;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox myradbutton = new TextBox();

            myradbutton = (TextBox)e.Row.FindControl("TextBox5");
            myradbutton.Attributes.Add("onChange", "MasterMath();");



            if (CategoryID.Text.Trim() != "115")
            {
                if (e.Row.Cells[5].Text == "105" && e.Row.Cells[2].Text.ToLower() == "indirect costs")
                {
                    myradbutton.Attributes.Add("readonly", "readonly");
                    //myradbutton.Text = "0.00";
                    lbl_noIndirectCOST.Visible = true;
                }

            }
            else if (CategoryID.Text.Trim() == "115")
            {
                if (e.Row.Cells[5].Text == "105")
                {
                    myradbutton.Attributes.Remove("readonly");
                    lbl_noIndirectCOST.Visible = false;
                }
            }

        }
    }
    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {


        try
        {
            lbl_MustPickDestination.Visible = false;
            lbl_MustPickSource.Visible = false;
        }
        catch
        {
        }


        RadGrid2.Visible = true;
        RadGrid4.Visible = true;
        Label20.Visible = true;
        Label28.Visible = true;
        Label29.Visible = true;
        Label30.Visible = true;
        Label31.Visible = true;
        Label32.Visible = true;
        Label33.Visible = true;
        Label34.Visible = true;
        Label35.Visible = true;


        Label15.Text = DropDownList3.SelectedItem.Text;


        SqlDataSource2.SelectParameters.Clear();
        if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
        {
            SqlDataSource2.SelectParameters.Add("activityid", DropDownList3.SelectedValue.ToString());
        }
        else if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
        {
            SqlDataSource2.SelectParameters.Add("activityid", txtActid.Text);

        }
        else
        {
            SqlDataSource2.SelectParameters.Add("activityid", "-1");
        }

        SqlDataSource2.Select(DataSourceSelectArguments.Empty);




        SQLDS_SOURCEDESCRIPTION.SelectParameters.Clear();
        SQLDS_SOURCEDESCRIPTION.SelectParameters.Add("key_activity_id", DropDownList3.SelectedValue.ToString());

        DataView dw = (DataView)SQLDS_SOURCEDESCRIPTION.Select(DataSourceSelectArguments.Empty);
        foreach (DataRow dr in dw.Table.Rows)
        {
            Label4.Text = dr["key_activity_id"].ToString();
            Label5.Text = dr["txt_activity_type_desc"].ToString();
            Label6.Text = dr["txt_activity_desc"].ToString();
            Label21.Text = dr["txt_category_type_desc"].ToString();
            Label11.Text = dr["txt_function_code_desc"].ToString();
            Label35.Text = dr["txt_category_desc"].ToString();
            //Label19.Text = dr["nbr_balance"].ToString();
            CategoryID.Text = dr["key_category_id"].ToString();
        }

        try
        {
            if (DropDownList3.SelectedValue == "-1")
            {
                RadGrid2.Visible = false;
                RadGrid4.Visible = false;
                Label20.Visible = false;
                Label28.Visible = false;
                Label29.Visible = false;
                Label30.Visible = false;
                Label31.Visible = false;
                Label32.Visible = false;
                Label33.Visible = false;
                Label34.Visible = false;
                Label35.Visible = false;

                Label4.Visible = false;
                Label5.Visible = false;
                Label6.Visible = false;
                Label21.Visible = false;
                Label11.Visible = false;
                Label35.Visible = false;
                //Label19.Text = dr["nbr_balance"].ToString();
                CategoryID.Visible = false;
                btnContinue.Enabled = false;
            }
            else
                btnContinue.Enabled = true;

        }
        catch
        {
        }
    }
    protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
    {

        //try
        //{
        //    lbl_MustPickDestination.Visible = false;
        //    lbl_MustPickSource.Visible = false;
        //}
        //catch
        //{
        //}


        SQLDS_SOURCEDESCRIPTION.SelectParameters.Clear();
        SQLDS_SOURCEDESCRIPTION.SelectParameters.Add("key_activity_id", DropDownList4.SelectedValue.ToString());
        DataView dw = (DataView)SQLDS_SOURCEDESCRIPTION.Select(DataSourceSelectArguments.Empty);
        if (dw.Count > 0)
        {
            Label19.Visible = true;
            Label22.Visible = true;
            Label23.Visible = true;
            Label24.Visible = true;
            Label8.Visible = true;
            Label25.Visible = true;
            RadGrid1.Visible = true;
            RadGrid3.Visible = true;
            Label26.Visible = true;
            Label27.Visible = true;
            Label37.Visible = true;
            Label36.Visible = true;

        }
        else
        {
            RadGrid1.Visible = false;
            RadGrid3.Visible = false;
            Label26.Visible = false;
            Label27.Visible = false;

        }
        foreach (DataRow dr in dw.Table.Rows)
        {
            Label10.Text = dr["key_activity_id"].ToString();
            Label12.Text = dr["txt_activity_type_desc"].ToString();
            Label14.Text = dr["txt_activity_desc"].ToString();
            Label9.Text = dr["txt_category_type_desc"].ToString();
            Label18.Text = dr["txt_function_code_desc"].ToString();
            Label37.Text = dr["txt_category_desc"].ToString();
            //    Label19.Text = dr["nbr_balance"].ToString();

        }

        if (DropDownList4.SelectedIndex.ToString() == "0")
        {

            try
            {

                Label9.Visible = false;
                Label22.Visible = false;
                Label23.Visible = false;
                Label24.Visible = false;
                Label8.Visible = false;
                Label25.Visible = false;
                RadGrid1.Visible = false;
                RadGrid3.Visible = false;
                Label26.Visible = false;
                Label27.Visible = false;
                Label37.Visible = false;
                Label36.Visible = false;

                Label10.Visible = false;
                Label12.Visible = false;
                Label14.Visible = false;

                Label18.Visible = false;
                Label37.Visible = false;


                RadGrid1.Visible = false;
                RadGrid3.Visible = false;
                Label26.Visible = false;
                Label27.Visible = false;

                btnContinue.Enabled = false;

            }
            catch
            {
            }
        }
        else
        {
            Label9.Visible = true;
            Label22.Visible = true;
            Label23.Visible = true;
            Label24.Visible = true;
            Label8.Visible = true;
            Label25.Visible = true;
            RadGrid1.Visible = true;
            RadGrid3.Visible = true;
            Label26.Visible = true;
            Label27.Visible = true;
            Label37.Visible = true;
            Label36.Visible = true;

            Label10.Visible = true;
            Label12.Visible = true;
            Label14.Visible = true;

            Label18.Visible = true;
            Label37.Visible = true;


            RadGrid1.Visible = true;
            RadGrid3.Visible = true;
            Label26.Visible = true;
            Label27.Visible = true;

            btnContinue.Enabled = true;
        }

    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddAmendmentReason.SelectedValue == "102")
        {

            tabWizard.FindTabByValue("Page4").Visible = false;
        }
        else
        {
            tabWizard.FindTabByValue("Page4").Visible = true;
        }

    }

    protected void Button3_Click(object sender, EventArgs e)
    {



    }

    protected void Insert_New_Activity()
    {
        if (hdn_KeyActivityID.Value == "-1")
        {
            SqlDSRL_pr_activitiy_stuff.InsertParameters.Clear();
            SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_local_plan_id", HDN_PlanID.Value);

            if (ddAmendmentReason.SelectedValue == "101")
            {
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_name", txtAmendmentName.Text.Trim());
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_desc", txtAmdChangeInFundsDesc.Text.Trim());
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("flg_is_amendment", "1");

                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", "102");
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_core_indicator_desc", txtAmdCoreIndicatorsDesc.Text.Trim());
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_funds_reduction_impact_desc", txtAmdReductionDesc.Text.Trim());
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_transaction_status_id", "0");

                //if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", "103");
                //else
                //  SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue.ToString());

                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
            }
            else
            {
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_name", TextBox2.Text.Trim());
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_desc", txtActivityDesc.Text.Trim());
                //if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                //    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", "103");
                //else
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue.ToString());

                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_category_id", DLB_Category.SelectedValue.ToString());
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_transaction_status_id", "0");
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("flg_is_amendment", "1");
                //if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                //{
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", "102");
                //}
                //else
                //{
                //    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", DLB_FunCode.SelectedValue.ToString());
                // }
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_core_indicator_desc", txtCoreIndicatorsDesc.Text.Trim());
                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_funds_reduction_impact_desc", txtReductionFundsDesc.Text.Trim());

                SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
            }
            Parameter myparam = new Parameter("l_key_activity_id");
            myparam.Direction = ParameterDirection.ReturnValue;
            SqlDSRL_pr_activitiy_stuff.InsertParameters.Add(myparam);

            SqlDSRL_pr_activitiy_stuff.Insert();

            int counter = 0;
            foreach (ListItem li in chkCoreIndicators.Items)
            {
                if (li.Selected)
                {
                    counter++;

                    /* Insert core indicator */

                    SqlRl_act_core_indicat_ins.InsertParameters.Clear();
                    SqlRl_act_core_indicat_ins.InsertParameters.Add("key_activity_id", txtActid.Text);  //DLB_ActType.SelectedValue.ToString());
                    SqlRl_act_core_indicat_ins.InsertParameters.Add("key_core_indicator_id", li.Value.ToString());
                    SqlRl_act_core_indicat_ins.Insert();
                }


            }
        }
    }

    protected void Insert_New_Header()
    {
        SqlRL_pr_at_transfer_Header_ins.InsertParameters.Clear();
        SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("key_activity_id", txtActid.Text);
        SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("key_activity_from_id", DropDownList4.SelectedValue.ToString());
        SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("p_key_local_plan_id", HDN_PlanID.Value.ToString());

        if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
        {
            SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("key_activity_to_id", DropDownList3.SelectedValue.ToString());
        }
        else if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
        {
            SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("key_activity_to_id", txtActid.Text);
        }

        Parameter myparam = new Parameter("l_header_activity_id");
        myparam.Direction = ParameterDirection.ReturnValue;
        SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add(myparam);

        SqlRL_pr_at_transfer_Header_ins.Insert();
        // Response.Write(header_transid.ToString());
        HDN_HEADER_KEY.Value = txtHeaderTrans.Text;
    }

    protected void Advance_Next_Tab()
    {
        Telerik.WebControls.Tab selectedTab = tabWizard.SelectedTab;
        Telerik.WebControls.Tab tempTab;
        HiddenField hdn = new HiddenField();
        string controlnme;
        if (selectedTab != null)
        {
            switch (selectedTab.ID)
            {
                case "tabAmendmentType":
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        tempTab = (Tab)tabWizard.FindControl("newDescription");

                        if (!tempTab.Visible)
                        {
                            tempTab.Visible = true;
                            tempTab.Enabled = true;
                            ddAmendmentReason.Enabled = false;
                            tabWizard.SelectedIndex = 1;
                            multipageWizard.SelectedIndex = 1;
                            RequiredFieldValidator5.Enabled = true;
                            RequiredFieldValidator6.Enabled = true;
                            RequiredFieldValidator7.Enabled = true;
                            RequiredFieldValidator8.Enabled = true;
                            RequiredFieldValidator11.Enabled = true;
                            RequiredFieldValidator12.Enabled = true;
                            RequiredFieldValidator13.Enabled = true;
                            cvCoreIndicator.Enabled = true;
                        }
                    }

                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                    {
                        tempTab = (Tab)tabWizard.FindControl("tabChangeDescription");
                        if (!tempTab.Visible)
                        {
                            tempTab.Visible = true;
                            tempTab.Enabled = true;
                            ddAmendmentReason.Enabled = false;
                            tabWizard.SelectedIndex = 2;
                            multipageWizard.SelectedIndex = 2;
                            RequiredFieldValidator1.Enabled = true;
                            RequiredFieldValidator2.Enabled = true;
                            RequiredFieldValidator3.Enabled = true;
                            RequiredFieldValidator4.Enabled = true;
                        }

                    }




                    break;

                case "newDescription":


                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Clear();
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_local_plan_id", HDN_PlanID.Value);
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_name", TextBox2.Text.Trim());
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_desc", txtActivityDesc.Text.Trim());
                    //if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                    //    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", "103");
                    //else
                    //    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue.ToString());


                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_category_id", DLB_Category.SelectedValue.ToString());
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_transaction_status_id", "0");
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("flg_is_amendment", "1");
                    //if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    //{
                    //    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", "102");
                    //}
                    //else
                    //{
                    //    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", DLB_FunCode.SelectedValue.ToString());
                    //}
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_core_indicator_desc", txtCoreIndicatorsDesc.Text.Trim());
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_funds_reduction_impact_desc", txtReductionFundsDesc.Text.Trim());

                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
                    //Parameter myparam1 = new Parameter("l_key_activity_id");
                    //myparam1.Direction = ParameterDirection.ReturnValue;
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add(myparam1);

                    //SqlDSRL_pr_activitiy_stuff.Insert();

                    int counter = 0;
                    foreach (ListItem li in chkCoreIndicators.Items)
                    {
                        if (li.Selected)
                        {
                            counter++;

                            /* Insert core indicator */

                            //SqlRl_act_core_indicat_ins.InsertParameters.Clear();
                            //SqlRl_act_core_indicat_ins.InsertParameters.Add("key_activity_id", txtActid.Text);  //DLB_ActType.SelectedValue.ToString());
                            //SqlRl_act_core_indicat_ins.InsertParameters.Add("key_core_indicator_id", li.Value.ToString());
                            //SqlRl_act_core_indicat_ins.Insert();
                        }


                    }
                    if (counter == 0)
                    {
                        Label17.Visible = true;
                        break;
                    }
                    else
                    {
                        Label17.Visible = false;
                    }





                    controlnme = "hdn_" + tabWizard.SelectedTab.Value.ToString();
                    hdn = (HiddenField)multipageWizard.FindControl(controlnme);
                    hdn.Value = "saved";

                    tempTab = (Tab)tabWizard.FindControl("tabFundSource");
                    tempTab.Enabled = true;
                    tempTab.Visible = true;
                    DLB_ActType.Enabled = false;
                    tabWizard.SelectedIndex = 3;
                    multipageWizard.SelectedIndex = 3;
                    RequiredFieldValidator9.Enabled = true;


                    break;
                case "tabChangeDescription":

                    tempTab = (Tab)tabWizard.FindControl("tabFundSource");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                        RequiredFieldValidator9.Enabled = true;
                    }

                    tabWizard.SelectedIndex = 3;
                    multipageWizard.SelectedIndex = 3;
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Clear();

                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_local_plan_id", HDN_PlanID.Value);
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_name", txtAmendmentName.Text.Trim());
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_desc", txtAmdChangeInFundsDesc.Text.Trim());
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("flg_is_amendment", "1");

                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", "102");
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_core_indicator_desc", txtAmdCoreIndicatorsDesc.Text.Trim());
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_funds_reduction_impact_desc", txtAmdReductionDesc.Text.Trim());
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_transaction_status_id", "0");

                    //if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                    //    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", "103");
                    //else
                    //    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue.ToString());

                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
                    //Parameter myparam = new Parameter("l_key_activity_id");
                    //myparam.Direction = ParameterDirection.ReturnValue;
                    //SqlDSRL_pr_activitiy_stuff.InsertParameters.Add(myparam);

                    //SqlDSRL_pr_activitiy_stuff.Insert();



                    controlnme = "hdn_" + tabWizard.SelectedTab.Value.ToString();
                    hdn = (HiddenField)multipageWizard.FindControl(controlnme);
                    hdn.Value = "saved";






                    break;

                case "tabFundSource":
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        btnContinue.Visible = false;
                        Button4.Visible = false;
                    }

                    tempTab = (Tab)tabWizard.FindControl("tabDestination");
                    Label13.Text = DropDownList4.SelectedItem.Text;
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                    {
                        try
                        {
                            Label15.Text = DropDownList3.SelectedItem.Text;
                        }
                        catch
                        {
                        }
                        if (!tempTab.Visible)
                        {
                            tempTab.Visible = true;
                            tempTab.Enabled = true;
                            RequiredFieldValidator10.Enabled = true;
                            tabWizard.SelectedIndex = 4;
                            multipageWizard.SelectedIndex = 4;

                        }
                    }


                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        tempTab = (Tab)tabWizard.FindControl("tabLineItems");

                        Label15.Text = txtActid.Text + " - " + TextBox2.Text;
                        tempTab.Visible = true;
                        tempTab.Enabled = true;
                        tabWizard.SelectedIndex = 5;
                        multipageWizard.SelectedIndex = 5;


                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Clear();
                        //// SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add

                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_id", txtActid.Text);
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_local_plan_id", HDN_PlanID.Value.ToString());
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_name", TextBox2.Text.ToString());
                        //if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                        //    SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_fund_source_id", "102");

                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_desc", txtActivityDesc.Text.ToString());

                        //if (ddAmendmentReason.SelectedValue == "101")
                        //    SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_type_id", "103");
                        //else
                        //{
                        //    SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue);
                        //}
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_category_id", DLB_Category.SelectedValue.ToString());
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_level_id", "101");
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_locked", "False");
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_approved", "False");
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_is_amendment", "1");
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
                        //SqlDSRL_pr_activitiy_SRC_OF_Fun.Update();
                        Insert_New_Activity();
                    }


                    SqlDataSource2.SelectParameters.Clear();
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                    {
                        SqlDataSource2.SelectParameters.Add("activityid", DropDownList3.SelectedValue.ToString());
                    }
                    else if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        SqlDataSource2.SelectParameters.Add("activityid", txtActid.Text);

                    }
                    else
                    {
                        SqlDataSource2.SelectParameters.Add("activityid", "-1");
                    }

                    SqlDataSource2.Select(DataSourceSelectArguments.Empty);




                    controlnme = "hdn_" + tabWizard.SelectedTab.Value.ToString();
                    hdn = (HiddenField)multipageWizard.FindControl(controlnme);
                    hdn.Value = "saved";



                    break;

                case "tabDestination":
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                        btnContinue.Visible = false;
                    tempTab = (Tab)tabWizard.FindControl("tabLineItems");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }

                    tabWizard.SelectedIndex = 5;
                    multipageWizard.SelectedIndex = 5;
                    Button4.Visible = false;
                    break;

                case "tabLineItems":

                    tempTab = (Tab)tabWizard.FindControl("tabStatus");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }

                    tabWizard.SelectedIndex = 5;
                    multipageWizard.SelectedIndex = 5;

                    break;
                case "PgChangeInFunds":

                    break;

                case "tabStatus":
                    foreach (Tab tTab in tabWizard.Tabs)
                    {
                        tTab.Enabled = false;
                    }
                    tabWizard.SelectedIndex = -1;
                    multipageWizard.SelectedIndex = 5;
                    break;
            }
        }
    }

    protected void Save_INFO()
    {
        Telerik.WebControls.Tab selectedTab = tabWizard.SelectedTab;
        Telerik.WebControls.Tab tempTab;
        HiddenField hdn = new HiddenField();
        string controlnme;
        if (selectedTab != null)
        {
            switch (selectedTab.ID)
            {
                case "tabAmendmentType":
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        tempTab = (Tab)tabWizard.FindControl("newDescription");

                        if (!tempTab.Visible)
                        {
                            tempTab.Visible = true;
                            tempTab.Enabled = true;
                            ddAmendmentReason.Enabled = false;
                            tabWizard.SelectedIndex = 1;
                            multipageWizard.SelectedIndex = 1;
                            RequiredFieldValidator5.Enabled = true;
                            RequiredFieldValidator6.Enabled = true;
                            RequiredFieldValidator7.Enabled = true;
                            RequiredFieldValidator8.Enabled = true;
                            RequiredFieldValidator11.Enabled = true;
                            RequiredFieldValidator12.Enabled = true;
                            RequiredFieldValidator13.Enabled = true;
                            cvCoreIndicator.Enabled = true;
                        }
                    }

                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                    {
                        tempTab = (Tab)tabWizard.FindControl("tabChangeDescription");
                        if (!tempTab.Visible)
                        {
                            tempTab.Visible = true;
                            tempTab.Enabled = true;
                            ddAmendmentReason.Enabled = false;
                            tabWizard.SelectedIndex = 2;
                            multipageWizard.SelectedIndex = 2;
                            RequiredFieldValidator1.Enabled = true;
                            RequiredFieldValidator2.Enabled = true;
                            RequiredFieldValidator3.Enabled = true;
                            RequiredFieldValidator4.Enabled = true;
                        }

                    }




                    break;

                case "newDescription":


                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Clear();
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_local_plan_id", HDN_PlanID.Value);
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_name", TextBox2.Text.Trim());
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_desc", txtActivityDesc.Text.Trim());
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                        SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", "103");
                    else
                        SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue.ToString());


                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_category_id", DLB_Category.SelectedValue.ToString());
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_transaction_status_id", "0");
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("flg_is_amendment", "1");
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", "102");
                    }
                    else
                    {
                        SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", DLB_FunCode.SelectedValue.ToString());
                    }
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_core_indicator_desc", txtCoreIndicatorsDesc.Text.Trim());
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_funds_reduction_impact_desc", txtReductionFundsDesc.Text.Trim());

                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
                    Parameter myparam1 = new Parameter("l_key_activity_id");
                    myparam1.Direction = ParameterDirection.ReturnValue;
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add(myparam1);

                    SqlDSRL_pr_activitiy_stuff.Insert();

                    int counter = 0;
                    foreach (ListItem li in chkCoreIndicators.Items)
                    {
                        if (li.Selected)
                        {
                            counter++;
                            SqlRl_act_core_indicat_ins.InsertParameters.Clear();
                            SqlRl_act_core_indicat_ins.InsertParameters.Add("key_activity_id", txtActid.Text);  //DLB_ActType.SelectedValue.ToString());
                            SqlRl_act_core_indicat_ins.InsertParameters.Add("key_core_indicator_id", li.Value.ToString());
                            SqlRl_act_core_indicat_ins.Insert();
                        }


                    }
                    if (counter == 0)
                    {
                        Label17.Visible = true;
                        break;
                    }
                    else
                    {
                        Label17.Visible = false;
                    }





                    controlnme = "hdn_" + tabWizard.SelectedTab.Value.ToString();
                    hdn = (HiddenField)multipageWizard.FindControl(controlnme);
                    hdn.Value = "saved";

                    tempTab = (Tab)tabWizard.FindControl("tabFundSource");
                    tempTab.Enabled = true;
                    tempTab.Visible = true;
                    DLB_ActType.Enabled = false;
                    tabWizard.SelectedIndex = 3;
                    multipageWizard.SelectedIndex = 3;
                    RequiredFieldValidator9.Enabled = true;


                    break;
                case "tabChangeDescription":

                    tempTab = (Tab)tabWizard.FindControl("tabFundSource");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                        RequiredFieldValidator9.Enabled = true;
                    }

                    tabWizard.SelectedIndex = 3;
                    multipageWizard.SelectedIndex = 3;
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Clear();

                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_local_plan_id", HDN_PlanID.Value);
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_name", txtAmendmentName.Text.Trim());
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_desc", txtAmdChangeInFundsDesc.Text.Trim());
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("flg_is_amendment", "1");

                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_fund_source_id", "102");
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_activity_core_indicator_desc", txtAmdCoreIndicatorsDesc.Text.Trim());
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("txt_funds_reduction_impact_desc", txtAmdReductionDesc.Text.Trim());
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_transaction_status_id", "0");

                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                        SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", "103");
                    else
                        SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue.ToString());

                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
                    Parameter myparam = new Parameter("l_key_activity_id");
                    myparam.Direction = ParameterDirection.ReturnValue;
                    SqlDSRL_pr_activitiy_stuff.InsertParameters.Add(myparam);

                    SqlDSRL_pr_activitiy_stuff.Insert();



                    controlnme = "hdn_" + tabWizard.SelectedTab.Value.ToString();
                    hdn = (HiddenField)multipageWizard.FindControl(controlnme);
                    hdn.Value = "saved";






                    break;

                case "tabFundSource":
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        btnContinue.Visible = false;
                        Button4.Visible = false;
                    }

                    tempTab = (Tab)tabWizard.FindControl("tabDestination");
                    Label13.Text = DropDownList4.SelectedItem.Text;
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                    {
                        try
                        {
                            Label15.Text = DropDownList3.SelectedItem.Text;
                        }
                        catch
                        {
                        }
                        if (!tempTab.Visible)
                        {
                            tempTab.Visible = true;
                            tempTab.Enabled = true;
                            RequiredFieldValidator10.Enabled = true;
                            tabWizard.SelectedIndex = 4;
                            multipageWizard.SelectedIndex = 4;

                        }
                    }


                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        tempTab = (Tab)tabWizard.FindControl("tabLineItems");

                        Label15.Text = txtActid.Text + " - " + TextBox2.Text;
                        tempTab.Visible = true;
                        tempTab.Enabled = true;
                        tabWizard.SelectedIndex = 5;
                        multipageWizard.SelectedIndex = 5;


                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Clear();
                        // SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add

                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_id", txtActid.Text);
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_local_plan_id", HDN_PlanID.Value.ToString());
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_name", TextBox2.Text.ToString());
                        if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_fund_source_id", "102");

                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_desc", txtActivityDesc.Text.ToString());

                        if (ddAmendmentReason.SelectedValue == "101")
                            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_type_id", "103");
                        else
                        {
                            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue);
                        }
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_category_id", DLB_Category.SelectedValue.ToString());
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_level_id", "101");
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_locked", "False");
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_approved", "False");
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_is_amendment", "1");
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
                        SqlDSRL_pr_activitiy_SRC_OF_Fun.Update();

                    }


                    SqlDataSource2.SelectParameters.Clear();
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                    {
                        SqlDataSource2.SelectParameters.Add("activityid", DropDownList3.SelectedValue.ToString());
                    }
                    else if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                    {
                        SqlDataSource2.SelectParameters.Add("activityid", txtActid.Text);

                    }
                    else
                    {
                        SqlDataSource2.SelectParameters.Add("activityid", "-1");
                    }

                    SqlDataSource2.Select(DataSourceSelectArguments.Empty);




                    controlnme = "hdn_" + tabWizard.SelectedTab.Value.ToString();
                    hdn = (HiddenField)multipageWizard.FindControl(controlnme);
                    hdn.Value = "saved";



                    break;

                case "tabDestination":
                    if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                        btnContinue.Visible = false;
                    tempTab = (Tab)tabWizard.FindControl("tabLineItems");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }

                    tabWizard.SelectedIndex = 5;
                    multipageWizard.SelectedIndex = 5;
                    Button4.Visible = false;
                    break;

                case "tabLineItems":

                    tempTab = (Tab)tabWizard.FindControl("tabStatus");
                    if (!tempTab.Enabled)
                    {
                        tempTab.Enabled = true;
                    }

                    tabWizard.SelectedIndex = 5;
                    multipageWizard.SelectedIndex = 5;

                    break;
                case "PgChangeInFunds":

                    break;

                case "tabStatus":
                    foreach (Tab tTab in tabWizard.Tabs)
                    {
                        tTab.Enabled = false;
                    }
                    tabWizard.SelectedIndex = -1;
                    multipageWizard.SelectedIndex = 5;
                    break;
            }
        }
    }






    protected void btnContinue_Click(object sender, EventArgs e)
    {

        //if (multipageWizard.SelectedIndex == 3)
        //{
        //    if (DropDownList4.SelectedIndex != 0)
        //    {
        //        Save_INFO();

        //    }
        //    else
        //        lbl_MustPickSource.Visible = true;
        //}
        //else if (multipageWizard.SelectedIndex == 4)
        //{
        //    if (DropDownList3.SelectedIndex != 0)
        //    {
        //        Save_INFO();

        //    }
        //    else
        //        lbl_MustPickDestination.Visible = true;
        //}
        //else
        //{
        //    try
        //    {
        //        lbl_MustPickDestination.Visible = false;
        //        lbl_MustPickSource.Visible = false;
        //    }
        //    catch
        //    {
        //    }
        //    Save_INFO();
        //}

        Advance_Next_Tab();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        double grid1total = 0;
        double grid2total = 0;
        foreach (GridViewRow g1r in GridView1.Rows)
        {

            TextBox mybox = (TextBox)g1r.FindControl("TextBox5");
            if (mybox.Text.Length > 0)
                grid1total += Convert.ToDouble(mybox.Text);
        }
        foreach (GridViewRow g2r in GridView2.Rows)
        {

            TextBox mybox = (TextBox)g2r.FindControl("TextBox5");
            if (mybox.Text.Length > 0)
                grid2total += Convert.ToDouble(mybox.Text);
        }

        if (grid1total == grid2total)    //over/extra protection added at postback pre insert
        {
            if (hdn_KeyActivityID.Value == "-1")
            {
                /* Insert First Transfer */
                Insert_New_Activity();
                
            }

            if (HDN_HEADER_KEY.Value == "-1")
            {
                Insert_New_Header();
            }

            if (radgridTransactions.MasterTableView.Items.Count == 0)
            {                
                //Amendment.Activity_Transaction_Status_Update(Convert.ToInt32(Session[Session.SessionID + "keyactiveID"]), 1);
                Amendment.Activity_Transaction_Status_Update(Convert.ToInt32(txtActid.Text), 1);
            }

            string idtovalue = string.Empty;
            string idfromvalue = string.Empty;
            string moneyfromamount = "0";
            string moneytoamount = "0";
            foreach (GridViewRow g1r in GridView1.Rows)
            {
                RadioButton rb = (RadioButton)g1r.FindControl("RadioButton1");
                if (rb.Checked)
                {
                    idfromvalue = g1r.Cells[1].Text;
                    TextBox mytex = (TextBox)g1r.FindControl("TextBox5");
                    moneyfromamount = mytex.Text;
                }
            }

            foreach (GridViewRow g2r in GridView2.Rows)
            {
                TextBox mybox = (TextBox)g2r.FindControl("TextBox5");
                idtovalue = g2r.Cells[1].Text;

                if (moneyfromamount.Length > 0 && mybox.Text.Length > 0)
                {
                    moneytoamount = (mybox.Text).ToString();

                    /* Section to test if Transfer should happen  RL 10-182008  */

                    SqlParameter rv_errornumber = new SqlParameter("@l_key_err_msg_amndmnt_hdr_id", SqlDbType.Int);
                    String connectionstring = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString;
                    SqlConnection myconn = new SqlConnection(connectionstring);
                    try
                    {

                        SqlCommand mycomm = new SqlCommand("pr_at_amendment_transfer_validation", myconn);
                        mycomm.CommandType = CommandType.StoredProcedure;
                        mycomm.Parameters.AddWithValue("p_key_local_plan_id", HDN_PlanID.Value.ToString());
                        mycomm.Parameters.AddWithValue("p_key_new_activity_id", txtActid.Text);
                        mycomm.Parameters.AddWithValue("p_amt_transfer_amount", moneytoamount.ToString());

                        rv_errornumber.Direction = ParameterDirection.ReturnValue;
                        mycomm.Parameters.Add(rv_errornumber);
                        if (myconn.State == ConnectionState.Closed)
                        {
                            myconn.Open();
                        }
                        mycomm.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        myconn.Close();
                        string myex_error = ex.Message.ToString();
                        //    throw new Exception(ex.Message + "      Error caused when calling pr_at_amendment_transfer_validation stored procedure logic");
                    }

                    /* End Section to test if Transfer should happen  RL 10-182008  */


                    if (rv_errornumber.Value.ToString() == "0")
                    {
                        HL_TransErrors.Visible = false;
                        SqlRL_attransferdetail.InsertParameters.Clear();
                        SqlRL_attransferdetail.InsertParameters.Add("key_amendment_transfer_hdr_id", txtHeaderTrans.Text);
                        SqlRL_attransferdetail.InsertParameters.Add("key_act_line_item_from_id", idfromvalue.ToString());
                        SqlRL_attransferdetail.InsertParameters.Add("amt_debit_amount", moneytoamount.ToString());
                        SqlRL_attransferdetail.InsertParameters.Add("key_act_line_item_to_id", idtovalue.ToString());
                        SqlRL_attransferdetail.InsertParameters.Add("amt_credit_amount", moneytoamount.ToString());
                        SqlRL_attransferdetail.Insert();
                        totaltransfered.Text = (Convert.ToDouble(moneytoamount.ToString()) + Convert.ToDouble(totaltransfered.Text.ToString())).ToString();
                    }
                    else
                    {
                        HL_TransErrors.Visible = true;

                        HL_TransErrors.Text = "Click to View Validation Errors";
                        HL_TransErrors.NavigateUrl = "javascript:showerrors(" + rv_errornumber.Value.ToString() + ");";


                    }
                    myconn.Close();
                }
            }
            Button2.Enabled = true;
            Button3.Enabled = true;

            /****************/




            SqlDataSource2.SelectParameters.Clear();
            if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
            {
                SqlDataSource2.SelectParameters.Add("activityid", DropDownList3.SelectedValue.ToString());
            }
            else if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
            {
                SqlDataSource2.SelectParameters.Add("activityid", txtActid.Text);

            }
            else
            {
                SqlDataSource2.SelectParameters.Add("activityid", "-1");
            }




            SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            SqlDataSource2.Select(DataSourceSelectArguments.Empty);
            GridView1.DataBind();
            GridView2.DataBind();
            sqlDSTransactions.Select(DataSourceSelectArguments.Empty);
            radgridTransactions.DataBind();
            DropDownList3.Enabled = false;
            DropDownList4.Enabled = false;
        }

    }


    protected void Transfer_fund()
    {
        double grid1total = 0;
        double grid2total = 0;
        foreach (GridViewRow g1r in GridView1.Rows)
        {

            TextBox mybox = (TextBox)g1r.FindControl("TextBox5");
            if (mybox.Text.Length > 0)
                grid1total += Convert.ToDouble(mybox.Text);
        }
        foreach (GridViewRow g2r in GridView2.Rows)
        {

            TextBox mybox = (TextBox)g2r.FindControl("TextBox5");
            if (mybox.Text.Length > 0)
                grid2total += Convert.ToDouble(mybox.Text);
        }

        if (grid1total == grid2total)    //over/extra protection added at postback pre insert
        {
            
            if (txtHeaderTrans.Text == "-1")
            {
                SqlRL_pr_at_transfer_Header_ins.InsertParameters.Clear();
                SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("key_activity_id", txtActid.Text);



                SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("key_activity_from_id", DropDownList4.SelectedValue.ToString());

                SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("p_key_local_plan_id", HDN_PlanID.Value.ToString());






                if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
                {

                    SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("key_activity_to_id", DropDownList3.SelectedValue.ToString());
                }
                else if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
                {
                    SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add("key_activity_to_id", txtActid.Text);
                }

                Parameter myparam = new Parameter("l_header_activity_id");
                myparam.Direction = ParameterDirection.ReturnValue;
                SqlRL_pr_at_transfer_Header_ins.InsertParameters.Add(myparam);

                SqlRL_pr_at_transfer_Header_ins.Insert();
                // Response.Write(header_transid.ToString());
                HDN_HEADER_KEY.Value = txtHeaderTrans.Text;

            }

            if (radgridTransactions.MasterTableView.Items.Count == 0)
            {
                //Amendment.Activity_Transaction_Status_Update(Convert.ToInt32(Session[Session.SessionID + "keyactiveID"]), 1);
                Amendment.Activity_Transaction_Status_Update(Convert.ToInt32(txtActid.Text), 1);
            }



            string idtovalue = string.Empty;
            string idfromvalue = string.Empty;
            string moneyfromamount = "0";
            string moneytoamount = "0";
            foreach (GridViewRow g1r in GridView1.Rows)
            {
                RadioButton rb = (RadioButton)g1r.FindControl("RadioButton1");
                if (rb.Checked)
                {
                    idfromvalue = g1r.Cells[1].Text;
                    TextBox mytex = (TextBox)g1r.FindControl("TextBox5");
                    moneyfromamount = mytex.Text;
                }
            }

            foreach (GridViewRow g2r in GridView2.Rows)
            {
                TextBox mybox = (TextBox)g2r.FindControl("TextBox5");
                idtovalue = g2r.Cells[1].Text;


                if (moneyfromamount.Length > 0 && mybox.Text.Length > 0)
                {
                    moneytoamount = (mybox.Text).ToString();

                    /* Section to test if Transfer should happen  RL 10-182008  */

                    SqlParameter rv_errornumber = new SqlParameter("@l_key_err_msg_amndmnt_hdr_id", SqlDbType.Int);
                    String connectionstring = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString;
                    SqlConnection myconn = new SqlConnection(connectionstring);
                    try
                    {

                        SqlCommand mycomm = new SqlCommand("pr_at_amendment_transfer_validation", myconn);
                        mycomm.CommandType = CommandType.StoredProcedure;
                        mycomm.Parameters.AddWithValue("p_key_local_plan_id", HDN_PlanID.Value.ToString());
                        mycomm.Parameters.AddWithValue("p_key_new_activity_id", txtActid.Text);
                        mycomm.Parameters.AddWithValue("p_amt_transfer_amount", moneytoamount.ToString());

                        rv_errornumber.Direction = ParameterDirection.ReturnValue;
                        mycomm.Parameters.Add(rv_errornumber);
                        if (myconn.State == ConnectionState.Closed)
                        {
                            myconn.Open();
                        }
                        mycomm.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        myconn.Close();
                        string myex_error = ex.Message.ToString();
                        //    throw new Exception(ex.Message + "      Error caused when calling pr_at_amendment_transfer_validation stored procedure logic");
                    }

                    /* End Section to test if Transfer should happen  RL 10-182008  */


                    if (rv_errornumber.Value.ToString() == "0")
                    {
                        HL_TransErrors.Visible = false;
                        SqlRL_attransferdetail.InsertParameters.Clear();
                        SqlRL_attransferdetail.InsertParameters.Add("key_amendment_transfer_hdr_id", txtHeaderTrans.Text);
                        SqlRL_attransferdetail.InsertParameters.Add("key_act_line_item_from_id", idfromvalue.ToString());
                        SqlRL_attransferdetail.InsertParameters.Add("amt_debit_amount", moneytoamount.ToString());
                        SqlRL_attransferdetail.InsertParameters.Add("key_act_line_item_to_id", idtovalue.ToString());
                        SqlRL_attransferdetail.InsertParameters.Add("amt_credit_amount", moneytoamount.ToString());
                        SqlRL_attransferdetail.Insert();
                        totaltransfered.Text = (Convert.ToDouble(moneytoamount.ToString()) + Convert.ToDouble(totaltransfered.Text.ToString())).ToString();
                    }
                    else
                    {
                        HL_TransErrors.Visible = true;

                        HL_TransErrors.Text = "Click to View Validation Errors";
                        HL_TransErrors.NavigateUrl = "javascript:showerrors(" + rv_errornumber.Value.ToString() + ");";


                    }
                    myconn.Close();
                }
            }
            Button2.Enabled = true;
            Button3.Enabled = true;

            /****************/

            SqlDataSource2.SelectParameters.Clear();
            if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 101)
            {
                SqlDataSource2.SelectParameters.Add("activityid", DropDownList3.SelectedValue.ToString());
            }
            else if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
            {
                SqlDataSource2.SelectParameters.Add("activityid", txtActid.Text);

            }
            else
            {
                SqlDataSource2.SelectParameters.Add("activityid", "-1");
            }




            SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            SqlDataSource2.Select(DataSourceSelectArguments.Empty);
            GridView1.DataBind();
            GridView2.DataBind();
            sqlDSTransactions.Select(DataSourceSelectArguments.Empty);
            radgridTransactions.DataBind();
            DropDownList3.Enabled = false;
            DropDownList4.Enabled = false;
        }
    }


    protected void SqlDSRL_pr_activitiy_stuff_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        txtActid.Text = e.Command.Parameters["@l_key_activity_id"].Value.ToString();
        //    keyactivityid = Convert.ToInt32(e.Command.Parameters["@l_key_activity_id"].Value);
        hdn_KeyActivityID.Value = txtActid.Text;
        Session[Session.SessionID + "keyactiveID"] = txtActid.Text;
    }

    protected void SqlRL_pr_at_transfer_Header_ins_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        //     header_transid = Convert.ToInt32(e.Command.Parameters["@l_header_activity_id"].Value);
        txtHeaderTrans.Text = e.Command.Parameters["@l_header_activity_id"].Value.ToString();
    }



    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        //  GridView1.Columns[1].ItemStyle.Width = 0;
    }



    protected void Button2_Click(object sender, EventArgs e)
    {
        SQLRL_act_transtatusupdate.UpdateParameters.Clear();
        //SQLRL_act_transtatusupdate.UpdateParameters.Add("key_activity_id", keyactivityid.ToString());Session[Session.SessionID + "keyactiveID"]
        SQLRL_act_transtatusupdate.UpdateParameters.Add("key_activity_id", hdn_KeyActivityID.Value);
        SQLRL_act_transtatusupdate.Update();
        
        hdn_KeyActivityID.Value = "-1";
        hdn_finishedStatus.Value = "true";

        SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Clear();
       
        if (Convert.ToInt32(ddAmendmentReason.SelectedValue) == 102)
        {
            
           
            //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_id", keyactivityid.ToString());Session[Session.SessionID + "keyactiveID"]
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_id", txtActid.Text);
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_local_plan_id", HDN_PlanID.Value.ToString());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_name", TextBox2.Text.ToString());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_function_code_id", DLB_FunCode.SelectedValue.ToString());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_fa_activity_type_id", ddlProgramType.SelectedValue.ToString());

            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_fund_source_id", "102");

            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_desc", txtActivityDesc.Text.ToString());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_core_indicator_desc", txtCoreIndicatorsDesc.Text);
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_funds_reduction_impact_desc", txtReductionFundsDesc.Text);

            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_type_id", DLB_ActType.SelectedValue);

            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_category_id", DLB_Category.SelectedValue.ToString());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_level_id", "101");
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_locked", "False");
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_approved", "False");
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_is_amendment", "1");
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.Update();
        }
        else
        {
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_id", txtActid.Text );
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_local_plan_id", HDN_PlanID.Value.ToString());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_name", txtAmendmentName.Text.Trim());
            //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_function_code_id", DLB_FunCode.SelectedValue.ToString());
            //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_fa_activity_type_id", ddlProgramType.SelectedValue.ToString());

            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_fund_source_id", "102");

            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_desc", txtAmdChangeInFundsDesc.Text.Trim());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_activity_core_indicator_desc", txtAmdCoreIndicatorsDesc.Text.Trim());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("txt_funds_reduction_impact_desc", txtAmdReductionDesc.Text.Trim());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_activity_type_id", "103");

            //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_category_id", DLB_Category.SelectedValue.ToString());
            //SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_level_id", "101");
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_locked", "False");
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_approved", "False");
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("flg_is_amendment", "1");
            SqlDSRL_pr_activitiy_SRC_OF_Fun.UpdateParameters.Add("key_amendment_reason_id", ddAmendmentReason.SelectedValue.ToString());
            SqlDSRL_pr_activitiy_SRC_OF_Fun.Update();           
        }

      
        int counter = 0;
        foreach (ListItem li in chkCoreIndicators.Items)
        {
            if (li.Selected)
            {
                counter++;
                SqlRl_act_core_indicat_ins.InsertParameters.Clear();
                //SqlRl_act_core_indicat_ins.InsertParameters.Add("key_activity_id", keyactivityid.ToString());  //DLB_ActType.SelectedValue.ToString());txtActid.Text
                SqlRl_act_core_indicat_ins.InsertParameters.Add("key_activity_id", txtActid.Text);  //DLB_ActType.SelectedValue.ToString());
                SqlRl_act_core_indicat_ins.InsertParameters.Add("key_core_indicator_id", li.Value.ToString());
                SqlRl_act_core_indicat_ins.Insert();
            }


        }
        if (counter == 0)
        {
            Label17.Visible = true;

        }
        else
        {
            Label17.Visible = false;
        }


        InjectScript.Text = "<script type='text/javascript'>Close('" + hdn_KeyActivityID.Value + "')</" + "script>";

    }



    protected void Button3_Click1(object sender, EventArgs e)
    {
        SQLRL_act_transtatusupdate.DeleteParameters.Clear();
        SQLRL_act_transtatusupdate.DeleteParameters.Add("key_activity_id", hdn_KeyActivityID.Value);
        SQLRL_act_transtatusupdate.Delete();
        InjectScript.Text = "<script type='text/javascript'>Close('" + hdn_KeyActivityID.Value + "')</" + "script>";
        // Response.Redirect("~/LocalPlan/Amendments.aspx");
    }


    protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
    }
    protected void radgridTransactions_ItemDeleted(object source, GridDeletedEventArgs e)
    {

    }

    protected void sqlDSTransactions_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {

        //    sqlDSTransactions.Delete();
        SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        SqlDataSource2.Select(DataSourceSelectArguments.Empty);
        GridView1.DataBind();
        GridView2.DataBind();
        sqlDSTransactions.Select(DataSourceSelectArguments.Empty);
        radgridTransactions.DataBind();
        if (radgridTransactions.MasterTableView.Items.Count <= 0)
        {
            //Amendment.Activity_Transaction_Status_Update(Convert.ToInt32(Session[Session.SessionID + "keyactiveID"]), 0);
            Amendment.Activity_Transaction_Status_Update(Convert.ToInt32(txtActid.Text), 0);
        }
    }
    protected void radgridTransactions_DeleteCommand(object source, GridCommandEventArgs e)
    {
        // Response.Write(e.Item.Cells[2].Text.ToString()+"helloworld");
        sqlDSTransactions.DeleteParameters.Clear();
        sqlDSTransactions.DeleteParameters.Add("DelId", e.Item.Cells[2].Text.ToString());
        sqlDSTransactions.Delete();
    }
    protected void RadGrid3_DataBound(object sender, EventArgs e)
    {


    }
    protected void RadGrid1_DataBound(object sender, EventArgs e)
    {


    }
    protected void tabWizard_TabClick(object sender, TabStripEventArgs e)
    {

    }
    protected void DLB_Category_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ListItem li = new ListItem("", "-1");
            if (DLB_Category.Items.IndexOf(li) < 0)
                DLB_Category.Items.Insert(0, li);
        }
    }
    protected void DLB_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        SDS_FunctionCODE.SelectParameters.Clear();
        SDS_FunctionCODE.SelectParameters.Add("p_key_category_id", DLB_Category.SelectedValue.ToString());
        DataView DW = (DataView)SDS_FunctionCODE.Select(DataSourceSelectArguments.Empty);
        DLB_FunCode.DataBind();
        txt_lbl_UseofFunds.Attributes.Add("ReadOnly", "ReadOnly");
        foreach (DataRow dr in DW.Table.Rows)
        {
            txt_lbl_UseofFunds.Text = dr["txt_category_type_desc"].ToString();
        }


        CategoryID.Text = DLB_Category.SelectedValue.ToString();


    }
    protected void DropDownList4_DataBound(object sender, EventArgs e)
    {
        //ListItem myitem = new ListItem("Select One", "-1");
        //if (DropDownList4.Items.IndexOf(myitem) < 0)
        //    DropDownList4.Items.Insert(0, myitem);
    }
    protected void DropDownList3_DataBound(object sender, EventArgs e)
    {
        ListItem myitem = new ListItem("Select One", "-1");
        if (DropDownList3.Items.IndexOf(myitem) < 0)
            DropDownList3.Items.Insert(0, myitem);
    }
    protected void DLB_FunCode_DataBound(object sender, EventArgs e)
    {
        ListItem myitem = new ListItem("Select Fund", "-1");
        if (DLB_FunCode.Items.IndexOf(myitem) < 0)
            DLB_FunCode.Items.Insert(0, myitem);
    }
    protected void DLB_Category_DataBound1(object sender, EventArgs e)
    {
        DD_Ins_Blank(DLB_Category, "Select a Category");
        //    ListItem myitem = new ListItem("Select Category", "-1");
        //    DLB_Category.Items.Insert(0, myitem);
    }


    protected void radgridTransactions_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (radgridTransactions.MasterTableView.Items.Count <= 0)
        {
            Button2.Enabled = false;
            //Amendment.Activity_Transaction_Status_Update(Convert.ToInt32(Session[Session.SessionID + "keyactiveID"]), 0);
        }
        else
            Button2.Enabled = true;
    }

    public void cvsCoreIndicator(object source, ServerValidateEventArgs args)
    {
        args.IsValid = true;
    }
}
