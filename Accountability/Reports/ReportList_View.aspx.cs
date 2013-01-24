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

public partial class Accountability_Reports_ReportList_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HL_Print.NavigateUrl = "Javascript:OpenReport(" + Request.QueryString["Acctid"].ToString() + ");";
            rbl_Print_Type.SelectedIndex = 0;
        }
    }
    protected void RadioButtonList1_DataBound(object sender, EventArgs e)
    {

    }
}
