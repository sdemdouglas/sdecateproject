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
using System.Globalization;
using BLL;
using System.Data.SqlClient;

public partial class LocalPlan_ActivityReimbursement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            act_activity aObj = new act_activity();

            if (aObj.LoadByPrimaryKey(Convert.ToInt32(Request.QueryString.Get("aid"))))
            {
                hdnactivityid.Value = Request.QueryString.Get("aid").ToString();
                lblActivityName.Text = aObj.Txt_activity_name;
                lblDescription.Text = aObj.Txt_activity_desc;
                hfLpId.Value = aObj.Key_local_plan_id.ToString();
            }            
        }

        lblInject.Text = "";        
        GearBox_ActivityReimbursement_Secruity();
    }

    protected void getLineItemTotal()
    {
        //act_activity_line_item aliObj = new act_activity_line_item();
        //if (!ddlActivityLineItem.SelectedItem.Value.Equals("-1"))
        //{
        //    if (aliObj.LoadByPrimaryKey(Convert.ToInt32(ddlActivityLineItem.SelectedItem.Value)))
        //        lblLITotal.Text = string.Format("{0:c}", aliObj.Amt_amount);
        //    else
        //        lblLITotal.Text = string.Format("{0:c}", 0);
        //}
        //else
        //    lblLITotal.Text = "";


        act_activity_reimbursement aliObj = new act_activity_reimbursement();
        if (!ddlActivityLineItem.SelectedItem.Value.Equals("-1"))
        {
            SqlDataReader dr = aliObj.get_Line_Item_Info(Convert.ToInt32(ddlActivityLineItem.SelectedItem.Value));
            if (dr.HasRows)
                while(dr.Read())
                {
                    lblLITotal.Text = string.Format("{0:c}", dr["amt_amount"]);
                    lblBalance.Text = string.Format("{0:c}", dr["nbr_line_item_balance"]);
                }
            else
            {
                lblLITotal.Text = string.Format("{0:c}", 0);
                lblBalance.Text = string.Format("{0:c}", 0);
            }
        }
        else
        {
            lblLITotal.Text = "";
            lblBalance.Text = "";
        }


        
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        NumberFormatInfo nf = new CultureInfo("en-US", false).NumberFormat;
        nf.CurrencySymbol = "$";
        //nf.CurrencyGroupSizes = 3;
        nf.CurrencyGroupSeparator = ".";
        nf.CurrencyDecimalDigits = 2;
        nf.CurrencyDecimalSeparator = ",";

        decimal decCurrentLiTotal = 0;
        int iLiIndex = ddlActivityLineItem.SelectedIndex - 1;
        decCurrentLiTotal = Convert.ToDecimal(RadGrid1.Items[iLiIndex]["Qtr 1"].Text) +
            Convert.ToDecimal(RadGrid1.Items[iLiIndex]["Qtr 2"].Text) +
            Convert.ToDecimal(RadGrid1.Items[iLiIndex]["Qtr 3"].Text) +
            Convert.ToDecimal(RadGrid1.Items[iLiIndex]["Qtr 4"].Text);

       
        decimal decBalance;
        decimal decAmt;

        if (!txtAmount.Text.Trim().Equals("") && !lblLITotal.Text.Trim().Equals(""))
        {
            decBalance = Decimal.Parse(lblBalance.Text.Remove(0, 1), nf);
            decAmt = Decimal.Parse(txtAmount.Text, nf);

            if (decAmt > decBalance)
            {
                lblInject.Text = "<script>Err('Value entered exceeds line item balance!')</" + "script>";
            }
            else
            {
                act_activity_reimbursement arObj = new act_activity_reimbursement();

                arObj.AddNew();
                arObj.Key_fiscal_year_quarter_id = Convert.ToInt32(ddlQuarter.SelectedValue);
                arObj.Key_activity_line_item_id = Convert.ToInt32(ddlActivityLineItem.SelectedValue);
                arObj.Nbr_amount = Decimal.Parse(txtAmount.Text, nf);

                arObj.Save();

                RadGrid1.DataBind();
                RadGrid2.DataBind();
                resetFields();
            }
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        resetFields();
    }

    protected void resetFields()
    {
        ddlQuarter.SelectedIndex = 0;
        ddlActivityLineItem.SelectedIndex = 0;
        txtAmount.Text = "";
        lblLITotal.Text = "";
        lblInject.Text = "";
        lblBalance.Text = "";
    }
    protected void ddlQuarter_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddlQuarter.Items.IndexOf(li) < 0)
            ddlQuarter.Items.Insert(0, li);
    }
    protected void ddlActivityLineItem_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddlActivityLineItem.Items.IndexOf(li) < 0)
            ddlActivityLineItem.Items.Insert(0, li);
    }

    double total;
    double totalQtr1 = 0;
    double totalQtr2 = 0;
    double totalQtr3 = 0;
    double totalQtr4 = 0;

    protected void RadGrid1_ItemDataBound1(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            Label tb = (Label)e.Item.FindControl("lblTotal");
            if (tb != null)
            {
                tb.Text = Convert.ToString( Convert.ToDecimal(dataItem["Qtr 1"].Text) +
                                            Convert.ToDecimal(dataItem["Qtr 2"].Text) +
                                            Convert.ToDecimal(dataItem["Qtr 3"].Text) +
                                            Convert.ToDecimal(dataItem["Qtr 4"].Text) );
                total += Double.Parse(tb.Text);
                tb.Text = string.Format("{0:N}", Double.Parse(tb.Text));
                totalQtr1 += Double.Parse(dataItem["Qtr 1"].Text);
                totalQtr2 += Double.Parse(dataItem["Qtr 2"].Text);
                totalQtr3 += Double.Parse(dataItem["Qtr 3"].Text);
                totalQtr4 += Double.Parse(dataItem["Qtr 4"].Text);

               
            }
        }

        if (e.Item is GridFooterItem)
        {
            GridFooterItem footerItem = e.Item as GridFooterItem;
            footerItem["Qtr 1"].Text = string.Format("{0:c}", totalQtr1);
            footerItem["Qtr 2"].Text = string.Format("{0:c}", totalQtr2);
            footerItem["Qtr 3"].Text = string.Format("{0:c}", totalQtr3);
            footerItem["Qtr 4"].Text = string.Format("{0:c}", totalQtr4);

            (footerItem.FindControl("lblSum") as Label).Text = string.Format("{0:c}", total);
        } 

    }
    protected void RadGrid2_ItemDeleted(object source, GridDeletedEventArgs e)
    {
        RadGrid1.DataBind();
    }
    protected void ddlActivityLineItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        getLineItemTotal();
    }
    protected void ddlQuarter_SelectedIndexChanged(object sender, EventArgs e)
    {
        getLineItemTotal();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {

    }

    protected void GearBox_ActivityReimbursement_Secruity()
    {
        lp_local_plan lpObj = new lp_local_plan();
        lpObj.ConnectionString = DataAccess.getConnStr();
        lpObj.LoadByPrimaryKey(Convert.ToInt32(hfLpId.Value));

        try
        {

            string roleid = Session[Session.SessionID + "roleid"].ToString();
            switch (lpObj.Key_local_plan_level_id.ToString())
            {
                case "101":
                    //Level 0 Awaiting CO Admin

                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;

                            break;
                        case "102":
                            //CAO
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                        case "101":
                            //SO Admin
                            ddlActivityLineItem.Enabled = true;
                            ddlQuarter.Enabled = true;
                            txtAmount.Enabled = true;
                            btnSave.Enabled = true;
                            btnClear.Enabled = true;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = true;
                            break;
                        case "104":
                            //View Only
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                    }

                    break;
                case "102":
                    //Level 1 Awaiting CAO
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;

                            break;
                        case "102":
                            //CAO
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                        case "101":
                            //SO Admin
                            ddlActivityLineItem.Enabled = true;
                            ddlQuarter.Enabled = true;
                            txtAmount.Enabled = true;
                            btnSave.Enabled = true;
                            btnClear.Enabled = true;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = true;
                            break;
                        case "104":
                            //View Only
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                    }
                    break;
                case "103":
                    //Review by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                        
                            break;
                        case "102":
                            //CAO
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;

                            break;
                        case "101":
                            //SO Admin
                            ddlActivityLineItem.Enabled = true;
                            ddlQuarter.Enabled = true;
                            txtAmount.Enabled = true;
                            btnSave.Enabled = true;
                            btnClear.Enabled = true;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = true;
                            break;
                        case "104":
                            //View Only
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                    }
                    break;

                case "104":
                    //So 3 Revision Requested by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;

                            break;
                        case "102":
                            //CAO
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                        case "101":
                            //SO Admin
                            ddlActivityLineItem.Enabled = true;
                            ddlQuarter.Enabled = true;
                            txtAmount.Enabled = true;
                            btnSave.Enabled = true;
                            btnClear.Enabled = true;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = true;
                            break;
                        case "104":
                            //View Only
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                    }
                    break;

                case "105":
                    //Level 4 Pending SDE Review
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;

                            break;
                        case "102":
                            //CAO
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;

                            break;
                        case "101":
                            //SO Admin
                            ddlActivityLineItem.Enabled = true;
                            ddlQuarter.Enabled = true;
                            txtAmount.Enabled = true;
                            btnSave.Enabled = true;
                            btnClear.Enabled = true;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = true;

                            break;
                        case "104":
                            //View Only
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                    }
                    break;

                case "106":
                    //Level 5 Approved
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;

                            break;
                        case "102":
                            //CAO
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;

                            break;
                        case "101":
                            //SO Admin
                            ddlActivityLineItem.Enabled = true;
                            ddlQuarter.Enabled = true;
                            txtAmount.Enabled = true;
                            btnSave.Enabled = true;
                            btnClear.Enabled = true;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = true;
                            break;
                        case "104":
                            //View Only
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                    }
                    break;

                case "107":
                    //Level 6 Closed
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;


                            break;
                        case "102":
                            //CAO
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                        case "101":
                            //SO Admin
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;    
                            break;
                        case "104":
                            //View Only
                            ddlActivityLineItem.Enabled = false;
                            ddlQuarter.Enabled = false;
                            txtAmount.Enabled = false;
                            btnSave.Enabled = false;
                            btnClear.Enabled = false;
                            RadGrid2.MasterTableView.Columns.FindByUniqueName("column").Display = false;
                            break;
                    }
                    break;
                default:
                    // View Only, and anything not covered

                    break;
            }
        }
        catch (Exception ex)
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();
            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
                //lblErr.Text = ex.ToString();
            }
            else
                lblErr.Text = ex.ToString();
            
        }
    }
}
