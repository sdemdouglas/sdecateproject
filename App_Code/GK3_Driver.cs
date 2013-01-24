using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Collections;
using System.DirectoryServices;
/// <summary>
/// Summary description for GK3_Driver
/// </summary>
public class GK3_Driver
{
	public GK3_Driver()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private string GlobalconnectionString
    {
        get { return WebConfigurationManager.ConnectionStrings["GateKeeper"].ConnectionString; }
    }

    private string AppConnectionString
    {
        get { return WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString; }
    }
    private string m_UserKey;
    public string UserKey
    {
        get
        {
            return m_UserKey;
        }
        set
        {
            m_UserKey = value;
        }
    }
    private string m_UserEmail;
    public string UserEmail
    {
        get
        {
            return m_UserEmail;
        }
        set
        {
            m_UserEmail = value;
        }
    }

    private string m_UserName;
    public string UserName
    {
        get
        {
            return m_UserName;
        }
        set
        {
            m_UserName = value;
        }
    }

    


    private void Add_User(string in_ProviderKey, string in_UserEmail, string in_Username)
    {

        SqlCommand mycomm = new SqlCommand();

        UserKey = in_ProviderKey;
        UserEmail = in_UserEmail;
        UserName = in_Username;
        mycomm = InsUsr();

        mycomm.ExecuteNonQuery();
        mycomm.Connection.Close();
    


    }

    private SqlConnection Gkconnection()
    {
        SqlConnection myconn = new SqlConnection(GlobalconnectionString);
        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        return myconn;
    }

    private SqlConnection Appconnection()
    {
        SqlConnection myconn = new SqlConnection(AppConnectionString);
        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        return myconn;
    }


    private SqlCommand InsUsr()
    {
        SqlCommand mycomm = new SqlCommand("pr_GK_PrimaryUSR_LIST_ins", Gkconnection());
        mycomm.CommandType = CommandType.StoredProcedure;
        mycomm.Parameters.Add("@ProviderUserKey", SqlDbType.NVarChar, 50).Value = UserKey;
        mycomm.Parameters.Add("@useremail", SqlDbType.NVarChar, 50).Value = UserEmail;
        mycomm.Parameters.Add("@gk_username", SqlDbType.NVarChar, 50).Value = UserName;

        return mycomm;


    }

    private SqlCommand GetUsr_ByName_Command()
    {
        SqlCommand mycomm = new SqlCommand("pr_GK_PrimaryUSR_LIST_GET", Gkconnection());
        mycomm.CommandType = CommandType.StoredProcedure;
        mycomm.Parameters.Add("@GKUsername", SqlDbType.NVarChar, 50).Value = UserName;
        return mycomm;
        
    }

    private SqlCommand GetallUserInfo(string inusername)
    {
        SqlCommand mycom = new SqlCommand("pr_SEC_ReturnUSerINfo_byName", Appconnection());
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@username", SqlDbType.NVarChar, 50).Value = inusername;

        return mycom;
    }
    
    public void  PushUsers()
    {



        MembershipUserCollection mycoll = Membership.GetAllUsers();

        foreach (MembershipUser objUser in mycoll)
        {
           
            if(objUser.Email != null)
            Add_User(objUser.ProviderUserKey.ToString(), objUser.Email, objUser.UserName);



        }

    }

    public DataSet AllUserINFO(string InUserName)
    {
        DataSet myds = new DataSet();

        if (InUserName.IndexOf("\\") > 0)
        {
            int startof = InUserName.IndexOf("\\") + 1;
            InUserName = InUserName.Remove(0, startof);
        }
        SqlDataAdapter myda = new SqlDataAdapter(GetallUserInfo(InUserName));
        myda.Fill(myds);
        return(myds);
    }

    public string GetKey_BYUserName(string in_user)
    {

        UserName = in_user;
        SqlCommand mycomm = new SqlCommand();
        mycomm = GetUsr_ByName_Command();
        string returnval =mycomm.ExecuteScalar().ToString();
        mycomm.Connection.Close();
        return (returnval);

    }


