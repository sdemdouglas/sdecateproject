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
using System.Data.SqlClient;
using Telerik.WebControls;
using BLL;

public partial class TextEditor : System.Web.UI.Page
{
    private String ssId;

    protected void Page_Load(object sender, EventArgs e)
    {
        string sDoc = Request.QueryString.Get("doc").ToString();
        ssId = "TextEditor" + Request.QueryString["nid"].ToString();
        if (!Page.IsPostBack)
        {
            switch(sDoc)
            {
                case "narrative" :                    
                    if (Session[ssId] != null)
                        RadEditor1.Html = (String)Session[ssId];
                    break;
            }    
        }
    }
    protected void RadEditor1_SubmitClicked(object sender, EventArgs e)
    {
        string sDoc = Request.QueryString.Get("doc").ToString();

        WordCounter wc = new WordCounter(RadEditor1.Text);
        int numWords, numChars;
        wc.CountStats(out numWords, out numChars);

        if (numChars <= 15000)
        {
            switch (sDoc)
            {
                case "narrative":
                    Session[ssId] = RadEditor1.Html;
                    break;
            }

            InjectScript.Text = "<script>CloseAndRebind()</" + "script>";
        }
        else
        {
            lblError.Text = "Document length is too long. Please limit to 15000 characters.";
        }
    }
    protected void RadEditor1_CancelClicked(object sender, EventArgs e)
    {
        InjectScript.Text = "<script>CancelEdit()</" + "script>";
    }
}
