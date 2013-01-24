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
//Create Date: Rick  11-13-2007
public partial class LocalPlan_LocalPlan_ApplicationForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      //  Response.Write(Request.QueryString["activityid"].ToString());
                  
        if (!IsPostBack)
        {
            WhichOne.Attributes.Add("href", "NothingStyle.css");
          

        }
    
    }
    protected void DLB_ActType_SelectedIndexChanged(object sender, EventArgs e)
    {
        #region
        /* 
             * RL Sets the Styles for what is seen and how based on querystring parameter saying               * how the form is to be used  
             * 11-12-2007 only 2 options fund or equipment
             * ?plantype=equipment or ?plantype=fund
             * add to end of url to get intended action
             */

        try
        {
        
            if(DLB_ActType.SelectedValue == "101")
            {
                WhichOne.Attributes.Add("href", "LocalPlan_applicationFunds.css");
                SDS_ActivityBudgetFunds.SelectParameters.Clear();
                SDS_ActivityBudgetFunds.SelectParameters.Add("p_key_line_item_type_id", "-1"); ;
                SDS_ActivityBudgetFunds.Select(DataSourceSelectArguments.Empty);
            }
            else if (DLB_ActType.SelectedValue == "102")
            {
                WhichOne.Attributes.Add("href", "LocalPlan_applicationEQUIPMENT.css");
                SDS_ActivityBudgetFunds.SelectParameters.Clear();
                SDS_ActivityBudgetFunds.SelectParameters.Add("p_key_line_item_type_id", "106"); ;
                SDS_ActivityBudgetFunds.Select(DataSourceSelectArguments.Empty);

            }
            else
            {

                WhichOne.Attributes.Add("href", "NothingStyle.css");
            }
        }
        catch (Exception ex)
        {
        }
        #endregion
    }
    protected void DLB_ActType_DataBound(object sender, EventArgs e)
    {
        ListItem myitem = new ListItem("Select Type", "-1");
            DLB_ActType.Items.Insert(0, myitem);
    }
}
