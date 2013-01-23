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
using Telerik.WebControls;

//********************************************************************
//** Author : RL
//** Date : 8-19-2009
//********************************************************************



public partial class Accountability_PerformanceIndicators : System.Web.UI.Page
{
    protected override void OnPreRender(EventArgs e)
    {

     
        base.OnPreRender(e);
    }
    protected override void OnPreRenderComplete(EventArgs e)
    {
        
        
        #region Remove DropDowns from Master Page
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

        //DropDownList MasterPageCollegeDD = (DropDownList)Master.FindControl("DropDownList1");
        //txt_CollegeID.Text = MasterPageCollegeDD.SelectedValue;


        //Check if the Selected College is changed 
        try
        {
            DropDownList MasterPageCollegeDD = (DropDownList)Master.FindControl("DropDownList1");
            DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());
            if (MasterPageCollegeDD.SelectedValue != myobj.CollID)
            {
                Response.Redirect("AccountabilityReport.aspx");
            }
        }
        catch
        {
        }


        base.OnPreRenderComplete(e);
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rdt_PerfIndcat.SelectedIndex = 0;

            RadMultiPage1.SelectedIndex = 0;
       
            try
            {
                DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());
               

                txt_AcctID.Text =myobj.AcctID;
                txt_CollegeID.Text = myobj.CollID;
                txt_FiscalYear.Text = myobj.FiscalYear;

                lbl_CurrfiscalYear.Text ="Fiscal Year: " + myobj.FiscalYear;

             
            }                        
            catch
            {
            }

         }
    }

    private void updateGenderData(RadGrid VARrdg_Gender)
    {
        foreach (GridDataItem item in VARrdg_Gender.Items)
        {
            SqlDS_Gender.UpdateParameters.Clear();
            SqlDS_Gender.UpdateParameters.Add("p_key_acct_gender_id", item["key_acct_gender_id"].Text);
            SqlDS_Gender.UpdateParameters.Add("p_nbr_students_numerator", ((RadNumericTextBox)item["nbr_students_numerator"].FindControl("nbr_students_numeratorTextBox")).Text);
            SqlDS_Gender.UpdateParameters.Add("p_nbr_student_denominator", ((RadNumericTextBox)item["nbr_student_denominator"].FindControl("nbr_student_denominatorTextBox")).Text);
            SqlDS_Gender.UpdateParameters.Add("p_txt_updated_by", HttpContext.Current.User.Identity.Name.ToString());
            SqlDS_Gender.Update();
           
        }      
    }
   

    private void updateRaceData(RadGrid VARrdg_Race)
    {

        foreach (GridDataItem item in VARrdg_Race.Items)
        {
            SqlDS_Race.UpdateParameters.Clear();
            SqlDS_Race.UpdateParameters.Add("p_key_acct_race_id", item["key_acct_race_id"].Text);
            SqlDS_Race.UpdateParameters.Add("p_nbr_students_numerator", ((RadNumericTextBox)item["nbr_students_numerator"].FindControl("nbr_students_numeratorTextBox")).Text);
            SqlDS_Race.UpdateParameters.Add("p_nbr_student_denominator", ((RadNumericTextBox)item["nbr_student_denominator"].FindControl("nbr_student_denominatorTextBox")).Text);
            SqlDS_Race.UpdateParameters.Add("p_txt_updated_by", HttpContext.Current.User.Identity.Name.ToString());
            SqlDS_Race.Update();

        }


        

    }
   


    private void updateSpecialPOPsData(RadGrid VARrdg_SpecPOPs)
    {

        foreach (GridDataItem item in VARrdg_SpecPOPs.Items)
        {
            SqlDS_SpecPop.UpdateParameters.Clear();
            SqlDS_SpecPop.UpdateParameters.Add("p_key_acct_spec_population_id", item["key_acct_spec_population_id"].Text);
            SqlDS_SpecPop.UpdateParameters.Add("p_nbr_students_numerator", ((RadNumericTextBox)item["nbr_students_numerator"].FindControl("nbr_students_numeratorTextBox")).Text);
            SqlDS_SpecPop.UpdateParameters.Add("p_nbr_student_denominator", ((RadNumericTextBox)item["nbr_student_denominator"].FindControl("nbr_student_denominatorTextBox")).Text);
            
            SqlDS_SpecPop.UpdateParameters.Add("p_nbr_adjusted_level_of_performance", ((RadNumericTextBox)item.FindControl("adjustedPerformance")).Text);
            SqlDS_SpecPop.UpdateParameters.Add("p_txt_updated_by", HttpContext.Current.User.Identity.Name.ToString());
            SqlDS_SpecPop.Update();

        }
    }

   
   
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        switch (Convert.ToInt16(hdn_tabselectedValue.Value))
        {
            case 101:
                updateGenderData(rdg_Gender);
                updateRaceData(rdg_Race);
                updateSpecialPOPsData(rdg_SpecPOPs);
                break;
            case 102:
                updateSpecialPOPsData(rdg_SpecPOPs2p1);
                break;
            case 103: 
                updateSpecialPOPsData(rdg_SpecPOPs3p1);
                break;
            case 104: 
                updateSpecialPOPsData(rdg_SpecPOPs4p1);
                break;
            case 105: 
                updateSpecialPOPsData(rdg_SpecPOPs5p1);
                break;
            case 106: 
                updateSpecialPOPsData(rdg_SpecPOPs5p2);
                break;
        }
       
    }
    protected void gridDataBinds_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //try
        //{
        //    RadNumericTextBox rdadjustedperformance = (RadNumericTextBox)e.Item.FindControl("adjustedPerformance");

        //          RadGrid mygrid = (RadGrid)sender;
        //    rdadjustedperformance.Attributes.Add("onChange", "copyperformancenumbers('" + rdadjustedperformance.ClientID + "','" + mygrid.ClientID + "')");
        //}
        //catch
        //{
        //}
        
    }

    protected void RadGrid_DataBound(object sender, EventArgs e)
    {
//RadGrid mygrid = (RadGrid)sender;
//string rowcount = "";
//string controlnamecollection = "";
//foreach (GridDataItem item in mygrid.Items)
//{
//    RadNumericTextBox rdadjustedperformance = (RadNumericTextBox)item.FindControl("adjustedPerformance");
//    controlnamecollection += (rdadjustedperformance.ClientID + ",");
//}
//rowcount = mygrid.Items.Count.ToString();
//foreach (GridDataItem item in mygrid.Items)
//{
//    try
//    {
//        RadNumericTextBox rdadjustedperformance = (RadNumericTextBox)item.FindControl("adjustedPerformance");
      

//        rdadjustedperformance.Attributes.Add("onChange", "copyperformancenumbers('" + rdadjustedperformance.ClientID + "','" + mygrid.ClientID + "','" + rowcount +  "','" + controlnamecollection + "')");
//    }
//    catch
//    {
//    }
//}


    }
    protected void adjustedPerformance_TextChanged(object sender, EventArgs e)
    {
        string mystring = ((RadNumericTextBox)sender).Text;
        foreach (GridDataItem item in rdg_SpecPOPs.Items)
        {
            try
            {
                RadNumericTextBox rdadjustedperformance = (RadNumericTextBox)item.FindControl("adjustedPerformance");
                rdadjustedperformance.Text = mystring;
            }
            catch
            {
            }
        }
    }
}
