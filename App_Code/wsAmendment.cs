using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;

/// <summary>
/// Summary description for wsAmendment
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class wsAmendment : System.Web.Services.WebService {

    public wsAmendment () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    public String del_Unfinished_Amendment()
    {
        GK3_Driver gk3 = new GK3_Driver();
        SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);

        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        SqlCommand mycom = new SqlCommand("pr_at_amendment_incomplete_amd_del", myconn);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_activity_id", SqlDbType.Int).Value = Convert.ToInt32(Session[Session.SessionID + "keyactiveID"].ToString());

        try
        {
            mycom.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "1";
    }

    [WebMethod]
    public String del_Unfinished_Amendment2(int aid)
    {
        GK3_Driver gk3 = new GK3_Driver();
        SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);

        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        SqlCommand mycom = new SqlCommand("pr_at_amendment_incomplete_amd_del", myconn);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_activity_id", SqlDbType.Int).Value = aid;

        try
        {
            mycom.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "1";
    }
}

