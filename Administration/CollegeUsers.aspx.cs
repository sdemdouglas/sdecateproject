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
using System.Text;
using System.Data.SqlClient;
using Telerik.WebControls;



public partial class Administration_CollegeInformation : System.Web.UI.Page
{
    static string strID;
    protected void Page_Load(object sender, EventArgs e)
    {
 
      
        if (!IsPostBack)
        {  
              CB_UserEnabled.Checked = true;
            strID = "-1";
            try
            {
                #region UserList
            

                DD_CollegeList.DataSource = sqlCollegeDs;
                DD_CollegeList.DataTextField = "txt_college_name";
                DD_CollegeList.DataValueField = "key_college_id";
                DD_CollegeList.DataBind();

                #endregion
            }
            catch (Exception ex)
            {
                #region Error Handling
             //   Response.Write(ex.Message);
                #endregion
            }
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {

    }



    protected void RadGrid1_EditCommand(object source, Telerik.WebControls.GridCommandEventArgs e)
    {

        GridDataItem item = (GridDataItem)e.Item;
        string strID = item.GetDataKeyValue("key_user_id").ToString();


        sqlDS_userroleDetail.SelectParameters.Clear();
        sqlDS_userroleDetail.SelectParameters.Add("keyuserid", strID);
    }
   
    protected void RD_GD_UserRoleDetail_DeleteCommand(object source, GridCommandEventArgs e)
    {
 
    }
    protected void DD_AllUSERS_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            strID = "-1";
            #region set LB_SECRoles to unselected
            foreach (ListItem li in LB_SECRoles.Items)
            {
                li.Selected = false;
            }
            #endregion



            #region Get Key_USER_ID of select User and Set Variable strID to it
            String sqlconnection_string = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ToString();
            SqlConnection myconn = new SqlConnection(sqlconnection_string);
            SqlCommand mycomm = new SqlCommand("select key_user_id from scs_college_users where txt_security_quid ='" + DD_AllUSERS.SelectedValue.ToString() + "'", myconn) ;
            if (myconn.State != ConnectionState.Open)
                myconn.Open();
            try
            {
                 strID = mycomm.ExecuteScalar().ToString();
               
            }
            catch (Exception ex)
            {
                strID = "-1";
            }
            #endregion

            if (strID != "-1")
            {
                #region Fill DataReader intialized with Variable name myrd with Details on Selected User
                sqlDS_userroleDetail.SelectParameters.Clear();
                sqlDS_userroleDetail.SelectParameters.Add("keyuserid", strID);
                SqlDataReader myrd;
                sqlDS_userroleDetail.DataSourceMode = SqlDataSourceMode.DataReader;
                myrd = (SqlDataReader)sqlDS_userroleDetail.Select(DataSourceSelectArguments.Empty);
                #endregion
                #region Set the College DropDown to the select Users college
                string collegeid = "-1";

                while (myrd.Read())
                {

            
                    ListItem LB_ITEM = LB_SECRoles.Items.FindByValue(myrd["key_role_id"].ToString());
                    LB_ITEM.Selected = true;
                    collegeid = myrd["key_college_id"].ToString();
                    CB_UserEnabled.Checked = (bool)myrd["flg_enabled"];
                    TXT_contactNumber.Text = myrd["txt_phone_number"].ToString();
                }

                ListItem dd_ITEM = DD_CollegeList.Items.FindByValue(collegeid);
                int inval = DD_CollegeList.Items.IndexOf(dd_ITEM);

                DD_CollegeList.SelectedIndex = inval;
                #endregion
            }

            String sqlconnection_string1 = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ToString();
            SqlConnection myconn1 = new SqlConnection(sqlconnection_string);
            SqlCommand mycomm1 = new SqlCommand("select displayname, emailadd,samaccountname from gk_adlist where quid ='" + DD_AllUSERS.SelectedValue.ToString() + "'", myconn1);
            if (myconn1.State != ConnectionState.Open)
                myconn1.Open();
            SqlDataReader mydr = mycomm1.ExecuteReader(CommandBehavior.CloseConnection);
            while (mydr.Read())
            {
                hdn_display.Value = mydr["displayname"].ToString();
                hdn_email.Value = mydr["emailadd"].ToString();
                hdn_username.Value = mydr["samaccountname"].ToString();
            }

         }
        catch (Exception ex)
        {
            #region Error Handling
         //  Response.Write(ex.Message);
            #endregion
        }
    
    }



