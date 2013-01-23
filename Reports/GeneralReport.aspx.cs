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

public partial class Reports_GeneralReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String keyid = Request.QueryString["keyid"].ToString();
        switch (Request.QueryString["type"].ToString())
        {
            case "pr_rpt_local_plan_activity":
                MultiView1.ActiveViewIndex = 0;
                hlPrintPdf.Attributes.Add("onClick", "printReport('rpt_local_plan_activity'," + keyid + ",'pdf')");
                hlPrintRdl.Attributes.Add("onClick", "printReport('rpt_local_plan_activity'," + keyid + ",'rdl')");
                break;

        }
    }

    double total;
    double ttSalary = 0;
    double ttFC = 0;
    double ttPS = 0;
    double ttIS = 0;
    double ttIC = 0;
    double ttEquipment = 0;

    protected void RadGrid1_ItemDataBound(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        GridDataItem dataItem = e.Item as GridDataItem;

        if (e.Item is GridDataItem)
        {
            total += Double.Parse(Utility.ToRawMoney(dataItem["Total"].Text));
            ttSalary += Double.Parse(dataItem["Salary"].Text);
            ttFC += Double.Parse(dataItem["Fixed Charges"].Text);
            ttPS += Double.Parse(dataItem["Purchased Services"].Text);
            ttIS += Double.Parse(dataItem["Instructional Supplies"].Text);
            ttIC += Double.Parse(dataItem["Indirect Costs"].Text);
            ttEquipment += Double.Parse(dataItem["Equipment"].Text);            
        }

        if (e.Item is GridFooterItem)
        {
            GridFooterItem footerItem = e.Item as GridFooterItem;
            footerItem["Total"].Text = string.Format("{0:c}", total);
            footerItem["Salary"].Text = string.Format("{0:c}", ttSalary);
            footerItem["Fixed Charges"].Text = string.Format("{0:c}", ttFC);
            footerItem["Purchased Services"].Text = string.Format("{0:c}", ttPS);
            footerItem["Instructional Supplies"].Text = string.Format("{0:c}", ttIS);

            footerItem["Indirect Costs"].Text = string.Format("{0:c}", ttIC);

            footerItem["Equipment"].Text = string.Format("{0:c}", ttEquipment);
           
        } 
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        RadGrid1.ExportSettings.ExportOnlyData = true;
        RadGrid1.ExportSettings.IgnorePaging = true;
        RadGrid1.ExportSettings.OpenInNewWindow = true;
        RadGrid1.MasterTableView.ExportToExcel2007();
    }
}
