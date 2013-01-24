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

public partial class LocalPlan_Activities_ActivityForm : System.Web.UI.Page
{
    static decimal   grandtotal_bookeeping_oldtotal;
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        try
        {
          
            hfLpId.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
          
            
        }
        catch
        {            
        }

        lp_local_plan lpObj = new lp_local_plan();
        DataAccess daObj = new DataAccess();
        SqlDataReader mydr = daObj.getAvialableFund(Convert.ToInt32(hfLpId.Value));

        if (mydr.HasRows)
        {
            while (mydr.Read())
            {
                try
                {
                    hfTotBal.Value = mydr["nbr_local_plan_balance"].ToString();
                    try
                    {
                        txtAvailableFunds.Text = string.Format("{0:C}", mydr["nbr_local_plan_balance"]);
                    }
                    catch
                    {
                        txtAvailableFunds.Text = string.Format("{0:C}", 0);
                    }

                    lblNewTotalLineItem.Text = string.Format("{0:C}", Double.Parse(hfTotBal.Value) + Double.Parse(hfGridTot.Value));

                    try{
                        if (lpObj.LoadByPrimaryKey(Convert.ToInt32(hfLpId.Value)))
                        {
                            if (lpObj.Flg_lock_amendment_period != true && ddStatus.SelectedValue == "107")
                                RadTabStrip1.Tabs[1].Visible = true;
                            else
                                RadTabStrip1.Tabs[1].Visible = false;
                        }
                        else
                            RadTabStrip1.Tabs[1].Visible = false;
                    }
                    catch{
                        RadTabStrip1.Tabs[1].Visible = false;
                    }
                }
                catch
                {
                }
            }
        }

        GearBox_ActivityForm_Secruity();
        Utility.addPageInfoChange(this.Page, "ActivityForm");
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.RadMultiViewActivity.SelectedIndex = 0;
            RadTabStrip1.SelectedIndex = 0;
            hlActivityChangeRequest.Attributes.Add("onclick", "editActivityChangeRequest(" + Request.QueryString.Get("id").ToString() + ",-1, 'activityFunds')");

            DLB_Category.Attributes.Add("OnChange", "saveCurrentBudget()");
            txtDescActivity.Attributes.Add("onkeyup", "calCharNumber()");


