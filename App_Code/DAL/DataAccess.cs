using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;

/// <summary>
/// Summary description for DataAccess
/// </summary>
public class DataAccess
{
	public DataAccess()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string GlobalconnectionString
    {
        get { return WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString; }
    }

    public static string getConnStr()
    {
        return WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString;         
    }

    public SqlConnection IT_CONNECTION
    {
        get
        {
            SqlConnection mycon = new SqlConnection(GlobalconnectionString);
            try
            {
                if (mycon.State != ConnectionState.Open)
                {
                    mycon.Open();
                }
            }
            catch
            {
                mycon.Close();
                mycon.Open();
            }
            return mycon;
        }
    }

    public static SqlConnection DataConnection()
    {
        SqlConnection mycon = new SqlConnection(getConnStr());
        try
        {
            if (mycon.State != ConnectionState.Open)
            {
                mycon.Open();
            }
        }
        catch
        {
            mycon.Close();
            mycon.Open();
        }
        return mycon;
    }

    public SqlDataReader getNarrativeDetails(int Nid)
    {
        SqlConnection mycon = new SqlConnection(GlobalconnectionString);
        SqlDataReader mydr;
        SqlCommand mycom = new SqlCommand("pr_lp_local_plan_narrative_get", mycon);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_local_plan_narrative_id", SqlDbType.Int).Value = Nid;
        
        if (mycon.State == ConnectionState.Closed)
        {
            mycon.Open();
        }

        mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);
        return mydr;
    }

    public SqlDataReader getLocalPlan(int iCid, int iFy)
    {
        SqlConnection mycon = new SqlConnection(GlobalconnectionString);
        SqlDataReader mydr;
        SqlCommand mycom = new SqlCommand("pr_lp_local_plan_get", mycon);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_college_id", SqlDbType.Int).Value = iCid;
        mycom.Parameters.Add("@p_nbr_fiscal_year", SqlDbType.Int).Value = iFy;

        if (mycon.State == ConnectionState.Closed)
        {
            mycon.Open();
        }        
        
        mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);
       
        return mydr;
    }

    public String updateLocalPlan(int iLid, decimal dYa, bool bLock)
    {
        SqlConnection mycon = new SqlConnection(GlobalconnectionString);
        SqlDataReader mydr;
        SqlCommand mycom = new SqlCommand("pr_lp_local_plan_upd", mycon);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_local_plan_id", SqlDbType.Int).Value = iLid;
        mycom.Parameters.Add("@nbr_yearly_appropiation", SqlDbType.Money).Value = dYa;
        mycom.Parameters.Add("@flg_locked", SqlDbType.Bit).Value = bLock;
        mycom.Parameters.Add("@flg_accepted_assurances", SqlDbType.Bit).Value = false;

        if (mycon.State == ConnectionState.Closed)
        {
            mycon.Open();
        } 

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "1";
    }

    public String insertLocalPlan(int iCid, int iFy, decimal dYa, bool bLock, String sCreUser)
    {
        String new_lp_id = "";

        SqlCommand mycom = new SqlCommand("pr_lp_local_plan_ins", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_college_id", SqlDbType.Int).Value = iCid;
        mycom.Parameters.Add("@p_nbr_fiscal_year", SqlDbType.Int).Value = iFy;
        mycom.Parameters.Add("@p_key_local_plan_level_id", SqlDbType.Int).Value = 101;
        mycom.Parameters.Add("@p_nbr_yearly_appropriation", SqlDbType.Money).Value = dYa;
        mycom.Parameters.Add("@p_txt_created_user", SqlDbType.VarChar).Value = sCreUser;

        //mycom.Parameters.Add("@p_flg_locked", SqlDbType.Bit).Value = bLock;
       
        
        SqlParameter outPa = mycom.Parameters.Add("@output_key_local_plan_id", SqlDbType.Int);
        outPa.Direction = ParameterDirection.ReturnValue;

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return outPa.Value.ToString();
    }

    public String insertActivity(int iLpid, String sAn, String sAd, int iAt, String sCid, int iC, int iFcid, int ikat, int iFsid)
    {
        SqlCommand mycom = new SqlCommand("pr_act_activity_ins", IT_CONNECTION);
        //SqlCommand mycom = new SqlCommand("pr_act_funded_activity_ins", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_local_plan_id", SqlDbType.Int).Value = iLpid;
        mycom.Parameters.Add("@txt_activity_name", SqlDbType.VarChar).Value = sAn;
        mycom.Parameters.Add("@txt_activity_desc", SqlDbType.VarChar).Value = sAd;
        mycom.Parameters.Add("@key_fa_activity_type_id", SqlDbType.Int).Value = iAt;
        mycom.Parameters.Add("@txt_activity_core_indicator_desc", SqlDbType.VarChar).Value = sCid;
        mycom.Parameters.Add("@key_category_id", SqlDbType.Int).Value = iC;
        mycom.Parameters.Add("@key_function_code_id", SqlDbType.Int).Value = iFcid;

        mycom.Parameters.Add("@flg_is_amendment", SqlDbType.Bit).Value = 0;
        mycom.Parameters.Add("@key_fund_source_id", SqlDbType.Int).Value = iFsid;
        mycom.Parameters.Add("@key_activity_type_id", SqlDbType.Int).Value = ikat;

        SqlParameter RetVal = mycom.Parameters.Add("RetVal", SqlDbType.Int);
        RetVal.Direction = ParameterDirection.ReturnValue;

        try
        {
            mycom.ExecuteNonQuery();            
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return RetVal.Value.ToString();
    }

    public int insertNewActivity(int aid, String sNewName, String sNewDesc, String sNewCoreInd)
    {
        SqlCommand mycom = new SqlCommand("pr_act_change_request_ins", IT_CONNECTION);
        //SqlCommand mycom = new SqlCommand("pr_act_funded_activity_ins", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = aid;
        mycom.Parameters.Add("@txt_activity_name_new", SqlDbType.VarChar).Value = sNewName;
        mycom.Parameters.Add("@txt_activity_desc_new", SqlDbType.VarChar).Value = sNewDesc;
        mycom.Parameters.Add("@txt_activity_core_indicator_desc_new", SqlDbType.VarChar).Value = sNewCoreInd;
       
        SqlParameter RetVal = mycom.Parameters.Add("RetVal", SqlDbType.Int);
        RetVal.Direction = ParameterDirection.ReturnValue;

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return 0;
        }
        return Convert.ToInt32(RetVal.Value.ToString());
    }

    public void insertNewNewCoreInd(int acid, int aId, int cI)
    {
        SqlCommand mycom = new SqlCommand("pr_act_change_core_indicator_NEW_ins", IT_CONNECTION);
       
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_activity_change_id", SqlDbType.Int).Value = acid;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = aId;
        mycom.Parameters.Add("@key_core_indicator_new_id", SqlDbType.Int).Value = cI;
        
        SqlParameter RetVal = mycom.Parameters.Add("RetVal", SqlDbType.Int);
        RetVal.Direction = ParameterDirection.ReturnValue;

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            //return 0;
        }
        //return RetVal.Value;
    }


    public String updateActivityChangeRequest(int acid, int aid, String actNameNew, String actDescNew, String actCoreIndDesNew, bool flgApprove)
    {
        SqlCommand mycom = new SqlCommand("pr_act_change_request_upd", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;

        mycom.Parameters.Add("@key_act_change_id", SqlDbType.Int).Value = acid;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = aid;
        mycom.Parameters.Add("@txt_activity_name_new", SqlDbType.VarChar).Value = actNameNew;
        mycom.Parameters.Add("@txt_activity_desc_new", SqlDbType.VarChar).Value = actDescNew;
        mycom.Parameters.Add("@txt_activity_core_indicator_desc_new", SqlDbType.VarChar).Value = actCoreIndDesNew;
        mycom.Parameters.Add("@flg_approved", SqlDbType.Bit).Value = flgApprove;
       
        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "0";
    }

    public String updateActivityChangeRequestCoreInd(int acid, int aid, String actNameNew, String actDescNew, String actCoreIndDesNew, bool flgApprove)
    {
        SqlCommand mycom = new SqlCommand("pr_act_change_request_upd", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;

        mycom.Parameters.Add("@key_act_change_id", SqlDbType.Int).Value = acid;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = aid;
        mycom.Parameters.Add("@txt_activity_name_new", SqlDbType.VarChar).Value = actNameNew;
        mycom.Parameters.Add("@txt_activity_desc_new", SqlDbType.VarChar).Value = actDescNew;
        mycom.Parameters.Add("@txt_activity_core_indicator_desc_new", SqlDbType.VarChar).Value = actCoreIndDesNew;
        mycom.Parameters.Add("@flg_approved", SqlDbType.Bit).Value = flgApprove;

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "0";
    }


   
    public String updateActivity(int iAid, int iLpid, String sAn, String sAd, int iAt, String sCid, int iC, int iFcid, int ikat, string sSon, int iKlid, bool bL, bool bA, bool bIsAme, String sfrid, int iFsid)
    {
        SqlCommand mycom = new SqlCommand("pr_act_activity_upd", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = iAid;
        mycom.Parameters.Add("@key_local_plan_id", SqlDbType.Int).Value = iLpid;
        mycom.Parameters.Add("@txt_activity_name", SqlDbType.VarChar).Value = sAn;
        mycom.Parameters.Add("@txt_activity_desc", SqlDbType.VarChar).Value = sAd;

        if (iAt != -1) mycom.Parameters.Add("@key_fa_activity_type_id", SqlDbType.Int).Value = iAt;
       
        mycom.Parameters.Add("@txt_activity_core_indicator_desc", SqlDbType.VarChar).Value = sCid;
        
        if(iC !=-1)  mycom.Parameters.Add("@key_category_id", SqlDbType.Int).Value =  iC;
        if(iFcid !=-1) mycom.Parameters.Add("@key_function_code_id", SqlDbType.Int).Value = iFcid;

        mycom.Parameters.Add("@txt_funds_reduction_impact_desc", SqlDbType.VarChar).Value = sfrid;
        mycom.Parameters.Add("@flg_is_amendment", SqlDbType.Bit).Value = bIsAme;
        if (iFsid != -1) mycom.Parameters.Add("@key_fund_source_id", SqlDbType.Int).Value = iFsid;
        mycom.Parameters.Add("@key_activity_type_id", SqlDbType.Int).Value = ikat;
        mycom.Parameters.Add("@txt_system_office_notes", SqlDbType.VarChar).Value = sSon;
        mycom.Parameters.Add("@key_level_id", SqlDbType.Int).Value = iKlid;
        mycom.Parameters.Add("@flg_approved", SqlDbType.Bit).Value = bA;
        mycom.Parameters.Add("@flg_locked", SqlDbType.Bit).Value = bL;
        //mycom.Parameters.Add("@key_amendment_reason_id", SqlDbType.Int).Value = iArid;
        
        
        
        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "0";
    }


    public String updateFundedActivityLineItems(int ika, int ikli, Decimal dAmt)
    {
        SqlCommand mycom = new SqlCommand("pr_act_activity_line_items_upd", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = ika;
        mycom.Parameters.Add("@key_line_item_type_id", SqlDbType.Int).Value = ikli;
        mycom.Parameters.Add("@amt_amount", SqlDbType.Money).Value = dAmt;

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "0";
    }


    public String insertFundedActivityCoreIndicator(int ika, int iCid)
    {
        SqlCommand mycom = new SqlCommand("pr_act_activity_core_indicator_ins", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = ika;
        mycom.Parameters.Add("@key_core_indicator_id", SqlDbType.Int).Value = iCid;
        
        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "0";
    }

    

    public String updateLocalPlanLevel(int iCurrentLevel, int iNextLevel)
    {
        SqlCommand mycom = new SqlCommand("pr_lp_local_plan_level_upd", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_local_plan_id", SqlDbType.Int).Value = iCurrentLevel;
        mycom.Parameters.Add("@p_key_local_plan_level_id", SqlDbType.Int).Value = iNextLevel;

        SqlParameter RetVal = mycom.Parameters.Add("RetVal", SqlDbType.Int);
        RetVal.Direction = ParameterDirection.ReturnValue;

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            //return ex.ToString();
            return "-1";
        }
        return RetVal.Value.ToString();
    }

    public String approveChangeRequest(int iACid, int iAid)
    {
        SqlCommand mycom = new SqlCommand("pr_act_change_request_approve", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@key_activity_change_id", SqlDbType.Int).Value = iACid;
        mycom.Parameters.Add("@key_activity_id", SqlDbType.Int).Value = iAid;

        SqlParameter RetVal = mycom.Parameters.Add("RetVal", SqlDbType.Int);
        RetVal.Direction = ParameterDirection.ReturnValue;

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return RetVal.Value.ToString();
    }

    public SqlDataReader getAvialableFund(int iLpId)
    {
        SqlConnection mycon = new SqlConnection(GlobalconnectionString);
        SqlDataReader mydr;
        SqlCommand mycom = new SqlCommand("pr_lp_local_plan_balance_get", mycon);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_local_plan_id", SqlDbType.Int).Value = iLpId;
       
        if (mycon.State == ConnectionState.Closed)
        {
            mycon.Open();
        }

        mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);

        return mydr;
    }

    public SqlDataReader getSysMessage(int iMid)
    {
        SqlConnection mycon = new SqlConnection(GlobalconnectionString);
        SqlDataReader mydr;
        SqlCommand mycom = new SqlCommand("pr_perkins_sys_message_get", mycon);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_perkins_sys_message_id", SqlDbType.Int).Value = iMid;

        if (mycon.State == ConnectionState.Closed)
        {
            mycon.Open();
        }

        mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);

        return mydr;
    }

    public SqlDataReader getAccountabilityNarrativeDetails(int Nid)
    {
        SqlConnection mycon = new SqlConnection(GlobalconnectionString);
        SqlDataReader mydr;
        SqlCommand mycom = new SqlCommand("pr_acc_accountability_narrative_get", mycon);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_accountability_narrative_rec_id", SqlDbType.Int).Value = Nid;

        if (mycon.State == ConnectionState.Closed)
        {
            mycon.Open();
        }

        mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);
        return mydr;
    }

    public String updateAccountabilityNarrative(int p_key_accountability_narrative_rec_id,
                                                String p_txt_narrative_response,
                                                String p_txt_updated_user,
                                                String p_txt_system_office_notes)
    {
        SqlCommand mycom = new SqlCommand("pr_acc_accountability_narrative_upd", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;

        mycom.Parameters.Add("@p_key_accountability_narrative_rec_id", SqlDbType.Int).Value = p_key_accountability_narrative_rec_id;
        mycom.Parameters.Add("@p_txt_narrative_response", SqlDbType.VarChar).Value = p_txt_narrative_response;
        mycom.Parameters.Add("@p_txt_updated_user", SqlDbType.VarChar).Value = p_txt_updated_user;
        mycom.Parameters.Add("@p_txt_system_office_notes", SqlDbType.VarChar).Value = p_txt_system_office_notes;
     
        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "1";
    }

    public String updateAccountabilityEnrollment(int p_key_cte_enrollment_id,
                                                 int p_nbr_students,
                                                 String p_txt_updated_by)
    {
        SqlCommand mycom = new SqlCommand("pr_acc_cte_enrollment_udp", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;

        mycom.Parameters.Add("@p_key_cte_enrollment_id", SqlDbType.Int).Value = p_key_cte_enrollment_id;
        if (p_nbr_students != -999999)
            mycom.Parameters.Add("@p_nbr_students", SqlDbType.Int).Value = p_nbr_students;
        mycom.Parameters.Add("@p_txt_updated_by", SqlDbType.VarChar).Value = p_txt_updated_by;
       

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "1";
    }

   public String updateAccountabilityInfo(int p_key_accountability_id, String p_txt_note)
                                          //1/19/2012 took out as second parameter       int p_key_accountability_level_id,
                                                
    {
        SqlCommand mycom = new SqlCommand("pr_acc_accountability_upd", IT_CONNECTION);
        mycom.CommandType = CommandType.StoredProcedure;

        mycom.Parameters.Add("@p_key_accountability_id", SqlDbType.Int).Value = p_key_accountability_id;
    //    mycom.Parameters.Add("@p_key_accountability_level_id ", SqlDbType.Int).Value = p_key_accountability_level_id;
        mycom.Parameters.Add("@p_txt_note", SqlDbType.VarChar).Value = p_txt_note;

        try
        {
            mycom.ExecuteNonQuery();
            IT_CONNECTION.Close();
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
        return "1";
    }
}
