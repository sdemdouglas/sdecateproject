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

public partial class LocalPlan_FundingPlan_FundingPlanReport_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HL_Print.NavigateUrl = "Javascript:OpenReport(" + Request.QueryString["planid"].ToString() + "," + Request.QueryString["fiscalyear"].ToString() + "," + Request.QueryString["versionid"].ToString() + ")";
     
    }
}
