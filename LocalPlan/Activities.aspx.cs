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
using System.Web.Configuration;

public partial class LocalPlans_Activites : System.Web.UI.Page
{
  
    protected override void OnPreRenderComplete(EventArgs e)
    {
        

        try
        {
            hfLocal_plan_id.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
            hl_fundpl.NavigateUrl = "Javascript:OpenFundingplan(" + hfLocal_plan_id.Value + ")";
            lblErr.Text = "";
            Panel1.Visible = true;


            #region This section test for Plan Level and Roleid if Level 103 - Under review by So and userroleid 101 SO Admin allow quick checkbox update else no updateing available


            lp_local_plan lpObj = new lp_local_plan();
            lpObj.ConnectionString = DataAccess.getConnStr();
            lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString()));


            string roleid = Session[Session.SessionID + "roleid"].ToString();



            if (lpObj.Key_local_plan_level_id.ToString() != "103" || roleid != "101")
            {
                hl_UpdateApprovals.Visible = false;
            }
            else
            {
                hl_UpdateApprovals.Visible = true;
            }

            #endregion

        }
        catch
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            
            hfLocal_plan_id.Value = "-1";
            if(errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text =  errObj.Txt_message;
                hl_UpdateApprovals.Visible = false;
            }
            Panel1.Visible = false;
        }
        RadGrid1.DataBind();

        GearBox_Activities_Secruity();

        base.OnPreRenderComplete(e);
    }

 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            string roleid_RL = Session[Session.SessionID + "roleid"].ToString();
            if (roleid_RL == "101")  // RL 05012008 added to have Reimbursement Column Show to System office Admins
            {
                RadGrid1.Columns[11].Visible = true;
            }
            else
            {
                RadGrid1.Columns[11].Visible = false;
            }


            hlNewFA.Attributes.Add("onclick", "ShowActivity(0)");
            hlNewEA.Attributes.Add("onclick", "ShowActivity(1)");
        }

        hlNewEA.Visible = true;
        hlNewFA.Visible = true;
    }

    protected void LinkButton1_OnCommand(object sender, CommandEventArgs e)
    {

    }

    protected void RadGrid1_DataBound(object sender, EventArgs e)
    {

    }
   

    protected void RadGrid1_DataBound1(object sender, EventArgs e)
    {
        foreach (GridDataItem item in RadGrid1.Items)
        {
            HyperLink mylink = new HyperLink();
            mylink = (HyperLink)item.FindControl("lbView");

            HyperLink hlReimb = (HyperLink)item.FindControl("hlReimbursement");
           
            if(mylink !=null)
                mylink.NavigateUrl = "javascript:popup(" + item["key_activity_id"].Text.Trim().ToLower() + ",'" + item["txt_activity_type_desc"].Text + "','" + item["key_amendment_reason_id"].Text + "');";

            if (hlReimb != null)
                hlReimb.NavigateUrl = "javascript:openReimbursement(" + item["key_activity_id"].Text.Trim().ToLower() + ");";  
         

            hfLocal_plan_id.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
            hl_fundpl.NavigateUrl = "Javascript:OpenFundingplan(" + hfLocal_plan_id.Value + ")";
            lblErr.Text = "";
            Panel1.Visible = true;


            #region This section test for Plan Level and Roleid if Level 103 - Under review by So and userroleid 101 SO Admin allow quick checkbox update else no updateing available
            lp_local_plan lpObj = new lp_local_plan();
            lpObj.ConnectionString = DataAccess.getConnStr();
            lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString()));


            string roleid = Session[Session.SessionID + "roleid"].ToString();



            if (lpObj.Key_local_plan_level_id.ToString() != "103" || roleid != "101")
            {


                (item["flg_approved"].FindControl("chb_approvals") as CheckBox).Attributes.Add("disabled", "true");
            }

