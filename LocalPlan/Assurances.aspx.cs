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

using BLL;

public partial class LocalPlans_Assurances : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
        DropDownList ddl = (DropDownList)Master.FindControl("DropDownList2");
        hfFiscalYear.Value = ddl.SelectedValue.ToString();



     
        
        
        
        
        try
        {
            
            hfLpid.Value = Session[Session.SessionID + "PlanID"].ToString();
            lblErr.Text = "";
            Panel1.Visible = true;
             
            lp_local_plan lpObj = new lp_local_plan();
            lpObj.ConnectionString = DataAccess.getConnStr();

            if (lpObj.LoadByPrimaryKey(Convert.ToInt32(hfLpid.Value)))
            {
                if (lpObj.Flg_accepted_assurances == true)
                {
                    cbAccepted.Checked = lpObj.Flg_accepted_assurances;                    
                }
                else
                    cbAccepted.Checked = false;                    
                
            }
            GearBox_Assurances_Secruity();
        }
        catch (Exception ex)
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
            }
            hfLpid.Value = "-1";
            //Panel1.Visible = false;
        }
        RadGrid1.DataBind();
        GearBox_Assurances_Secruity();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            
            //DropDownList ddl = (DropDownList)Master.FindControl("DropDownList2");

            //sqlAssurancesDs.SelectParameters.Clear();
           // sqlAssurancesDs.SelectParameters.Add("p_nbr_fiscal_year", ddl.SelectedValue.ToString());

            //sqlAssurancesDs.Select(DataSourceSelectArguments.Empty);
            //sqlAssurancesDs.DataBind();
          //  RadGrid1.DataBind();

            if (Session[Session.SessionID + "roleid"].ToString() == "102")
            {
                //User is a CAO 102 so they can accept assurances
                cbAccepted.Enabled = true;
                btnSubmit.Enabled = true;
                btnPrint.Enabled = true;
            }
         
            
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lp_local_plan lpObj = new lp_local_plan();
        lpObj.ConnectionString = DataAccess.getConnStr();

        if (lpObj.LoadByPrimaryKey(Convert.ToInt32(hfLpid.Value)))
        {
            if (cbAccepted.Checked)
                lpObj.Flg_accepted_assurances = true;
            else 
                lpObj.Flg_accepted_assurances = false;
            lpObj.Save();
        }
    }





    protected void GearBox_Assurances_Secruity()
    {
        lp_local_plan lpObj = new lp_local_plan();
        lpObj.ConnectionString = DataAccess.getConnStr();
        lpObj.LoadByPrimaryKey(Convert.ToInt32(hfLpid.Value));

        try
        {

            string roleid = Session[Session.SessionID + "roleid"].ToString();
            switch (lpObj.Key_local_plan_level_id.ToString())
            {
                case "101":
                    //Level 0 Awaiting CO Admin

                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;

                            break;
                        case "102":
                            //CAO
                            cbAccepted.Enabled = true;
                            btnSubmit.Enabled = true;
                            btnPrint.Enabled = true;
                            break;
                        case "101":
                            //SO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                        case "104":
                            //View Only
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                    }

                    break;
                case "102":
                    //Level 1 Awaiting CAO
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;

                            break;
                        case "102":
                            //CAO
                            cbAccepted.Enabled = true;
                            btnSubmit.Enabled = true;
                            btnPrint.Enabled = true; 
                            break;
                        case "101":
                            //SO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                        case "104":
                            //View Only
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                    }
                    break;
                case "103":
                    //Review by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                        case "102":
                            //CAO
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;

                            break;
                        case "101":
                            //SO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                        case "104":
                            //View Only
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                    }
                    break;

                case "104":
                    //So 3 Revision Requested by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;

                            break;
                        case "102":
                            //CAO
                            cbAccepted.Enabled = true;
                            btnSubmit.Enabled = true;
                            btnPrint.Enabled = true;


                            break;
                        case "101":
                            //SO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                        case "104":
                            //View Only
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                    }
                    break;

                case "105":
                    //Level 4 Pending SDE Review
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;


                            break;
                        case "102":
                            //CAO
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;

                            break;
                        case "101":
                            //SO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;

                            break;
                        case "104":
                            //View Only
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                    }
                    break;

                case "106":
                    //Level 5 Approved
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;


                            break;
                        case "102":
                            //CAO
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;

                            break;
                        case "101":
                            //SO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                        case "104":
                            //View Only
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;
                            break;
                    }
                    break;

                case "107":
                    //Level 6 Closed
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;


                            break;
                        case "102":
                            //CAO
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = true;


                            break;
                        case "101":
                            //SO Admin
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = false;

                            break;
                        case "104":
                            //View Only
                            cbAccepted.Enabled = false;
                            btnSubmit.Enabled = false;
                            btnPrint.Enabled = false;
                            break;
                    }
                    break;
                default:
                    // View Only, and anything not covered

                    break;
            }



           
            //4-23-2008 added to trump all if assurances accepted then checkbox and submit buttun disabled
            if (lpObj.LoadByPrimaryKey(Convert.ToInt32(hfLpid.Value)))
            {
                if (lpObj.Flg_accepted_assurances == true)
                {
                    cbAccepted.Enabled = (!lpObj.Flg_accepted_assurances);
                    btnSubmit.Enabled = (!lpObj.Flg_accepted_assurances);
                }

               

            }
        
        }
        catch(Exception ex)
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();
            if (errObj.LoadByPrimaryKey("100"))
            {
                lblErr.Text = errObj.Txt_message;
                //lblErr.Text = ex.ToString();
            }
            else
                lblErr.Text = ex.ToString();
            Panel1.Visible = false;
        }
    }


    protected void sqlAssurancesDs_Init(object sender, EventArgs e)
    {
       
    }
}
