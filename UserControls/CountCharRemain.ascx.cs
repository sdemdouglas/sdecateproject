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

public partial class UserControls_WebUserControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtCharCount.Attributes.Add("readonly", "readonly");
    }

    private int _maxChar;
    public int maxChar
    {
        get { return _maxChar; }
        set { _maxChar = value; }
    }

    public void initial(int value)
    {
        txtCharCount.Text = value.ToString();
    }
   
}
