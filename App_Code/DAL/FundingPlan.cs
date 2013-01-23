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
/// Summary description for FundingPlan
/// </summary>
public class FundingPlan
{
	public FundingPlan()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static SqlDataReader get_Header_Info(int fph_id )
    {
        GK3_Driver gk3 = new GK3_Driver();
        SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);

        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        SqlCommand mycom = new SqlCommand("pr_fp_funding_plan_hdr_get", myconn );
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_funding_plan_hdr_id", SqlDbType.Int).Value  = fph_id;

        SqlDataReader mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);
        
        return mydr;
    }


    public static String update_FundingPlan(int lp_id, int fph_id, int nlv_id, String cs)
    {
        GK3_Driver gk3 = new GK3_Driver();
        SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);
        string returnedvalue = "101";
        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        SqlCommand mycom = new SqlCommand("pr_fp_funding_plan_level_upd", myconn);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_local_plan_id", SqlDbType.Int).Value = lp_id;
        mycom.Parameters.Add("@p_key_funding_plan_hdr_id", SqlDbType.Int).Value = fph_id;
        mycom.Parameters.Add("@p_key_funding_plan_level_to_id", SqlDbType.VarChar).Value = nlv_id;
        SqlParameter myparam = new SqlParameter("l_perkins_sys_message", SqlDbType.NVarChar);
        myparam.Direction = ParameterDirection.ReturnValue;
        mycom.Parameters.Add(myparam);

        try
        {
            mycom.ExecuteNonQuery();
             returnedvalue = mycom.Parameters["l_perkins_sys_message"].Value.ToString();
        }
        catch(Exception ex)
        {
            return ex.ToString();
        }

        return returnedvalue;// "101";
    }

    public static String get_Funding_Plan_Level(int aid)
    {
        String returnedvalue = string.Empty;
        GK3_Driver gk3 = new GK3_Driver();
        SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);

        if (myconn.State != ConnectionState.Open)
        {
            myconn.Open();
        }

        SqlCommand mycom = new SqlCommand("pr_fp_funding_plan_level_get", myconn);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_activity_id", SqlDbType.Int).Value = aid;
        SqlParameter myparam = new SqlParameter("@l_key_funding_plan_hdr_id", SqlDbType.Int);
        myparam.Direction = ParameterDirection.ReturnValue;
        mycom.Parameters.Add(myparam);

       // SqlDataReader mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);

        try
        {
            mycom.ExecuteNonQuery();
            returnedvalue = mycom.Parameters["@l_key_funding_plan_hdr_id"].Value.ToString();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }

        return returnedvalue;
    }
}
