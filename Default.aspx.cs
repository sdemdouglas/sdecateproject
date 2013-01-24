using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


using BLL;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        try
        {
            DropDownList ddl = (DropDownList)Master.FindControl("DropDownList2");
            this.HFFiscalyear.Value = ddl.SelectedValue.ToString();
            this.RadGrid1.Rebind(); 
        }
        catch (Exception ex)
        {
            
        }
   
    
    
    }

}
