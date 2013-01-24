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

public partial class LocalPlan_Reimbursements_LineItemBalance : System.Web.UI.Page
{
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

                if (ddlLineItemCategory.SelectedIndex == 0)
                {
                    //gvFundingPlan.DataSource = "None";
                    //gvFundingPlan.DataBind();
                }              
            }
        }
        catch (Exception ex)
        {
            scs_error_dictionary errObj = new scs_error_dictionary();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = "<image src='../../images/msgIcons/stop.jpg' style='WIDTH: 25px;VERTICAL-ALIGN: middle; valign=middle; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 26px; BORDER-BOTTOM-STYLE: none' />  There is no local plan for this selection! Please contact system office.";
            }
            Panel1.Visible = false;
        }


        //GearBox_Activities_Secruity();


    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlLineItemCategory.DataBind();
            ddlLineItemCategory.SelectedIndex = 0;
            gvFundingPlan.Visible = false;
        }
       
    }
    protected void ddlLineItemCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlLineItemCategory.SelectedIndex > 0)
        {
            gvFundingPlan.Visible = true;
            dsRei.SelectCommand = ddlLineItemCategory.SelectedValue.ToString();

            dsRei.DataBind();
            gvFundingPlan.DataSource = dsRei;
            gvFundingPlan.DataBind();
            if (ddlLineItemCategory.SelectedIndex == 2 || ddlLineItemCategory.SelectedIndex == 4)
            {
                gvFundingPlan.Columns[0].Visible = false;
                gvFundingPlan.Columns[1].Visible = false;
                gvFundingPlan.Columns[2].Visible = false;
                gvFundingPlan.Columns[3].Visible = true;
            }
            else
            {
                gvFundingPlan.Columns[0].Visible = true;
                gvFundingPlan.Columns[1].Visible = true;
                gvFundingPlan.Columns[2].Visible = true;
                gvFundingPlan.Columns[3].Visible = false;
            }
        }
        else
        {
            gvFundingPlan.Visible = false;
            gvFundingPlan.DataBind();
        }
    }

    double gridTotal = 0;
    double lineTotal = 0;
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
                lineTotal = Convert.ToDouble(Convert.ToDecimal(dataItem["Salary"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Fixed Charges"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Purchased Services"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Instructional Supplies"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Indirect Costs"].Text.Replace("$", "")) +
                        Convert.ToDecimal(dataItem["Equipment"].Text.Replace("$", "")));
                tb.Text = string.Format("{0:c}", lineTotal);
                totalS += Double.Parse(dataItem["Salary"].Text.Replace("$", ""));
                totalFC += Double.Parse(dataItem["Fixed Charges"].Text.Replace("$", ""));
                totalPS += Double.Parse(dataItem["Purchased Services"].Text.Replace("$", ""));
                totalIS += Double.Parse(dataItem["Instructional Supplies"].Text.Replace("$", ""));
                totalIC += Double.Parse(dataItem["Indirect Costs"].Text.Replace("$", ""));
                totalE += Double.Parse(dataItem["Equipment"].Text.Replace("$", ""));

                if (lineTotal > 0)
                    dataItem.BackColor = System.Drawing.Color.LightYellow;

                gridTotal += lineTotal;
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

            (footerItem.FindControl("lblFooterSum") as Label).Text = string.Format("{0:c}", gridTotal);
        }
    }

    protected void FundPlanChange()
    {       
            ddlLineItemCategory.SelectedIndex = 0;
            //dsRei.SelectCommand = ddlLineItemCategory.SelectedValue.ToString();

            //dsRei.DataBind();
            gvFundingPlan.DataSource = "";
            gvFundingPlan.DataBind();
            gvFundingPlan.Visible = false;
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        if(ddlLineItemCategory.SelectedIndex > 0)
            try
            {
                gvFundingPlan.ExportSettings.ExportOnlyData = true;
                gvFundingPlan.ExportSettings.IgnorePaging = true;
                gvFundingPlan.ExportSettings.OpenInNewWindow = true;
                gvFundingPlan.MasterTableView.ExportToExcel();
            }
            catch { }
    }

    protected void ddlLineItemCategory_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("Select Category", "-1");
        if (ddlLineItemCategory.Items.IndexOf(li) < 0)
            ddlLineItemCategory.Items.Insert(0, li);

    }
}
