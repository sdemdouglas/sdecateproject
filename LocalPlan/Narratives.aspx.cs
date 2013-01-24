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
using System.Web.Configuration;
using System.Data.SqlClient;

public partial class LocalPlans_Narratives : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
        }

    }
    
    protected void  RadGrid1_ItemDataBound(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
       
        HyperLink hlSection = (HyperLink)e.Item.FindControl("hlSection");
        HiddenField hfNid = (HiddenField)e.Item.FindControl("hfNid");
        LinkButton lbSection = (LinkButton)e.Item.FindControl("lbSection");

        if (hlSection != null && hfNid != null)
        {
            int vNid = Convert.ToInt32(hfNid.Value.ToString());
            hlSection.Attributes.Add("onClick", "ShowNarrativeDetails(" + vNid + ")");

            HyperLink mylink = new HyperLink();
            mylink = (HyperLink)e.Item.FindControl("lbView");
            mylink.Attributes.Add("onClick", "ShowNarrativeDetails(" + vNid + ")");

        }

        //Set edited record

        try
        {
            if (Request.QueryString.Get("keynid").ToString() != "")
            {
                if (e.Item is GridDataItem)
                {
                    GridDataItem dataItem = e.Item as GridDataItem;
                    if (dataItem["key_local_plan_narrative_id"].Text.Trim() == Request.QueryString["keynid"].ToString())
                    {
                        TableRow row = e.Item as TableRow;
                        e.Item.ForeColor = System.Drawing.Color.Red;
                        row.BackColor = System.Drawing.Color.LightBlue;
                        row.Font.Bold = true;

                    }


                }
            }
        }
        catch { }


        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
           
            //lbl_narrative_response
            if ((dataItem["flg_narrative_response"].FindControl("lbl_narrative_response") as Label).Text == "0")
                (dataItem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Checked = false;
            else
                (dataItem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Checked = true;
            (dataItem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Attributes.Add("disabled", "true");
        }

    }

    protected void RadGrid1_ItemCreated(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        
    }

    protected override void OnPreRenderComplete(EventArgs e)
    {
      

        try
        {
            lblErr.Text = "";
            hfLocal_plan_id.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
            Panel1.Visible = true;
        }
        catch
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
                hl_UpdateApprovals.Visible = false;
            }
            hfLocal_plan_id.Value = "-1";
            Panel1.Visible = false;
        }

        RadGrid1.DataBind();

        try
        {
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
        }


        base.OnPreRenderComplete(e);
    }
    protected override void RaisePostBackEvent(IPostBackEventHandler source, string eventArgument)
    {
        base.RaisePostBackEvent(source, eventArgument);
        if (source is RadGrid)
        {
            switch (eventArgument)
            {
                case "Rebind":
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.Rebind();
                    break;
                case "RebindAndNavigate":
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
                    RadGrid1.Rebind();
                    break;
            }
        }
    }

    protected void RadGrid1_DataBound(object sender, EventArgs e)
   {
       try
       {
           lp_local_plan lpObj = new lp_local_plan();
           lpObj.ConnectionString = DataAccess.getConnStr();
           lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString()));


           string roleid = Session[Session.SessionID + "roleid"].ToString();
           foreach (GridDataItem item in RadGrid1.Items)
           {
               #region This section test for Plan Level and Roleid if Level 103 - Under review by So and userroleid 101 SO Admin allow quick checkbox update else no updateing available


               if (lpObj.Key_local_plan_level_id.ToString() != "103" || roleid != "101")
               {


                   (item["flg_approved"].FindControl("chb_approvals") as CheckBox).Attributes.Add("disabled", "true");
               }

               #endregion

           }
       }
       catch
       {
       }

    }


    private void update_quickApprovalUpdate(string actid, Boolean approved)
    {


        String sqlconnection_string = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ToString();
        SqlConnection myconn = new SqlConnection(sqlconnection_string);
        SqlCommand mycomm = new SqlCommand("pr_lp_local_plan_narrative_approval_udp", myconn);
        mycomm.CommandType = CommandType.StoredProcedure;
        mycomm.Parameters.AddWithValue("@p_key_local_plan_narrative_id", actid);
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
    protected void hl_UpdateApprovals_Click(object sender, EventArgs e)
    {
        foreach (GridDataItem item in RadGrid1.Items)
        {
            update_quickApprovalUpdate(item["key_local_plan_narrative_id"].Text.ToString(), (item["flg_approved"].FindControl("chb_approvals") as CheckBox).Checked);
        }
    }
}
