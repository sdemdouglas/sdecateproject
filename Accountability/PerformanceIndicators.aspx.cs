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
using System.Data.SqlClient;
using System.Web.Configuration;

public partial class Accountability_PerformanceIndicators : System.Web.UI.Page
{
    protected void Security_LockoutControl_by_LEVELS()
    {
        try
        {
            string levelid = Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString();
            if (levelid == "104")
            {
                btn_SavePerfInfo.Visible = false;
                btn_SaveHeaderInfo.Visible = false;
            }
            else if (levelid == "100" || levelid == "102")
            {

                if (Session[Session.SessionID + "roleid"].ToString() != "101" )
                {
                   btn_SavePerfInfo.Visible = false ;
                }
                else{
                    btn_SavePerfInfo.Visible = true;
                    }

            }
            else if(levelid == "106")
                btn_SavePerfInfo.Visible = false;
        }
        catch
        {
        }

    }

    protected override void OnPreRenderComplete(EventArgs e)
    {


        #region Remove DropDowns from Master Page
        Panel panControl = (Panel)Master.FindControl("panControl");
        if (panControl != null)
            panControl.Visible = false;


       

        Label Label2 = (Label)Master.FindControl("Label2");
        if (Label2 != null)
            Label2.Visible = false;

        DropDownList DropDownList2 = (DropDownList)Master.FindControl("DropDownList2");
        if (DropDownList2 != null)
            DropDownList2.Visible = false;
        #endregion

     
        try
        {
           
            DropDownList MasterPageCollegeDD = (DropDownList)Master.FindControl("DropDownList1");

            #region Test to see if Accountablity Report Created if not show message of none available
           
            
            
            if (txt_AcctID.Text.Length == 0 || lbl_CurrfiscalYear.Text.Length == 0 || txt_FiscalYear.Text == "")
            {
                pan_TopInfo.Visible = false;
                lbl_errortext.Text = "</br><image src='../images/msgIcons/stop.jpg' style='WIDTH: 25px;VERTICAL-ALIGN: middle; valign=middle; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 26px; BORDER-BOTTOM-STYLE: none' />  There is no Accountablity Report for the selected year! Please contact system office.";
        
                Label7.Visible = false;
                dd_CoreIndicator.Visible = false;
                btn_SavePerfInfo.Visible = false;
                btn_Export_Excel.Visible = false;
                lbl_CurrfiscalYear.Visible = false;
            }
            else
            {
                pan_TopInfo.Visible = true;
                lbl_errortext.Text = "";
                Label7.Visible = true;
                dd_CoreIndicator.Visible = true;
                btn_SavePerfInfo.Visible = true;
                btn_Export_Excel.Visible = true;
                lbl_CurrfiscalYear.Visible = true;
            }
            #endregion
    
            
            DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());

            #region Test to see if College Changed if so bounce user back to front page
           
            
            if (MasterPageCollegeDD.SelectedValue != myobj.CollID)
            {
                Response.Redirect("AccountabilityReport.aspx");
            }

            #endregion
       
        
        }
        catch
        {
        }

        #region fill dd_CoreIndicator  with "select Indicator
        if (!IsPostBack)
        {
            ListItem BlankCoreindicatoritem = new ListItem("Select Indicator", "-1");
            dd_CoreIndicator.Items.Insert(0, BlankCoreindicatoritem);
            dd_CoreIndicator.SelectedIndex = 0;
        }
        #endregion 


