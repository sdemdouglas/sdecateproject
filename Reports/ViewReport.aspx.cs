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
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.IO;
using System.Collections.Generic;
using System.Reflection;

using System.Windows.Forms;
using Aspose.Words.Reporting;



public partial class PopUPs_ViewReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string[] myvalue;
        DataView dv = new DataView();
        int x = 0;
        try
        {
            this.RS_Veiwer.ServerReport.ReportPath = "";
            this.RS_Veiwer.ServerReport.Refresh();
            this.RS_Veiwer.ProcessingMode = ProcessingMode.Remote;


            //System.Uri myuri = new System.Uri(ConfigurationManager.AppSettings["GateKeeper2.service"].ToString());
         //   System.Uri myuri = new System.Uri("http://vuits/ReportServer");

            System.Uri myuri = new System.Uri(ConfigurationManager.AppSettings["ReportServerKey"].ToString());
            this.RS_Veiwer.ServerReport.ReportServerUrl = myuri;
            string reportPTH =ConfigurationManager.AppSettings["reportpath"].ToString();
        //     this.RS_Veiwer.ServerReport.ReportServerCredentials.ImpersonationUser.
            string type = null;
            try
            {
                type = Request.QueryString["type"].ToString();
            }
            catch
            {
            }
            List<ReportParameter> paramList = new List<ReportParameter>();
         
            if (type != null)
                switch (type.ToLower())
                {
                    case "assurances":
                        this.RS_Veiwer.ServerReport.ReportPath = "/epms/rpt_performance_evaluation";                         
                        //paramList.Add(new ReportParameter("p_key_evaluation_id", Request.QueryString["Evalid"].ToString(), false));
                        //RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "activities":
                        this.RS_Veiwer.ServerReport.ReportPath = "/epms/rpt_performance_evaluation";
                        paramList.Add(new ReportParameter("p_key_evaluation_id", "101", false));
                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;
                   
                    case "fiscalassurances":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_assurances_by_fiscal_year";
                        paramList.Add(new ReportParameter("p_nbr_fiscal_year", Request.QueryString["fiscalyear"].ToString(), false));
                        paramList.Add(new ReportParameter("p_key_local_plan_id", Request.QueryString["planid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);

                        break;
                    case "narrativeplan":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_local_plan_narrative";
                        paramList.Add(new ReportParameter("key_local_plan_narrative_id", Request.QueryString["keyid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);

                        break;

                    case "narrative_by_id":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_local_plan_narrative_by_id";
                        paramList.Add(new ReportParameter("key_local_plan_narrative_id", Request.QueryString["keyid"].ToString(), false));
                        paramList.Add(new ReportParameter("p_key_local_plan_id", "-1", false));
                        
                        RS_Veiwer.ServerReport.SetParameters(paramList);

                        break;
                   
                    case "fundedactivities":

                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_funded_activity";
                        paramList.Add(new ReportParameter("p_key_activity_id", Request.QueryString["keyid"].ToString(), false));
                     
                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        
                        break;

                    case "equipactivities":

                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_equipment_activity";
                        paramList.Add(new ReportParameter("p_key_activity_id", Request.QueryString["keyid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);

                        break;

                    case "fundedamendment":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_funded_amendment";
                        paramList.Add(new ReportParameter("p_key_activity_id", Request.QueryString["keyid"].ToString(), false));
                     
                        RS_Veiwer.ServerReport.SetParameters(paramList);

                        break;

                

                    case "rpt_funded_activity":
                        dv = (DataView)sqlrl_activitylist.Select(DataSourceSelectArguments.Empty);

                        myvalue = new string[dv.Table.Rows.Count];
                       
                        foreach (DataRow dr in dv.Table.Rows)
                        {
                            myvalue[x] = dr["key_activity_id"].ToString();
                            x++;
                        }
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_funded_activity";
                    
                        paramList.Add(new ReportParameter("p_key_activity_id", myvalue, false));
                                  RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "rpt_equipment_activity":
                       
                         dv = (DataView)sqlrl_activitylist.Select(DataSourceSelectArguments.Empty);

                        myvalue = new string[dv.Table.Rows.Count];
                        
                        foreach (DataRow dr in dv.Table.Rows)
                        {
                            myvalue[x] = dr["key_activity_id"].ToString();
                            x++;
                        }
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_equipment_activity";

                        paramList.Add(new ReportParameter("p_key_activity_id", myvalue, false));
                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                          case "local_plan_cover_page":
                              this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "local_plan_cover_page";
                        paramList.Add(new ReportParameter("p_key_local_plan_id", Request.QueryString["planid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                  
                    case "transferfunds":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_transfer_of_funds";
                        paramList.Add(new ReportParameter("p_key_activity_id", Request.QueryString["keyid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);

                        break;

                    case "rpt_local_plan_activity":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_local_plan_activity_line_items";
                        paramList.Add(new ReportParameter("p_key_local_plan_id", Request.QueryString["keyid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);

                        break;
                    case "fundingplanitems":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_funding_plan_items";
                        paramList.Add(new ReportParameter("p_funding_plan_hdr_id", Request.QueryString["planid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);

                        break;


                    case "rpt_college_funding_plan":
                       this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_college_funding_plan";
                        paramList.Add(new ReportParameter("p_key_local_plan_id", Request.QueryString["planid"].ToString(), false));
                       // this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_college_funding_plan_dynamic";
                       // paramList.Add(new ReportParameter("p_key_funding_plan_hdr_id", Request.QueryString["planid"].ToString(), false));

                       

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "fundingplan":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_college_funding_plan_dynamic";
                        paramList.Add(new ReportParameter("p_key_funding_plan_hdr_id", Request.QueryString["keyid"].ToString(), false));
                       // this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_college_funding_plan";
                      //  paramList.Add(new ReportParameter("p_key_local_plan_id", Request.QueryString["keyid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "rpt_funding_plan_item_v1_org_budget":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_funding_plan_item_v1_org_budget";
                        paramList.Add(new ReportParameter("p_funding_plan_hdr_id", Request.QueryString["planid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "rpt_annual_performance_report_cte_enrollment":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_annual_performance_report_cte_enrollment";
                        paramList.Add(new ReportParameter("p_key_accountability_id", Request.QueryString["aa_id"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "rpt_acc_accountability_narrative_get_rec_id":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_acc_accountability_narrative_get_rec_id";
                        paramList.Add(new ReportParameter("p_key_accountability_narrative_rec_id", Request.QueryString["n_id"].ToString(), false));
                        paramList.Add(new ReportParameter("p_key_accountability_id", Request.QueryString["aa_id"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;


                    case "rpt_annual_performance_report_cover":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_annual_performance_report_cover";                        
                        paramList.Add(new ReportParameter("p_key_accountability_id", Request.QueryString["aa_id"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "pr_rpt_act_activity_transactions":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "pr_rpt_act_activity_transactions";
                        paramList.Add(new ReportParameter("p_key_activity_id", Request.QueryString["Keyid"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "rpt_improvement_plan":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_improvement_plan";
                        paramList.Add(new ReportParameter("p_key_perf_report_hdr_id", Request.QueryString["key_prd_id"].ToString(), false));
                        paramList.Add(new ReportParameter("p_key_acc_accountability_imprv_plan_id", Request.QueryString["key_aip_id"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;

                    case "rpt_annual_performance_report_hdr":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_annual_performance_report_hdr";
                        paramList.Add(new ReportParameter("p_key_accountability_id", Request.QueryString["accoutablityID"].ToString(), false));
                        paramList.Add((new ReportParameter("p_key_core_idicator_id", Request.QueryString["coredindicator"].ToString(), false)));
                        
                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;



                    case "activities_by_catandfundcode":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "Activities_By_CATandFUNDcode";
                        paramList.Add(new ReportParameter("collegeId", Request.QueryString["college_id"].ToString(), false));
                        paramList.Add((new ReportParameter("categoryID", Request.QueryString["category"].ToString(), false)));
                        paramList.Add(new ReportParameter("functionCODE", Request.QueryString["functioncode"].ToString(), false));
                        paramList.Add(new ReportParameter("activitynumber", Request.QueryString["activityORlinetimenumber"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;
                    case "activitybylineitem_functioncode_categorycode":
                        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "ActivitybyLineItem_FunctionCode_CategoryCode";
                        paramList.Add(new ReportParameter("collegeId", Request.QueryString["college_id"].ToString(), false));
                        paramList.Add((new ReportParameter("categoryID", Request.QueryString["category"].ToString(), false)));
                        paramList.Add(new ReportParameter("functionCODE", Request.QueryString["functioncode"].ToString(), false));
                        paramList.Add(new ReportParameter("lineitem", Request.QueryString["activityORlinetimenumber"].ToString(), false));

                        RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;



                    default:
                        //this.RS_Veiwer.ServerReport.ReportPath = "/epms/rpt_performance_evaluation";
                      //    List<ReportParameter> paramList = new List<ReportParameter>();
                        //paramList.Add(new ReportParameter("p_key_evaluation_id", Request.QueryString["Evalid"].ToString(), false));
                        //RS_Veiwer.ServerReport.SetParameters(paramList);
                        break;


                   
                }            

           //////
          
                string mimeType, encoding, extension;
                string deviceInfo;
                string[] streamids;
                Microsoft.Reporting.WebForms.Warning[] warnings;
                String format = String.Empty;
                try
                {
                    format = Request.QueryString.Get("format").ToString().Trim().ToLower(); //Desired format goes here (PDF, Excel, or Image)
                    // 05252012  made all the format stuff lower case comparison
                    // 11/11/09 VV Use AWDOC to stop Office asking for downloading converter 
                    if (format.ToLower() == "awdocx" || format.ToLower() == "awdoc")
                        format = "word";
                }
                catch
                {
                    format = "pdf";
                }
                if (format == null)
                    format = "pdf";

                deviceInfo =
                "<DeviceInfo>" +
                "<SimplePageHeaders>True</SimplePageHeaders>" +
                "</DeviceInfo>";

                byte[] bytes = RS_Veiwer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);
                HttpContext.Current.Response.Buffer = true;
                Response.Clear();
                Response.Buffer = true;

                if (format == "excel")
                {
                    Response.ContentType = "application/ms-excel";  //rl 5/25/2012 excel
                    Response.AddHeader("Content-disposition", "attachment;filename=output.xls");
                }
                else if (format == "pdf")
                {
                    //To pdf
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-disposition", "filename=output.pdf");
                }
                else if (format.ToLower() == "word" )
                {
                    //To Word
                    Response.ContentType = "application/msword";
                    Response.AddHeader("Content-disposition", "filename=output.doc");
                }


                Response.OutputStream.Write(bytes, 0, bytes.Length);
                Response.OutputStream.Flush();
                Response.OutputStream.Close();
                Response.Flush();
                Response.Close();
           

        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
      
    }
}
