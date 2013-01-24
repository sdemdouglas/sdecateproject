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
using BLL;


public partial class LocalPlan_Amendments_AmendmentForm2 : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
        
        try
        {
            hfLocal_plan_id.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
            //(FormView1.FindControl("lblMsg") as Label).Text = "";
            //Panel1.Visible = true;
            lp_local_plan lpObj = new lp_local_plan();

            DropDownList ddStatus = (DropDownList) FormView1.FindControl("ddStatus");
            if (lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID.ToString() + "PlanID"].ToString())))
            {
                if (lpObj.Flg_lock_amendment_period != true && ddStatus.SelectedValue == "107")
                {
                    RadTabStrip1.Tabs[1].Visible = true;
                    hlActivityChangeRequest.Visible = true;
                }
                else
                {
                    RadTabStrip1.Tabs[1].Visible = false;
                    hlActivityChangeRequest.Visible = false;
                }
                
            }
        }
        catch
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                (FormView1.FindControl("lblMsg") as Label).Text = errObj.Txt_message;
            }
            //Panel1.Visible = false;
            hlActivityChangeRequest.Visible = false;
        }
        //RadGrid1.DataBind();
        GearBox_Ammendments_Secruity();

    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session[Session.SessionID + "roleid"].ToString() != "101")
        {
            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

        }

        
        
        
        
        this.RadMultiViewActivity.SelectedIndex = 0;
        RadTabStrip1.SelectedIndex = 0;
        hlActivityChangeRequest.Attributes.Add("onclick", "editActivityChangeRequest(" + Request.QueryString.Get("keyid").ToString() + ",-1, 'amendmentForm2')");

        if (!IsPostBack)
        {
            //
            (FormView1.FindControl("DLB_Category") as DropDownList).DataBind();

            hfCategory.Value = (FormView1.FindControl("DLB_Category") as DropDownList).SelectedValue.ToString();
            SqlDS_RLcoreindi_Get.DataBind();
            SDS_FunctionCODE.DataBind();
            //

            FormView1.FindControl("chkCoreIndicators").DataBind();
            FireQuerys();

            hf_Amendment_Id.Value = (FormView1.FindControl("lbl_Amendment_Num") as Label).Text;

            try
            {                                
                this.RadMultiViewActivity.SelectedIndex = Convert.ToInt32(Request.QueryString.Get("view").ToString());
                RadTabStrip1.SelectedIndex = Convert.ToInt32(Request.QueryString.Get("view").ToString());
            }
            catch (Exception ex){ }
        }


        try
        {

            SDS_FunctionCODE.SelectParameters.Clear();
            DropDownList ddlb = (FormView1.FindControl("DLB_Category") as DropDownList);

            SDS_FunctionCODE.SelectParameters.Add("p_key_category_id", ddlb.SelectedValue.ToString());
            DataView DW = (DataView)SDS_FunctionCODE.Select(DataSourceSelectArguments.Empty);
            TextBox txtbx = (FormView1.FindControl("txt_SourceofFunds") as TextBox);
            DropDownList ddlbfuncode = (FormView1.FindControl("DLB_FunCode") as DropDownList);
           
            txtbx.Attributes.Add("ReadOnly", "ReadOnly");
            foreach (DataRow dr in DW.Table.Rows)
            {
                txtbx.Text = dr["txt_category_type_desc"].ToString();
            }
        }
        catch
        {
        }
    }

    protected void FireQuerys()
    {
        lp_local_plan lpObj = new lp_local_plan();

        if (lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID.ToString() + "PlanID"].ToString())))
        {
            if (lpObj.Flg_lock_amendment_period == true)
                RadTabStrip1.Tabs[1].Visible = false;
            else
                RadTabStrip1.Tabs[1].Visible = true;
        }

        


        DataView dx = (DataView)SqlDS_RLcoreindi_Get.Select(DataSourceSelectArguments.Empty);
        CheckBoxList cblCoreIndicators = (CheckBoxList)FormView1.FindControl("chkCoreIndicators");
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


        Label myactfrom = (Label)FormView1.FindControl("lblAcitvityFrom");
        Label mylblCategoryFrom = (Label)FormView1.FindControl("lblCategoryFrom");
        Label mylblFunctionFrom = (Label)FormView1.FindControl("lblFunctionFrom");


        DataView DV = (DataView)this.SQLDS_RLMOVEFROM_CAT.Select(DataSourceSelectArguments.Empty);
        if (DV.Table.Rows.Count > 0)
        {
            myactfrom.Text = DV.Table.Rows[0][0].ToString();
            mylblCategoryFrom.Text = DV.Table.Rows[0][2].ToString();
            mylblFunctionFrom.Text = DV.Table.Rows[0][1].ToString();

        }





        Label mylblActivityTo = (Label)FormView1.FindControl("lblActivityTo");
        Label mylblCategoryTo = (Label)FormView1.FindControl("lblCategoryTo");
        Label mylblFunctionTo = (Label)FormView1.FindControl("lblFunctionTo");


        DV = (DataView)this.sqlds_rlmoveto_cat.Select(DataSourceSelectArguments.Empty);
        if (DV.Table.Rows.Count > 0)
        {
            mylblActivityTo.Text = DV.Table.Rows[0][0].ToString();
            mylblCategoryTo.Text = DV.Table.Rows[0][2].ToString();
            mylblFunctionTo.Text = DV.Table.Rows[0][1].ToString();

        }

        DV = (DataView)this.SqlDS_RLactivityGET.Select(DataSourceSelectArguments.Empty);
        if (DV.Table.Rows.Count > 0)
        {
            if (!DV.Table.Rows[0]["flg_locked"].ToString().Equals("False"))
                hlActivityChangeRequest.Visible = false;

            DropDownList dd_cat = FormView1.FindControl("DLB_Category") as DropDownList;
            DropDownList dd_fund = FormView1.FindControl("DLB_FunCode") as DropDownList;
            DropDownList dd_use = FormView1.FindControl("ddlUseOfFunds") as DropDownList;
            DropDownList dd_type = FormView1.FindControl("ddlProgramType") as DropDownList;

            dd_fund.DataBind();

            dd_cat.SelectedIndex = dd_cat.Items.IndexOf(dd_cat.Items.FindByValue(DV.Table.Rows[0][6].ToString()));
            dd_fund.SelectedIndex = dd_fund.Items.IndexOf(dd_fund.Items.FindByValue(DV.Table.Rows[0][7].ToString()));

            dd_use.SelectedIndex = dd_use.Items.IndexOf(dd_use.Items.FindByValue(DV.Table.Rows[0][9].ToString()));
            dd_type.SelectedIndex = dd_type.Items.IndexOf(dd_type.Items.FindByValue(DV.Table.Rows[0][5].ToString()));
        }

    }
    protected void btnClose_Click(object sender, EventArgs e)
    {

        //(HiddenField)hfPageInfo = (HiddenField)FormView1.FindControl("hfPageInfo");
        //(HiddenField)hfFlgSave = (HiddenField)FormView1.FindControl("hfFlgSave");

        Label lblMsg = (Label)FormView1.FindControl("lblMsg");


        if (hfPageInfo.Value == "1") //page Info changed
        {
            // yes: user wants to close page without save 
            if (hfFlgSave.Value == "yes")
                InjectScript.Text = "<script>CloseAndRebind(" + Convert.ToInt32(Request.QueryString.Get("level").ToString()) + ")</script>";
            else
            {
                //TRG_Funds.DataBind();
                //RadGrid1.DataBind();
                lblMsg.Text = "";
            }
        }
        else
        {
            InjectScript.Text = "<script>CloseAndRebind(" + Convert.ToInt32(Request.QueryString.Get("level").ToString()) + ")</script>";
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                //Update current activity
                DataAccess obj = new DataAccess();
                act_activity actObj = new act_activity();
                actObj.ConnectionString = DataAccess.getConnStr();
                int ika = Convert.ToInt32(Request.QueryString.Get("keyid").ToString());

                if (actObj.LoadByPrimaryKey(ika))
                {                    
                    obj.updateActivity(ika,
                                       Convert.ToInt32(Session[Session.SessionID.ToString() + "PlanID"].ToString()),
                                       (FormView1.FindControl("txtActivityName") as TextBox).Text,
                                       (FormView1.FindControl("txtDescActivity") as TextBox).Text,
                                       Convert.ToInt32((FormView1.FindControl("ddlProgramType") as DropDownList).SelectedValue),
                                       (FormView1.FindControl("txtDescCoreInd") as TextBox).Text,
                                       Convert.ToInt32((FormView1.FindControl("DLB_Category") as DropDownList).SelectedValue),
                                       Convert.ToInt32((FormView1.FindControl("DLB_FunCode") as DropDownList).SelectedValue),
                                       actObj.Key_activity_type_id,
                                       (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Text,
                                       Convert.ToInt32((FormView1.FindControl("ddStatus") as DropDownList).SelectedValue),
                                       (FormView1.FindControl("cbLocked") as CheckBox).Checked,
                                       (FormView1.FindControl("cbApproved") as CheckBox).Checked,
                                       true,
                                       (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Text,
                                       102);

                    //Insert Core Indicator

                    CheckBoxList cblCoreIndicators = FormView1.FindControl("chkCoreIndicators") as CheckBoxList;
                    for (int i = 0; i < cblCoreIndicators.Items.Count; i++)
                        if (cblCoreIndicators.Items[i].Selected)
                            obj.insertFundedActivityCoreIndicator(Convert.ToInt32(ika),
                                                                  Convert.ToInt32(cblCoreIndicators.Items[i].Value));


                    //update Line Item
                    //for (int i = 0; i < TRG_Funds.MasterTableView.Items.Count; i++)
                    //{
                    //    TextBox tb = (TextBox)TRG_Funds.MasterTableView.Items[i].FindControl("txt_Funds");
                    //    if (tb != null && !tb.Text.Equals(""))
                    //    {
                    //        obj.updateFundedActivityLineItems(Convert.ToInt32(ika),
                    //                                          Convert.ToInt32(TRG_Funds.MasterTableView.Items[i].GetDataKeyValue("key_line_item_type_id")),
                    //                                          Convert.ToDecimal(tb.Text));
                    //    }
                    //}

                    scs_error_dictionary errObj = new scs_error_dictionary();

                    if (errObj.LoadByPrimaryKey("200"))
                    {
                        (FormView1.FindControl("lblMsg") as Label).Text = errObj.Txt_message;
                    }

                }
            }
            catch(Exception ex)
            {
                scs_error_dictionary errObj = new scs_error_dictionary();

                if (errObj.LoadByPrimaryKey("201"))
                {
                    (FormView1.FindControl("lblMsg") as Label).Text = errObj.Txt_message;
                }
            }       
        }
    }
   
    protected void RadGrid2_DataBound(object sender, EventArgs e)
    {
        foreach (GridDataItem item in RadGrid2.Items)
        {
            HyperLink hlEdit = (HyperLink)item.FindControl("hlEdit");

            if (hlEdit != null)
            {
                hlEdit.NavigateUrl = "javascript:editActivityChangeRequest(" + item["key_activity_id"].Text.Trim().ToLower() + ", " + item["key_act_change_id"].Text.Trim().ToLower() + ", 'activityFunds');";
            }

            CheckBox cbApproved = (CheckBox)item.FindControl("cbReqApproved");

            if (cbApproved != null)
            {
                if (!cbApproved.Checked)
                {
                    //hlActivityChangeRequest.Visible = false;
                    hlAcr.Style["Display"] = "none";    
                    item["DeleteColumn"].Visible = true;

                }
                else
                {
                    item["DeleteColumn"].Visible = false;

                }
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        act_activity aObj = new act_activity();
        aObj.ConnectionString = DataAccess.getConnStr();
        if (!Request.QueryString.Get("keyid").ToString().Equals("-1"))
        {
            if (hfDelete.Value == "yes")
            {
                aObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("keyid").ToString()));
                aObj.DeleteCurrentRow();
                aObj.Save();
                InjectScript.Text = "<script>CloseAndRebind()</" + "script>";
            }
            //else
            //{
            //    lblTotalBudget.Text = hfTotalBudget.Value;
            //}
        }
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
       
    }
    protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
    {

    }
    protected void DLB_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        SDS_FunctionCODE.SelectParameters.Clear();
        DropDownList ddlb = (FormView1.FindControl("DLB_Category") as DropDownList);
       
        SDS_FunctionCODE.SelectParameters.Add("p_key_category_id", ddlb.SelectedValue.ToString());
        DataView DW = (DataView)SDS_FunctionCODE.Select(DataSourceSelectArguments.Empty);
        TextBox txtbx = (FormView1.FindControl("txt_SourceofFunds") as TextBox);
        DropDownList ddlbfuncode = (FormView1.FindControl("DLB_FunCode") as DropDownList);
        ddlbfuncode.DataBind();
        txtbx.Attributes.Add("ReadOnly", "ReadOnly");
        foreach (DataRow dr in DW.Table.Rows)
        {
            txtbx.Text = dr["txt_category_type_desc"].ToString();
        }
    }

    protected void GearBox_Ammendments_Secruity()
    {
        try
        {
            int aid = Convert.ToInt32(Request.QueryString.Get("keyid").ToString());

            //lp_local_plan lpObj = new lp_local_plan();
            //lpObj.ConnectionString = DataAccess.getConnStr();
            //lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString()));


            string roleid = Session[Session.SessionID + "roleid"].ToString();
            switch (FundingPlan.get_Funding_Plan_Level(aid))
            {
                case "101":
                    //Level 0 Awaiting CO Admin

                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = true;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = true;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = true;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = true;
                            

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "102":
                            //CAO

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = true;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = true;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = true;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button ).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                         // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }

                    break;
                case "102":
                    //Level 1 Awaiting CAO
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = true;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = true;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = true;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = true;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = true;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = true;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = true;


                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                        //    (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox ).Enabled = false;
                            break;
                    }
                    break;
                case "103":
                    //Review by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList ).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }
                    break;

                case "104":
                    //So 3 Revision Requested by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = true;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = true;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = true;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = true;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = true;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = true;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;

                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }
                    break;

                case "105":
                    //Level 4 Pending SDE Review
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;


                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;


                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;

                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }
                    break;

                case "106":
                    //Level 5 Approved
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;

                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("DLB_Category") as DropDownList).Enabled = false;
                            (FormView1.FindControl("DLB_FunCode") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txt_SourceofFunds") as TextBox).Enabled = false;
                            (FormView1.FindControl("ddlProgramType") as DropDownList).Enabled = false;
                            (FormView1.FindControl("chkCoreIndicators") as CheckBoxList).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                    }
                    break;
               
                default:
                    // View Only, and anything not covered

                    break;
            }


            //if (lpObj.Flg_lock_amendment_period != true)
            //{
            //    hlNewAmendment.Visible = true;
            //}
            //else
            //    hlNewAmendment.Visible = false;
        }
        catch (Exception ex)
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                //lblMsg.Text = errObj.Txt_message;
            }
            Panel1.Visible = false;
        }

    }
    protected void ddlProgramType_DataBound(object sender, EventArgs e)
    {
        DropDownList ddlProgramType = FormView1.FindControl("ddlProgramType") as DropDownList;
        ListItem li = new ListItem("", "-1");
        if (ddlProgramType.Items.IndexOf(li) < 0)
            ddlProgramType.Items.Insert(0, li);
        ddlProgramType.SelectedIndex = 0;
    }

    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        base.RaisePostBackEvent(sourceControl, eventArgument);

        if (sourceControl is RadGrid)
        {
            switch (eventArgument)
            {
                case "Rebind":
                    RadGrid2.Rebind();
                    break;
            }
        }
    }


    double h_total = 0;
    double c_total = 0;
    double d_total = 0;

    double group_c_total = 0;
    double group_d_total = 0;

    double h_totalAdj = 0;

    protected void rg_History_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is Telerik.Web.UI.GridDataItem)
        {
            Telerik.Web.UI.GridDataItem dataItem = e.Item as Telerik.Web.UI.GridDataItem;
            Label tb = (Label)e.Item.FindControl("lblTotal");


            if (tb != null)
            {
                h_total += Double.Parse(dataItem["nbr_credit_amount"].Text) +
                                            Double.Parse(dataItem["nbr_debit_amount"].Text);

                c_total += Double.Parse(dataItem["nbr_credit_amount"].Text);
                d_total += Double.Parse(dataItem["nbr_debit_amount"].Text);

                group_c_total += Double.Parse(dataItem["nbr_credit_amount"].Text);
                group_d_total += Double.Parse(dataItem["nbr_debit_amount"].Text);
                h_totalAdj = c_total + d_total;
                tb.Text = string.Format("{0:N2}", h_totalAdj);
            }
        }

        if (e.Item is Telerik.Web.UI.GridGroupFooterItem)
        {
            Telerik.Web.UI.GridGroupFooterItem gfi = e.Item as Telerik.Web.UI.GridGroupFooterItem;
            gfi["nbr_credit_amount"].Text = string.Format("{0:c}", group_c_total);
            gfi["nbr_debit_amount"].Text = string.Format("{0:c}", group_d_total);
            gfi["TemplateColumn"].Text = string.Format("{0:c}", h_totalAdj);

            group_d_total = 0;
            group_c_total = 0;
            //(gfi.FindControl("lblTotal") as Label).Text = string.Format("{0:c}", h_totalAdj);

            //(gfi.FindControl("lblTotal") as Label).Text = string.Format("{0:c}", h_totalAdj);

        }

        if (e.Item is Telerik.Web.UI.GridFooterItem)
        {
            Telerik.Web.UI.GridFooterItem footerItem = e.Item as Telerik.Web.UI.GridFooterItem;
            footerItem["nbr_credit_amount"].Text = string.Format("{0:c}", c_total);
            footerItem["nbr_debit_amount"].Text = string.Format("{0:c}", d_total);

            footerItem["dte_created_date"].Text = "TOTAL";

            (footerItem.FindControl("lbl_Sum") as Label).Text = string.Format("{0:c}", h_total);
            // hfGridTot.Value = total.ToString();
        }
    }
    
}
