using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using Telerik.WebControls;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using BLL;

public partial class LocalPlan_Activities_ActivityFormEquipment : System.Web.UI.Page
{
    static decimal grandtotal_bookeeping_oldtotal;
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
            while(mydr.Read())
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
                catch(Exception ex)
                {
                    RadTabStrip1.Tabs[1].Visible = false;
                }
            }
            catch
            {
            }
            }
        }
        //if (lpObj.LoadByPrimaryKey(Convert.ToInt32(hfLpId.Value)))
        //{
        //    try
        //    {
        //        hfTotBal.Value = lpObj.nbr_balance.ToString();
        //        try
        //        {
        //            txtAvailableFunds.Text = string.Format("{0:C}", lpObj.nbr_balance);
        //        }
        //        catch
        //        {
        //            txtAvailableFunds.Text = string.Format("{0:C}", 0);
        //        }
        //    }
        //    catch
        //    {
        //    }
        //}
        GearBox_ActivityForm_Secruity();
        Utility.addPageInfoChange(this.Page, "ActivityEquipment");
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            this.RadMultiViewActivity.SelectedIndex = 0;
            RadTabStrip1.SelectedIndex = 0;
            hlActivityChangeRequest.Attributes.Add("onclick", "editActivityChangeRequest(" + Request.QueryString.Get("id").ToString() + ", -1, 'activityEquip')");
            ddStatus.DataBind();

            cblCoreIndicators.DataBind();
            SqlActivitieChanges.DataBind();
            RadGrid2.DataBind();

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

            if (Request.QueryString.Get("id").ToString().Equals("-1"))
            {
                btnDelete.Visible = false;
                btnSave.Text = "Add";
                lblAid.Text = "";
                RadTabStrip1.Tabs[1].Visible = false;
                btnPrint.Enabled = false;
                btn_Print_History.Enabled = false;
                btnPrintWord.Enabled = false;
            }
            else
            {
                btnDelete.Visible = true;
                btnSave.Text = "Save";

                lblAid.Text = Request.QueryString.Get("id").ToString();

                

                act_activity actObj = new act_activity();
                actObj.ConnectionString = DataAccess.getConnStr();

                if(actObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("id").ToString())))
                {
                    txtTypeEquip.Text = actObj.Txt_activity_name.ToString();
                    txtSupProgram.Text = actObj.Txt_activity_desc.ToString();
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



                    txtSystemOfficeNotes.Text = actObj.Txt_system_office_notes;

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
                    ddStatus.SelectedIndex = ddStatus.Items.IndexOf(ddStatus.Items.FindByValue(actObj.Key_level_id.ToString()));
                }
            }
            DLB_Category.SelectedIndex = 10;
            DLB_Category.Enabled = false;

            DLB_FunCode.SelectedIndex = 0;
            DLB_FunCode.Enabled = false;



            //DataView dw = (DataView)SqlDS_RLactivityGET.Select(DataSourceSelectArguments.Empty);
            //foreach (DataRow dr in dw.Table.Rows)
            //{
            //    txtTypeEquip.Text = dr["txt_activity_name"].ToString();
            //    DLB_Category.SelectedIndex = DLB_Category.Items.IndexOf(DLB_Category.Items.FindByValue(dr["key_category_id"].ToString()));
            //    DLB_FunCode.SelectedIndex = DLB_FunCode.Items.IndexOf(DLB_FunCode.Items.FindByValue(dr["key_fund_source_id"].ToString()));
            //    txtSupProgram.Text = dr["txt_activity_desc"].ToString();
            //}

            //DataView dy = (DataView)SqlDS_RLActivityLineGet.Select(DataSourceSelectArguments.Empty);

            //foreach (DataRow dr in dy.Table.Rows)
            //{


            //}

            if (cbLocked.Checked == true)
                if (!Session[Session.SessionID + "roleid"].ToString().Equals("101"))
                    Lock_Page();

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
        }
    }
   
    protected void btnClose_Click(object sender, EventArgs e)
    {
        if (hfPageInfo.Value == "1") //page Info changed
        {
            
            // yes: user wants to close page without save 
            if (hfFlgSave.Value == "yes")
                InjectScript.Text = "<script>CloseAndRebind("+ Convert.ToInt32(Request.QueryString.Get("id").ToString()) + ")</script>";
            else
            {
                //TRG_Funds.DataBind();
                //RadGrid1.DataBind();
                lblMsg.Text = "";
            }
        }
        else
        {
            InjectScript.Text = "<script>CloseAndRebind(" + Convert.ToInt32(Request.QueryString.Get("id").ToString()) + ")</script>";
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
    protected void TRG_Funds_DataBound(object sender, EventArgs e)
    {
        DataView dx = (DataView)SqlDS_RLActivityLineGet.Select(DataSourceSelectArguments.Empty);

        grandtotal_bookeeping_oldtotal = 0;

        foreach (GridItem Gi in TRG_Funds.Items)
        {
            //(Gi.Cells[2].Text);
            foreach (DataRow dr in dx.Table.Rows)
            {
                if (Gi.Cells[2].Text.Trim().ToLower() == dr["key_line_item_type_id"].ToString().Trim())
                {
                    TextBox mytxt = (TextBox)Gi.FindControl("txt_Funds");
                    mytxt.Text = string.Format("{0:F}", dr["amt_amount"]);
                    grandtotal_bookeeping_oldtotal += Convert.ToDecimal(mytxt.Text);
                }
                else
                {

                }
            }


        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        act_activity aObj = new act_activity();
        aObj.ConnectionString = DataAccess.getConnStr();
        if (!Request.QueryString.Get("id").ToString().Equals("-1"))
        {
            if (hfDelete.Value == "Yes")
            {
                aObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("id").ToString()));
                aObj.DeleteCurrentRow();
                aObj.Save();
                InjectScript.Text = "<script>CloseAndRebind()</" + "script>";
            }
        }        
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


    protected void Save()
    {
        lblMsg.Text = "";
        hfPageInfo.Value = "0";
        hfFlgSave.Value = "";

        try
        {
            if (Request.QueryString.Get("id").Equals("-1"))
            {
                //Add new Activity
                DataAccess obj = new DataAccess();
                //Local Plan id will be enter later, use 101 for now
                int iLpid;

                iLpid = Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString());

                String ika = obj.insertActivity(iLpid,
                                                   txtTypeEquip.Text,
                                                   txtSupProgram.Text,
                                                   101,
                                                   "",
                                                   Convert.ToInt32(DLB_Category.SelectedValue),
                                                   Convert.ToInt32(DLB_FunCode.SelectedValue),
                                                   102,
                                                   101);
                lblAid.Text = ika;
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
            else
            {
                //Update current activity
                DataAccess obj = new DataAccess();
                //Local Plan id will be enter later, use 101 for now
                int ika = Convert.ToInt32(Request.QueryString.Get("id").ToString());
                obj.updateActivity(ika,
                                   101,
                                   txtTypeEquip.Text,
                                   txtSupProgram.Text,
                                   0,
                                   "",
                                   Convert.ToInt32(DLB_Category.SelectedValue),
                                   Convert.ToInt32(DLB_FunCode.SelectedValue),
                                   102,
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
            TRG_Funds.DataBind();
            RadGrid1.DataBind();



        }
        catch (Exception ex)
        {
            scs_error_dictionary errObj = new scs_error_dictionary();

            if (errObj.LoadByPrimaryKey("201"))
            {
                lblMsg.Text = errObj.Txt_message;
            }
        }
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
        //txtTypeEquip.Enabled = false;
        //DLB_Category.Enabled = false;
        //DLB_FunCode.Enabled = false;
        //cblCoreIndicators.Enabled = false;
        //txtSupProgram.Enabled = false;      
        //TRG_Funds.Enabled = false;
        
        btnSave.Enabled  = false;
        btnDelete.Enabled  = false;

        Lock_SO();
    }

    protected void UnLock_Page()
    {
        //txtTypeEquip.Enabled = true;
        //DLB_Category.Enabled = true;
        //DLB_FunCode.Enabled = true;
        //cblCoreIndicators.Enabled = true;
        //txtSupProgram.Enabled = true;
        //TRG_Funds.Enabled = true;
        btnSave.Enabled = true;
        btnDelete.Enabled = true;
        UnLock_SO();
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
                tb.Text = string.Format("{0:N}", (Double.Parse(dataItem["amt_amount"].Text) -
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
        if (mybox.TextMode == TextBoxMode.MultiLine)
        {
            mybox.ReadOnly = true;
            mybox.ForeColor = System.Drawing.Color.Gray;
        }
        else
            mybox.Attributes.Add("ReadOnly", "ReadOnly");
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
                        //disable_textBoxes(txtTypeEquip);
                        //disable_textBoxes(txtSupProgram);
                    
                        disable_textBoxes(txtSystemOfficeNotes);


                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                    


                        //btnSave.Enabled = false;
                        //btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtTypeEquip);
                        //disable_textBoxes(txtSupProgram);
                       
                        disable_textBoxes(txtSystemOfficeNotes);


                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                   


                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                     
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                 


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
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtTypeEquip);
                        //disable_textBoxes(txtSupProgram);
                     
                        disable_textBoxes(txtSystemOfficeNotes);


                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                     


                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtTypeEquip);
                        //disable_textBoxes(txtSupProgram);
                    
                        disable_textBoxes(txtSystemOfficeNotes);


                        Disable_DropDownList(ddStatus);
                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                     

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
          
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                     


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

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                       Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
              
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                     


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
            
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                   


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

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                        if (cbLocked.Checked)
                        {
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                            Lock_Page();
                        }
                        //disable_textBoxes(txtTypeEquip);
                        //disable_textBoxes(txtSupProgram);
               
                        disable_textBoxes(txtSystemOfficeNotes);

                        Disable_DropDownList(ddStatus);

                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                   

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        //disable_TRGFUNDS_TXTBOXES();
                   //     Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        //disable_textBoxes(txtTypeEquip);
                       // disable_textBoxes(txtSupProgram);
              
                        disable_textBoxes(txtSystemOfficeNotes);



                        //Disable_DropDownList(DLB_Category);
                        //Disable_DropDownList(DLB_FunCode);
                     

                        btnSave.Enabled = true;
                        btnDelete.Enabled = true;
                        break;
                    case "101":
                        //SO Admin
                        cbApproved.Enabled = true;
                        cbLocked.Enabled = true;
                        txtSystemOfficeNotes.Enabled = true;

                        break;
                    case "104":
                        //View Only
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                     


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

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                 
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                    

                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                   
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                   

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
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                   
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                     


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

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                   
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                   

                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                    
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                    

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
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                   
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                   


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

                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                     
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                   


                        btnSave.Enabled = false;
                        btnDelete.Enabled = false;
                        break;
                    case "102":
                        //CAO
                        cbApproved.Enabled = false;
                        cbLocked.Enabled = false;
                        disable_TRGFUNDS_TXTBOXES();
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "test", mysb.ToString(), true);
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                  
                        disable_textBoxes(txtSystemOfficeNotes);



                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                    


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
                        disable_textBoxes(txtTypeEquip);
                        disable_textBoxes(txtSupProgram);
                        
                        disable_textBoxes(txtSystemOfficeNotes);


   
                        Disable_DropDownList(DLB_Category);
                        Disable_DropDownList(DLB_FunCode);
                    

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
















    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {

    }
    protected void TRG_Funds_ItemCreated(object sender, GridItemEventArgs e)
    {
        TextBox txt_Funds = (TextBox)e.Item.FindControl("txt_Funds");
        if (txt_Funds != null)
        {
            txt_Funds.Attributes.Add("onblur", "getItemValue('" + txt_Funds.ClientID + "')");
            TRG_Funds.Controls.Add(new LiteralControl("<script type='text/javascript'> window['txt_Funds'] = '" + txt_Funds.ClientID + "';</script>")); 
        }
    }

    
    
    protected void RadGrid2_DataBound(object sender, EventArgs e)
    {
        


        foreach (GridDataItem item in RadGrid2.Items)
        {
            HyperLink hlEdit = (HyperLink)item.FindControl("hlEdit");

            if (hlEdit != null)
            {
                hlEdit.NavigateUrl = "javascript:editActivityChangeRequest(" + item["key_activity_id"].Text.Trim().ToLower() + ", " + item["key_act_change_id"].Text.Trim().ToLower() + ", 'activityEquip');";
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
            lblPrintTrigger.Text = "<script>Print('equipactivities','pdf')</" + "script>";
        }
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


    
    protected void rg_History_ItemDataBound(object sender, GridItemEventArgs e)
    {
        
    }

    double h_total = 0;
    double c_total = 0;
    double d_total = 0;

    double group_c_total = 0;
    double group_d_total = 0;

    double h_totalAdj = 0;

    protected void RadGrid3_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
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
            lblPrintTrigger.Text = "<script>Print('equipactivities','AWDOCX')</" + "script>";
        }
    }
}
