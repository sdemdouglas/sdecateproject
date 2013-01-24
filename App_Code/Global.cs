using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.SessionState;
using System.Net.Mail;
using System.Web.Configuration;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Global
/// </summary>
public class Global :System.Web.HttpApplication
{
	public Global()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    void Application_Start(object sender, EventArgs e)
    {
    

    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
        // Code that runs on application startup
      

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs
        string erroremailuser = "non retreivalbe";
        try
        {
            GK3_Driver mydrive = new GK3_Driver();
            System.Data.DataSet myds = new DataSet();
            myds = mydrive.AllUserINFO(HttpContext.Current.User.Identity.Name.ToString());   
            
             erroremailuser = myds.Tables[0].Rows[0]["txt_email"].ToString();
        }
        catch
        {
        }
        
        try
        {
           
      Exception objErr = Server.GetLastError().GetBaseException();

      string emailrecps = WebConfigurationManager.AppSettings["ErrorEmails"].ToString();

            MailMessage mm = new MailMessage(erroremailuser,emailrecps);
            mm.Subject = HttpContext.Current.User.Identity.Name.ToString() + " caused an error";





            mm.Body = erroremailuser + "   Has caused an error" + Environment.NewLine + Environment.NewLine + Environment.NewLine + "*******************Details ****************" + Environment.NewLine + Environment.NewLine + "**************Message**************" + Environment.NewLine + objErr.Message.ToString() + Environment.NewLine + Environment.NewLine + Environment.NewLine + Environment.NewLine + "*********Stack Trace *****************" + Environment.NewLine + objErr.StackTrace + Environment.NewLine + Environment.NewLine + Environment.NewLine + Environment.NewLine + Environment.NewLine + "****************Offending Page ******************" + Environment.NewLine + Request.Url;
            SmtpClient smtp = new SmtpClient();
            smtp.UseDefaultCredentials  = true;
            smtp.Send(mm);
            if (objErr.GetType().ToString() == "System.Data.SqlClient.SqlException")
            {

                Response.Redirect("http://localhost/perkins_vers2/General_UserError.aspx");

            }
            //if (Session[Session.SessionID + "USERID"] == null)
            if (Context.Session == null || Context.Session.IsNewSession)
            {
              //  Response.Redirect("http://localhost/perkins_vers2/SessionTimeOut.aspx");
            }
            else
            {

            //    Response.Redirect("http://localhost/perkins_vers2/UnexpectedError.aspx");
            }
        }
        catch (Exception ex)
        {
            string mystring = ex.Message;
            string mestring = "filler";

           // Response.Redirect("http://localhost/perkins_vers2/UnexpectedError.aspx");
            

           
        }







    }

    protected void Application_AuthenticateRequest(Object sender, EventArgs e)
    {
       //HttpCookie authCookie = Request.Cookies[
       //      FormsAuthentication.FormsCookieName];
       //Response.Write(authCookie.Name.ToString());
 string mystring;
 if (Request.IsAuthenticated)
 {
 }
    }

    void Session_Start(object sender, EventArgs e)
    {
        GK3_Driver mydrive = new GK3_Driver();
        System.Data.DataSet myds = new DataSet();

        Session.Timeout = 600;

        try
        {

            if (Session[Session.SessionID + "ChildTabIndex"] != null)
            {
                Session.Remove(Session.SessionID + "ChildTabIndex");
            }
            Session.Add(Session.SessionID + "ChildTabIndex", "-1");
            if (Session[Session.SessionID + "ChildTabValue"] != null)
            {
                Session.Remove(Session.SessionID + "ChildTabValue");
            }
            Session.Add(Session.SessionID + "ChildTabValue", "-1");

            if (Session[Session.SessionID + "ChildURLValue"] != null)
            {
                Session.Remove(Session.SessionID + "ChildURLValue");
            }
            Session.Add(Session.SessionID + "ChildURLValue", "");


            if (Session[Session.SessionID + "ParentTabIndex"] != null)
            {
                Session.Remove(Session.SessionID + "ParentTabIndex");
            }
            Session.Add(Session.SessionID + "ParentTabIndex", "-1");

            if (Session[Session.SessionID + "ParentTabValue"] != null)
            {
                Session.Remove(Session.SessionID + "ParentTabValue");
            }
            Session.Add(Session.SessionID + "ParentTabValue", "-1");




            
            myds = mydrive.AllUserINFO(HttpContext.Current.User.Identity.Name.ToString());
            string teststring = myds.Tables[0].Rows[0][0].ToString();

            if (Session[Session.SessionID + "USERID"] != null)
            {
                Session.Remove(Session.SessionID + "USERID");
            }
            Session.Add(Session.SessionID + "USERID", myds.Tables[0].Rows[0]["key_user_id"].ToString());
            //////////////////////
            if (Session[Session.SessionID + "email"] != null)
            {
                Session.Remove(Session.SessionID + "email");
            }
            Session.Add(Session.SessionID + "email", myds.Tables[0].Rows[0]["txt_email"].ToString());
            //////////////////////
            if (Session[Session.SessionID + "diplayname"] != null)
            {
                Session.Remove(Session.SessionID + "displayname");
            }
            Session.Add(Session.SessionID + "displayname", myds.Tables[0].Rows[0]["txt_display_name"].ToString());
            //////////////////////

            if (Session[Session.SessionID + "roleid"] != null)
            {
                Session.Remove(Session.SessionID + "roleid");
            }
            Session.Add(Session.SessionID + "roleid", myds.Tables[0].Rows[0]["key_role_id"].ToString());
            //////////////////////
            if (Session[Session.SessionID + "Userscollege"] != null)
            {
                Session.Remove(Session.SessionID + "userscollege");
            }
            Session.Add(Session.SessionID + "userscollege", myds.Tables[0].Rows[0]["key_college_id"].ToString());
            //////////////////////

            if (Session[Session.SessionID + "CollegeDDvalue"] != null)
            {
                Session.Remove(Session.SessionID + "CollegeDDvalue");
            }
            Session.Add(Session.SessionID + "CollegeDDvalue", myds.Tables[0].Rows[0]["key_college_id"].ToString());

        }
        catch (Exception ex)
        {
           Response.Redirect("~/access_denied.aspx");
   //       Response.Write(ex.Message.ToString());
        }

    }

    void Session_End(object sender, EventArgs e)
    {
     if(Session[Session.SessionID + "keyactiveID"] != null && Session[Session.SessionID + "keyactiveID"] != "-1")
            {

              string connectionstring=  WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString;
         SqlConnection myconn = new SqlConnection(connectionstring);
         SqlCommand mycomm = new SqlCommand("pr_at_amendment_incomplete_amd_del",myconn);
         mycomm.CommandType = CommandType.StoredProcedure;
         mycomm.Parameters.AddWithValue("p_key_activity_id", Session[Session.SessionID + "keyactiveID"]);
         myconn.Open();
         mycomm.ExecuteNonQuery();
         myconn.Close();

         //pr_at_amendment_incomplete_amd_del @p_key_activity_id 

        }

        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
}
