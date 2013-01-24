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
using Telerik.WebControls;

public partial class LocalPlans_Admendments : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        try
        {
            hfLocal_plan_id.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
            hl_fundpl.NavigateUrl = "Javascript:OpenFundingplan(" + hfLocal_plan_id.Value + ")";
            lblErr.Text = "";
            Panel1.Visible = true;

        }
        catch
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
            }
            Panel1.Visible = false;
        }
        RadGrid1.DataBind();
        GearBox_Amendments_Secruity();

    }
    protected void Page_Load(object sender, EventArgs e)
    {
      
        try
        {
            hfLocal_plan_id.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
            hf_Role_Id.Value = Session[Session.SessionID + "roleid"].ToString();
        }
        catch
        {
        }

        String notfinished = string.Empty;
        try
        {
            if(Request.QueryString.Get("notfinished").ToString() != "undefined")
                CleanUP_UnFinished_activities(Request.QueryString.Get("notfinished").ToString());
        }
        catch
        {
        }

        

        try
        {
            if (!IsPostBack)
            {
                Session.Add(Session.SessionID + "keyactiveID", "-1");
                hlNewAmendment.Attributes.Add("onClick", "openmywindow();");
            }
            else
            {
                wsAmendment wsaObj = new wsAmendment();
                wsaObj.del_Unfinished_Amendment();
            }
        }
        catch { }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Response.Redirect("~/LocalPlan/Amendment_Adjustments_HostPage.aspx");
    }
    protected void RadGrid1_ItemDataBound(object sender, Telerik.WebControls.GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
           
            GridDataItem dataItem1 = e.Item as GridDataItem;
            if (dataItem1["key_amendment_reason_id"].Text.Trim() == "101")
            {
              LinkButton mylb=(LinkButton) dataItem1.FindControl("LinkButton1");
              HyperLink myib = (HyperLink)dataItem1.FindControl("hlView");
              mylb.OnClientClick = "Javascript:open_admentForm('" + dataItem1.Cells[3].Text.Trim() + "')";
              myib.Attributes.Add("onclick", "Javascript:open_admentForm('" + dataItem1.Cells[4].Text.Trim() + "')");
                
            }
            else if (dataItem1["key_amendment_reason_id"].Text.Trim() == "102")
            {
                TableRow row = e.Item as TableRow;
           //     row.BackColor = System.Drawing.Color.LightBlue;
                LinkButton mylb = (LinkButton)dataItem1.FindControl("LinkButton1");
                HyperLink myib = (HyperLink)dataItem1.FindControl("hlView");
                mylb.OnClientClick = "Javascript:open_admentForm2('" + dataItem1.Cells[2].Text.Trim() + "')";
                myib.Attributes.Add("onclick", "Javascript:open_admentForm2('" + dataItem1.Cells[4].Text.Trim() + "')");

            }
            else
            {
                LinkButton mylb = (LinkButton)dataItem1.FindControl("LinkButton1");
                HyperLink myib = (HyperLink)dataItem1.FindControl("hlView");
                mylb.OnClientClick = "";
                myib.Attributes.Add("onclick", "");
            }
        }


        if (Request.QueryString["keyactiveid"] != null)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem.Cells[2].Text.Trim() == Request.QueryString["keyactiveid"].ToString())
                {
                    TableRow row = e.Item as TableRow;
                    row.ForeColor = System.Drawing.Color.Red;
                    row.BackColor = System.Drawing.Color.LightBlue;
                    row.Font.Bold = true;
                  
                }
              
              
            }
        }

    }

    protected void GearBox_Amendments_Secruity()
    {
        try
        {
            lp_local_plan lpObj = new lp_local_plan();
            lpObj.ConnectionString = DataAccess.getConnStr();
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
                       //     if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                     //       else
                     //           hlNewAmendment.Visible = true;
                            break;
                        case "102":
                            //CAO
                     //       if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                     //       else
                     //           hlNewAmendment.Visible = true;
                            break;
                        case "101":
                            //SO Admin
                    //        if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                   //         else
                   //             hlNewAmendment.Visible = true;
                            break;
                        case "104":
                            //View Only
                            hlNewAmendment.Visible = false;
                            break;
                    }

                    break;
                case "102":
                    //Level 1 Awaiting CAO
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                     //       if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                     //       else
                      //          hlNewAmendment.Visible = true;

                            break;
                        case "102":
                            //CAO
                      //      if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                      //      else
                      //          hlNewAmendment.Visible = true;

                            break;
                        case "101":
                            //SO Admin
                       //     if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                        //    else
                       //         hlNewAmendment.Visible = true;


                            break;
                        case "104":
                            //View Only
                            hlNewAmendment.Visible = false;
                            break;
                    }
                    break;
                case "103":
                    //Review by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                     //       if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                      //      else
                      //          hlNewAmendment.Visible = true;


                            break;
                        case "102":
                            //CAO
                         //   if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                          //  else
                          //      hlNewAmendment.Visible = true;

                            break;
                        case "101":
                            //SO Admin
                          //  if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                          //  else
                          //      hlNewAmendment.Visible = true;

                            break;
                        case "104":
                            //View Only
                            hlNewAmendment.Visible = false;
                            break;
                    }
                    break;

                case "104":
                    //So 3 Revision Requested by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                        //    if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                         //   else
                        //        hlNewAmendment.Visible = true;
                            break;
                        case "102":
                            //CAO
                        //    if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                       //     else
                       //         hlNewAmendment.Visible = true;
                            break;
                        case "101":
                            //SO Admin                           
                         //       hlNewAmendment.Visible = true;
                            hlNewAmendment.Visible = false;
                            break;
                        case "104":
                            //View Only
                            hlNewAmendment.Visible = false;
                            break;
                    }
                    break;

                case "105":
                    //Level 4 Pending SDE Review
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                       //     if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                       //     else
                       //         hlNewAmendment.Visible = true;

                            break;
                        case "102":
                            //CAO
                      //      if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                       //     else
                       //         hlNewAmendment.Visible = true;
                            break;
                        case "101":
                            //SO Admin

                        //    if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                        //    else
                         //       hlNewAmendment.Visible = true;

                            break;
                        case "104":
                            //View Only
                            hlNewAmendment.Visible = false;
                            break;
                    }
                    break;

                case "106":
                    //Level 5 Approved
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                            else
                                hlNewAmendment.Visible = true;

                            break;
                        case "102":
                            //CAO
                            if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                            else
                                hlNewAmendment.Visible = true;

                            break;
                        case "101":
                            //SO Admin
                            if (lpObj.Flg_lock_amendment_period == true)
                                hlNewAmendment.Visible = false;
                            else
                                hlNewAmendment.Visible = true;

                            break;
                        case "104":
                            //View Only
                            hlNewAmendment.Visible = false;
                            
                            break;
                    }
                    break;
         
                default:
                    // View Only, and anything not covered
                    hlNewAmendment.Visible = false;
                    break;
            }
        }
        catch
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
            }
            Panel1.Visible = false;
        }



        //try
        //{
        //    DataView dv = (DataView)SQLDS_RLGETPLANSTATUS.Select(DataSourceSelectArguments.Empty);
        //    if (dv.Table.Rows.Count > 0)
        //    {
        //        Boolean returnval = (Boolean)dv.Table.Rows[0][0];
        //        if (returnval)
        //        {
        //            //deactivate button if status is closed on plan status
        //            string nostring = "Filler Line";
        //                              hlNewAmendment.Visible = false;
        //        }

        //    }
        //}
        //catch (Exception ex)
        //{
           
        //}



    }


    public void CleanUP_UnFinished_activities(string keyactivity)
    {


        SQLDS_DeleteUnfinishedActivities.DeleteParameters.Clear();
        SQLDS_DeleteUnfinishedActivities.DeleteParameters.Add("p_key_activity_id", keyactivity);
        SQLDS_DeleteUnfinishedActivities.Delete();
       // string mystring = "";
      //  Response.Write("hello world");
        //pr_at_amendment_incomplete_amd_del @p_key_activity_id int

    }
    protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
    {
        //if (e.Item is GridDataItem)
        //{
        //    HyperLink myib = (HyperLink)e.Item.FindControl("hlView");
        //    if (myib != null)
        //        myib.Attributes.Add("onclick", "Javascript:open_admentForm('" + e.Item.Cells[2].Text.Trim() + "')");
        //}
    }

    public String serverCleanUp()
    {
        String res = String.Empty;
        try
        {
            res = Amendment.del_Unfinished_Amendment(Convert.ToInt32(Session[Session.SessionID + "keyactiveID"].ToString()), "");
            return res;
        }
        catch
        {
            return "-1";
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
                    RadGrid1.Rebind();
                    break;                
            }
        }
    }


    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        RadGrid1.ExportSettings.ExportOnlyData = true;
        RadGrid1.ExportSettings.IgnorePaging = true;
        RadGrid1.ExportSettings.OpenInNewWindow = true;
        RadGrid1.MasterTableView.ExportToExcel2007();
    }
}