   public void ReinstailizeAD_Table()
   {




       DirectoryEntry entry = new DirectoryEntry(@"LDAP://ad.asdfasdf.com");

       //   :636
       DirectorySearcher mySearcher = new DirectorySearcher(entry);
       mySearcher.PageSize = 6000;
       entry.Username = "asdfasdf"; 
       entry.Password = "asdfasdf";
       SearchResultCollection results;

       mySearcher.Filter = "(&(objectClass=user)(objectCategory=person)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))";




       mySearcher.PropertiesToLoad.Add("telephonenumber");

       mySearcher.PropertiesToLoad.Add("department");
       mySearcher.PropertiesToLoad.Add("displayname");
       mySearcher.PropertiesToLoad.Add("objectguid");
       mySearcher.PropertiesToLoad.Add("mail");
       mySearcher.PropertiesToLoad.Add("company");
       mySearcher.PropertiesToLoad.Add("mailnickname");
       mySearcher.PropertiesToLoad.Add("samaccountname");
       mySearcher.PropertiesToLoad.Add("title");


       //  string queryGuid1 = "50d50b492f1dfc4c9fe1b239258bf9c7";


       results = mySearcher.FindAll();



       int i = 0;


     // OleDbConnection dbconn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;data source=" + Server.MapPath("GK_AD_LIST.mdb"));
      // dbconn.Open();
     
       // OleDbCommand dbcomm = new OleDbCommand("select * from gk_adlist", dbconn);
       string truncatetable = @"truncate table gk_adlist";
       SqlCommand mytruncomm = new SqlCommand(truncatetable, Appconnection());
       mytruncomm.ExecuteNonQuery();



       string insertvalue = @"insert into gk_adlist (quid,displayname,emailadd,company,department,phonenumber,samaccountname,title) values (";
       string department = ""; string displayname = ""; string objectguid = ""; string mail = ""; string company = ""; string telephonenumber = ""; string queryGuid = ""; string samaccountname = ""; string title = "";
       foreach (SearchResult resEnt in results)
       {

           {

               ResultPropertyCollection propcoll = resEnt.Properties;

               i++;
               foreach (string key in propcoll.PropertyNames)
               {

                   try
                   {

                       if (key.ToString().Trim().ToLower() == "objectguid")
                       {

                           foreach (byte b in (System.Byte[])resEnt.Properties[key][0])
                           {
                               queryGuid += b.ToString("x2");
                           }





                       }
                       else
                       {

                       }

                       if (key.ToString().Trim().ToLower() == "telephonenumber")
                       {
                           telephonenumber = resEnt.Properties[key][0].ToString().Trim();
                       }
                       if (key.ToString().Trim().ToLower() == "department")
                       { department = replacebadcharacters(resEnt.Properties[key][0].ToString().Trim()); }
                       if (key.ToString().Trim().ToLower() == "displayname")
                       {
                           displayname = replacebadcharacters(resEnt.Properties[key][0].ToString().Trim());
                       }
                       if (key.ToString().Trim().ToLower() == "mail")
                       { mail = replacebadcharacters(resEnt.Properties[key][0].ToString().Trim()); }
                       if (key.ToString().Trim().ToLower() == "samaccountname")
                       { samaccountname = replacebadcharacters(resEnt.Properties[key][0].ToString().Trim()); }
                       if (key.ToString().Trim().ToLower() == "title")
                       { title = replacebadcharacters(resEnt.Properties[key][0].ToString().Trim()); }
                       if (key.ToString().Trim().ToLower() == "company")
                       { company = replacebadcharacters(replacebadcharacters(resEnt.Properties[key][0].ToString().Trim())); }

                  //     Response.Write(key.Trim() + "=" + resEnt.Properties[key][0].ToString().Trim());


                   }
                   catch (Exception ee)
                   {

                  //    Response.Write(ee.Message.ToString());
                   }

               }
               insertvalue += "'" + queryGuid + "','" + displayname + "','" + mail + "','" + company + "','" + department + "','" + telephonenumber + "','" + samaccountname + "','" + title + "')";

               SqlCommand dbcom = new SqlCommand(insertvalue, Appconnection());
               try
               {
                   string test;
                   if (displayname.Trim().Length > 0 && mail.Trim().Length > 0)
                       dbcom.ExecuteNonQuery();
                   dbcom.Connection.Close();
                       test = "4";


               }
               catch (Exception ex)
               {

                   
               }
            //   Response.Write("<br />");

               insertvalue = "insert into gk_adlist (quid,displayname,emailadd,company,department,phonenumber,samaccountname, title) values (";
               department = ""; displayname = ""; objectguid = ""; mail = ""; company = ""; telephonenumber = ""; queryGuid = "";



           }







       }

      // dbconn.Close();
   }
    private string replacebadcharacters(string a)
    {
        try
        {
            if (a.LastIndexOf("'") > 0)
                a = (a.Replace("'", ""));
            if (a.LastIndexOf(":") > 0)
                a = (a.Replace(":", ""));
        }
        catch
        {
        }
        return a;
    }

    public SqlDataReader get_Email_Notice_List(int key_accc_id)
    {
        SqlConnection myconn = new SqlConnection(AppConnectionString);

        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        SqlCommand mycom = new SqlCommand("pr_accountablity_email_recipient", myconn);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_accountability_id", SqlDbType.Int).Value = key_accc_id;
       
        SqlDataReader mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);

        return mydr;
    }

}