    protected void add_db_user(string username)
{
    try
    {
        String sqlconnection_string = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ToString();
        SqlConnection myconn = new SqlConnection(sqlconnection_string);
        SqlCommand mycomm = new SqlCommand("select samaccountname from gk_adlist where quid ='" + username + "'", myconn);
        if (myconn.State != ConnectionState.Open)
            myconn.Open();
        string shortname = mycomm.ExecuteScalar().ToString();
        string longname = "sctcs" + @"\" + shortname;


        StringBuilder mystring = new StringBuilder();
        mystring.Append("use sctcs_perkins; exec sp_adduser '");
        mystring.Append("sctcs");
        mystring.Append(@"\");
        mystring.Append(shortname);
        mystring.Append("', '");
        mystring.Append("sctcs");
        mystring.Append(@"\");
        mystring.Append(shortname);
        mystring.Append("','dbo'");
       
        

        string sqlADDUSERstring = "use sctcs_perkins; create login [" + mystring + "] from WINDOWS";
        string sqlRolestring = "use sctcs_perkins; exec sp_adduser '" + mystring + "', '" + mystring +"','dbo'";

        SqlCommand command1_sql = new SqlCommand();
        command1_sql.CommandText = mystring.ToString().Replace("//", @"/");// sqlRolestring;
        command1_sql.Connection = myconn;
        command1_sql.ExecuteNonQuery();
    }
    catch(Exception ex)
    {
        string mi;
        mi = ex.Message.ToString();
        string a;
        a = "filler";
        throw new Exception(mi);

    }






}


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        { 

            SQLDS_INSUSR.Insert();
            Label2.Visible = false;
            try
            {
         //       add_db_user(DD_AllUSERS.SelectedValue.ToString());
                Label2.Visible = false;
            }
            catch
            {
                Label2.Visible = true;
            }

            String sqlconnection_string = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ToString();
            SqlConnection myconn = new SqlConnection(sqlconnection_string);
            SqlCommand mycomm = new SqlCommand("select key_user_id from scs_college_users where txt_security_quid ='" + DD_AllUSERS.SelectedValue.ToString() + "'", myconn);
            if (myconn.State != ConnectionState.Open)
                myconn.Open();
            try
            {
                strID = mycomm.ExecuteScalar().ToString();

            }
            catch (Exception ex)
            {
                strID = "-1";
            }

            hdn_strid.Value = strID;

            sqlDS_GetAllUsers_nRoles.Select(DataSourceSelectArguments.Empty);
            SQLDS_USR_Role_EDIT.Insert();
            RadGrid1.DataBind();
            Label2.Visible = false;
            

        }
        catch
        {
            Label2.Visible = true;
        }

        sqlds_GrantUsers.Select(DataSourceSelectArguments.Empty);
        RADG_Userlist.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GK3_Driver myobj = new GK3_Driver();
        myobj.ReinstailizeAD_Table();
        SqlDS_ALLADSTAFF.Select(DataSourceSelectArguments.Empty);
            DD_AllUSERS.DataBind();

    }
    protected void DD_CollegeList_DataBound(object sender, EventArgs e)
    {
        ListItem myitem = new ListItem("Select a College","-1");
        DD_CollegeList.Items.Insert(0, myitem);
    }
    protected void RadGrid1_DeleteCommand(object source, GridCommandEventArgs e)
    {
      string ID = (e.Item as GridDataItem)["key_user_id"].Text;
        sqlDS_GetAllUsers_nRoles.DeleteParameters.Clear();
        sqlDS_GetAllUsers_nRoles.DeleteParameters.Add("userid", ID);
        sqlDS_GetAllUsers_nRoles.Delete();
        
      
    }
    protected void DD_AllUSERS_DataBound(object sender, EventArgs e)
    {
        ListItem myitem = new ListItem("Select a User", "-1");
        DD_AllUSERS.Items.Insert(0, myitem);
    }
    protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            string contactName = dataItem["txt_display_name"].Text;

            LinkButton button = dataItem["DeleteColumn"].Controls[0] as LinkButton;
            button.Attributes["onclick"] = "return confirm('Are you sure you want to delete User: " +
            contactName + "?')";
        }
    }









    protected void DD_Roles_Edit_DataBound(object sender, EventArgs e)
    {

    }

    protected void RADG_Userlist_ItemCommand(object source, GridCommandEventArgs e)
    {
        if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
        {
            DropDownList DD_Roles_Edit = e.Item.FindControl("DD_Roles_Edit") as DropDownList;
            HiddenField hf_Role = e.Item.FindControl("hf_Role") as HiddenField;

            if (DD_Roles_Edit != null)
            {
                hf_Role.Value = DD_Roles_Edit.SelectedValue.ToString();
            }

            DropDownList DD_College_Edit = e.Item.FindControl("DD_College_Edit") as DropDownList;
            HiddenField hf_College = e.Item.FindControl("hf_College") as HiddenField;

            if (DD_College_Edit != null)
            {
                hf_College.Value = DD_College_Edit.SelectedValue.ToString();
            }


        }
    }


    protected void RADG_Userlist_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
        {
            DropDownList DD_Roles_Edit = e.Item.FindControl("DD_Roles_Edit") as DropDownList;
            HiddenField hf_Role = e.Item.FindControl("hf_Role") as HiddenField;

            if (DD_Roles_Edit != null)
            {
                DD_Roles_Edit.DataBind();
                ListItem li = new ListItem("", "-1");
                if (DD_Roles_Edit.Items.IndexOf(li) < 0)
                    DD_Roles_Edit.Items.Insert(0, li);


                DD_Roles_Edit.SelectedIndex = DD_Roles_Edit.Items.IndexOf(DD_Roles_Edit.Items.FindByValue(hf_Role.Value));
            }

            DropDownList DD_College_Edit = e.Item.FindControl("DD_College_Edit") as DropDownList;
            HiddenField hf_College = e.Item.FindControl("hf_College") as HiddenField;

            if (DD_College_Edit != null)
            {
                DD_College_Edit.DataBind();
                ListItem li = new ListItem("", "-1");
                if (DD_College_Edit.Items.IndexOf(li) < 0)
                    DD_College_Edit.Items.Insert(0, li);


                DD_College_Edit.SelectedIndex = DD_College_Edit.Items.IndexOf(DD_College_Edit.Items.FindByValue(hf_College.Value));
            }


        }


    }

    protected void RADG_Userlist_DeleteCommand(object source, Telerik.WebControls.GridCommandEventArgs e)
    {

        string ID = (e.Item as GridDataItem)["key_user_id"].Text;
        sqlds_GrantUsers.DeleteParameters.Clear();
        sqlds_GrantUsers.DeleteParameters.Add("userid", ID);
        sqlds_GrantUsers.Delete();


        //sqlds_GrantUsers.DeleteParameters.Clear();
        //string ID = (e.Item as GridDataItem)["key_user_id"].Text;
        //sqlds_GrantUsers.DeleteParameters.Add("key_user_id", ID);
        //sqlds_GrantUsers.DeleteParameters.Add("key_role_id", "104");
        //sqlds_GrantUsers.Delete();

    }
}
