using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.WebControls;
using System.Net.Mail;
using BLL;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for Utility
/// </summary>
public class Utility
{
	public Utility()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void addPageInfoChange(Page cp, String pageName) 
    {        
        if (cp != null)
        {
            try
            {
                HtmlForm form1 = (HtmlForm)cp.FindControl("form1");

                switch (pageName)
                {                    
                    case "ActivityForm":                                            
                        if (form1 != null)
                        {
                            RadMultiPage rmp = (RadMultiPage)form1.FindControl("RadMultiViewActivity");

                            PageView pv1 = (PageView)rmp.FindControl("PgViewActivity");

                            foreach (Control childCtrl in pv1.Controls)
                            {
                                if (childCtrl is TextBox)
                                {
                                    //Response.write("Requiredfieldvalidator<br>") 
                                    ((TextBox)childCtrl).Attributes.Add("onChange", "pageInfoChanged('" + childCtrl.ClientID + "')");
                                }
                                if (childCtrl is DropDownList )
                                {
                                    //Response.write("Requiredfieldvalidator<br>") 
                                    ((DropDownList)childCtrl).Attributes.Add("onChange", "pageInfoChanged()");
                                }
                                if (childCtrl is CheckBoxList)
                                {
                                    CheckBoxList cbl = (CheckBoxList)childCtrl;                                    
                                    cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");

                                }
                                if (childCtrl is RadGrid)
                                {
                                    RadGrid grid = (RadGrid)childCtrl;
                                    for (int i = 0; i < grid.Items.Count; i++ )
                                    {
                                        TextBox txt_Funds = (TextBox) grid.Items[i].FindControl("txt_Funds");
                                        if (txt_Funds != null)
                                            txt_Funds.Attributes.Add("onChange", "pageInfoChanged()");
                                    }
                                }
                            }                            
                        }
                        break;
                    case "ActivityEquipment":
                       
                        if (form1 != null)
                        {
                            RadMultiPage rmp = (RadMultiPage) form1.FindControl("RadMultiViewActivity");

                            PageView pv1 = (PageView)rmp.FindControl("PgViewActivity");

                            foreach (Control childCtrl in pv1.Controls)
                            {
                                if (childCtrl is TextBox)
                                {
                                    //Response.write("Requiredfieldvalidator<br>") 
                                    ((TextBox)childCtrl).Attributes.Add("onChange", "pageInfoChanged()");
                                }
                                if (childCtrl is DropDownList)
                                {
                                    //Response.write("Requiredfieldvalidator<br>") 
                                    ((DropDownList)childCtrl).Attributes.Add("onChange", "pageInfoChanged()");
                                }
                                if (childCtrl is CheckBoxList)
                                {
                                    CheckBoxList cbl = (CheckBoxList)childCtrl;
                                    lp_local_plan lpObj = new lp_local_plan();
                                    
                                    
                                    lpObj.LoadByPrimaryKey(Convert.ToInt32(cp.Session[cp.Session.SessionID + "PlanID"].ToString()));       
                                    string roleid = cp.Session[cp.Session.SessionID + "roleid"].ToString();
                                    

                                    switch (lpObj.Key_local_plan_level_id.ToString())
                                    {
                                        case "101":
                                             
                                             switch (roleid)
                                             {
                                                 case "103":
                                                     //CO Admin
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     
                                                     break;
                                                 case "102":
                                                     //CAO

                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     break;  
                                                 case "101":
                                                     //SO Admin
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     break;
                                                 case "104":
                                                     //View Only
                                                     
                                                     
                                                     
                                                     break;
                                             }

                                             break;
                                         case "102":
                                             //Level 1 Awaiting CAO
                                             switch (roleid)
                                             {
                                                 case "103":
                                                     //CO Admin
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     
                                                     break;
                                                 case "102":
                                                     //CAO
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     break;
                                                 case "101":
                                                     //SO Admin
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     break;
                                                 case "104":
                                                     //View Only
                                                     
                                                     break;
                                             }
                                             break;
                                         case "103":
                                             //Review by So
                                             switch (roleid)
                                             {
                                                 case "103":
                                                     //CO Admin

                                                     break;
                                                 case "102":
                                                     //CAO
                                                    
                                                     break;
                                                 case "101":
                                                     //SO Admin
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     break;
                                                 case "104":
                                                     //View Only
                                                    
                                                     break;
                                             }
                                             break;

                                         case "104":
                                             //So 3 Revision Requested by So
                                             switch (roleid)
                                             {
                                                 case "103":
                                                     //CO Admin

                                                     break;
                                                 case "102":
                                                     //CAO
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     break;
                                                 case "101":
                                                     //SO Admin
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");
                                                     break;
                                                 case "104":
                                                     //View Only
                                                    
                                                     break;
                                             }
                                             break;

                                         case "105":
                                             //Level 4 Pending SDE Review
                                             switch (roleid)
                                             {
                                                 case "103":
                                                     //CO Admin

                                                     break;
                                                 case "102":
                                                     //CAO
                                                     break;
                                                 case "101":
                                                     //SO Admin
                                                     cbl.Attributes.Add("onClick", "pageInfoChanged('cbl')");                                                     
                                                     break;
                                                 case "104":
                                                     //View Only
                                                     
                                                     break;
                                             }
                                             break;

                                         case "106":
                                             //Level 5 Approved
                                             switch (roleid)
                                             {
                                                 case "103":
                                                     //CO Admin

                                                     break;
                                                 case "102":
                                                     //CAO
                                                     break;
                                                 case "101":
                                                     //SO Admin
                                                                                                          
                                                     break;
                                                 case "104":
                                                     //View Only
                                                     
                                                     break;
                                             }
                                             break;

                                         case "107":
                                             //Level 6 Closed
                                             switch (roleid)
                                             {
                                                 case "103":
                                                     //CO Admin

                                                     break;
                                                 case "102":
                                                     //CAO
                                                     break;
                                                 case "101":
                                                     //SO Admin
                                                     
                                                     break;
                                                 case "104":
                                                     //View Only
                                                     break;
                                             }
                                             break;
                                         default:
                                             // View Only, and anything not covered

                                             break;
                                     }

                                }
                                if (childCtrl is RadGrid)
                                {
                                    RadGrid grid = (RadGrid)childCtrl;
                                    for (int i = 0; i < grid.Items.Count; i++)
                                    {
                                        TextBox txt_Funds = (TextBox)grid.Items[i].FindControl("txt_Funds");
                                        if (txt_Funds != null)
                                            txt_Funds.Attributes.Add("onChange", "pageInfoChanged()");
                                    }
                                }
                            }
                        }
                        break;
                }

            }
            catch (Exception ex)
            {
                //return ex.ToString();
            }
        }       
    }

