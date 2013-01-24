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
using System.Web.Configuration;
public partial class LocalPlan_Transfer_ValidationErrors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Request.QueryString["id"] != null)
        //{
        //    String connectionstring = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString1"].ConnectionString;

        //    string errorcode = Request.QueryString["id"].ToString();
        //    SqlConnection myconn = new SqlConnection(connectionstring);
        //    SqlCommand mycomm = new SqlCommand("pr_at_amendment_transfer_validation_errors_get", myconn);
        //    mycomm.CommandType = CommandType.StoredProcedure;
        //    mycomm.Parameters.AddWithValue("p_key_err_msg_amndmnt_hdr_id", errorcode);
        //    if (myconn.State == ConnectionState.Closed)
        //    {
        //        myconn.Open();
        //    }
        //    DataSet myds = new DataSet();
        //    SqlDataAdapter myda = new SqlDataAdapter(mycomm);
        //    myda.Fill(myds);

        //    RadGrid1.DataSource = myds.Tables[0]; 
        //    RadGrid1.DataBind();
        //}
    }
}
