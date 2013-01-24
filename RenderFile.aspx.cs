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

public partial class RenderFile : System.Web.UI.Page
{
    string connectionstring = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString;


    protected void Page_Load(object sender, EventArgs e)
    {

        int docid = Convert.ToInt32(Request.QueryString["intid"]);

        using (SqlConnection myConnection = new SqlConnection(connectionstring))
        {

            const String SQL = "pr_doc_files_get";
            SqlCommand myCommand = new SqlCommand(SQL, myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.Parameters.AddWithValue("Key_doc_file_storage_id", docid);

            myConnection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();

            if (myReader.Read())
            {

                Response.Buffer = true;
                Response.Expires = 0;
                Response.ContentType = myReader["txt_file_mimetype"].ToString();
                Response.AddHeader("Content-transfer-encoding", "binary");
                Response.AddHeader("Content-Disposition", "attachment;filename=" + myReader["txt_file_name"].ToString());



                Response.BinaryWrite((byte[])myReader["bin_binaryFile_data"]);
                Response.Flush();
            }


            myReader.Close();
            myConnection.Close();
        }

    }
}