    public string StripTags(string HTML)
    {
        // Removes tags from passed HTML 
        String ret = System.Text.RegularExpressions.Regex.Replace(HTML, "<[^>]*>", "");
           
        //return objRegEx.Replace(HTML, "<[^>]*>", "");
        return ret;
    }

    public static String ToRawMoney(String input)
    {
        String ret = input.Replace("$","");
        ret = ret.Replace(",", "");

        return ret;
    }

    public void sendEmail(string st_subject, string st_body, string st_receivers)
    {
        try
        {
            if (st_receivers.Trim() != "")
            {
                GK3_Driver mydrive = new GK3_Driver();
                System.Data.DataSet myds = new DataSet();
                myds = mydrive.AllUserINFO(HttpContext.Current.User.Identity.Name.ToString());

                string erroremailuser = myds.Tables[0].Rows[0]["txt_email"].ToString();

                MailMessage mm = new MailMessage("Perkins@sctechsystem.edu", st_receivers);

                if (HttpContext.Current.Server.MachineName.ToLower() == "vdogwood")
                    mm.Subject = "TESTING - " + st_subject;
                else
                    mm.Subject = st_subject;

                mm.Bcc.Add("lowryr@sctechsystem.edu,vu@sctechsystem.edu");

                mm.IsBodyHtml = true;
                mm.Body = st_body;
                SmtpClient smtp = new SmtpClient();
                smtp.UseDefaultCredentials = true;
                smtp.Send(mm);
            }
        }
        catch { }
    }


    public void sendNoticeEmail(string st_subject, string st_body, string st_receivers)
    {
        try
        {

            //GK3_Driver mydrive = new GK3_Driver();
            //System.Data.DataSet myds = new DataSet();
            //myds = mydrive.AllUserINFO(HttpContext.Current.User.Identity.Name.ToString());

            //string erroremailuser = myds.Tables[0].Rows[0]["txt_email"].ToString();


            MailMessage mm = new MailMessage("Perkins@sctechsystem.edu", st_receivers);
            //  MailMessage mm = new MailMessage("Perkins@sctechsystem.edu", st_receivers);
            if(HttpContext.Current.Server.MachineName.ToLower() == "vdogwood")
                mm.Subject = "TESTING " + st_subject;
            else 
                mm.Subject = st_subject;
           
             mm.Bcc.Add("lowryr@sctechsystem.edu,vu@sctechsystem.edu");

            mm.IsBodyHtml = true;
            mm.Body = st_body;
            SmtpClient smtp = new SmtpClient();
            smtp.UseDefaultCredentials = true;
            smtp.Send(mm);
        }
        catch (Exception ex)
        {
        }

    }


    public static String convertPToD(String input)
    {
        String output = String.Empty;
        if (Regex.IsMatch(input, @"(^\(.+\)$)"))
        {
            output = Regex.Replace(input, @"[(\$)]", "");
            return "-" + output;
        }
        else
        {
            return Regex.Replace(input, @"[\$]", "");
        }
    }

}
