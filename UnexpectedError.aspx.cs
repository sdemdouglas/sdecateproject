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
using System.Net.Mail;

public partial class UnexpectedError : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            MailMessage mm = new MailMessage(TextBox1.Text, "HelpDesk@sctechsystem.edu");
            mm.Subject = HttpContext.Current.User.Identity.Name.ToString() + " caused an error in Perkins";

            mm.Bcc.Add("lowryr@sctechsystem.edu");



            mm.Body = TextBox2.Text;
            SmtpClient smtp = new SmtpClient();
            smtp.UseDefaultCredentials = true;
            smtp.Send(mm);
        }
        catch
        {
        }
    }
}