        if (Session[Session.SessionID + "roleid"].ToString() != "101" )
        {
            LockGrid_toColleges();
            chk_NotApplicable.Enabled = false;
            #region LockTextBoxes from Colleges
           
//10/18/2011 RL changed Per Stephanie Request to allow colleges to add 1p1 numbers
 if (Session[Session.SessionID + "roleid"].ToString() == "101")
        {
            
           
            rdNum_AdjustPerf.ReadOnly = false;
            rdNum_StudNum.ReadOnly = false;
            rdNum_StudDen.ReadOnly = false;
}
//else
//{
try
{
    string levelid = Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString();
    if ((levelid == "101" || levelid == "103") && (dd_CoreIndicator.SelectedValue.ToString() == "101") && (Session[Session.SessionID + "roleid"].ToString() == "103" || Session[Session.SessionID + "roleid"].ToString() == "105"))
    {
        rdNum_AdjustPerf.ReadOnly = false;
        rdNum_StudNum.ReadOnly = false;
        rdNum_StudDen.ReadOnly = false;
    }
    else
    {
        rdNum_AdjustPerf.ReadOnly = true;
        rdNum_StudNum.ReadOnly = true;
        rdNum_StudDen.ReadOnly = true;
    }
}
catch
{
    rdNum_AdjustPerf.ReadOnly = true;
    rdNum_StudNum.ReadOnly = true;
    rdNum_StudDen.ReadOnly = true;
}
  //  }        



rdn_90adj.ReadOnly = true;
            rdn_ActualLvePerf.ReadOnly = true;
            rdn_adj_vs_act.ReadOnly = true;

            #endregion


            #region if Not Applicable Check empty and disable the boxes
            if (chk_NotApplicable.Checked)
            {
                rdNum_AdjustPerf.Text = string.Empty;
                rdNum_StudNum.Text = string.Empty;
                rdNum_StudDen.Text = string.Empty;
                rdn_90adj.Text = string.Empty;
                rdn_ActualLvePerf.Text = string.Empty;
                rdn_adj_vs_act.Text = string.Empty;    
                rdNum_AdjustPerf.ReadOnly = true;
                rdNum_StudNum.ReadOnly = true;
                rdNum_StudDen.ReadOnly = true;
                rdn_90adj.ReadOnly = true;
                rdn_ActualLvePerf.ReadOnly = true;
                rdn_adj_vs_act.ReadOnly = true;
               // lbl_notApplicableMSG.Text = "Indicator not applicable";


            }
            else
            {
             //   lbl_notApplicableMSG.Text = "Indicator Applicable";
            }
            #endregion
        }
        else
        {
          //  lbl_notApplicableMSG.Text = "Indicator Applicable";
            
        }
        if (chk_NotApplicable.Checked)
        {
           // lbl_notApplicableMSG.Visible = true;
        }




     if (rdNum_AdjustPerf.Text.Equals("") ||
            rdNum_StudNum.Text.Equals("") ||
            rdNum_StudDen.Text.Equals("") )
        {
           
            rtb_indicator_plan.Tabs[1].Visible = false;
            rtb_indicator_plan.Tabs[2].Visible = false;
        }
        else
        {
          
            rtb_indicator_plan.Tabs[1].Visible = true;
        }

        Security_LockoutControl_by_LEVELS();
        if (rdn_90adj.Text.Trim().ToLower() == "n"  )
        {
            rtb_indicator_plan.Tabs[2].Visible = true;
        }

