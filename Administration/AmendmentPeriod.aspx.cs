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

public partial class Administration_AmendmentPeriod : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
        Panel panControl = (Panel)Master.FindControl("panControl");
        if (panControl != null)
            panControl.Visible = false;


        Label lblCollege = (Label)Master.FindControl("lblCollege");
        if (lblCollege != null)
            lblCollege.Visible = false;

        DropDownList DropDownList1 = (DropDownList)Master.FindControl("DropDownList1");
        if (DropDownList1 != null)
            DropDownList1.Visible = false;

        Label Label2 = (Label)Master.FindControl("Label2");
        if (Label2 != null)
            Label2.Visible = false;

        DropDownList DropDownList2 = (DropDownList)Master.FindControl("DropDownList2");
        if (DropDownList2 != null)
            DropDownList2.Visible = false;

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Panel panControl = (Panel)Master.FindControl("panControl");
            if (panControl != null)
                panControl.Visible = false;
        }
    }
    protected void radGdLockAmd_ItemCreated(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        
    }
    protected void radGdLockAmd_ItemDataBound(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        TextBox tb = (TextBox)e.Item.FindControl("txtLevelId");

        if (tb != null)
        {
            if (tb.Text.Trim().Equals("107"))
            {
                ImageButton ib = (ImageButton)e.Item.FindControl("imbEdit");
                if (ib != null)
                {
                    ib.Visible = false;
                }
            }
        }
    }
}
