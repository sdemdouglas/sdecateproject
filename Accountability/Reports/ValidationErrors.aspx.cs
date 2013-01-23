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

public partial class LocalPlan_ValidationErrors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());
        hf_accID.Value =   myobj.AcctID.ToString();

    SQLDsValidationErrors.Select(DataSourceSelectArguments.Empty);
    rdg_errors.DataBind();
    }
}
