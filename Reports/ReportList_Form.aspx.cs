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
using System.Web.Configuration;
using System.Data.SqlClient;

public partial class Reports_ReportList_Form : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HL_Print.NavigateUrl = "Javascript:OpenReport(" + Request.QueryString["planid"].ToString() + "," + Request.QueryString["fiscalyear"].ToString() + ")";

            rbl_Print_Type.SelectedIndex = 0;
        }
      

    }
    protected Boolean getactNumber(int planid,int type)
    {
        
        SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString.ToString());
        SqlCommand mycom = new SqlCommand("pr_lp_nbr_activities_get", myconn);
        mycom.CommandType = CommandType.StoredProcedure;
        mycom.Parameters.Add("@p_key_local_plan_id", SqlDbType.Int).Value = planid;
        mycom.Parameters.Add("@p_key_activity_type_id", SqlDbType.Int).Value = type;

        if (myconn.State == ConnectionState.Closed)
        {
            myconn.Open();
        }
        object o = mycom.ExecuteScalar();
        if (o == null)
        return false;
        else
            return true;
    }
    protected void RadioButtonList1_DataBound(object sender, EventArgs e)
    {
        if (!getactNumber(Convert.ToInt32(Request.QueryString["planid"].ToString()), 101))
        {
            foreach (ListItem li in RadioButtonList1.Items)
            {
                if (li.Value == "rpt_funded_activity")
                { li.Enabled = false;
                Label1.Visible = true;
            }
            }

        }
        if (!getactNumber(Convert.ToInt32(Request.QueryString["planid"].ToString()), 102))
        {
            foreach (ListItem li in RadioButtonList1.Items)
            {
                if (li.Value == "rpt_equipment_activity")
                { li.Enabled = false; Label1.Visible = true; }
            }
        }
    }
}
