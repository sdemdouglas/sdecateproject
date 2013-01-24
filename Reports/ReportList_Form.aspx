<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportList_Form.aspx.cs"
    Inherits="Reports_ReportList_Form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Local Plan Reports</title>
</head>
<body>
    <form id="form1" runat="server">

        <script language="javascript">
               function OpenReport(planid, fiscalyear)
               {       
                   
                   var list =  document.getElementById("<%= RadioButtonList1.ClientID %>");
                   var radio = list.getElementsByTagName("input");
                   var reportname;   
                  // alert(radio.length);
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
                    

                    if(reportname == "fiscalassurances")
                    {
                        window.open("../Reports/ViewReport.aspx?type=" + reportname + "&format=" + format + "&Keyid=" + planid +"&planid=" + planid + "&activitytypeid=" + activitytypeid + "&fiscalyear=" + fiscalyear,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
                    }
                  
                    if ( reportname == "rpt_funded_activity")
                    {
                        activitytypeid = "101";
                        window.open("../Reports/ViewReport.aspx?type=" + reportname + "&format=" + format + "&Keyid=" + planid + "&activitytypeid=" + activitytypeid,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
                    } 

                    if( reportname == "rpt_equipment_activity")
                    {
                        activitytypeid = "102";
                        window.open("../Reports/ViewReport.aspx?type=" + reportname + "&format=" + format + "&Keyid=" + planid + "&activitytypeid=" + activitytypeid,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
                    }
                    if( reportname == "rpt_college_funding_plan")
                    {
                     window.open("../Reports/ViewReport.aspx?planid="+ planid + "&type=" + reportname + "&format=" + format,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
                    }
                   
                    if(reportname == "rpt_multi_narratives")
                    {
                        window.open("../Reports/ViewCrystalReport.aspx?type=" + reportname + "&format=" + format + "&PlanId=" + planid + "&rcid=-1",null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
                    }
                    
                    if(reportname == "local_plan_cover_page")
                    {
                       window.open("../Reports/ViewReport.aspx?type=" + reportname + "&format=" + format + "&Keyid=" + planid +"&planid=" + planid + "&activitytypeid=" + activitytypeid,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
                    }
              
            }
        </script>

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
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" DataSourceID="SqlDataSource1"
                            DataTextField="txt_report_category" DataValueField="txt_report_id_name" OnDataBound="RadioButtonList1_DataBound">
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
                        <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="NOTE: No Available Actvities"
                            Visible="False"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:HyperLink ID="HL_Print" runat="server">Print Report</asp:HyperLink></td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
                SelectCommand="select * from scs_report_category WHERE nbr_report_type = 1 ORDER by nbr_order">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="ds_Print_Type" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
                SelectCommand="SELECT [txt_Value], [txt_Document_Type] FROM [scs_document_types] WHERE ([flg_Inactive] = @flg_Inactive)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="False" Name="flg_Inactive" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
