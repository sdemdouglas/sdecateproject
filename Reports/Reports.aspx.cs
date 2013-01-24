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

public partial class Reports : System.Web.UI.Page
{
    protected override void OnPreRender(EventArgs e)
    {
      
    
     
        
        if (Session[Session.SessionID + "roleid"].ToString() == "101")  //Admin role is 101
        {
            
        }
        else 
        {
            lbl_activityNumber.Visible = false;
            ddl_College.SelectedValue = Session[(Session.SessionID + "CollegeDDvalue")].ToString();
            ddl_College.Enabled = false;
            ddl_College.Attributes.Add("style", "visibility:hidden");
            lbl_collegeddl.Visible = false;
            txt_ActivityNumber.Attributes.Add("style", "visibility:hidden");
            lbl_activityNumber.Visible = false;
        }
        
      
        base.OnPreRender(e);
    }
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        if (!IsPostBack)
        {        
     
       }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        RadMultiPage1.SelectedIndex = -1;
    
        }
    }
    protected void ddlMonth_DataBound(object sender, EventArgs e)
    {
       
    }

    protected void ddlMonth1_DataBound(object sender, EventArgs e)
    {
        //ListItem li = new ListItem("", "-1");
        //if (ddlMonth1.Items.IndexOf(li) < 0)
        //    ddlMonth1.Items.Insert(0, li);
    }

  
    protected void ddl_Reports_SelectedIndexChanged(object sender, EventArgs e)
    {
        //lbl_College.Visible = true;
        //ddl_College.Visible = true;

        switch (ddl_Reports.SelectedValue)
        {
            case "Activities_By_CATandFUNDcode":
                RadMultiPage1.SelectedIndex = 0;
                break;

            case "ActivitybyLineItem_FunctionCode_CategoryCode":
                RadMultiPage1.SelectedIndex = 1;
                break;

            case "rpt_ce_college_expenditures_by_month_prior":
                RadMultiPage1.SelectedIndex = 2;
                break;

            case "rpt_college_reimbursement":
                //lbl_College.Visible = false;
                //ddl_College.Visible = false;
                RadMultiPage1.SelectedIndex = 3;
                break;

            case "rpt_arra_expenditure_report_dtl":
                //lbl_College.Visible = false;
                //ddl_College.Visible = false;
                //ds_Expenditure_Detail.DataBind();
                //ddl_Grant_Name_Exp.DataBind();
                RadMultiPage1.SelectedIndex = 4;
                break;

            case "rpt_arra_vendor":
                //lbl_College.Visible = false;
                //ddl_College.Visible = false;
                //ds_Vendor.DataBind();
                //ddl_Grant_Name_Vendor.DataBind();
                RadMultiPage1.SelectedIndex = 5;
                break;

            case "rpt_arra_infrastructure_project_report":
                //lbl_College.Visible = false;
                //ddl_College.Visible = false;
                //ds_Project.DataBind();
                //ddl_Grant_Name_Pro.DataBind();
                RadMultiPage1.SelectedIndex = 6;
                break;

            case "rpt_arra_jobs_created_retained":
                //lbl_College.Visible = false;
                //ddl_College.Visible = false;
                //ds_Job.DataBind();
                //ddl_Grant_Name_Job.DataBind();
                RadMultiPage1.SelectedIndex = 7;
                break;
            
            case "rpt_ce_college_expenditures_by_grant_group":
                //ds_Grant_Group.DataBind();
                //ddl_Grant_Group.DataBind();
                RadMultiPage1.SelectedIndex = 8;
                break;

            case "rpt_btop_expenditures_by_month":              
                RadMultiPage1.SelectedIndex = 9;
                break;


            default:
                RadMultiPage1.SelectedIndex = -1;
                break;
        }  

    }
   
    
   

    protected void ib_Print_Click(object sender, EventArgs e)
    {
        RadMultiPage1.SelectedIndex = 0;
    }
   
    protected void ib_Print1_Click(object sender, EventArgs e)
    {
        RadMultiPage1.SelectedIndex = 1;
    }

    protected void ib_Print2_Click(object sender, EventArgs e)
    {
        RadMultiPage1.SelectedIndex = 2;
    }
    protected void btn_Print_CR_Click(object sender, EventArgs e)
    {
        RadMultiPage1.SelectedIndex = 3;
    }
    protected void ddl_CR_Month_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        //if (ddl_CR_Month.Items.IndexOf(li) < 0)
        //    ddl_CR_Month.Items.Insert(0, li);
    }
  
    //protected void DDL_CR_Year_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (DDL_CR_Year.Items.IndexOf(li) < 0)
    //        DDL_CR_Year.Items.Insert(0, li);
    //}
    //protected void ddl_Grant_Name_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}
    //protected void ddl_Grant_Name_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Grant_Name.Items.IndexOf(li) < 0)
    //        ddl_Grant_Name.Items.Insert(0, li);
    //}
    //protected void CR_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddl_CR_Month.SelectedIndex > 0 && DDL_CR_Year.SelectedIndex > 0)
    //    {
    //        ddl_Grant_Name.DataBind();
    //    }
    //}
    //protected void ddl_College_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-2");
    //    if (ddl_College.Items.IndexOf(li) < 0)
    //        ddl_College.Items.Insert(0, li);
    //}
    //protected void ddl_Month_Exp_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Rebind_Grand_Name();
    //}

    //protected void Rebind_Grand_Name()
    //{
    //    ds_Expenditure_Detail.DataBind();
    //    ddl_Grant_Name_Exp.DataBind();
    //}
    //protected void ddl_Year_Exp_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Rebind_Grand_Name();
    //}
    //protected void ddl_Month_Exp_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Month_Exp.Items.IndexOf(li) < 0)
    //        ddl_Month_Exp.Items.Insert(0, li);
    //}
    //protected void btn_Print_Expenditure_Detail_Click(object sender, EventArgs e)
    //{
    //    RadMultiPage1.SelectedIndex = 4;
    //}
    //protected void ddl_Month_Vendor_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Month_Vendor.Items.IndexOf(li) < 0)
    //        ddl_Month_Vendor.Items.Insert(0, li);
    //}

    //protected void Rebind_Grand_Name_Vendor()
    //{
    //    ds_Vendor.DataBind();
    //    ddl_Grant_Name_Vendor.DataBind();
    //}
    //protected void ddl_Month_Vendor_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Rebind_Grand_Name_Vendor();
    //}
    //protected void ddl_Year_Vendor_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Rebind_Grand_Name_Vendor();
    //}
    //protected void ddl_Grant_Name_Vendor_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Grant_Name_Vendor.Items.IndexOf(li) < 0)
    //        ddl_Grant_Name_Vendor.Items.Insert(0, li);
    //}
    //protected void btn_Print_Vendor_Click(object sender, EventArgs e)
    //{
    //    RadMultiPage1.SelectedIndex = 5;
    //}
    //protected void ddl_Grant_Name_Exp_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Grant_Name_Exp.Items.IndexOf(li) < 0)
    //        ddl_Grant_Name_Exp.Items.Insert(0, li);
    //}
    //protected void ddl_Month_Pro_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Month_Pro.Items.IndexOf(li) < 0)
    //        ddl_Month_Pro.Items.Insert(0, li);
    //}
    //protected void ddl_Grant_Name_Pro_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Grant_Name_Pro.Items.IndexOf(li) < 0)
    //        ddl_Grant_Name_Pro.Items.Insert(0, li);
    //}
    //protected void btn_Print_Pro_Click(object sender, EventArgs e)
    //{
    //    RadMultiPage1.SelectedIndex = 6;
    //}

    //protected void Rebind_Grand_Name_Job()
    //{
    //    ds_Job.DataBind();
    //    ddl_Grant_Name_Job.DataBind();
    //}

    //protected void ddl_Month_Job_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Month_Job.Items.IndexOf(li) < 0)
    //        ddl_Month_Job.Items.Insert(0, li);
    //}
    //protected void ddl_Month_Job_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Rebind_Grand_Name_Job();
    //}
    //protected void ddl_Year_Job_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    Rebind_Grand_Name_Job();
    //}
    //protected void ddl_Grant_Name_Job_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Grant_Name_Job.Items.IndexOf(li) < 0)
    //        ddl_Grant_Name_Job.Items.Insert(0, li);
    //}
    //protected void btn_Print_Job_Click(object sender, EventArgs e)
    //{
    //    RadMultiPage1.SelectedIndex = 7;
    //}



    //protected void ddl_College_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    ddl_Reports_SelectedIndexChanged(ddl_College, e);
    //}
   
    //protected void ddl_EndMonth_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_EndMonth.Items.IndexOf(li) < 0)
    //        ddl_EndMonth.Items.Insert(0, li);
    //}
    //protected void ddl_EndYear_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_EndYear.Items.IndexOf(li) < 0)
    //        ddl_EndYear.Items.Insert(0, li);
    //}
    //protected void ddl_Grant_Group_DataBinding(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Grant_Group.Items.IndexOf(li) < 0)
    //        ddl_Grant_Group.Items.Insert(0, li);
    //}
    //protected void ddl_Gg_Begin_Month_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_Gg_Begin_Month.Items.IndexOf(li) < 0)
    //        ddl_Gg_Begin_Month.Items.Insert(0, li);
    //}
    //protected void ddl_GG_End_Month_DataBound(object sender, EventArgs e)
    //{
    //    ListItem li = new ListItem("", "-1");
    //    if (ddl_GG_End_Month.Items.IndexOf(li) < 0)
    //        ddl_GG_End_Month.Items.Insert(0, li);
    //}
    //protected void ddl_Gg_Begin_Month_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    GG_Change();
    //}

    //protected void GG_Change()
    //{
    //    ds_Grant_Group.DataBind();
    //    ddl_Grant_Group.DataBind();
    //}
    //protected void ddl_GG_Begin_Year_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    GG_Change();
    //}
    //protected void ddl_GG_End_Month_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    GG_Change();
    //}
    //protected void ddl_GG_End_Year_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    GG_Change();
    //}
    //protected void btn_Print_GG_Click(object sender, EventArgs e)
    //{
    //    RadMultiPage1.SelectedIndex = 8;
    //}
    //protected void ddl_btop_Month_DataBound(object sender, EventArgs e)
    //{
    //  //  Utilities.Add_Blank_Item((DropDownList)sender);
    //}
    //protected void ddl_btop_Year_DataBound(object sender, EventArgs e)
    //{
    ////    Utilities.Add_Blank_Item((DropDownList)sender);
    //}
    //protected void btn_Print_BTOP_Click(object sender, EventArgs e)
    //{
    //    RadMultiPage1.SelectedIndex = 9;
    //}
    protected void ddl_Reports_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddl_Reports.Items.IndexOf(li) < 0)
            ddl_Reports.Items.Insert(0, li);
    }
    protected void ddl_College_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddl_College.Items.IndexOf(li) < 0)
            ddl_College.Items.Insert(0, li);
    }

    protected void ddl_DataBound_INSERTBLACK(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        ListItem li = new ListItem("", "-1");
        if (ddl.Items.IndexOf(li) < 0)
            ddl.Items.Insert(0, li);
    }
    protected void ddl_College_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
