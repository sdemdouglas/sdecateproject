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
public partial class Accountability_Reports_ViewAccountablity_Reports : System.Web.UI.Page
{

    protected override void  OnPreRenderComplete(EventArgs e)
{
 	
       
        
        base.OnPreRenderComplete(e);
}
    protected void Page_Load(object sender, EventArgs e)
    {
        string acctID = Request.QueryString["accoutablityID"].ToString();
        string coreindicatorID = Request.QueryString["coredindicator"].ToString();
        runreport(acctID, coreindicatorID);
    }



    protected void runreport(string acctid, string coreid)
    {
        List<ReportParameter> paramList = new List<ReportParameter>();
       
        this.RS_Veiwer.ServerReport.ReportPath = "";
        this.RS_Veiwer.ServerReport.Refresh();
        this.RS_Veiwer.ProcessingMode = ProcessingMode.Remote;
        System.Uri myuri = new System.Uri(ConfigurationManager.AppSettings["ReportServerKey"].ToString());
        this.RS_Veiwer.ServerReport.ReportServerUrl = myuri;
        string reportPTH = ConfigurationManager.AppSettings["reportpath"].ToString();



        this.RS_Veiwer.ServerReport.ReportPath = reportPTH + "rpt_annual_performance_report_hdr";

        paramList.Add(new ReportParameter("p_key_accountability_id", acctid.ToString(), false));
        paramList.Add((new ReportParameter("p_key_core_idicator_id", coreid, false)));
        RS_Veiwer.ServerReport.SetParameters(paramList);
        string mimeType, encoding, extension;
        string deviceInfo;
        string[] streamids;
        Microsoft.Reporting.WebForms.Warning[] warnings;


        deviceInfo =
  "<DeviceInfo>" +
  "<SimplePageHeaders>True</SimplePageHeaders>" +
  "</DeviceInfo>";

        byte[] bytes = RS_Veiwer.ServerReport.Render("pdf", deviceInfo, out mimeType, out encoding, out extension, out streamids, out warnings);

        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-disposition", "filename=output.pdf");
        Response.OutputStream.Write(bytes, 0, bytes.Length);
        Response.OutputStream.Flush();
        Response.OutputStream.Close();
        Response.Flush();
        Response.Close();

    }

    protected void dd_CoreIndicator_SelectedIndexChanged(object sender, EventArgs e)
    {
        

    }
}
