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
using Telerik.WebControls;

public partial class Accountability_EnrollmentForm_v2 : System.Web.UI.Page
{

    protected void Security_LockoutControl_by_LEVELS()
    {
        try
        {
            string levelid = Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString();
            if (levelid == "104")
            {
                btn_Save.Visible = false;
            }
            else if (levelid == "100" || levelid == "102")
            {
                if (Session[Session.SessionID + "roleid"].ToString() != "101")
                {
                    btn_Save.Visible = false;
                }
            }
            else if (levelid == "106")
                btn_Save.Visible = false;
            else
                btn_Save.Visible = true;
           
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


        



        if (lbl_CurrfiscalYear.Text.Trim() == "Fiscal Year: -1" || hf_Accountability_Id.Value.Length == 0)
        {
            lbl_errortext.Text = "<image src='../images/msgIcons/stop.jpg' style='WIDTH: 25px;VERTICAL-ALIGN: middle; valign=middle; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 26px; BORDER-BOTTOM-STYLE: none' />  There is no Accountablity Report for the selected year! Please contact system office.";
            btn_Save.Visible = false;
            lbl_CurrfiscalYear.Visible = false;
            pan_topInfo.Visible = false;
        }
        else
        {
            pan_topInfo.Visible = true;
          //  Pan_allfunctionPage.Visible = true;
            lbl_errortext.Text = "";
            btn_Save.Visible = true;
            lbl_CurrfiscalYear.Visible = true;

        }

        Security_LockoutControl_by_LEVELS();
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
                try
                {
                    hf_Created_By.Value = HttpContext.Current.User.Identity.Name.ToString();
                    lbl_CurrfiscalYear.Text = "Fiscal Year: " + myobj.FiscalYear + "  " + Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "LevelTitle"].ToString();
                }
                catch { }
                ds_Enrollment.Select(DataSourceSelectArguments.Empty);
              //  ds_Enrollment.DataBind();
                rg_Enrollment.DataBind();
            }
            catch
            {
            }
        }
    }


    protected void nbr_studentsTextBox_TextChanged(object sender, EventArgs e)
    {


        RadNumbox_TextChanged();
        //Telerik.Web.UI.GridDataItem gd_item = (Telerik.Web.UI.GridDataItem)(sender as Telerik.WebControls.RadNumericTextBox).NamingContainer;
        // HiddenField hf_kp_id = (HiddenField) gd_item.FindControl("hf_kp_id");

        // int value = -999999;
        //if ((sender as Telerik.WebControls.RadNumericTextBox).Text.Trim() != "") value = Convert.ToInt32((sender as Telerik.WebControls.RadNumericTextBox).Text);
        



        //if (hf_kp_id != null)
        //{
        //    DataAccess da = new DataAccess();
        //    String res = da.updateAccountabilityEnrollment(Convert.ToInt32(hf_kp_id.Value),
        //                                                   value,
        //                                                   HttpContext.Current.User.Identity.Name.ToString());
        //}
    }


    protected void btn_Save_Click(object sender, EventArgs e)
    {
       foreach (Telerik.Web.UI.GridDataItem gdi in rg_Enrollment.Items)
       {
           ds_Enrollment.UpdateParameters.Clear();
           ds_Enrollment.UpdateParameters.Add("p_key_cte_enrollment_id", gdi["key_cte_enrollment_id"].Text.ToString());
           ds_Enrollment.UpdateParameters.Add("p_nbr_students", ((Telerik.WebControls.RadNumericTextBox)gdi["nbr_students"].FindControl("nbr_studentsTextBox")).Text);
           ds_Enrollment.UpdateParameters.Add("p_txt_updated_by", HttpContext.Current.User.Identity.Name.ToString());
           ds_Enrollment.Update();       
       }     
    }



    protected void LockGrid_toColleges()
    {
        //if dd_CoreIndicator.SelectedValue all unlocked else colleges only         //make changes to special pop
       
        int length = rg_Enrollment.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader).Length;
        for (int i = 0; i < length; i++)
        {
            Telerik.Web.UI.GridGroupHeaderItem groupHeader = (Telerik.Web.UI.GridGroupHeaderItem)rg_Enrollment.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader)[i];
            Telerik.Web.UI.GridItem[] children = groupHeader.GetChildItems();

            foreach (Telerik.Web.UI.GridItem child in children)
            {
                try
                {
                    #region Grid Control Variable Setup
                    Telerik.Web.UI.GridDataItem dataItem = child as Telerik.Web.UI.GridDataItem;
                    Telerik.WebControls.RadNumericTextBox mynumbox = ((child.FindControl("nbr_studentsTextBox") as Telerik.WebControls.RadNumericTextBox));
                  
                    #endregion

                    
                    #region LockDown Grid based on Accountablity Level
                    string levelid = Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString();
                    if (levelid == "104")
                    {
                        mynumbox.Attributes.Add("readonly", "readonly");
                     
                    }
                    if (Session[Session.SessionID + "roleid"].ToString() != "101" && (i == 0 || i == 1))
                    {
                        mynumbox.Attributes.Add("readonly", "readonly");
                    }

                    else if (levelid == "100" || levelid == "102")
                    {
                        if (Session[Session.SessionID + "roleid"].ToString() != "101")
                        {
                            mynumbox.Attributes.Add("readonly", "readonly");
                            btn_Save.Visible = false;

                        }
                       
                    }
                    //added for AA requestion 10/26/2011 lets less security on data entry
                    if ((Session[Session.SessionID + "roleid"].ToString() == "103" || Session[Session.SessionID + "roleid"].ToString() == "105") && (levelid == "101" || levelid == "103") && i == 2)
                    {
                        mynumbox.Attributes.Remove("readonly");
                        btn_Save.Visible = true;
                    }
                    #endregion
  







                }
                catch(Exception ex)
                {
                    string mystring = ex.Message;
                }
            }
        }
    }


    protected void rg_Enrollment_DataBound(object sender, EventArgs e)
    {
        LockGrid_toColleges();
        RadNumbox_TextChanged();

        //Add Label to Group Total
        int length = rg_Enrollment.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader).Length;
        for (int i = 0; i < length; i++)
        {
            Telerik.Web.UI.GridGroupHeaderItem groupHeader = (Telerik.Web.UI.GridGroupHeaderItem)rg_Enrollment.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader)[i];
            Telerik.Web.UI.GridItem[] children = groupHeader.GetChildItems();
            int numtotal = 0;

            foreach (Telerik.Web.UI.GridItem child in children)
            {
                try
                {
                    Telerik.Web.UI.GridDataItem dataItem = child as Telerik.Web.UI.GridDataItem;

                    Telerik.WebControls.RadNumericTextBox nbr_studentsTextBox = (Telerik.WebControls.RadNumericTextBox)child.FindControl("nbr_studentsTextBox");
                   
                    Telerik.Web.UI.GridTableView tableView = (Telerik.Web.UI.GridTableView)dataItem.NamingContainer;

                    if(nbr_studentsTextBox != null)
                        numtotal += Convert.ToInt32((child.FindControl("nbr_studentsTextBox") as Telerik.WebControls.RadNumericTextBox).Text);
                    
                }
                catch
                {
                }
            }
            Telerik.Web.UI.GridGroupFooterItem groupfooter = (Telerik.Web.UI.GridGroupFooterItem)rg_Enrollment.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupFooter)[i];
            groupfooter.Cells[(rg_Enrollment.MasterTableView.GetColumn("nbr_students").OrderIndex)].Text = @"<label id=""Total" + i.ToString() + @""">" + numtotal.ToString() + "</label>";
        }
    }







    protected void RadNumbox_TextChanged()
    {
        try
        {

            double numtotal = 0;
            double gendertotal = 0;
            double ethnicitytotal = 0;
            int length = rg_Enrollment.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader).Length;
            for (int i = 0; i < length; i++)
            {
                Telerik.Web.UI.GridGroupHeaderItem groupHeader = (Telerik.Web.UI.GridGroupHeaderItem)rg_Enrollment.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader)[i];
                Telerik.Web.UI.GridItem[] children = groupHeader.GetChildItems();
                numtotal = 0;
               
                foreach (Telerik.Web.UI.GridItem child in children)
                {
                    try
                    {
                        Telerik.Web.UI.GridDataItem dataItem = child as Telerik.Web.UI.GridDataItem;
                        numtotal += Convert.ToDouble((child.FindControl("nbr_studentsTextBox") as Telerik.WebControls.RadNumericTextBox).Text);                      
                        Telerik.Web.UI.GridTableView tableView = (Telerik.Web.UI.GridTableView)dataItem.NamingContainer;
                        //if (Convert.ToDouble((child.FindControl("rdnum_studtsnumerator") as RadNumericTextBox).Text) > Convert.ToDouble((child.FindControl("rdnum_studtsdenominator") as RadNumericTextBox).Text))
                        //{
                        //    Label mylabel = new Label();
                        //    mylabel.Text = @"</br><font color=""Red"">Numerator can not exceed Denominator</font>";
                        //    child.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("nbr_students_numerator").OrderIndex)].Controls.Add(mylabel);
                        //}
                    }
                    catch
                    {
                    }
                }

                Telerik.Web.UI.GridGroupFooterItem groupfooter = (Telerik.Web.UI.GridGroupFooterItem)rg_Enrollment.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupFooter)[i];

                Label mylabel = new Label();
               
                mylabel.Width = System.Web.UI.WebControls.Unit.Pixel(90);
                mylabel.Text = @"<div style=""text-align:right"">" + numtotal.ToString() + "</div>";

                groupfooter.Cells[(rg_Enrollment.MasterTableView.GetColumn("nbr_students").OrderIndex)].Controls.Add(mylabel);
              
                groupfooter.Cells[(rg_Enrollment.MasterTableView.GetColumn("txt_desc").OrderIndex)].Text = "Grand Total:";

                if (i == 0)
                    gendertotal = numtotal;
                if (i == 1)
                    ethnicitytotal = numtotal;
                
            }

            if (gendertotal != ethnicitytotal)
            {
                lbl_error.Text = "* Gender and Ethnicity totals must equal";
                btn_Save.Enabled = false;

            }
            else
            {
                lbl_error.Text = "";
                btn_Save.Enabled = true;
            }

        }
        catch
        {
        }

        //}
    }




    protected void btn_Export_Excel_Click(object sender, EventArgs e)
    {
        rg_Enrollment.ExportSettings.ExportOnlyData = true;
        rg_Enrollment.ExportSettings.Excel.Format = Telerik.Web.UI.GridExcelExportFormat.ExcelML;
        rg_Enrollment.ExportSettings.OpenInNewWindow = true;
        rg_Enrollment.MasterTableView.ExportToExcel();
        RadNumbox_TextChanged();
    }
    protected void ds_Enrollment_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.AffectedRows > 0)
            lbl_error.Text = "Save Successfully.";
        else
            lbl_error.Text = "Save fail.";
        lbl_error.Visible = true;
    }
    protected void rg_Enrollment_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is Telerik.Web.UI.GridDataItem)
        {
            Telerik.WebControls.RadNumericTextBox nbr_studentsTextBox = e.Item.FindControl("nbr_studentsTextBox") as Telerik.WebControls.RadNumericTextBox;
            if (nbr_studentsTextBox != null)
                nbr_studentsTextBox.Attributes.Add("onchange", "RowChanged()");
        }        
    }
    protected void btn_print_Click(object sender, EventArgs e)
    {
        RadNumbox_TextChanged();
    }
}
