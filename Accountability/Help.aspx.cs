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

public partial class Accountability_Help : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        Panel panControl = (Panel)Master.FindControl("panControl");
        if (panControl != null)
            panControl.Visible = false;

        //Check if the Selected College is changed 
        try
        {
            DropDownList MasterPageCollegeDD = (DropDownList)Master.FindControl("DropDownList1");
            DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());
            if (MasterPageCollegeDD.SelectedValue != myobj.CollID)
            {
                Response.Redirect("AccountabilityReport.aspx");
            }


        }
        catch
        {
        }



        Label Label2 = (Label)Master.FindControl("Label2");
        if (Label2 != null)
            Label2.Visible = false;

        DropDownList DropDownList2 = (DropDownList)Master.FindControl("DropDownList2");
        if (DropDownList2 != null)
            DropDownList2.Visible = false;
        Security_LockoutControl_by_LEVELS();       


        base.OnPreRenderComplete(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Security_LockoutControl_by_LEVELS()
    {
        try
        {
            string levelid = Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString();

            if (levelid == "100" || levelid == "102")
            {

            }
        }
        catch
        {
        }

    }
}
