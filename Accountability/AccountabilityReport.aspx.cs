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

public partial class Accountability_AccountabilityReport : System.Web.UI.Page
{    

    protected void Security_LockoutControl_by_LEVELS()
    {
        if (!IsPostBack)
        {
            try
            {
                string levelid = Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString();
                string roleid = Session[Session.SessionID + "roleid"].ToString();

                switch (levelid)
                {
                    case "100":
                        switch (roleid)
                        {
                            case "101":
                                break;
                            default:
                                lnkSubmit.Visible = false;
                                HL_Errors.Visible = false;
                                btn_Save.Visible = false;
                                lnkSubmit.Visible = false;
                                break;
                        }
                        break;

                    case "101":
                        switch (roleid)
                        {
                            case "101":
                                btn_Save.Visible = true;

                                break;
                            default:
                                btn_Save.Visible = false;
                                break;
                        }
                        break;


                    case "102":
                        switch (roleid)
                        {
                            case "101":
                                btn_Save.Visible = true;
                                break;
                            default:
                                lnkSubmit.Visible = false;
                                HL_Errors.Visible = false;
                                btn_Save.Visible = false;
                                lnkSubmit.Visible = false;
                                break;
                        }
                        break;

                    case "103":
                        switch (roleid)
                        {
                            case "101":
                                btn_Save.Visible = true;
                                break;
                            default:
                                btn_Save.Visible = false;
                                break;
                        }
                        break;

                    case "104":
                        switch (roleid)
                        {
                            case "101":
                                btn_Save.Visible = true;
                                break;
                            default:
                                HL_Errors.Visible = false;
                                btn_Save.Visible = false;
                                lnkSubmit.Visible = false;
                                break;
                        }
                        lnkSubmit.Visible = false;
                        break;

                    case "106":
                        HL_Errors.Visible = false;
                        btn_Save.Visible = false;
                        lnkSubmit.Visible = false;
                        break;

                    default:
                        break;
                }

            }
            catch
            {
            }
        }
    }

    protected override void OnPreRenderComplete(EventArgs e)
    {
        #region Take away controls on Master Page
        Panel panControl = (Panel)Master.FindControl("panControl");
        if (panControl != null)
            panControl.Visible = false;


        //Label lblCollege = (Label)Master.FindControl("lblCollege");
        //if (lblCollege != null)
        //    lblCollege.Visible = false;

        //DropDownList DropDownList1 = (DropDownList)Master.FindControl("DropDownList1");
        //if (DropDownList1 != null)
        //    DropDownList1.Visible = false;

        Label Label2 = (Label)Master.FindControl("Label2");
        if (Label2 != null)
            Label2.Visible = false;

        DropDownList DropDownList2 = (DropDownList)Master.FindControl("DropDownList2");
        if (DropDownList2 != null)
            DropDownList2.Visible = false;
        #endregion

        #region Insert Blank into Fiscal Year DropDown
        if (!IsPostBack)
             {
         
               ListItem FiscalYRblank = new ListItem("Select Year", "-1");
               ddl_fiscalyear.Items.Insert(0, FiscalYRblank);
           }
        #endregion 

           DropDownList MasterPageCollegeDD = (DropDownList)Master.FindControl("DropDownList1");
        ddl_College.SelectedIndex = MasterPageCollegeDD.SelectedIndex;

        #region Maintain Sessions and Accompaning Controls
       
        try
        {
            DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());
         

            if (MasterPageCollegeDD.SelectedValue != myobj.CollID)
            {
               /********/
                //New College Choosen So clear everything and reset                   session values to mostly blanks, roleid and                         collegeid
               /********/
                LoadSession();
                ReloadData();
            }
            else
            {
                /********/
                //Page has be reloaded either Postback or revisit to                                and college hasn't changed so Fiscal Year selection is                            maintained and all controlls are refilled based on session                        variable values and sql querys of those values
                /********/
                ddl_fiscalyear.SelectedValue = myobj.FiscalYear.ToString();
                ReloadData();
                

            }
            myobj = null;
            
        }
        catch
        {

        }
        #endregion 
  