        if ((chk_NotApplicable.Checked))
        {
            rtb_indicator_plan.Tabs[1].Visible = false;
            rtb_indicator_plan.Tabs[2].Visible = false;
        }
        #region Grid_TO_TabFinalCleanup
        foreach (Telerik.Web.UI.GridDataItem di in rdg_perfDetailInfo.Items)
        {
            Label mylabelvisble = (Label)(di.FindControl("lbl_VisibleYN_response"));
            
            if(mylabelvisble != null)            
                if (mylabelvisble.Text.Trim().ToLower() == "n")
                {
                    try
                    {
                        if (di["key_population_category_id"].Text.ToString() == "103")
                            rtb_indicator_plan.Tabs[2].Visible = true;
                    }
                    catch
                    {
                    }
                }
        
        }
        #endregion 
        base.OnPreRenderComplete(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            chk_NotApplicable.Attributes.Add("onClick", "Checked_Applicable();");
            GetCurrentLevel();
            txt_LoggedPerson.Text = HttpContext.Current.User.Identity.Name.ToString();

            try
            {
                DecipherSession myobj = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());


                txt_AcctID.Text = myobj.AcctID;
                txt_CollegeID.Text = myobj.CollID;
                txt_FiscalYear.Text = myobj.FiscalYear;

                lbl_CurrfiscalYear.Text = "Fiscal Year: " + myobj.FiscalYear;
                if (lbl_CurrfiscalYear.Text.Length > 0)
                {
                    lbl_CurrfiscalYear.Text += ("  " + Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "LevelTitle"].ToString());
                }


            }
            catch
            {
            }

        }

    }

    protected void dd_CoreIndicator_SelectedIndexChanged(object sender, EventArgs e)
    {

       // RadMultiPage1.SelectedIndex = 2;
        if (dd_CoreIndicator.SelectedIndex > 0)
        {
            pan_TopProvided.Visible = true;
            pan_bottom_Provided.Visible = true;
            //btn_print.Enabled = true;
            //btn_print.OnClientClick = "Javascript:OpenReports(" + txt_AcctID.Text + "," + dd_CoreIndicator.SelectedValue.ToString() + ");return false;";
            //btn_Export_Excel.Enabled = true;

            //Check if this is Saved, don't change tab and pageview values
            try
            {
                if (!(sender as Button).Text.Trim().Equals("Save"))
                {
                    
                }
            }
            catch {
                rtb_indicator_plan.SelectedIndex = 0;
                RadMultiPage1.SelectedIndex = 2;
            }
        }
        else
        {

            pan_TopProvided.Visible = false;
            pan_bottom_Provided.Visible = false;
            btn_print.Enabled = false;
            btn_Export_Excel.Enabled = false;
        }
        try
        {
            DataView dv = (DataView)sqlDS_PerfHeaderInfo.Select(DataSourceSelectArguments.Empty);
            DataSet headerdata = dv.Table.DataSet.Copy();
            rdNum_StudNum.Text = "";
            rdNum_StudDen.Text = "";
            rdNum_AdjustPerf.Text = "";
            rdn_ActualLvePerf.Text = "";
            rdn_adj_vs_act.Text = ""; ;
            rdn_90adj.Text = "";
                     
            if (headerdata.Tables[0].Rows.Count > 0)
            {
                btn_SaveHeaderInfo.Text = "Update";
                foreach (DataRow dr in headerdata.Tables[0].Rows)
                {
                    rtb_indicator_plan.Tabs[1].Visible = true;
                  //  rtb_indicator_plan.Tabs[2].Visible = true; 
                    chk_NotApplicable.Checked = Convert.ToBoolean(dr["flg_not_required"].ToString());

                    if (!chk_NotApplicable.Checked)
                    {
                        btn_print.Enabled = true;
                        btn_print.OnClientClick = "Javascript:OpenReports(" + txt_AcctID.Text + "," + dd_CoreIndicator.SelectedValue.ToString() + ");return false;";
                        btn_Export_Excel.Enabled = true;
                    }
                    else
                    {
                        btn_print.Enabled = false;                       
                        btn_Export_Excel.Enabled = false;
                    }
                    
                    txt_HeaderID.Text = dr["key_perf_report_hdr_id"].ToString();
                    rdNum_StudNum.Text = dr["nbr_students_numerator"].ToString();
                    rdNum_StudDen.Text = dr["nbr_student_denominator"].ToString();

                    System.Globalization.NumberFormatInfo provider = new System.Globalization.NumberFormatInfo();
                    provider.NumberDecimalDigits = 2;
                    string mytempstring = dr["nbr_adjusted_lvl_perf"].ToString();
                    rdNum_AdjustPerf.Text = (Convert.ToDouble(mytempstring)).ToString("N", provider);
                    rdn_ActualLvePerf.Text = FormatNumbers_ForHeaders(dr["nbr_actual_level_of_performance"].ToString());
                    rdn_adj_vs_act.Text = FormatNumbers_ForHeaders(dr["nbr_perfomance_variance"].ToString());

                    if (Convert.ToBoolean(dr["flg_not_required"].ToString()))
                        rdn_90adj.Text = "";
                    else
                        rdn_90adj.Text = dr["flg_performance_level_pass"].ToString();
                     
                    txt_updateMode.Text = "1";

                   

                }
            }
            else
            {
                rtb_indicator_plan.Tabs[1].Visible = false;
                RadMultiPage1.SelectedIndex = 2;
               // rtb_indicator_plan.Tabs[2].Visible = false;
                btn_SaveHeaderInfo.Text = "Save";
                txt_HeaderID.Text = "";
                rdNum_StudNum.Text = "";
                rdNum_StudDen.Text = "";
                rdNum_AdjustPerf.Text = "";
                txt_updateMode.Text = "0";
            }

            sqlDS_perfDetailInfo.Select(DataSourceSelectArguments.Empty);
            rdg_perfDetailInfo.DataBind();
        }
        catch
        {
        }
    }

    public string FormatNumbers_ForHeaders(string vari)
    {
        try
        {
            System.Globalization.NumberFormatInfo provider = new System.Globalization.NumberFormatInfo();
            provider.NumberDecimalDigits = 2;
           
            return (Convert.ToDouble(vari)).ToString("N",provider) + "%";
        }
        catch
        {
            return "";
        }

    }



    protected void btn_SavePerfInfo_Click(object sender, EventArgs e)
    {
        
        if (rtb_indicator_plan.SelectedIndex == 1)
        {
           
            RadNumbox_TextChanged();
            if (Indicator_Numerator_Denominator_Validation())
            {

                foreach (Telerik.Web.UI.GridDataItem gdi in rdg_perfDetailInfo.Items)
                {
                    sqlDS_perfDetailInfo.UpdateParameters.Clear();
                    sqlDS_perfDetailInfo.UpdateParameters.Add("p_key_accountability_perf_detail_id", gdi["key_accountability_perf_detail_id"].Text.Trim());
                    sqlDS_perfDetailInfo.UpdateParameters.Add("p_nbr_students_numerator", ((RadNumericTextBox)gdi["nbr_students_numerator"].FindControl("rdnum_studtsnumerator")).Text);
                    sqlDS_perfDetailInfo.UpdateParameters.Add("p_nbr_student_denominator", ((RadNumericTextBox)gdi["nbr_student_denominator"].FindControl("rdnum_studtsdenominator")).Text);
                    sqlDS_perfDetailInfo.UpdateParameters.Add("p_dte_date_created", System.DateTime.Now.Date.ToShortDateString());

                    sqlDS_perfDetailInfo.UpdateParameters.Add("p_txt_updated_by", HttpContext.Current.User.Identity.Name.ToString());
                    sqlDS_perfDetailInfo.Update();

                    lbl_numden_ValidationError.Visible = false;

                }
            }

            else
            {
                lbl_numden_ValidationError.Visible = true;
            }
        }

        if (chk_NotApplicable.Checked)
        {
            rdNum_AdjustPerf.Text = "0";
            rdNum_StudNum.Text = "0";
            rdNum_StudDen.Text = "0";
            rdn_90adj.Text = "";
            rdn_ActualLvePerf.Text = "0";
            rdn_adj_vs_act.Text = "";


            //pr_acc_accountability_imprv_plan_del @p_key_perf_report_hdr_id

           //pr_acc_accountability_perf_detail_del @p_key_perf_report_hdr_id

            SqlConnection mycon = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);
            SqlCommand mycom = new SqlCommand("pr_acc_accountability_imprv_plan_del", mycon);
            mycom.CommandType = CommandType.StoredProcedure;
            mycom.Parameters.AddWithValue("@p_key_perf_report_hdr_id", txt_HeaderID.Text);

            if (mycon.State == ConnectionState.Closed)
            {
                mycon.Open();
            }

            mycom.ExecuteScalar();
      

            SqlConnection mycon1 = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString);
            SqlCommand mycom1 = new SqlCommand("pr_acc_accountability_perf_detail_del", mycon);
            mycom1.CommandType = CommandType.StoredProcedure;
            mycom1.Parameters.AddWithValue("@p_key_perf_report_hdr_id", txt_HeaderID.Text);

            if (mycon1.State == ConnectionState.Closed)
            {
                mycon1.Open();
            }

            mycom1.ExecuteScalar();

        }

            if (txt_updateMode.Text == "0") //New
            {
                sqlDS_PerfHeaderInfo.Insert();
                //dd_CoreIndicator_SelectedIndexChanged(dd_CoreIndicator, null);          
                dd_CoreIndicator_SelectedIndexChanged(btn_SavePerfInfo , null);          
                txt_updateMode.Text = "1";
            }
            else if (txt_updateMode.Text == "1")  //Update
            {
                sqlDS_PerfHeaderInfo.Update();
                dd_CoreIndicator_SelectedIndexChanged(btn_SavePerfInfo, null);
                txt_updateMode.Text = "1";
            }
        
            rtb_indicator_plan.Tabs[1].Visible = true;
            rtb_indicator_plan.Tabs[2].Visible = false;


        
        foreach(Telerik.Web.UI.GridDataItem di in rdg_perfDetailInfo.Items)
        {
            Label mylabelvisble = (Label)(di.FindControl("lbl_VisibleYN_response"));
            if (mylabelvisble.Text.Trim().ToLower() == "n")
            {
                try
                {
                    
                    sqlDS_ImprovementPlan.Insert();
                    if (di["key_population_category_id"].Text.ToString() == "103")
                    rtb_indicator_plan.Tabs[2].Visible = true;
                }
                catch
                {
                }
            }
        }
           
         
    }

    protected void btn_SaveHeaderInfo_Click(object sender, EventArgs e)
    {
        
        if (txt_updateMode.Text  == "0") //New
        {
            sqlDS_PerfHeaderInfo.Insert();
            txt_updateMode.Text = "1";
        }
        else if (txt_updateMode.Text == "1")  //Update
        {
            sqlDS_PerfHeaderInfo.Update();
            txt_updateMode.Text = "1";
        }

        rtb_indicator_plan.Tabs[1].Visible = true;
      //  rtb_indicator_plan.Tabs[2].Visible = true;
    


    }
    protected void sqlDS_PerfHeaderInfo_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        string HeaderID = e.Command.Parameters["@return_value"].Value.ToString();
        txt_HeaderID.Text = HeaderID;
    }

  
    double Numtotal = 0;
    double Dentotal = 0;

  
    protected void rdg_perfDetailInfo_ItemDataBound1(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
     
       rtb_indicator_plan.Tabs[2].Visible = false;
        if (e.Item is Telerik.Web.UI.GridDataItem)
        {
            try
            {   
                System.Globalization.NumberFormatInfo provider  = new System.Globalization.NumberFormatInfo();
                provider.PercentDecimalDigits=2;

                Label mylab = (Label)e.Item.FindControl("nbr_actual_level_of_performanceLabel");
                mylab.Text = (Convert.ToDouble(mylab.Text)).ToString("N",provider) +"%";

       Label mylab1 = (Label)e.Item.FindControl("nbr_perfomance_varianceLabel");
    


                mylab1.Text = (Convert.ToDouble(mylab1.Text)).ToString("N",provider) +"%";
                Numtotal += Convert.ToDouble(((RadNumericTextBox)e.Item.FindControl("rdnum_studtsnumerator")).Text);


                Label mylabel = (Label)(e.Item.FindControl("lbl_PerfYN"));
                Label mylabelvisble = (Label)(e.Item.FindControl("lbl_VisibleYN_response"));

                if (mylabel.Text.Trim().ToLower() == "true")
                {
                    mylabelvisble.Text = "Y";
                    
                }
                else
                {
                    mylabelvisble.Text = "N";
                    if(((Telerik.Web.UI.GridDataItem)e.Item)["key_population_category_id"].Text.ToString() == "103")
                   rtb_indicator_plan.Tabs[2].Visible = true;
                 
                }
            }
            catch
            {
                Label mylabelvisble = (Label)(e.Item.FindControl("lbl_VisibleYN_response"));
                mylabelvisble.Text = "";
            }
            
        }

        else if (e.Item is Telerik.Web.UI.GridFooterItem)
        {
            //Telerik.Web.UI.GridFooterItem footerItem = e.Item as Telerik.Web.UI.GridFooterItem;
            //Label mylabel = new Label();
            //mylabel.Text = "HELLO THIS IS A TEST";
            //footerItem["nbr_students_numerator"].Controls.Add(new LiteralControl("hello world test"));
          //  footerItem["nbr_students_numerator"].Controls.AddAt(1, mylabel);
        }





        
    }
    protected void rdg_perfDetailInfo_PreRender(object sender, EventArgs e)
    {
       

    }
    protected void rdg_perfDetailInfo_DataBound(object sender, EventArgs e)
    {
        try
        {
            double numtotal = 0;
            double dentotal = 0;
            int length = rdg_perfDetailInfo.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader).Length;
            for (int i = 0; i < length; i++)
            {
                Telerik.Web.UI.GridGroupHeaderItem groupHeader = (Telerik.Web.UI.GridGroupHeaderItem)rdg_perfDetailInfo.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader)[i];
                Telerik.Web.UI.GridItem[] children = groupHeader.GetChildItems();
                numtotal = 0;
                dentotal = 0;
                foreach (Telerik.Web.UI.GridItem child in children)
                {
                    try
                    {
                        Telerik.Web.UI.GridDataItem dataItem = child as Telerik.Web.UI.GridDataItem;
                      
                        RadNumericTextBox studnumebox = (RadNumericTextBox)child.FindControl("rdnum_studtsnumerator");
                        studnumebox.Attributes.Add("Onchange", "IndicatorNumerator_GroupTotals();");

                        
                        RadNumericTextBox studdenbox = (RadNumericTextBox)child.FindControl("rdnum_studtsdenominator");
                        studdenbox.Attributes.Add("Onchange", "IndicatorDenominator_GroupTotals();");
                        
                       
                        double num;
                        Telerik.Web.UI.GridTableView tableView = (Telerik.Web.UI.GridTableView)dataItem.NamingContainer;
                        if(double.TryParse((child.FindControl("rdnum_studtsnumerator") as RadNumericTextBox).Text,out num))
                        numtotal += Convert.ToDouble((child.FindControl("rdnum_studtsnumerator") as RadNumericTextBox).Text);
                    if (double.TryParse((child.FindControl("rdnum_studtsdenominator") as RadNumericTextBox).Text, out num))
                        dentotal += Convert.ToDouble((child.FindControl("rdnum_studtsdenominator") as RadNumericTextBox).Text);

                    }
                    catch (Exception ex1)
                    {
                        string mystring = ex1.Message.ToString();

                    }
                }

                Telerik.Web.UI.GridGroupFooterItem groupfooter = (Telerik.Web.UI.GridGroupFooterItem)rdg_perfDetailInfo.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupFooter)[i];
                //groupfooter.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("nbr_students_numerator").OrderIndex)].Text = numtotal.ToString();
                //groupfooter.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("nbr_student_denominator").OrderIndex)].Text = dentotal.ToString();

                groupfooter.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("nbr_students_numerator").OrderIndex)].Text = @"<label id=""NumSumTotal" + i.ToString() + @""">" + numtotal.ToString() + "</label>" ;

                groupfooter.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("nbr_student_denominator").OrderIndex)].Text = @"<label id=""DenSumTotal" + i.ToString() + @""">" + dentotal.ToString() + "</label>";

                groupfooter.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("txt_desc").OrderIndex)].Text = "Total:";
            }

        }
        catch
        {
        }
    }




    protected void rdg_perfDetailInfo_ExcelMLExportRowCreated(object source, Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLRowCreatedArgs e)
    {
        if (e.RowType == Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLRowType.DataRow)
        {
            if (e.Row.Cells[0] != null && ((string)e.Row.Cells[0].Data.DataItem).Contains("U"))
            {
                e.Row.Cells[0].StyleValue = "MyCustomStyle";
            }
        }
    }
    protected void rdg_perfDetailInfo_ExcelMLExportStylesCreated(object source, Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLStyleCreatedArgs e)
    {
        foreach (Telerik.Web.UI.GridExcelBuilder.StyleElement style in e.Styles)
        {
            if (style.Id == "headerStyle")
            {
                style.FontStyle.Bold = true;
                style.FontStyle.Color = System.Drawing.Color.Gainsboro;
                style.InteriorStyle.Color = System.Drawing.Color.Blue;
                style.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
            }
            else if (style.Id == "itemStyle")
            {
                style.InteriorStyle.Color = System.Drawing.Color.WhiteSmoke;
                style.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
            }
            else if (style.Id == "alternatingItemStyle")
            {
                style.InteriorStyle.Color = System.Drawing.Color.LightGray;
                style.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
            }
        }

        Telerik.Web.UI.GridExcelBuilder.StyleElement myStyle = new Telerik.Web.UI.GridExcelBuilder.StyleElement("MyCustomStyle");
        myStyle.FontStyle.Bold = true;
        myStyle.FontStyle.Italic = true;
        myStyle.InteriorStyle.Color = System.Drawing.Color.Gray;
        myStyle.InteriorStyle.Pattern = Telerik.Web.UI.GridExcelBuilder.InteriorPatternType.Solid;
        e.Styles.Add(myStyle);
    }
    protected void imgb_Excel_Click(object sender, ImageClickEventArgs e)
    {
        rdg_perfDetailInfo.ExportSettings.ExportOnlyData = true;
        rdg_perfDetailInfo.ExportSettings.Excel.Format = Telerik.Web.UI.GridExcelExportFormat.ExcelML;
        rdg_perfDetailInfo.ExportSettings.OpenInNewWindow = true;
       rdg_perfDetailInfo.MasterTableView.ExportToExcel();
    }



    private void GetCurrentLevel()
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


            lbl_Level.Text = dv.Table.Rows[0][3].ToString();
        }
        catch
        {
        }

    }
    protected void rdg_ImprovementPlan_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        //img_edit
        try
        {
            if (e.Item is Telerik.Web.UI.GridDataItem)
            {
                Telerik.Web.UI.GridDataItem myitem = (Telerik.Web.UI.GridDataItem)e.Item;
                ImageButton mybutton = new ImageButton();
                mybutton = (ImageButton)myitem.FindControl("img_edit");
                mybutton.OnClientClick = "javascript:popup_ImprovementPlanEdit('" + myitem["key_acc_accountability_imprv_plan_id"].Text + "','" + myitem["key_perf_report_hdr_id"].Text + "','" + Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString() +"');return false;";



              
                 
                    if ((myitem["flg_narrative_response"].FindControl("lbl_narrative_response") as Label).Text == "0")
                        (myitem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Checked = false;
                    else
                        (myitem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Checked = true;
                    (myitem["flg_narrative_response"].FindControl("chk_narrative_response") as CheckBox).Attributes.Add("disabled", "true");
               
            
            
            
            }
        }
        catch
        {
        }

    }




    protected void rdnum_inGridInfo_TextChanged(object sender, EventArgs e)
    {
       // foreach (Telerik.Web.UI.GridDataItem gi in rdg_perfDetailInfo)
       //{
      //  RadNumbox_TextChanged();
       // btn_SavePerfInfo.Enabled = Indicator_Numerator_Denominator_Validation();
      
    }



    protected Boolean Indicator_Numerator_Denominator_Validation()
    {
        Boolean validated = true;
        
         return validated;

    }
    protected void LockGrid_toColleges()
    {
        //if dd_CoreIndicator.SelectedValue all unlocked else colleges only         //make changes to special pop
        
  int length = rdg_perfDetailInfo.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader).Length;
            for (int i = 0; i < length; i++)
            {
                Telerik.Web.UI.GridGroupHeaderItem groupHeader = (Telerik.Web.UI.GridGroupHeaderItem)rdg_perfDetailInfo.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader)[i];
                Telerik.Web.UI.GridItem[] children = groupHeader.GetChildItems();
               
                foreach (Telerik.Web.UI.GridItem child in children)
                {
                    try
                    {
                        #region Grid Control Variable Setup
                        Telerik.Web.UI.GridDataItem dataItem = child as Telerik.Web.UI.GridDataItem;
                                RadNumericTextBox mynumbox = ((child.FindControl("rdnum_studtsnumerator") as RadNumericTextBox));
                          RadNumericTextBox mydenbox = ((child.FindControl("rdnum_studtsdenominator") as RadNumericTextBox));
                        #endregion 


                          #region LockDown Grid based on Accountablity Level
                          string levelid = Session[HttpContext.Current.User.Identity.Name + Session.SessionID + "ACCLevelID"].ToString();
                          if (levelid == "104")
                          {
                              mynumbox.Attributes.Add("readonly", "readonly");
                              mydenbox.Attributes.Add("readonly", "readonly");
                          }

                          else if (levelid == "100" || levelid == "102")
                                 {
//rl 10/20/2011 change for non admins to enter value
                                     if (Session[Session.SessionID + "roleid"].ToString() != "101" )
                                      {

                                          if (i == 2 && (Session[Session.SessionID + "roleid"].ToString() != "101" || Session[Session.SessionID + "roleid"].ToString() != "103" || Session[Session.SessionID + "roleid"].ToString() != "105"))
                                          { }
                                          else 
                                          {
                                              mynumbox.Attributes.Add("readonly", "readonly");
                                              mydenbox.Attributes.Add("readonly", "readonly");
                                          }

                                      }
                               }
                          #endregion

//RL 10/20/2011 change for non admins to enter value
                          if (Session[Session.SessionID + "roleid"].ToString() != "101" )
                        {

                          
                            if (dd_CoreIndicator.SelectedValue != "101" && (i == 0 || i == 1))
                            {
                               
                                mynumbox.Attributes.Add("readonly", "readonly");
                                mydenbox.Attributes.Add("readonly", "readonly");
                                Telerik.Web.UI.GridTableView tableView = (Telerik.Web.UI.GridTableView)dataItem.NamingContainer;
                            }

                           
                        }

                        



                     
                     
                    }
                    catch
                    {
                    }
                }
            }



    }
    protected void RadNumbox_TextChanged()
    {
        try
        {

            double numtotal = 0;
            double dentotal = 0;
            int length = rdg_perfDetailInfo.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader).Length;
            for (int i = 0; i < length; i++)
            {
                Telerik.Web.UI.GridGroupHeaderItem groupHeader = (Telerik.Web.UI.GridGroupHeaderItem)rdg_perfDetailInfo.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupHeader)[i];
                Telerik.Web.UI.GridItem[] children = groupHeader.GetChildItems();
                numtotal = 0;
                dentotal = 0;
                foreach (Telerik.Web.UI.GridItem child in children)
                {
                    try
                    {
                        Telerik.Web.UI.GridDataItem dataItem = child as Telerik.Web.UI.GridDataItem;
                        numtotal += Convert.ToDouble((child.FindControl("rdnum_studtsnumerator") as RadNumericTextBox).Text);
                        dentotal += Convert.ToDouble((child.FindControl("rdnum_studtsdenominator") as RadNumericTextBox).Text);
                        Telerik.Web.UI.GridTableView tableView = (Telerik.Web.UI.GridTableView)dataItem.NamingContainer;
                        if (Convert.ToDouble((child.FindControl("rdnum_studtsnumerator") as RadNumericTextBox).Text) > Convert.ToDouble((child.FindControl("rdnum_studtsdenominator") as RadNumericTextBox).Text))
                        { Label mylabel = new Label();
                            mylabel.Text =@"</br><font color=""Red"">Numerator can not exceed Denominator</font>";
                            child.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("nbr_students_numerator").OrderIndex)].Controls.Add(mylabel);
                        }
                    }
                    catch
                    {
                    }
                }

                Telerik.Web.UI.GridGroupFooterItem groupfooter = (Telerik.Web.UI.GridGroupFooterItem)rdg_perfDetailInfo.MasterTableView.GetItems(Telerik.Web.UI.GridItemType.GroupFooter)[i];
                groupfooter.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("nbr_students_numerator").OrderIndex)].Text = numtotal.ToString();
                groupfooter.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("nbr_student_denominator").OrderIndex)].Text = dentotal.ToString();

                groupfooter.Cells[(rdg_perfDetailInfo.MasterTableView.GetColumn("txt_desc").OrderIndex)].Text = "Total:";
            }

        }
        catch
        {
        }
        //}
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
        switch (GetCurrentLevel_Id())
        {
            case "101":
                break;
        }
    }
    protected void btn_Export_Excel_Click(object sender, EventArgs e)
    {
        rdg_perfDetailInfo.ExportSettings.ExportOnlyData = true;
        rdg_perfDetailInfo.ExportSettings.Excel.Format = Telerik.Web.UI.GridExcelExportFormat.ExcelML;
        rdg_perfDetailInfo.ExportSettings.OpenInNewWindow = true;
        rdg_perfDetailInfo.MasterTableView.ExportToExcel();
    }
}
