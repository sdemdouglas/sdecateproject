<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NarrativeDetails.aspx.cs" Inherits="LocalPlan_NarrativeDetails" Title ="Enter Narrative Information"  %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>

<%@ Register Assembly="RadEditor.Net2" Namespace="Telerik.WebControls" TagPrefix="radE" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Local Plan Details</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
</head>
<body style="background-color: white; text-align: center;" >
    <form id="form1" runat="server">
    <script type="text/javascript">
        function TextEdit()
        {
            var nid =  document.getElementById('<%= hfNid.ClientID %>').value;
           
            var wObj = window.radopen("TextEditor.aspx?doc=narrative&nid=" + nid, "UserListDialog");
            wObj.Center();
           
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
            var nid =  document.getElementById('<%= hfNid.ClientID %>').value;
            var level = document.getElementById('<%= hfLevel.ClientID %>').value;
            GetRadWindow().Close();
            GetRadWindow().BrowserWindow.refreshGrid(null,nid, level);   
            }
            catch(err)
            {
             }                
        }

        function RefreshParentPage()
        {
            GetRadWindow().BrowserWindow.location.reload();
        }

        function refreshPage()
        {
            window.location.reload(false);
        }
        
        
        
        function Print(format)
        {       
            var keyid= document.getElementById("<%= hfNid.ClientID %>").value;
            var lblResponse = document.getElementById("<%=lblResponse.ClientID %>").innerHTML;
            
            //   var oBrowserWnd = GetRadWindow().BrowserWindow; 
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;

            if(lblResponse != '')
            {
                if( format == "AWDOCX")
                    window.open("../Reports/ViewReport.aspx?type=narrative_by_id&Keyid=" + keyid + "&format=" + format ,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
                else
                    window.open("../Reports/ViewCrystalReport.aspx?type=NarrativePlan&Keyid=" + keyid + "&format=" + format ,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
            }
           
        }
        
        
       // function Print()
       // {
        //    window.open("../../Reports/ViewReport.aspx?type=narrative");
       // }
        
        function cvResponseFunc(source, args)
        {
            args.IsValid = false;
            
            var lblopt = document.getElementById("<%= lblResponsOpt.ClientID %>").innerText;
            var lblRes = document.getElementById("<%= lblResponse.ClientID %>").innerText;
                   
            if(lblopt == "Response Required")
            {                
               // alert(lblRes);
               if (trim(lblRes) != "")
               {
                 args.IsValid = true;                
               }
            }
            else
            {
                args.IsValid = true;
                //alert("No Res");
            }
        }  
        function trim(stringToTrim) 
        {
        	return stringToTrim.replace(/^\s+|\s+$/g,"");
        }     
    </script>

       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
         
        
        <table   style="width: 703px; border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-bottom-width: 1px; border-bottom-color: black; border-top-color: black; border-right-width: 1px; border-right-color: black;">
            <tr>
                <td colspan="4" style="width: 687px; border-bottom: dodgerblue 1px groove">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="4" style="width: 687px; border-bottom: black 1px groove;">
                    <strong>&nbsp;<asp:Label ID="lblCollege" runat="server" Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="9pt"></asp:Label>
                        - <span style="font-size:9pt; font-family: Trebuchet MS">Fiscal Year</span> </strong>
                    <asp:Label ID="lblFiscalYear" runat="server" Font-Bold="True" Font-Size="9pt"></asp:Label>&nbsp;--
                    <asp:Label ID="lblResponsOpt" runat="server" Text="Label" Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="9pt" ForeColor="Red"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 54px; text-align: left">
                    <table width="100%">
                        <tr>
                            <td style="text-align: left">
                            </td>
                            <td colspan="2" style="text-align: right">
                    <asp:Label ID="lblErr" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="border-bottom: dodgerblue 1px groove; height: 24px; text-align: right">
                    <asp:Button ID="btnUpdate" runat="server" Text="Save" Width="100px" OnClick="btnUpdate_Click" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" Height="25px" />
                                <asp:Button ID="btnPrint" runat="server" Text="Print PDF" Width="100px" OnClick="btnPrint_Click" OnClientClick='Print("pdf")' Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" Height="25px" />
                                <asp:Button ID="btnPrintWord" runat="server" Text="Print Word" Width="100px" OnClick="btnPrint_Click" OnClientClick='Print("AWDOCX")' Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" Height="25px" />
                                <asp:Button ID="btnClose" runat="server" Text="Close" Width="100px" OnClick="btnClose_Click" OnClientClick='Close()' Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" Height="25px" /></td>
                        </tr>
                    </table>
                    Item #<asp:Label ID="lblId" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 8px; background-color: gainsboro; text-align: left; width: 687px;">
                    <strong>Section Title</strong> &nbsp; &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 27px; text-align: left; width: 687px;">
                    <asp:Label ID="lblSection" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" colspan="4" style="height: 2px; background-color: gainsboro; width: 687px;">
                    <strong>Narrative Description</strong>&nbsp; &nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td align="left" colspan="4" style="height: 23px; width: 687px;">
                    <asp:Label ID="lblDescription" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr style="color: #000000">
                <td colspan="4" style="height: 16px; background-color: gainsboro; text-align: left; width: 687px;">
                    <strong>Response&nbsp;
                        <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="False" OnClick="LinkButton1_Click"
                            OnClientClick="javascript:TextEdit();return false;" CausesValidation="False">[Edit...]</asp:LinkButton>
                    </strong>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 35px; text-align: left; width: 687px;">
                    &nbsp;<asp:Panel ID="Panel1" runat="server" Height="283px" ScrollBars="Vertical" Width="100%" BorderColor="Silver" BorderStyle="Double" BorderWidth="2px">
                        <asp:Label ID="lblResponse" runat="server" Text="Label" Width="97%"></asp:Label>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="cvResponseFunc"
                            ErrorMessage="* Response Required"></asp:CustomValidator></asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-top-color: black;
                    height: 21px; text-align: left; border-right-width: 1px;
                    border-right-color: black; width: 687px; border-bottom: black 1px groove;" valign="top">
                    <strong>Date Updated: &nbsp;<asp:Label ID="lblDateUpdated" runat="server" Text="Label"
                        Width="93px" Font-Names="Trebuchet MS"></asp:Label>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Updated By:
                        <asp:Label ID="lblUpdatedBy" runat="server" Text="Label" Width="106px" Font-Names="Trebuchet MS"></asp:Label></strong></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 21px;
                    background-color: gainsboro; text-align: left; border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-bottom-width: 1px; border-bottom-color: black; border-top-color: black; border-right-width: 1px; border-right-color: black; width: 687px;" valign="top">
                    <span style="color: #000099"><strong>
                        For System Office Use Only</strong></span></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 21px; background-color: gainsboro; text-align: left; width: 687px;"
                    valign="top">
                    <strong>Approved by System Office&nbsp;</strong>
                    <asp:CheckBox ID="cbApproved" runat="server" />
                    &nbsp; <strong>Locked by System Office</strong>&nbsp;
                    <asp:CheckBox ID="cbLocked" runat="server" /></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 6px; text-align: left; width: 687px;" valign="top">
                </td>
            </tr>
            <tr>
                <td colspan="4" style="background-color: gainsboro; text-align: left; width: 687px;">
                    <strong>Status &nbsp;&nbsp;</strong></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 30px; text-align: left; width: 687px;">
                    <asp:DropDownList ID="ddStatus" runat="server" DataSourceID="SqlDataSource1" DataTextField="txt_level_desc"
                        DataValueField="key_level_id" Width="416px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="SELECT [key_level_id], [txt_level_desc] FROM [scs_level]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="text-align: left; background-color: gainsboro; width: 687px;" valign="top">
                    &nbsp;<strong>System Office Notes</strong></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left; width: 687px;">
                    <strong>
                        <asp:TextBox ID="txtSystemOfficeNotes" runat="server" Height="80px" TextMode="MultiLine"
                            Width="692px"></asp:TextBox></strong></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left; width: 687px;">
                    <asp:HiddenField ID="hfNid" runat="server" />
                    <asp:Button ID="btnEditResponse" runat="server" OnClientClick="javascript:TextEdit();return false;"
                        Text="Edit" Width="100px" OnClick="btnEditResponse_Click" Visible="False" />
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
        <br />
        <br />
                <asp:HiddenField ID="hfLevel" runat="server" />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
       </ContentTemplate>
            
        </asp:UpdatePanel>
    
    </form>
</body>
</html>
