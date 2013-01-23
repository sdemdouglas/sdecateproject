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
using Telerik.Web.UI;

public partial class Accountability_narrative : System.Web.UI.Page
{

    protected void Security_LockoutControl_by_LEVELS()
    {
        try
        {
            string levelid = Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString();

             if (levelid == "100" || levelid == "102")
            {
                
            }
        }
        catch
        {
        }

    }


    protected override void OnPreRenderComplete(EventArgs e)
    {
        Panel panControl = (Panel)Master.FindControl("panControl");
        if (panControl != null)
            panControl.Visible = false;

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

       

        Label Label2 = (Label)Master.FindControl("Label2");
        if (Label2 != null)
            Label2.Visible = false;

        DropDownList DropDownList2 = (DropDownList)Master.FindControl("DropDownList2");
        if (DropDownList2 != null)
            DropDownList2.Visible = false;
        Security_LockoutControl_by_LEVELS();





     if (rg_Narratives.MasterTableView.Items.Count == 0)
          {
            lbl_errortext.Text = "</br><image src='../images/msgIcons/stop.jpg' style='WIDTH: 25px;VERTICAL-ALIGN: middle; valign=middle; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 26px; BORDER-BOTTOM-STYLE: none' />  There is no Accountablity Report for the selected year! Please contact system office.";
            PanelTops.Visible = false;
            lbl_Fiscal_Year.Visible = false;
            Label1.Visible = false;
            rg_Narratives.Visible = false;
        }
        else
        {
            PanelTops.Visible = true;
            lbl_Fiscal_Year.Visible = true;
            Label1.Visible = true;
            rg_Narratives.Visible = true;
            lbl_errortext.Text = "";
        }

     

        base.OnPreRenderComplete(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {                              
                DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());



                hf_Accountability_Id.Value = myobj.AcctID.ToString();
                lbl_Fiscal_Year.Text = myobj.FiscalYear.ToString() + "  " +   Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "LevelTitle"].ToString();
                rg_Narratives.DataBind();
                Set_Security();
                btn_print.OnClientClick = "Javascript:OpenReports(" + hf_Accountability_Id.Value.ToString() + ");return false;";
            }
            catch (Exception ex)
            {
            }
        }
    }
    protected void rg_Narratives_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        HiddenField hf_Nid = (HiddenField)e.Item.FindControl("hf_Nid");
        HyperLink lbView = e.Item.FindControl("lbView") as HyperLink;
        if (lbView != null && hf_Nid != null)
        {
            lbView.Attributes.Add("onClick", "ShowNarrativeDetails(" + hf_Nid.Value + "," + Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString() + ")"); 
        }

        if (e.Item is GridDataItem)
        {
            GridDataItem myitem = (GridDataItem)e.Item;
            if ((myitem["flg_narrative_response"].FindControl("lbl_narrative_response") as Label).Text == "0")
                (myitem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Checked = false;
            else
                (myitem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Checked = true;
            (myitem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Attributes.Add("disabled", "true");
        }

    }

    private String GetCurrentLevel_Id()
    {
        try
        {
            DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());
            SQLDS_Accountablity.SelectParameters.Clear();
            SQLDS_Accountablity.SelectParameters.Add("p_key_college_id", myobj.CollID.ToString());
            SQLDS_Accountablity.SelectParameters.Add("p_nbr_fiscal_year", myobj.FiscalYear.ToString());
            SQLDS_Accountablity.Select(DataSourceSelectArguments.Empty);


            DataSourceSelectArguments dssa = new DataSourceSelectArguments();
            dssa.AddSupportedCapabilities(DataSourceCapabilities.RetrieveTotalRowCount);
            dssa.RetrieveTotalRowCount = true;
            DataView dv = (DataView)SQLDS_Accountablity.Select(dssa);


            return dv.Table.Rows[0][3].ToString();
        }
        catch
        {
            return "";
        }

        return "";
    }


    protected void Set_Security()
    {
        
        string roleid = Session[Session.SessionID + "roleid"].ToString();

        switch (GetCurrentLevel_Id())
        {
            case "100":
                switch (roleid)
                {
                     case "101":
                        // Admin                                                  
                        break;
                    case "102":
                        //CAO
                        
                        break;
                    case "103":
                        //Perkins Admin
                        
                       
                        break;
                    case "104":
                        //View Only
                        
                        break;                               
                }
                break;


            case "101":
                switch (roleid)
                {
                    case "101":
                        // Admin

                   
                        break;
                    case "102":
                        //CAO

                        break;
                    case "103":
                        //Perkins Admin


                        break;
                    case "104":
                        //View Only

                        break;
                }
                break;

            case "102":
                switch (roleid)
                {
                    case "101":
                        // Admin


                        break;
                    case "102":
                        //CAO
                        
                        break;
                    case "103":
                        //Perkins Admin
                        

                        break;
                    case "104":
                        //View Only
                        
                        break;
                }
                break;

            case "103":
                switch (roleid)
                {
                    case "101":
                        // Admin


                        break;
                    case "102":
                        //CAO
                       
                        break;
                    case "103":
                        //Perkins Admin
                      

                        break;
                    case "104":
                        //View Only
                      
                        break;
                }
                break;

            case "104":
                //Approved
                switch (roleid)
                {
                    case "101":
                        // Admin
                        
                        break;

                    case "102":
                        //CAO
                        
                        break;

                    case "103":
                        //Perkins Admin
                        
                        break;

                    case "104":
                        //View Only
                        
                        break;
                }
                break;
        }
    }
    protected void imgb_Excel_Click(object sender, ImageClickEventArgs e)
    {
        rg_Narratives.ExportSettings.ExportOnlyData = true;
        rg_Narratives.ExportSettings.Excel.Format = Telerik.Web.UI.GridExcelExportFormat.ExcelML;
        rg_Narratives.ExportSettings.OpenInNewWindow = true;
        rg_Narratives.MasterTableView.ExportToExcel();
    }
    protected void btn_Export_Excel_Click(object sender, EventArgs e)
    {
        rg_Narratives.ExportSettings.ExportOnlyData = true;
        rg_Narratives.ExportSettings.Excel.Format = Telerik.Web.UI.GridExcelExportFormat.ExcelML;
        rg_Narratives.ExportSettings.OpenInNewWindow = true;
        rg_Narratives.MasterTableView.ExportToExcel();
    }
}