            txtDescCoreInd.Attributes.Add("onkeyup", "calCharNumber1()");
        }
        try
        {
            if (Request.QueryString.Get("reload") == "true")
            {
                RadTabStrip1.SelectedIndex = 1;
                RadMultiViewActivity.SelectedIndex = 1;
            }

        }
        catch
        {
        }
        if (!IsPostBack)
        {
              
                  
            DLB_Category.DataBind();
            DLB_FunCode.DataBind();
            ddlUseOfFunds.DataBind();
            TRG_Funds.DataBind();
            DLB_ActType.DataBind();
            ddlProgramType.DataBind();
            ddStatus.DataBind();
            cblCoreIndicators.DataBind();
            hfPageInfo.Value = "0";

            lblMsg.Text = "";

            try
            {
                this.RadMultiViewActivity.SelectedIndex = Convert.ToInt32(Request.QueryString.Get("view").ToString());
                RadTabStrip1.SelectedIndex = Convert.ToInt32(Request.QueryString.Get("view").ToString());
            }
            catch { }


            lp_local_plan lpObj = new lp_local_plan();

            if (lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID.ToString() + "PlanID"].ToString())))
            {
                lblCollege.Text = lpObj.Txt_college_name;
                lblFiscalYear.Text = lpObj.Nbr_fiscal_year.ToString();
            }

            if(Request.QueryString.Get("id").ToString().Equals("-1"))
            {
                //Add new 
                btnDelete.Visible = false;
                btnSave.Text = "Add";
                lblAvtivityNbr.Text = "";
                RadTabStrip1.Tabs[1].Visible = false;
                btnPrint.Enabled = false;
                btn_Print_History.Enabled = false;
                btnPrintWord.Enabled = false;
            }
            else
            {
                // Edit
                //btnDelete.Visible = true;
                btnSave.Text = "Save";

                

                 //DataView dw = (DataView)SqlDS_RLactivityGET.Select(DataSourceSelectArguments.Empty);
                 //foreach (DataRow dr in dw.Table.Rows)
                 //{
                 //    DLB_ActType.SelectedIndex = DLB_ActType.Items.IndexOf(DLB_ActType.Items.FindByValue(dr["key_activity_type_id"].ToString()));

                 //    txtActivityName.Text = dr["txt_activity_name"].ToString();
                 //    txtDescActivity.Text = dr["txt_activity_desc"].ToString();
                 //    txtDescCoreInd.Text = dr["txt_activity_core_indicator_desc"].ToString();
                 //    DLB_Category.SelectedIndex = DLB_Category.Items.IndexOf(DLB_Category.Items.FindByValue(dr["key_category_id"].ToString()));
                 //    DLB_FunCode.SelectedIndex = DLB_FunCode.Items.IndexOf(DLB_FunCode.Items.FindByValue(dr["key_function_code_id"].ToString()));
                 //    ddlUseOfFunds.SelectedIndex = ddlUseOfFunds.Items.IndexOf(ddlUseOfFunds.Items.FindByValue(dr["key_fund_source_id"].ToString()));
                 //    ddlProgramType.SelectedIndex = ddlProgramType.Items.IndexOf(ddlProgramType.Items.FindByValue(dr["key_fa_activity_type_id"].ToString()));
                 //}
                act_activity actObj = new act_activity();
                actObj.ConnectionString = DataAccess.getConnStr();

                if (actObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("id").ToString())))
                {
                    
                    try
                    {

                        DLB_ActType.SelectedIndex = DLB_ActType.Items.IndexOf(DLB_ActType.Items.FindByValue(actObj.Key_fa_activity_type_id.ToString()));
                    }
                    catch
                    {
                        DLB_ActType.SelectedIndex = 0;
                    }
                    
                    lblAvtivityNbr.Text = actObj.Key_activity_id.ToString();
                    txtActivityName.Text = actObj.Txt_activity_name;
                    txtDescActivity.Text = actObj.Txt_activity_desc;
                    try
                    {
                        txtDescCoreInd.Text = actObj.Txt_activity_core_indicator_desc;
                    }
                    catch
                    {
                        txtDescCoreInd.Text = "";
                    }
                    DLB_Category.SelectedIndex = DLB_Category.Items.IndexOf(DLB_Category.Items.FindByValue(actObj.Key_category_id.ToString()));

                    try
                    {
                        DLB_FunCode.SelectedIndex = DLB_FunCode.Items.IndexOf(DLB_FunCode.Items.FindByValue(actObj.Key_function_code_id.ToString()));
                    }
                    catch
                    {
                        DLB_FunCode.SelectedIndex = 0;
                    }
                    
                    //ddlUseOfFunds.SelectedIndex = ddlUseOfFunds.Items.IndexOf(ddlUseOfFunds.Items.FindByValue(actObj.Key_fund_source_id.ToString()));
                    //Set for 0 right now - will be changed later 
                    ddlUseOfFunds.SelectedIndex = 1;
                    try
                    {
                        ddlProgramType.SelectedIndex = ddlProgramType.Items.IndexOf(ddlProgramType.Items.FindByValue(actObj.Key_fa_activity_type_id.ToString()));
                    }
                    catch
                    {
                        ddlProgramType.SelectedIndex = 0;
                    }
                    try
                    {
                        lblDateUpdated.Text = actObj.Dte_updated_date.ToShortDateString();
                    }
                    catch
                    {
                        lblDateUpdated.Text = "";
                    }

                    try
                    {
                        lblUpdatedBy.Text = actObj.Txt_updated_user;
                    }
                    catch
                    {
                        lblUpdatedBy.Text = "";
                    }
                    try
                    {
                        cbApproved.Checked = actObj.Flg_approved;
                    }
                    catch
                    {
                        cbApproved.Checked = false;
                    }
                    try
                    {
                        cbLocked.Checked = actObj.Flg_locked;
                    }
                    catch
                    {
                        cbLocked.Checked = false;
                    }
                    txtSystemOfficeNotes.Text = actObj.Txt_system_office_notes.ToString();
                    ddStatus.SelectedIndex = ddStatus.Items.IndexOf(ddStatus.Items.FindByValue(actObj.Key_level_id.ToString()));

                }
            }
            
            DLB_ActType.SelectedIndex = 0;
            if (cbLocked.Checked == true)
            {
                if (!Session[Session.SessionID + "roleid"].ToString().Equals("101"))
                    Lock_Page();
                
            }
            //else
            //{
            //    if (ddStatus.SelectedIndex < 2)
            //        Lock_SO();
            //}
        }


        try
        {
            SDS_FunctionCODE.SelectParameters.Clear();
            SDS_FunctionCODE.SelectParameters.Add("p_key_category_id", DLB_Category.SelectedValue.ToString());
            DataView DW = (DataView)SDS_FunctionCODE.Select(DataSourceSelectArguments.Empty);
           

            txt_UseOfFunds.Attributes.Add("ReadOnly", "ReadOnly");
            foreach (DataRow dr in DW.Table.Rows)
            {
                txt_UseOfFunds.Text = dr["txt_category_type_desc"].ToString();
            }
        }
        catch
        {
        }
        if(hfTempTotal.Value.Trim() != "")
            lblTotalBudget.Text = hfTempTotal.Value;
    }

    protected void DLB_Category_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (DLB_Category.Items.IndexOf(li) < 0)
            DLB_Category.Items.Insert(0, li);
          DataView dw = (DataView)SqlDS_RLactivityGET.Select(DataSourceSelectArguments.Empty);
          foreach (DataRow dr in dw.Table.Rows)
          {
              DLB_Category.SelectedIndex = DLB_Category.Items.IndexOf(DLB_Category.Items.FindByValue(dr["key_category_id"].ToString()));
          }

    }
    protected void DLB_FunCode_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (DLB_FunCode.Items.IndexOf(li) < 0)
            DLB_FunCode.Items.Insert(0, li);
  
        DataView dw = (DataView)SqlDS_RLactivityGET.Select(DataSourceSelectArguments.Empty);
        foreach (DataRow dr in dw.Table.Rows)
        {
            DLB_FunCode.SelectedIndex = DLB_FunCode.Items.IndexOf(DLB_FunCode.Items.FindByValue(dr["key_function_code_id"].ToString()));
        }


    }
    protected void ddlUseOfFunds_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddlUseOfFunds.Items.IndexOf(li) < 0)
            ddlUseOfFunds.Items.Insert(0, li);
    }
    protected void ddlProgramType_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddlProgramType.Items.IndexOf(li) < 0)
            ddlProgramType.Items.Insert(0, li);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            lblPrintTrigger.Text = "";

            decimal total = 0;
            for (int i = 0; i < TRG_Funds.MasterTableView.Items.Count; i++)
            {
                TextBox tb = (TextBox)TRG_Funds.MasterTableView.Items[i].FindControl("txt_Funds");
                if (tb != null && !tb.Text.Equals(""))
                {
                    total += Convert.ToDecimal(tb.Text);
                }
            }

            decimal availbal = 0;
            DataView da = (DataView)SQLDS_RLGETBALANCE.Select(DataSourceSelectArguments.Empty);
            foreach (DataRow dr in da.Table.Rows)
            {
                availbal += Convert.ToDecimal(dr["nbr_local_plan_balance"].ToString());
            }

            if (total - grandtotal_bookeeping_oldtotal <= availbal)
            {
                Save();
                Label2.Visible = false;
            }
            else
            {
                Label2.Visible = true;
            }
        }
    }


    protected void btnClose_Click(object sender, EventArgs e)
    {
        if (hfPageInfo.Value == "1")
        {
            // yes: user wants to close page without save 
            if (hfFlgSave.Value == "yes")
                InjectScript.Text = "<script>CloseAndRebind(" + Convert.ToInt32(Request.QueryString.Get("level").ToString()) + ")</script>";
            else
                lblMsg.Text = "";
        }
        else
        {
            try
            {
                InjectScript.Text = "<script>CloseAndRebind(" + Convert.ToInt32(Request.QueryString.Get("level").ToString()) + ")</script>";
            }
            catch
            {
                InjectScript.Text = "<script>CloseAndRebind(-1)</script>";
            }
        }
    }

    protected void Save()
    {       
            lblMsg.Text = "";
            hfPageInfo.Value = "0";
            hfFlgSave.Value = "";

            if (Request.QueryString.Get("id").Equals("-1"))
            {
                //Add new Activity
                DataAccess obj = new DataAccess();
                
                int iLpid;
                try
                {
                    iLpid = Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString());

                    String ika = obj.insertActivity(iLpid,
                                                   txtActivityName.Text,
                                                   txtDescActivity.Text,
                                                   Convert.ToInt32(ddlProgramType.SelectedValue),
                                                   txtDescCoreInd.Text,
                                                   Convert.ToInt32(DLB_Category.SelectedValue),
                                                   Convert.ToInt32(DLB_FunCode.SelectedValue),
                                                   Convert.ToInt32(DLB_ActType.SelectedValue),
                                                   101); 

                    lblAvtivityNbr.Text = ika;

                    //Insert Core Indicator
                    for (int i = 0; i < cblCoreIndicators.Items.Count; i++)
                        if (cblCoreIndicators.Items[i].Selected)
                            obj.insertFundedActivityCoreIndicator(Convert.ToInt32(ika),
                                                                  Convert.ToInt32(cblCoreIndicators.Items[i].Value));


                    //update Line Item
                    for (int i = 0; i < TRG_Funds.MasterTableView.Items.Count; i++)
                    {
                        TextBox tb = (TextBox)TRG_Funds.MasterTableView.Items[i].FindControl("txt_Funds");
                        if (tb != null && !tb.Text.Equals(""))
                        {
                            obj.updateFundedActivityLineItems(Convert.ToInt32(ika),
                                                              Convert.ToInt32(TRG_Funds.MasterTableView.Items[i].GetDataKeyValue("key_line_item_type_id")),
                                                              Convert.ToDecimal(tb.Text));
                        }
                    }
                    InjectScript.Text = "<script>refreshPage(" + ika + ")</" + "script>";
                }
                catch
                {
                    //No local plan id
                }

            }
            else
            {
                //Update current activity
                DataAccess obj = new DataAccess();
                act_activity actObj = new act_activity();
                actObj.ConnectionString = DataAccess.getConnStr();
                int ika = Convert.ToInt32(Request.QueryString.Get("id").ToString());

                if (actObj.LoadByPrimaryKey(ika))
                {
                    //Local Plan id will be enter later, use 101 for now

                    obj.updateActivity(ika,
                                       Convert.ToInt32(Session[Session.SessionID.ToString() + "PlanID"].ToString()),
                                       txtActivityName.Text,
                                       txtDescActivity.Text,
                                       Convert.ToInt32(ddlProgramType.SelectedValue),
                                       txtDescCoreInd.Text,
                                       Convert.ToInt32(DLB_Category.SelectedValue),
                                       Convert.ToInt32(DLB_FunCode.SelectedValue),
                                       Convert.ToInt32(DLB_ActType.SelectedValue),
                                       txtSystemOfficeNotes.Text,
                                       Convert.ToInt32(ddStatus.SelectedValue),
                                       cbLocked.Checked,
                                       cbApproved.Checked,
                                       false,
                                       "",
                                       101);

                    //Insert Core Indicator
                    for (int i = 0; i < cblCoreIndicators.Items.Count; i++)
                        if (cblCoreIndicators.Items[i].Selected)
                            obj.insertFundedActivityCoreIndicator(Convert.ToInt32(ika),
                                                                  Convert.ToInt32(cblCoreIndicators.Items[i].Value));


                    //update Line Item
                    for (int i = 0; i < TRG_Funds.MasterTableView.Items.Count; i++)
                    {
                        TextBox tb = (TextBox)TRG_Funds.MasterTableView.Items[i].FindControl("txt_Funds");
                        if (tb != null && !tb.Text.Equals(""))
                        {
                            obj.updateFundedActivityLineItems(Convert.ToInt32(ika),
                                                              Convert.ToInt32(TRG_Funds.MasterTableView.Items[i].GetDataKeyValue("key_line_item_type_id")),
                                                              Convert.ToDecimal(tb.Text));
                        }
                    }

                }
                scs_error_dictionary errObj = new scs_error_dictionary();

                if (errObj.LoadByPrimaryKey("200"))
                {
                    lblMsg.Text = errObj.Txt_message;
                }

            }
            TRG_Funds.DataBind();
            RadGrid1.DataBind();
        
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
    

    protected void TRG_Funds_DataBound(object sender, EventArgs e)
    {
        grandtotal_bookeeping_oldtotal = 0;
        //IndirectCost_rule(); 

        DataView dx = (DataView)SqlDS_RLActivityLineGet.Select(DataSourceSelectArguments.Empty);
        decimal dTotal = 0;
        TextBox mytxt;

        foreach (GridItem Gi in TRG_Funds.Items)
        {
          //(Gi.Cells[2].Text);
            foreach (DataRow dr in dx.Table.Rows)
            {
                if (Gi.Cells[2].Text.Trim().ToLower() == dr["key_line_item_type_id"].ToString().Trim())
                {
                    mytxt = (TextBox)Gi.FindControl("txt_Funds");
                    mytxt.Text = string.Format("{0:N2}", dr["amt_amount"]);
                    if (mytxt != null)
                        dTotal += Convert.ToDecimal(mytxt.Text);

                    grandtotal_bookeeping_oldtotal += Convert.ToDecimal(mytxt.Text);
                }               
            }
            
        }
        lblTotalBudget.Text = string.Format("{0:N2}", dTotal);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        act_activity aObj = new act_activity();
        aObj.ConnectionString = DataAccess.getConnStr();
        if(!Request.QueryString.Get("id").ToString().Equals("-1"))
        {
            if (hfDelete.Value == "Yes")
            {
                aObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("id").ToString()));
                aObj.DeleteCurrentRow();
                aObj.Save();
                InjectScript.Text = "<script>CloseAndRebind()</" + "script>";
            }
            else
            {
                lblTotalBudget.Text = hfTotalBudget.Value;
            }
        }
        
    }

    protected void TRG_Funds_ItemCreated(object sender, GridItemEventArgs e)
    {

        TextBox txtFunds = (TextBox)e.Item.FindControl("txt_Funds");
        if (txtFunds != null)
        {
            txtFunds.Attributes.Add("onblur", "updateTotal('" + txtFunds.ClientID + "')");
            txtFunds.Attributes.Add("onFocus", "getItemValue('" + txtFunds.ClientID + "')");
        }

        //TextBox txtFunds1 = (TextBox)e.Item.FindControl("txt_Funds1");
        //if (txtFunds1 != null)
        //{
        //    txtFunds1.Attributes.Add("onblur", "updateTotal('" + txtFunds1.ClientID + "')");
        //    txtFunds1.Attributes.Add("onFocus", "getItemValue('" + txtFunds1.ClientID + "')");
        //}
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
        //txtActivityName.ReadOnly = true;
        //DLB_Category.Enabled = false;
        //DLB_FunCode.Enabled = false;
        //ddlUseOfFunds.Enabled = false;
        //ddlUseOfFunds.Enabled = false;
        //cblCoreIndicators.Enabled = false;
        //txtDescActivity.ReadOnly  = true ;
        //txtDescCoreInd.ReadOnly  = true ;
        //TRG_Funds.Enabled = false;
        //ddlProgramType.Enabled = false;
        //btnSave.Enabled = false;
        //btnDelete.Enabled = false;

        btnDelete.Enabled = false;
        btnSave.Enabled = false; 
        Lock_SO();
    }

    protected void UnLock_Page()
    {
        //txtActivityName.Enabled = true;
        //DLB_Category.Enabled = true;
        //DLB_FunCode.Enabled = true;
        //ddlUseOfFunds.Enabled = true;
        //ddlUseOfFunds.Enabled = true;
        //cblCoreIndicators.Enabled = true;
        //txtDescActivity.Enabled = true;
        //txtDescCoreInd.Enabled = true;
        //TRG_Funds.Enabled = true;
        //ddlProgramType.Enabled = true;
        
        btnDelete.Enabled = true;
        btnSave.Enabled = true;
        UnLock_SO();
    }


    protected void btnPrint_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (Request.QueryString.Get("id").ToString().Equals("-1"))
            {
                Save();
            }
            else
            {
                act_activity actObj = new act_activity();
                actObj.ConnectionString = DataAccess.getConnStr();

                if (actObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("id").ToString())))
                {
                    try
                    {
                        if (actObj.Flg_locked)
                        {
                            if (Session[Session.SessionID + "roleid"].ToString().Equals("101"))
                            {
                                Save();
                            }
                        }
                        else
                            Save();
                    }
                    catch
                    {
                        Save();
                    }
                }
            }
            lblPrintTrigger.Text = "<script>Print('fundedactivities','pdf')</" + "script>";
        }
    }

    double total;
    double totalOriAmt = 0;
    double totalQtr1 = 0;
    double totalQtr2 = 0;
    double totalQtr3 = 0;
    double totalQtr4 = 0;
    double totalAdj = 0;

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            Label tb = (Label)e.Item.FindControl("lblTotal");
           

            if (tb != null)
            {
                tb.Text = string.Format("{0:N2}", (Double.Parse(dataItem["amt_amount"].Text) -
                                            Double.Parse(dataItem["Qtr 1"].Text) -
                                            Double.Parse(dataItem["Qtr 2"].Text) -
                                            Double.Parse(dataItem["Qtr 3"].Text) -
                                            Double.Parse(dataItem["Qtr 4"].Text)) +
                                            Double.Parse(dataItem["nbr_total_adjustments"].Text));
                total += Double.Parse(tb.Text);
                totalOriAmt += Double.Parse(dataItem["amt_amount"].Text);
                totalQtr1 += Double.Parse(dataItem["Qtr 1"].Text);
                totalQtr2 += Double.Parse(dataItem["Qtr 2"].Text);
                totalQtr3 += Double.Parse(dataItem["Qtr 3"].Text);
                totalQtr4 += Double.Parse(dataItem["Qtr 4"].Text);
                totalAdj += Double.Parse(dataItem["nbr_total_adjustments"].Text);
            }
        }

        if (e.Item is GridFooterItem)
        {
            GridFooterItem footerItem = e.Item as GridFooterItem;
            footerItem["amt_amount"].Text = string.Format("{0:c}", totalOriAmt);
            footerItem["Qtr 1"].Text = string.Format("{0:c}", totalQtr1);
            footerItem["Qtr 2"].Text = string.Format("{0:c}", totalQtr2);
            footerItem["Qtr 3"].Text = string.Format("{0:c}", totalQtr3);
            footerItem["Qtr 4"].Text = string.Format("{0:c}", totalQtr4);

            footerItem["nbr_total_adjustments"].Text = string.Format("{0:c}", totalAdj);

            (footerItem.FindControl("lblSum") as Label).Text = string.Format("{0:c}", total);

            hfGridTot.Value = totalOriAmt.ToString();
        } 
    }


    protected void disable_TRGFUNDS_TXTBOXES()
    {

        foreach (GridItem dr in TRG_Funds.Items)
        {
            try
            {
                TextBox txbx = (TextBox)dr.FindControl("txt_Funds");
            //    txbx.Enabled = false;
                  txbx.Attributes.Add("ReadOnly", "true");
             
            }

            catch
            {
            }
        }
    }


    protected void Disable_DropDownList(DropDownList mycon)
    {
        foreach (ListItem li in mycon.Items)
        {
            if (li.Text != mycon.SelectedItem.Text)
                li.Enabled = false;
        }
    }
    protected void disable_textBoxes(TextBox mybox)
    {
        if (mybox.TextMode == TextBoxMode.MultiLine )
        {
            mybox.ReadOnly = true;
            mybox.ForeColor = System.Drawing.Color.Gray;
        }
        else 
            mybox.Attributes.Add("ReadOnly", "ReadOnly");
    }

    protected void GearBox_ActivityForm_Secruity()
    {
        lp_local_plan lpObj = new lp_local_plan();
        lpObj.ConnectionString = DataAccess.getConnStr();
        lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString()));

        string mysb;
        mysb = "var ddcheck =  document.getElementById('cblCoreIndicators_0');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_1');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_2');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_3');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_4');ddcheck.disabled =true;ddcheck =  document.getElementById('cblCoreIndicators_5');ddcheck.disabled =true;";
     
       
        string roleid = Session[Session.SessionID + "roleid"].ToString();
        switch (lpObj.Key_local_plan_level_id.ToString())
        {
            case "101":
                //Level 0 Awaiting CO Admin

                switch (roleid)
                {
                    case "103":
                        //CO Admin
                       
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtActivityName);
                        //disable_textBoxes(txtDescActivity);
                        //disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                        //Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(ddlProgramType);

                        
                        //btnSave.Enabled = true;
                        //btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtActivityName);
                        //disable_textBoxes(txtDescActivity);
                        //disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                        //Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);

                        RadGrid2.MasterTableView.Columns.FindByUniqueName("DeleteColumn").Display = false;
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

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                       // Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtActivityName);
                        //disable_textBoxes(txtDescActivity);
                        //disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                        //Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = true;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtActivityName);
                        //disable_textBoxes(txtDescActivity);
                        //disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                        //Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                       RadGrid2.MasterTableView.Columns.FindByUniqueName("DeleteColumn").Display = false;
                        break;
                }
                break;
            case "103":
                //Review by So
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                      RadGrid2.MasterTableView.Columns.FindByUniqueName("DeleteColumn").Display = false;
                        break;
                }
                break;

            case "104":
                //So 3 Revision Requested by So
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                        if (cbLocked.Checked)
                        {
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                            Lock_Page();
                        }
                        //disable_textBoxes(txtActivityName);
                        //disable_textBoxes(txtDescActivity);
                        //disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                        //Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(ddlProgramType);

                       
                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                     //   Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtActivityName);
                        //disable_textBoxes(txtDescActivity);
                        //disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                        //Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        RadGrid2.MasterTableView.Columns.FindByUniqueName("DeleteColumn").Display = false;
                        break;
                }
                break;

            case "105":
                //Level 4 Pending SDE Review
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        RadGrid2.MasterTableView.Columns.FindByUniqueName("DeleteColumn").Display = false;
                        break;
                }
                break;

            case "106":
                //Level 5 Approved
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        RadGrid2.MasterTableView.Columns.FindByUniqueName("DeleteColumn").Display = false;
                        break;
                }
                break;

            case "107":
                //Level 6 Closed
                switch (roleid)
                {
                    case "103":
                        //CO Admin

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtActivityName);
                        disable_textBoxes(txtDescActivity);
                        disable_textBoxes(txtDescCoreInd);
                        disable_textBoxes(txtSystemOfficeNotes);


                           
                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                        Disable_DropDownList(ddlUseOfFunds);
                        Disable_DropDownList(ddStatus);
                        Disable_DropDownList(ddlProgramType);


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        RadGrid2.MasterTableView.Columns.FindByUniqueName("DeleteColumn").Display = false;
                        break;
                }
                break;
            default:
                // View Only, and anything not covered

                break;


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


    public void IndirectCost_rule()
    {
        SDS_FunctionCODE.SelectParameters.Clear();
        SDS_FunctionCODE.SelectParameters.Add("p_key_category_id", DLB_Category.SelectedValue.ToString());
        DataView DW = (DataView)SDS_FunctionCODE.Select(DataSourceSelectArguments.Empty);
        DLB_FunCode.DataBind();
        txt_UseOfFunds.Attributes.Add("ReadOnly", "ReadOnly");
        foreach (DataRow dr in DW.Table.Rows)
        {
            txt_UseOfFunds.Text = dr["txt_category_type_desc"].ToString();
        }








        if (DLB_Category.SelectedItem.Value == "115")
        {
            foreach (GridDataItem item in TRG_Funds.Items)
            {
                if (item["key_line_item_type_id"].Text == "105")
                {
                    (item.FindControl("txt_Funds") as TextBox).Attributes.Remove("readonly");
                    (item.FindControl("indycost_message") as Label).Visible = false;
                }
            }
        }

        else if (DLB_Category.SelectedItem.Value != "115")
        {
            foreach (GridDataItem item in TRG_Funds.Items)
            {
                if (item["key_line_item_type_id"].Text == "105")
                {
                    (item.FindControl("txt_Funds") as TextBox).Attributes.Add("readonly", "readonly");
                    (item.FindControl("txt_Funds") as TextBox).Text = "0.00";
                    (item.FindControl("indycost_message") as Label).Visible = true;

                }
            }
        }

    }
    protected void DLB_Category_SelectedIndexChanged(object sender, EventArgs e)
    {

        IndirectCost_rule();


//        IF Category <> 15 (key_category_id = 115)
//THEN
//                                    Check to make sure there are NO FUNDS in Line Item Type “Indirect Cost” (key_line_item_type = 105):
//                                    IF there are funds in “Indirect Cost”
//                                         ALERT messagebox “The Category you have chosen does not allow funds to be placed in Line Item Indirect Cost.” *
//                                    IF no funds in “Indirect Cost”
//                                        ENABLE ONLY Line Item Types 1 through 4 (key_line_item_type 101, 102, 103, 104)

//IF Category = 15 (key_category_id = 115)
//THEN
//    ENABLE ONLY Line Item Types 1 through 5 (key_line_item_type 101, 102, 103, 104, 105)

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
    protected void RadGrid2_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        RadGrid2.DataBind();
        hlActivityChangeRequest.Visible = true;
    }


    double h_total = 0;
    double c_total = 0;
    double d_total = 0;

    double group_c_total = 0;
    double group_d_total = 0;
    double group_h_total = 0;

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


                h_totalAdj = group_c_total + group_d_total;
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
            h_totalAdj = 0;

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
    protected void btn_Print_History_Click(object sender, EventArgs e)
    {
        lblPrintTrigger.Text = "<script>Print('pr_rpt_act_activity_transactions','pdf')</" + "script>";
    }
    protected void btnPrintWord_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (Request.QueryString.Get("id").ToString().Equals("-1"))
            {
                Save();
            }
            else
            {
                act_activity actObj = new act_activity();
                actObj.ConnectionString = DataAccess.getConnStr();

                if (actObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("id").ToString())))
                {
                    try
                    {
                        if (actObj.Flg_locked)
                        {
                            if (Session[Session.SessionID + "roleid"].ToString().Equals("101"))
                            {
                                Save();
                            }
                        }
                        else
                            Save();
                    }
                    catch
                    {
                        Save();
                    }
                }
            }
            lblPrintTrigger.Text = "<script>Print('fundedactivities','AWDOCX')</" + "script>";
        }
    }
    protected void rg_History_GroupsChanging(object source, Telerik.Web.UI.GridGroupsChangingEventArgs e)
    {
      
    }
}
