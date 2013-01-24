<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewReport.aspx.cs" Inherits="PopUPs_ViewReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>View Reports</title>
</head>
<body onload="StayOnTop()" style="background-color:White;">
    <script type="text/javascript">
    //    function StayOnTop()
   //     {
   //         self.focus()
    //    }    
    </script>
    <form id="form1" runat="server">
    <div>
        &nbsp;<rsweb:ReportViewer ID="RS_Veiwer" runat="server" Width="800px" Height="600px">
        </rsweb:ReportViewer>
        <asp:SqlDataSource ID="sqlrl_activitylist" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            SelectCommand="pr_act_activity_list_report_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:QueryStringParameter Name="p_key_local_plan_id" QueryStringField="keyid" Type="Int32" />
                <asp:QueryStringParameter DefaultValue="" Name="p_key_fa_activity_type_id" QueryStringField="activitytypeid"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