        #region Added session for Accountablity Level for Reporting Popup NEEDS also popup links are setup
       
        
        Session.Add(HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID", hf_Level_Id.Value);
        HL_Errors.NavigateUrl = "Javascript:OpenErrors()";
        HL_RPLIST.NavigateUrl = "Javascript:OpenReports(" + lbl_Acc_Id.Text + ")";
     

        #endregion

        #region Lock out Controls based on Accountablity Levels and re-evaluate final session and control data values
        
        LoadSession();                        
        ReloadData();
        Security_LockoutControl_by_LEVELS();
        #endregion 


        base.OnPreRenderComplete(e);
    }

    
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }
   
    
    
    protected void ddl_College_FiscalYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        /****/
        // 8-25-2009 Note: College Drop Down no longer interactive to the user
        // On fiscal Date change Data is reevaluated based on year/Accountablity ID etc.  and Session and Control Values are updated accordingly
        /***/
        ReloadData();
        LoadSession();

    }
    #region ReloadData() method :  Gets new data based on Fiscal year etc and Reloads accompanying controls and/or controls their visiblity if no data avialable

    protected void ReloadData()
    {

        DataView dv1 = (DataView)sqlds_accountablityCheck.Select(DataSourceSelectArguments.Empty);
            DataSet rowcountds = dv1.Table.DataSet.Copy();
            if (rowcountds.Tables[0].Rows[0][0].ToString() == "0")
            {
                btnCreate.Visible = true;
               
                lbl_Acc_Id.Text = "";
                lbl_Acc_Id.Visible = false;
                txt_Note.Visible = false;
                lbl_Level.Visible = false;
                hf_Level_Id.Visible = false;
                ddl_Acct_Next_Level.Visible = false;
                btn_Save.Visible = false;
                Label3.Visible = false;
                Label4.Visible = false;
                Label5.Visible = false;
                Label6.Visible = false;
                HL_Errors.Visible = false;
                HL_RPLIST.Visible = false;
                lnkSubmit.Visible = false;
                if (Session[Session.SessionID + "roleid"].ToString() != "101")
                {
                    btnCreate.Visible = false;
                }
                else
                {
                    btnCreate.Visible = true;
                }

                lbl_error.Visible = true;
            }
            else
            {
                btnCreate.Visible = false;
                lbl_error.Visible = false;
                if (ddl_fiscalyear.SelectedIndex > 0)
                {
                    SQLDS_Accountablity.SelectParameters.Clear();
                    SQLDS_Accountablity.SelectParameters.Add("p_key_college_id", ddl_College.SelectedValue);
                    SQLDS_Accountablity.SelectParameters.Add("p_nbr_fiscal_year", ddl_fiscalyear.SelectedValue);
                    SQLDS_Accountablity.SelectParameters.Add("p_txt_created_by", HttpContext.Current.User.Identity.Name.ToString());
                    SQLDS_Accountablity.Select(DataSourceSelectArguments.Empty);


                    DataSourceSelectArguments dssa = new DataSourceSelectArguments();
                    dssa.AddSupportedCapabilities(DataSourceCapabilities.RetrieveTotalRowCount);
                    dssa.RetrieveTotalRowCount = true;
                    DataView dv = (DataView)SQLDS_Accountablity.Select(dssa);

                    hf_Accountability_Id.Value = dv.Table.Rows[0][0].ToString();
                    lbl_Acc_Id.Text = dv.Table.Rows[0][0].ToString();
                    txt_Note.Text = dv.Table.Rows[0][4].ToString();


                    dv = (DataView)ds_Level.Select(dssa);
                    lbl_Level.Text = dv.Table.Rows[0][1].ToString();
                    Session.Add(HttpContext.Current.User.Identity.Name + Session.SessionID + "LevelTitle", lbl_Level.Text);
                    hf_Level_Id.Value = dv.Table.Rows[0][0].ToString();

                    ddl_Acct_Next_Level.DataBind();
                    lbl_Acc_Id.Visible = true;
                    txt_Note.Visible = true;
                    lbl_Level.Visible = true;
                    hf_Level_Id.Visible = true;
                    ddl_Acct_Next_Level.Visible = true;
                    btn_Save.Visible = true;
                    Label3.Visible = true;
                    Label4.Visible = true;
                    Label5.Visible = true;
                    Label6.Visible = true;
                  
                    HL_RPLIST.Visible = true;
                    lnkSubmit.Visible = true;
                }
                else
                {
                    lbl_Acc_Id.Text = "";
                    txt_Note.Text = "";
                    lbl_Level.Text = "";
                    hf_Level_Id.Value = "";
                    //ds_Acct_Next_Level.DataBind();
                    ddl_Acct_Next_Level.Items.Clear();
                    HL_Errors.Visible = false;
                    HL_RPLIST.Visible = false;
                    lnkSubmit.Visible = false;
                }
            }
        }

    #endregion 
  
        #region LoadSession() method: Sets the Session Variables pertaining to Accountablity ID, College ID, and Fiscal 

        protected void LoadSession()
    {
       /***********/
        //NOTE: one variable is used to store Accountablity ID, College ID and              Fiscal year and DecipherSession must be called to seperate out the comma          seperated this was done to save on Number of session variables and                remembering session names, the DecipherSession object exposes easily the          wanted names
      /*************/
        try
        {
            
            Session.Remove(Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids");
            Session.Add(Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids", lbl_Acc_Id.Text + "," + ddl_College.SelectedValue + "," + ddl_fiscalyear.SelectedValue);
        }
        catch (Exception ex)
        {
        }
    }
        #endregion

    protected void btn_Save_Click(object sender, EventArgs e)
    {
           //as of 8-25-2009 purly functions as a way to update the Notes of an                Accountablity Report
       //1/19/2012  took out the unnecessary 2nd parameter of the Level Info, as this pertains solely to Notes for the accountablity
      ////  String res = da.updateAccountabilityInfo(Convert.ToInt32(hf_Accountability_Id.Value),
      ////                                          Convert.ToInt32(ddl_Acct_Next_Level.SelectedValue),
      ////                                          txt_Note.Text);
      ////changed to
      ////      String res = da.updateAccountabilityInfo(Convert.ToInt32(hf_Accountability_Id.Value),                                           
      ////                                          txt_Note.Text);
       
        DataAccess da = new DataAccess();
        String res = da.updateAccountabilityInfo(Convert.ToInt32(hf_Accountability_Id.Value),
                                                txt_Note.Text);
    }

    
    protected void btnCreate_Click(object sender, EventArgs e)
    {
        // Create an Accountability Report 
        if (ddl_fiscalyear.SelectedIndex > 0)
        {

            SQLDS_Accountablity.InsertParameters.Clear();
            SQLDS_Accountablity.InsertParameters.Add("p_key_college_id", ddl_College.SelectedValue);
            SQLDS_Accountablity.InsertParameters.Add("p_nbr_fiscal_year", ddl_fiscalyear.SelectedValue);
            SQLDS_Accountablity.InsertParameters.Add("p_txt_created_by", HttpContext.Current.User.Identity.Name.ToString());
            SQLDS_Accountablity.Insert();




            SQLDS_Accountablity.SelectParameters.Clear();
            SQLDS_Accountablity.SelectParameters.Add("p_key_college_id", ddl_College.SelectedValue);
            SQLDS_Accountablity.SelectParameters.Add("p_nbr_fiscal_year", ddl_fiscalyear.SelectedValue);
            SQLDS_Accountablity.SelectParameters.Add("p_txt_created_by",HttpContext.Current.User.Identity.Name.ToString());
            SQLDS_Accountablity.Select(DataSourceSelectArguments.Empty);


            DataSourceSelectArguments dssa = new DataSourceSelectArguments();
            dssa.AddSupportedCapabilities(DataSourceCapabilities.RetrieveTotalRowCount);
            dssa.RetrieveTotalRowCount = true;
            DataView dv = (DataView)SQLDS_Accountablity.Select(dssa);

            hf_Accountability_Id.Value = dv.Table.Rows[0][0].ToString();
            lbl_Acc_Id.Text = dv.Table.Rows[0][0].ToString();
            txt_Note.Text = dv.Table.Rows[0][4].ToString();


            dv = (DataView)ds_Level.Select(dssa);
            lbl_Level.Text = dv.Table.Rows[0][1].ToString();
            hf_Level_Id.Value = dv.Table.Rows[0][0].ToString();

            ddl_Acct_Next_Level.DataBind();
            lbl_Acc_Id.Visible = true;
            txt_Note.Visible = true;
            lbl_Level.Visible = true;
            hf_Level_Id.Visible = true;
            ddl_Acct_Next_Level.Visible = true;
            btn_Save.Visible = true;
            Label3.Visible = true;
            Label4.Visible = true;
            Label5.Visible = true;
            Label6.Visible = true;
     
            HL_RPLIST.Visible = true;
            lnkSubmit.Visible = true;
        }
        else
        {
            lbl_Acc_Id.Text = "";
            txt_Note.Text = "";
            lbl_Level.Text = "";
            hf_Level_Id.Value = "";
            //ds_Acct_Next_Level.DataBind();
            ddl_Acct_Next_Level.Items.Clear();
            HL_Errors.Visible = false;
            HL_RPLIST.Visible = false;
            lnkSubmit.Visible = false;
            btn_Save.Visible = false;
        }

        LoadSession();
        ReloadData();
    }

    #region Level Updating method and Level Updating Error Handling

    protected void lnkSubmit_Click(object sender, EventArgs e)
    {
        /****/
        //Call sqlds_submitlevelupdate sql datasource control to update the Level           of the accountablity report
        /****/
      
        sqlds_submitLevelUpdate.Update();           
    }
  
    protected void sqlds_submitLevelUpdate_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        /********/
        //Evaluates the Return Value of a Level update from sql datasource control          "sqlds_submitlevelupdate" if error display error link for popup                   reporting
        /********/

        string errormessage = e.Command.Parameters[0].Value.ToString();
       
        if (errormessage == "102")
            HL_Errors.Visible = true;

        if (errormessage == "0")
        {
            String receivers = String.Empty;

            GK3_Driver gk3 = new GK3_Driver();
            SqlDataReader dr = gk3.get_Email_Notice_List(Convert.ToInt32(hf_Accountability_Id.Value));

            if (dr.HasRows)
                while (dr.Read())
                {
                    if(receivers.Trim() == "")
                        receivers += dr["txt_email"].ToString();
                    else 
                        receivers += ", " + dr["txt_email"].ToString();
                }

           

            Utility u_Obj = new Utility();
            String body = String.Empty;

            if (ddl_Acct_Next_Level.SelectedValue.ToString() == "101" && hf_Level_Id.Value.Trim() == "100")
            {
                body = "The Perkins Data Management System is now open for submission of the 2012 Annual Performance Report. Log on to https://www.sctechsystem.edu/perkins to complete required narrative and data components. The report is due on November 18, 2012. Detailed reporting instructions are available on the Perkins T-Web site at https://tweb.sctechsystem.edu/groups/perkins/accountability/default.aspx.";
                u_Obj.sendNoticeEmail("Perkins-Accountability Email Notifications", body, receivers);
            }

            if ((ddl_Acct_Next_Level.SelectedValue.ToString() == "102" && hf_Level_Id.Value.Trim() == "101") ||
                (ddl_Acct_Next_Level.SelectedValue.ToString() == "102" && hf_Level_Id.Value.Trim() == "103"))
            {
               
                body = "Attention Needed: The " + ddl_fiscalyear.SelectedValue + " Perkins IV Accountability report for " + ddl_College.SelectedItem.Text.ToString() + " has been submitted for your review/approval. https://www.sctechsystem.edu/perkins";
                u_Obj.sendNoticeEmail("Perkins-Accountability Email Notifications", body, receivers);
            }

            if (ddl_Acct_Next_Level.SelectedValue.ToString() == "103" && hf_Level_Id.Value.Trim() == "102")
            {
                
                body = "Attention Needed: The System Office has requested revisions to the " + ddl_fiscalyear.SelectedValue.ToString() + " Perkins IV Accountability report for " + ddl_College.SelectedItem.Text.ToString() + ". Please log in to the Perkins DMS to review the System Office notes and resubmit the report once revisions are made. https://www.sctechsystem.edu/perkins.";
                u_Obj.sendNoticeEmail("Perkins-Accountability Email Notifications", body, receivers);
            }
        }
    }

    #endregion

}
