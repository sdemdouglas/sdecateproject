<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportList_View.aspx.cs"
    Inherits="Accountability_Reports_ReportList_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Report List</title>
</head>

<script language="javascript" type="text/javascript">
   function OpenReport(acctid)
   {       
       
       var list =  document.getElementById("<%= rdlst_reportlist.ClientID %>");
       var radio = list.getElementsByTagName("input");
       var reportname;   
  
       for( x = 0; x < radio.length; x++ )
       {
            if(radio[x].checked)
            reportname =radio[x].value; 
       }
   
   
       var rbl_Print_Type =  document.getElementById("<%= rbl_Print_Type.ClientID %>");
       var type_list = rbl_Print_Type.getElementsByTagName("input");
       var format;   
      // alert(radio.length);
       for( i = 0; i < type_list.length; i++ )
       {
            if(type_list[i].checked)
                format =type_list[i].value; 
       }
   
     
          
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;
            var activitytypeid=0;

            if(reportname == "7")
            {
                window.open("../../Reports/ViewReport.aspx?type=rpt_annual_performance_report_cover&format=" + format + "&aa_id=" + acctid ,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
            }
         else if(reportname == "8")
            {
                window.open("../../Reports/ViewReport.aspx?type=rpt_acc_accountability_narrative_get_rec_id&n_id=-1" + "&format=" + format + "&Reportid=" + reportname + "&aa_id=" + acctid +"&accoutablityID=" + acctid ,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
            }
           else if(reportname == "9")
            {
                window.open("../../Reports/ViewReport.aspx?type=rpt_annual_performance_report_hdr" + "&accoutablityID=" + acctid + "&coredindicator=-1&format=" + format,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
            }
           else if(reportname == "10")
            {
               window.open("../../Reports/ViewReport.aspx?format=" + format + "&type=rpt_annual_performance_report_cte_enrollment&aa_id=" + acctid + "&Reportid=" + reportname ,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
            }
        
          
      
        }</script>

<body>
    <form id="form1" runat="server">
        <div style="text-align: left">
            <table width="100%">
                <tr>
                    <td colspan="3">
                        Document Name:</td>
                </tr>
                <tr>
                    <td style="width: 37px">
                    </td>
                    <td colspan="2">
                        <asp:RadioButtonList ID="rdlst_reportlist" runat="server" DataSourceID="sqlds_reportList"
                            DataTextField="txt_report_category" DataValueField="key_report_category_id" OnDataBound="RadioButtonList1_DataBound">
                        </asp:RadioButtonList></td>
                </tr>
                <tr>
                    <td colspan="3">
                        Print Type:</td>
                </tr>
                <tr>
                    <td style="width: 37px; height: 21px">
                    </td>
                    <td colspan="2" style="height: 21px">
                        <asp:RadioButtonList ID="rbl_Print_Type" runat="server" DataSourceID="ds_Print_Type"
                            DataTextField="txt_Document_Type" DataValueField="txt_Value" OnDataBound="RadioButtonList1_DataBound"
                            RepeatDirection="Horizontal">
                        </asp:RadioButtonList></td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 21px">
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:HyperLink ID="HL_Print" runat="server">Print Report</asp:HyperLink></td>
                </tr>
            </table>
        </div>
        <asp:SqlDataSource ID="sqlds_reportList" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            SelectCommand="SELECT key_report_category_id, txt_report_category, txt_report_id_name, nbr_order, nbr_report_type FROM scs_report_category WHERE (nbr_report_type = '2') ORDER BY nbr_order">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="ds_Print_Type" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            SelectCommand="SELECT [txt_Value], [txt_Document_Type] FROM [scs_document_types] WHERE ([flg_Inactive] = @flg_Inactive)">
            <SelectParameters>
                <asp:Parameter DefaultValue="False" Name="flg_Inactive" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
