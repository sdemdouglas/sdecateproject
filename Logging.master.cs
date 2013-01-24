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
using System.Configuration;
using System.Web.Configuration;

public partial class Logging : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Account_Information myaaccinfo = new Account_Information();
            txt_EMPGuid.Text = myaaccinfo.ReturnGuidFrom_AD(HttpContext.Current.User.Identity.Name.ToString());
            try
            {
                txt_EMPID.Text = myaaccinfo.Return_EmpID(txt_EMPGuid.Text);
                txt_EMPRoleID.Text = myaaccinfo.Return_EmpRoleid(txt_EMPGuid.Text);
            }
            catch
            {
                Response.Redirect("access_denied.aspx");
            }

            myaaccinfo.Dispose();

            Site_EventLoggin obj_logevent = new Site_EventLoggin();
            obj_logevent.writeLogg(txt_EMPID.Text + " with Guid " + txt_EMPGuid.Text + " has hit the master page at time: " + System.DateTime.Now.ToString());
            obj_logevent.Dispose();

            /* Check if user is enabled */

            SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_Grants"].ConnectionString);
            SqlCommand mycomm = new SqlCommand("pr_scs_college_user_status_get", myconn);
            mycomm.CommandType = CommandType.StoredProcedure;
            mycomm.Parameters.AddWithValue("@key_user_id", txt_EMPID.Text);

            if (myconn.State == ConnectionState.Closed)
                myconn.Open();

            SqlDataReader dr = mycomm.ExecuteReader();

            if (dr.HasRows)
                while (dr.Read())
                {
                    if (((bool)dr["flg_enabled"]) == false)
                        Response.Redirect(WebConfigurationManager.AppSettings.Get("AppLocation").ToString() + "/ErrorHandler.aspx?err=104");
                }

            mycomm.Dispose();
            myconn.Dispose();
        }
    }
   
}
