<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_EditImprovementPlan.aspx.cs" Inherits="Accountability_popup_EditImprovementPlan" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>

<%@ Register Assembly="RadEditor.Net2" Namespace="Telerik.WebControls" TagPrefix="radE" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>
<%@ Register Src="~/UserControls/CountCharRemain.ascx" TagName="CountCharRemain" TagPrefix="uc2" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Improvement Plan</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: white" >
    <form id="form1" runat="server">
    <script type="text/javascript">
        function TextEdit()
        {
var systemnotes = document.getElementById('<%= txtSystemOfficeNotes.ClientID  %>');
systemnotes.removeAttribute("readonly",0);


var notes = document.getElementById('<%= txtResponse.ClientID  %>');
notes.removeAttribute("readonly",0);
             
        }
        function GetRadWindow()
        {
           var oWindow = null;
           if (window.radWindow) oWindow = window.radWindow;
           else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
           return oWindow;
        }
        
        function Close()
        {
            try
            {

                GetRadWindow().Close();
     
            }
            catch(err)
            {
             }                
        }

        function RefreshParentPage()
        {
         //   GetRadWindow().BrowserWindow.location.reload();
        }

        function refreshPage()
        {
         //   window.location.reload(false);
        }
        
        
        
        function Print(format)
        {       
            var key_aip_id = document.getElementById("<%= hf_ImprovementID.ClientID %>").value;
            var key_prd_id = document.getElementById("<%= hf_HeaderID.ClientID %>").value;
            
            window.open("../Reports/ViewReport.aspx?type=rpt_improvement_plan&format=" + format + "&key_prd_id=" + key_prd_id + "&key_aip_id=" + key_aip_id);                       
        }
        
        
       // function Print()
       // {
        //    window.open("../../Reports/ViewReport.aspx?type=narrative");
       // }
        
        function cvResponseFunc(source, args)
        {
            
        }  
        
        
        function trim(stringToTrim) 
        {
        	return stringToTrim.replace(/^\s+|\s+$/g,"");
        }   
        function calCharNumber()
        {
            var remCharlength = 1500;                        
            var des = document.getElementById("<%= txtResponse.ClientID %>").value;
            document.getElementById("CountCharRemain1_txtCharCount").value = (remCharlength - des.length);           
        }    
    </script>

     <%--  <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>--%>
   
            <table style="width: 703px; border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-bottom-width: 1px; border-bottom-color: black; border-top-color: black; border-right-width: 1px; border-right-color: black;">
            <tr>
                <td colspan="4" style="height: 54px; text-align: left">
                    <table width="100%">
                        <tr>
                            <td style="text-align: left">
                            </td>
                            <td colspan="2" style="text-align: right; border-bottom: royalblue 1px solid;">
                    <asp:Button ID="btnUpdate" runat="server" Text="Save" Width="100px" OnClick="btnUpdate_Click" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" Height="25px" /><asp:Button ID="btnPrint" runat="server" Text="Print PDF" Width="100px" OnClick="btnPrint_Click" OnClientClick='Print("pdf")' Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" Height="25px" /><asp:Button ID="btnPrintWord" runat="server" Text="Print Word" Width="100px" OnClick="btnPrint_Click" OnClientClick='Print("AWDOCX")' Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" Height="25px" /><asp:Button ID="btnClose" runat="server" Text="Close" Width="100px" OnClick="btnClose_Click" OnClientClick='Close()' Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" Height="25px" /></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="border-bottom: dodgerblue 1px groove; height: 24px; text-align: right">
                    <asp:Label ID="lblErr" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    Item #<asp:Label ID="lblId" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 8px; background-color: gainsboro; text-align: left; width: 687px;">
                    Description&nbsp; &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 27px; text-align: left; width: 687px;">
                    <asp:Label ID="lblSection" runat="server"></asp:Label></td>
            </tr>
            <tr style="color: #000000">
                <td colspan="4" style="height: 16px; background-color: gainsboro; text-align: left; width: 687px;">
                    <strong>Response&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtResponse"
                            ErrorMessage="* Required"></asp:RequiredFieldValidator></strong></td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:TextBox ID="txtResponse" runat="server" Height="275px" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
            </tr>
                <tr>
                    <td colspan="4">
                        <uc2:CountCharRemain ID="CountCharRemain1" runat="server" />
                    </td>
                </tr>
            <tr>
                <td colspan="4" style="border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-top-color: black;
                    height: 21px; text-align: left; border-right-width: 1px;
                    border-right-color: black; width: 687px; border-bottom: black 1px groove;" valign="top">
                    <strong> Updated By:
                        <asp:Label ID="lblUpdatedBy" runat="server" Width="106px" Font-Names="Trebuchet MS"></asp:Label></strong></td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: left; background-color: gainsboro; width: 687px;" valign="top">
                    &nbsp;<strong>System Office Notes</strong></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left; width: 687px;">
                    <strong>
                        <asp:TextBox ID="txtSystemOfficeNotes" runat="server" Height="31px" TextMode="MultiLine"
                            Width="692px"></asp:TextBox></strong></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left; width: 687px;">
                    &nbsp;
                    <radW:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Outlook" >
                        <Windows>
                            <radw:RadWindow ID="UserListDialog" runat="server" Title="Edit Response" Skin="Outlook" Height="500px"
                              Width="800px"  Left="150px"  BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top=""  />
                        </Windows>
                    </radW:RadWindowManager>
                    
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left; width: 687px;">
                    <asp:Label ID="lblPrintTrigger" runat="server"></asp:Label></td>
            </tr>
        </table>
         <br />
                <asp:HiddenField ID="hf_HeaderID" runat="server" />
        <br />
                    <asp:HiddenField ID="hf_ImprovementID" runat="server" />
        <br />  
      
                <asp:SqlDataSource ID="sqlDS_improvmentPlan" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="pr_acc_accountability_imprv_plan_get" SelectCommandType="StoredProcedure"
                    UpdateCommand="pr_acc_accountability_imprv_plan_upd" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                        <asp:ControlParameter ControlID="hf_ImprovementID" Name="p_key_acc_accountability_imprv_plan_id"
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="hf_ImprovementID" Name="p_key_acc_accountability_imprv_plan_id"
                            PropertyName="Value" Type="Int32" />
                        <asp:ControlParameter ControlID="txtResponse" Name="p_txt_narrative_response" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="txtSystemOfficeNotes" Name="p_txt_system_office_notes"
                            PropertyName="Text" Type="String" />
                        <asp:Parameter Name="p_txt_updated_user" Type="String" />
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <br />
    <%--   </ContentTemplate>
            
        </asp:UpdatePanel>--%>
    
    </form>
</body>
</html>
