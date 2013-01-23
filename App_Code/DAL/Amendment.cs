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
using System.Configuration;
using System.Web.Configuration;

/// <summary>
/// Summary description for Amendment
/// </summary>
public class Amendment
{
	public Amendment()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static String del_Unfinished_Amendment(int aid, String ssid)
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
        catch(Exception ex)
        {
            return ex.ToString();
        }
        return "1";
    }


    public static String Activity_Transaction_Status_Update(int aid, int sid)
    {
        GK3_Driver gk3 = new GK3_Driver();
        SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);

        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        SqlCommand mycom = new SqlCommand("pr_act_transaction_status_upd", myconn);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = aid;
        mycom.Parameters.Add("@p_flg_key_transaction_status_id", SqlDbType.Int).Value = sid;

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
