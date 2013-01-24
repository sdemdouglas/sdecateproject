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

public partial class LocalPlan_DefaultList : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
        try
        {
            hfLpid.Value = Session[Session.SessionID + "PlanID"].ToString();
            lblErr.Text = "";
            Panel1.Visible = true;
        }
        catch 
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
            }
            hfLpid.Value = "-1";
            Panel1.Visible = false;
        }
        RadGrid1.DataBind();
      
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RadGrid1_DataBound(object sender, EventArgs e)
    {
        foreach (GridDataItem item in RadGrid1.Items)
        {
            HyperLink mylink = new HyperLink();
            mylink = (HyperLink)item.FindControl("HyperLink1");
          //  string frst_PopUpUrl = @"javascript:window.open(""";
         //   string last_popupurl = @""") target=""_blank""";
          //  if (item["txt_type"].Text.Trim().ToLower() == "activity")
          //  {
            mylink.NavigateUrl = "javascript:popup('" + item["key_activity_type_id"].Text.Trim().ToLower() + "','" + item["key_local_plan_narrative_id"].Text + "','" + item["key_amendment_reason_id"].Text + "');";
            switch (Session[Session.SessionID + "roleid"].ToString())
            {
                case "101":  //Admin
                    if (item["key_level_id"].Text == "103" || item["key_level_id"].Text == "105")
                        item.Style.Add("Color", "Red");
                      //  item.BackColor = System.Drawing.Color.Red;
                    break;
                case "102":  //CAO
                    if (item["key_level_id"].Text == "102" || item["key_level_id"].Text == "104")
                        item.Style.Add("Color", "Red");
                    //    item.BackColor = System.Drawing.Color.Blue;
                    break;
                case "103":  //Perkins Admin
                    if (item["key_level_id"].Text == "101" || item["key_level_id"].Text == "104")
                        item.Style.Add("Color", "Red");
                     //   item.BackColor = System.Drawing.Color.Red;
                    break;
                case "104":  //View Only
                    break;


            }
             //   item["TemplateColumn"].Text = "<a href=" + frst_PopUpUrl + "http://www.google.com" + last_popupurl + ">Hello</a>";
              // Activities/ActivityForm.aspx

           // }
          //  else if (item["txt_type"].Text.Trim().ToLower() == "narrative")
           // {
//Activities/ActivityFormEquipment.aspx 
           // }
  

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
                    RadGrid1.DataBind();
                    break;
             //   case "RebindAndNavigate":                 
                 //   RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;
             //       RadGrid1.Rebind();
              //      break;
            }
        }
    }
    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (Request.QueryString["KEYNID"] != null)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                if (dataItem["key_local_plan_narrative_id"].Text.Trim() == Request.QueryString["KEYNID"].ToString())
                {
                    TableRow row = e.Item as TableRow;
                    row.ForeColor = System.Drawing.Color.Red;
                   row.BackColor = System.Drawing.Color.LightBlue;
                    row.Font.Bold = true;

                }


            }
        }
    }
    protected void ddlStatus_DataBound(object sender, EventArgs e)
    {
        if (Request.QueryString.Get("level") != null)
        {
            ddlStatus.SelectedIndex = ddlStatus.Items.IndexOf(ddlStatus.Items.FindByValue(Request.QueryString.Get("level").ToString()));
        }
    }
    protected void chkApproved_CheckedChanged(object sender, EventArgs e)
    {
        if (chkApproved.Checked)
        {
            this.txtShowAll.Text  = "0,1" ;
        }
        else
        {
            this.txtShowAll.Text  = "0";
        }
    }
}
