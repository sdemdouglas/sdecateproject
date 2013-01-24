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

public partial class LocalPlan_FundingPlan : System.Web.UI.Page
{
   

    protected void Page_Load(object sender, EventArgs e)
    {
        HL_Print.NavigateUrl = "JavaScript:OpenReport(" + Request.QueryString["id"].ToString() + ")";
        HL_Print_RDL.NavigateUrl = "JavaScript:OpenReportRDL(" + Request.QueryString["id"].ToString() + ")";
        HL_Print_RDL.Visible = false;
    }

    double Grandtotal = 0;
    double tot_sal = 0;
    double tot_fixed = 0;
    double tot_purchased = 0;
    double tot_instr = 0;
    double tot_equip = 0;
    double tot_indirect = 0;
    protected void GridFundingPlan_ItemDataBound(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        double total = 0;
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;

            total += (Convert.ToDouble(dataItem["nbr_salary"].Text.Replace("$", "")) + Convert.ToDouble(dataItem["nbr_fixed_charges"].Text.Replace("$", "")) + Convert.ToDouble(dataItem["nbr_purchased_services"].Text.Replace("$", "")) + Convert.ToDouble(dataItem["nbr_instructional_supplies"].Text.Replace("$", "")) + Convert.ToDouble(dataItem["nbr_equipment_cost"].Text.Replace("$", "")) + Convert.ToDouble(dataItem["nbr_indirect_costs"].Text.Replace("$", "")) );
           

            dataItem["total"].Text = String.Format("{0:c}",total);
            if (total > 0)
                dataItem.BackColor = System.Drawing.Color.LightYellow;


Grandtotal += total;
tot_sal += Convert.ToDouble(dataItem["nbr_salary"].Text.Replace("$", ""));
tot_fixed += Convert.ToDouble(dataItem["nbr_fixed_charges"].Text.Replace("$", ""));
tot_purchased += Convert.ToDouble(dataItem["nbr_purchased_services"].Text.Replace("$", ""));
tot_instr += Convert.ToDouble(dataItem["nbr_instructional_supplies"].Text.Replace("$", ""));
tot_equip += Convert.ToDouble(dataItem["nbr_equipment_cost"].Text.Replace("$", ""));
tot_indirect += Convert.ToDouble(dataItem["nbr_indirect_costs"].Text.Replace("$", ""));



           // Label abc = (dataItem.FindControl("lblTotal") as Label).Text;
            //if (abc != null)
              //      abc.Text = String.Format("{0:c}",(Double.Parse(dataItem["nbr_salary"].Text) + Double.Parse(dataItem["nbr_fixed_charges"].Text)));
           // total += Double.Parse((dataItem.FindControl("lblTotal") as Label).Text);
        }

        else if (e.Item is GridFooterItem)
        {
            GridFooterItem footer = (GridFooterItem)e.Item;

            footer["txt_category_title"].Text = "Grand Totals: ";
            
            footer["nbr_salary"].Text = String.Format("{0:c}", tot_sal);
            footer["nbr_fixed_charges"].Text = String.Format("{0:c}", tot_fixed);
            footer["nbr_purchased_services"].Text = String.Format("{0:c}", tot_purchased);
            footer["nbr_instructional_supplies"].Text = String.Format("{0:c}", tot_instr);
            footer["nbr_equipment_cost"].Text = String.Format("{0:c}", tot_equip);
            footer["nbr_indirect_costs"].Text = String.Format("{0:c}", tot_indirect);
            
            
            footer["total"].Text = String.Format("{0:c}",Grandtotal);



        }


    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        GridFundingPlan.ExportSettings.ExportOnlyData = true;
        GridFundingPlan.ExportSettings.IgnorePaging = true;
        GridFundingPlan.ExportSettings.OpenInNewWindow = true;
        GridFundingPlan.MasterTableView.ExportToExcel2007();
    }
}
