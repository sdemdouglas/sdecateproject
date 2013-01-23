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
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using System.Net;
using System.Web.Configuration;


public partial class Reports_ViewCrystalReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportDocument rpt = new ReportDocument();
        
        string type = null;

        try
        {
            type = Request.QueryString["type"].ToString();
        }
        catch
        {
        }       

        try{
            if (type != null)
                switch (type.ToLower())
                {
                    case "narrativeplan":

                        rpt.Load(Server.MapPath("rpt_narrative.rpt"));
                        rpt.SetParameterValue("@key_local_plan_narrative_id", Convert.ToInt32(Request.QueryString["Keyid"].ToString()));
                        //rpt.SetParameterValue("@p_key_local_plan_id", "-1");
                        rpt.SetDatabaseLogon(WebConfigurationManager.AppSettings["CrystalUserName"].ToString(), WebConfigurationManager.AppSettings["CrystalUserPassWord"].ToString());
                        //rpt.SetDatabaseLogon("sa", "666ming");
                        break;

                    case "rpt_multi_narratives":

                        rpt.Load(Server.MapPath("rpt_multi_narratives.rpt"));
                        //rpt.SetParameterValue("@key_local_plan_narrative_id", Convert.ToInt32(Request.QueryString["rcid"].ToString()));
                        rpt.SetParameterValue("@p_key_local_plan_id", Convert.ToInt32(Request.QueryString["PlanId"].ToString()));
                        rpt.SetDatabaseLogon(WebConfigurationManager.AppSettings["CrystalUserName"].ToString(), WebConfigurationManager.AppSettings["CrystalUserPassWord"].ToString());
                     //   rpt.SetDatabaseLogon("sa", "666ming");
                        break;

                    default:               
                        break;
                }


  ExportOptions exp = new ExportOptions();
            //exp.ExportFormatType = ExportFormatType.PortableDocFormat;
            //exp.FormatOptions = new PdfRtfWordFormatOptions();


            //      DiskFileDestinationOptions diskOpts = new DiskFileDestinationOptions();
            //diskOpts.DiskFileName = AppDomain.CurrentDomain.BaseDirectory.Trim() +  ".pdf";
            //exp.ExportDestinationOptions = diskOpts;
            //rpt.Export(exp);      
            //CrystalReportViewer1.ReportSource = rpt;
          
            
            // Export to PDF

          



            exp.ExportFormatType = ExportFormatType.PortableDocFormat;
            exp.FormatOptions = new PdfRtfWordFormatOptions();
            ExportRequestContext req = new ExportRequestContext();
            req.ExportInfo = exp;
           
            System.IO.Stream st;
            //rpt.FormatEngine.PrintOptions.PaperSize = PaperSize.PaperA4;
            //rpt.FormatEngine.PrintOptions.PaperOrientation = PaperOrientation.Portrait;
            st = rpt.FormatEngine.ExportToStream(req);
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Buffer = true;
            Response.ContentType = "application/pdf";
            
            byte[] b = new byte[st.Length + 1];
            st.Read(b, 0, Convert.ToInt32(st.Length));
            Response.BinaryWrite(b);
            Response.Flush();
            Response.End(); 


        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }
}
