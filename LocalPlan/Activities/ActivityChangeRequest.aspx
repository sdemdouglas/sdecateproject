<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ActivityChangeRequest.aspx.cs" Inherits="LocalPlan_Activities_FundedActivityChange" %>

<%@ Register Src="../../UserControls/CountCharRemain.ascx" TagName="CountCharRemain"
    TagPrefix="uc1" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Activity Change Request</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript">
        function GetRadWindow()
        {
           var oWindow = null;
           if (window.radWindow) oWindow = window.radWindow;
           else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
           return oWindow;
        }
        
        function Close()
        {
            GetRadWindow().Close();
        }
        
        function CloseAndRebind(type, action)
        {
            //alert(action);
            
            var aId = document.getElementById("<%= hfaId.ClientID %>").value;                                      
            GetRadWindow().Close();
            if (action == 'Rebind')
            {
                GetRadWindow().BrowserWindow.refreshChangeRequest(action);
            }
            else
            {
                var url = GetRadWindow().BrowserWindow.location + "";
                
                if (url.charAt(url.length-1) == '#')
                    url = url.substring(0,url.length-1);
                
                if(url.search('reload=true') < 0)
                    url = url + "&reload=true";
                                             
                GetRadWindow().BrowserWindow.location = url;                                  
            }
        }

        
        function cvCoreIndValFunc(source, args)
        {   
            var cblCoreInd = document.getElementById("<%= cblCoreIndicators.ClientID %>").getElementsByTagName('input');                                  
            //alert(cblCoreInd.length);                 
            args.IsValid = false;
            for (var i=0; i < cblCoreInd.length; i++)
            {
                if(cblCoreInd[i].checked)
                    args.IsValid = true;
            }                        
        }
        
        function confirmDelete()
        {
            var ans = confirm("Are you sure you want to Delete this Activity Change Request?");
            if(ans==true)
            {
                document.getElementById("<%= hfDelete.ClientID %>").value = "Yes";
            }
            else
            {
                document.getElementById("<%= hfDelete.ClientID %>").value = "No";
                
            }
        }
        
        function calCharNumber1()
        {
            var remCharlength = 2000;                        
            var des = document.getElementById("<%= txtNewActivityDesc.ClientID %>").value;
            document.getElementById("CountCharRemain1_txtCharCount").value = (remCharlength - des.length);           
        }
        
        function calCharNumber2()
        {
            var remCharlength = 2000;                        
            var des = document.getElementById("<%= txtNewCoreIndicatorDesc.ClientID %>").value;
            document.getElementById("CountCharRemain2_txtCharCount").value = (remCharlength - des.length);           
        }
        
    </script>
    
    <div style="background-color: white">
        <table style="width: 703px; border-left-width: 1px; border-left-color: inactivecaptiontext; border-top-width: 1px; border-bottom-width: 1px; border-bottom-color: inactivecaptiontext; border-top-color: inactivecaptiontext; border-right-width: 1px; border-right-color: inactivecaptiontext;">
            <tr>
                <td colspan="4" style="border-bottom: black 2px groove; text-align: center">
                    <strong><span style="font-size: 9pt">CHANGE REQUEST FORM - </span>
                    <asp:Label ID="lblCollege" runat="server" Font-Bold="True" ></asp:Label><span
                            ><span style="font-size: 11pt"> - Fiscal Year</span>
                    </span>
                    <asp:Label ID="lblFiscalYear" runat="server" Font-Bold="True"></asp:Label></strong></td>
            </tr>
            <tr>
                <td>
                </td>
                <td align="right" colspan="3">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 146px; height: 21px; text-align: left">
                </td>
                <td align="right" colspan="3" style="width: 670px; height: 21px; text-align: right">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Width="100px" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CausesValidation="False" Width="100px" OnClientClick="confirmDelete()" Visible="False" OnClick="btnDelete_Click" />
                    <asp:Button ID="btnPrint" runat="server" Text="Print" CausesValidation="False" Width="100px" OnClientClick="Print()" />
                    <asp:Button ID="btnClose" runat="server" Text="Close" CausesValidation="False" Width="100px" OnClick="btnClose_Click" /></td>
            </tr>
            <tr>
                <td style="width: 146px; height: 21px; text-align: left">
                    Activity #</td>
                <td colspan="3" style="width: 670px; height: 21px; text-align: left">
                    <asp:Label ID="lblAvtivityNbr" runat="server" Width="123px"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 146px; height: 22px; text-align: left">
                    Activity Name</td>
                <td align="left" colspan="3" style="width: 670px; height: 22px">
                    <asp:Label ID="lblActivityName" runat="server" Font-Bold="False" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 146px; height: 22px; text-align: left">
                    New
                    Activity Name</td>
                <td colspan="3" style="height: 22px; width: 670px;" align="left">
                    <asp:TextBox ID="txtNewActivityName" runat="server" Width="537px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtNewActivityName"
                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 146px; height: 12px; text-align: left; border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-top-color: black; border-bottom: black 1px groove; border-right-width: 1px; border-right-color: black;" valign="top">
                    <asp:Label ID="Label3" runat="server" Font-Bold="False" Text="Core Indicators"></asp:Label></td>
                <td colspan="3" style="height: 12px; text-align: left; width: 670px; border-bottom: black 1px groove;" valign="top">
                    <asp:CheckBoxList ID="cblCoreIndicators" runat="server" DataSourceID="SDS_CoreIndicators"
                        DataTextField="Column1" DataValueField="key_core_indicator_id" OnDataBound="cblCoreIndicators_DataBound">
                    </asp:CheckBoxList>
                    <asp:CustomValidator ID="cvCoreInd" runat="server" ClientValidationFunction="cvCoreIndValFunc"
                        ErrorMessage="* Required (At least one core indicator has to be selected)"></asp:CustomValidator><br />
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                </td>
            </tr>
            <tr>
                <td style="height: 10px; text-align: left" valign="top" colspan="4">
                    <strong>
                    Current Description of activity (Proposed Use of Funds)</strong></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                    <asp:Label ID="lblActivityDesc" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                    Revised description of activity (Proposed Use of Funds)
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNewActivityDesc"
                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td colspan="4" style="width: 100%; height: 10px; text-align: left" valign="top">
                    <asp:TextBox ID="txtNewActivityDesc" runat="server" Height="109px" Width="745px" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                    <uc1:CountCharRemain ID="CountCharRemain1" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                </td>
            </tr>
            <tr>
                <td style="height: 10px; text-align: left" valign="top" colspan="4">
                    <asp:Label ID="Label1" runat="server" Text="Current description of how the activity will help meet the core indicator(s)" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                    <asp:Label ID="lblCoreIndicatorDesc" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                    <asp:Label ID="Label2" runat="server" Text="Revised description of how the activity will help meet the core indicator."></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNewCoreIndicatorDesc"
                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 12px; text-align: left" valign="top">
                    <asp:TextBox ID="txtNewCoreIndicatorDesc" runat="server" Height="109px" Width="745px" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 3px; text-align: left" valign="top">
                    <uc1:CountCharRemain ID="CountCharRemain2" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="4"  valign = "top" style="height: 3px; text-align: left">
                    <br />
                    &nbsp;
                        <table style="width: 751px;">
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                Date Created<strong> &nbsp;</strong><asp:Label ID="lblDateCreated" runat="server"
                                    Width="93px"></asp:Label><strong> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </strong>
                            </td>
                        </tr>
                        <tr style="font-weight: bold">
                            <td colspan="4" style="height: 7px; background-color: #bfdbff; text-align: left">
                                <span>For System Office Use Only</span></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                <strong>Approved by System Office&nbsp;</strong>
                                <asp:CheckBox ID="cbApproved" runat="server" />
                                &nbsp; &nbsp;</td>
                        </tr>
                    </table>
                        <br />
                    </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;&nbsp;&nbsp;
                    <br />
                    <asp:HiddenField ID="hfItem" runat="server" />
                    <asp:HiddenField ID="hfLpId" runat="server" />
                    <asp:HiddenField ID="hfPageInfo" runat="server" />
                    <asp:HiddenField ID="hfFlgSave" runat="server" />
                    <asp:SqlDataSource ID="SqlDS_RLcoreindi_Get" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_act_activity_core_indicator_get" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="aid"
                                Type="Int32" />
                            <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_change_id" QueryStringField="acrId"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="hfaId" runat="server" />
                    <asp:HiddenField ID="hfDelete" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 26px; text-align: left">
                    &nbsp;<asp:Label ID="InjectScript" runat="server"></asp:Label>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SDS_CoreIndicators" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT key_core_indicator_id, txt_core_indiciator_code+ ' - ' +  txt_core_indicator_name  FROM scs_core_indicator">
        </asp:SqlDataSource>
        &nbsp; &nbsp;<br />
    
    </div>
    </form>
   
</body>
</html>