#endregion
        }
    }

    protected override void RaisePostBackEvent(IPostBackEventHandler source, string eventArgument)
    {
        base.RaisePostBackEvent(source, eventArgument);
        if (source is RadGrid)
        {
            switch (eventArgument)
            {
                case "Rebind":
             
                    RadGrid1.Rebind();
                    break;
                case "RebindAndNavigate":
              
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    RadGrid1.Rebind();
                    break;
            }
        }
    }




    protected void GearBox_Activities_Secruity()
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



                            break;
                        case "102":
                            //CAO

                            break;
                        case "101":
                            //SO Admin
                            RadGrid1.Columns[10].Visible = true;
                            break;
                        case "104":
                            //View Only
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;
                            break;
                    }

                    break;
                case "102":
                    //Level 1 Awaiting CAO
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin



                            break;
                        case "102":
                            //CAO

                            break;
                        case "101":
                            //SO Admin
                            RadGrid1.Columns[10].Visible = true;
                            break;
                        case "104":
                            //View Only
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;
                            break;
                    }
                    break;
                case "103":
                    //Review by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;

                            break;
                        case "102":
                            //CAO
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;

                            break;
                        case "101":
                            //SO Admin
                            RadGrid1.Columns[10].Visible = true;
                            break;
                        case "104":
                            //View Only
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;
                            break;
                    }
                    break;

                case "104":
                    //So 3 Revision Requested by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin


                            break;
                        case "102":
                            //CAO



                            break;
                        case "101":
                            //SO Admin
                            RadGrid1.Columns[10].Visible = true;
                            break;
                        case "104":
                            //View Only
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;
                            break;
                    }
                    break;

                case "105":
                    //Level 4 Pending SDE Review
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;


                            break;
                        case "102":
                            //CAO
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;

                            break;
                        case "101":
                            //SO Admin

                            RadGrid1.Columns[10].Visible = true;
                            break;
                        case "104":
                            //View Only
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;
                            break;
                    }
                    break;

                case "106":
                    //Level 5 Approved
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;


                            break;
                        case "102":
                            //CAO
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;

                            break;
                        case "101":
                            //SO Admin
                            
                            break;
                        case "104":
                            //View Only
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;
                            break;
                    }
                    break;

                case "107":
                    //Level 6 Closed
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;


                            break;
                        case "102":
                            //CAO
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;


                            break;
                        case "101":
                            //SO Admin
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;

                            break;
                        case "104":
                            //View Only
                            hlNewEA.Visible = false;
                            hlNewFA.Visible = false;
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
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
            }
            Panel1.Visible = false;
        }
    }

    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (Request.QueryString["KeyActid"] != null)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem["key_activity_id"].Text.Trim() == Request.QueryString["KeyActid"].ToString())
                {
                    TableRow row = e.Item as TableRow;
                    row.ForeColor = System.Drawing.Color.Red;
                    row.BackColor = System.Drawing.Color.LightBlue;
                    row.Font.Bold = true;

                }


            }
        }
    }
    protected void hl_UpdateApprovals_Click(object sender, EventArgs e)
    {
        foreach (GridDataItem item in RadGrid1.Items)
        {
            update_quickApprovalUpdate(item["key_Activity_id"].Text.ToString(), (item["flg_approved"].FindControl("chb_approvals") as CheckBox).Checked);
        }
      
    }

    private void update_quickApprovalUpdate(string actid,Boolean approved)
    {
         

        String sqlconnection_string = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ToString();
        SqlConnection myconn = new SqlConnection(sqlconnection_string);
        SqlCommand mycomm = new SqlCommand("pr_act_activity_approval_udp", myconn);
        mycomm.CommandType = CommandType.StoredProcedure;
        mycomm.Parameters.AddWithValue("@p_key_activity_id", actid);
        mycomm.Parameters.AddWithValue("@p_flg_approved", approved);
        if (myconn.State != ConnectionState.Open)
            myconn.Open();
        try
        {
             mycomm.ExecuteScalar();

        }
        catch (Exception ex)
        {
            
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
