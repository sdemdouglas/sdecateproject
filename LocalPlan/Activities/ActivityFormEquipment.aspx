<%@ Page Language="C#" AutoEventWireup="true"  Title = "Equipment Activity" CodeFile="ActivityFormEquipment.aspx.cs" Inherits="LocalPlan_Activities_ActivityFormEquipment" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Appendix D: Equipment Activity Sheet – Form 2B </title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
    <link href="../../Custom_Skins/Grid.Office2007.css" rel="stylesheet" type="text/css" />
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

        function CloseAndRebind(level)
        {              
            var nid =  document.getElementById('<%= lblAid.ClientID %>').innerText; 
         
            Close();   
            GetRadWindow().BrowserWindow.refreshActivities("Activities",nid, level );  
                        
        }
        
        function CloseAndReload()
        {         
            Close();   
            GetRadWindow().BrowserWindow.location.reload(); 
        }

        function refreshPage(kid)
        {
            //window.location.reload(false);
            Close();
            var wObj = GetRadWindow().BrowserWindow.radopen("Activities/ActivityFormEquipment.aspx?id=" + kid, "UserListDialog");
            
            var wW = Math.round(document.documentElement.clientWidth *95/100);            
            var wH = Math.round(document.documentElement.clientHeight *95/100);
            
            wObj.SetSize(wW,wH);
            wObj.Center();
        }
        
        function confirmDelete()
        {
            var ans = confirm("Are you sure you want to Delete this Activity?");
            if(ans==true)
            {
                document.getElementById("<%= hfDelete.ClientID %>").value = "Yes";
            }
            else
            {
                document.getElementById("<%= hfDelete.ClientID %>").value = "No";
                
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
        
        function pageInfoChanged()
        {
            //alert("onchange");
            document.getElementById("<%= lblMsg.ClientID %>").innerText = "";
            document.getElementById("<%= hfPageInfo.ClientID %>").value = "1";
        }
        
        function confirmClose()
        {
            var ans;
            
            if (document.getElementById("<%= hfPageInfo.ClientID %>").value == "1")
                ans = confirm("Information on this page has been changed but not saved yet. Do you want to process to close?");      
            
            if(ans==true)
                document.getElementById("<%= hfFlgSave.ClientID %>").value = "yes";
            else
                document.getElementById("<%= hfFlgSave.ClientID %>").value = "no";     
        }
        
        function getItemValue(id)
        {
            var itemVal = document.getElementById(id).value;
            
            if(itemVal.length > 0)
            {
                if(!isNaN(parseFloat(itemVal)))
                {
         //           alert(itemVal);
                    
                    document.getElementById(id).value = parseFloat(itemVal).toFixed(2);
                }
                else
                {
                    document.getElementById(id).value = "0.00";
                }
            }
            else
            {
                document.getElementById(id).value = "0.00";                                       
            }
        }
        
        function cvFunds (source, args)
        {
            var txt_Funds = document.getElementById(window['txt_Funds']).value;
            var hfTotBal = document.getElementById("<%= hfTotBal.ClientID %>").value;
            var hfGridTot = document.getElementById("<%= hfGridTot.ClientID %>").value;
            
//            alert(hfTotBal);
//            alert(hfGridTot);            
//            
//            alert(txt_Funds);   
            
            
            
            var newBalance = parseFloat(hfTotBal) + parseFloat(hfGridTot) - parseFloat(txt_Funds);
            
            args.IsValid = false;
            
            if (txt_Funds != null)
            {                                
                if (txt_Funds.length  > 0)
                {                    
                    if(!isNaN(txt_Funds) && parseFloat(txt_Funds) > 0)
                    {
                        //alert(newBalance);
                        if (newBalance >= 0)
                        {
                            args.IsValid = true;                  
                        }                        
                    }
                }               
            }        
        }
        
//        function openActivityChangeRequest(aid)
//        {
//           var rWindow = window.radopen("ActivityChangeRequest.aspx?aid=" + aid + "&acrId=-1", "UserListDialog");
//            
//         
//           rWindow.SetSize(800,550);
//           rWindow.Center();
//        }     
        
        function editActivityChangeRequest(aid, acrId, type)
        {
           //alert(acrId);
           
           var rWindow = window.radopen("ActivityChangeRequest.aspx?aid=" + aid + "&acrId=" + acrId + "&type=" + type, "UserListDialog");
                    
           rWindow.SetSize(800,550);
           rWindow.Center();
        }           
        
        function Print(type,format)
        {       
            var keyid= document.getElementById("<%= lblAid.ClientID %>").innerText;
       
            //   var oBrowserWnd = GetRadWindow().BrowserWindow; 
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;


            window.open("../../Reports/ViewReport.aspx?type=" + type + "&Keyid=" + keyid + "&format=" + format,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
 
           // window.open("../../Reports/ViewReport.aspx?type='activities'");
        }
        function refreshChangeRequest(action)      
        {        
            window["<%=RadGrid2.ClientID %>"].AjaxRequest('<%= RadGrid2.UniqueID %>', action); 
                         
        }
        
        function forcePostback()
        {
            var divAcr = document.getElementById("hlAcr");            
            divAcr.style.display = 'inline';  
            refreshChangeRequest('Rebind');
        }
    </script>
    <div>
        &nbsp;<table style="width: 785px; border-top-width: 1px; border-left-width: 1px; border-left-color: gray; border-bottom-width: 1px; border-bottom-color: gray; border-top-color: gray; border-right-width: 1px; border-right-color: gray;">
            <tr>
                <td colspan="3" style="text-align: center; border-bottom: black 1px groove;">
                    <strong><span style="font-size: 9pt"><span style="font-size: 9pt; color: black;"> Equipment Activity Sheet - Form 2B</span> - </span></strong>
                    <asp:Label ID="lblCollege" runat="server" Font-Bold="True" Text="Trident Technical College" Font-Size="9pt"></asp:Label><span
                        style="font-size: 9pt"> - &nbsp;</span><asp:Label ID="lblFiscalYear" runat="server" Font-Bold="True" Text="2008" Font-Size="9pt"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3" style="border-left-width: 1px; border-left-color: black; border-right-width: 1px; border-right-color: black; border-top-width: 1px; border-bottom-width: 1px; border-bottom-color: black; border-top-color: black; text-align: right;">
                    <radTS:RadTabStrip ID="RadTabStrip1"  MultiPageID ="RadMultiViewActivity" runat="server" Skin="ClassicBlue" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" style="border-bottom: skyblue 1px groove" CausesValidation="False">
                        <Tabs>
                            <radTS:Tab runat="server" PageViewID= "PgViewActivity" Text="Activity Information">
                            </radTS:Tab>
                            <radTS:Tab runat="server"  PageViewID = "PgViewChangeRequest" Text="Change Requests">
                            </radTS:Tab>
                            <radTS:Tab runat="server" PageViewID="pv_History" Text="Transaction History">
                            </radTS:Tab>
                        </Tabs>
                    </radTS:RadTabStrip>
                    <asp:Label ID="lblMsg" runat="server" Text="Label"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3">
                    <radTS:RadMultiPage ID="RadMultiViewActivity" runat="server" Width="746px">
                        <radTS:PageView ID="PgViewActivity" runat="server">
        <table>
            <tr>
                <td style="border-top-width: 1px; border-top-color: black; height: 18px;
                    text-align: right; border-bottom: black 1px groove;" colspan="4">
                    <asp:Label ID="Label2" runat="server" ForeColor="Red" Style="position: relative"
                        Text="The Total of the Line Item(s) on this Activity exceeds the Available Funds."
                        Visible="False"></asp:Label>
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS" />
                    <asp:Button ID="btnDelete" runat="server" CausesValidation="False" OnClick="btnDelete_Click"
                        Text="Delete" Width="100px" OnClientClick="confirmDelete()" Font-Bold="False" Font-Names="Trebuchet MS" />
                    <asp:Button ID="btn_Print_History" runat="server" Text="Print History" OnClick="btn_Print_History_Click" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS" />
                    
                    <asp:Button ID="btnPrint" runat="server" Text="Print PDF" OnClick="btnPrint_Click" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS" />
                    
                    <asp:Button ID="btnPrintWord" runat="server" Text="Print Word" OnClick="btnPrintWord_Click" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS" />
                    <asp:Button ID="btnClose" runat="server" Text="Close" Width="100px" CausesValidation="False" OnClick="btnClose_Click" OnClientClick="confirmClose()" Font-Bold="False" Font-Names="Trebuchet MS" />
                </td>
            </tr>
            <tr>
                <td style="width: 178px; height: 1px; text-align: left; border-top-width: 1px; border-top-color: black;">
                    Activity #</td>
                <td align="left" colspan="3" style="height: 1px; border-top-width: 1px; border-bottom-width: 1px; border-bottom-color: royalblue; border-top-color: inactivecaption;">
                    <asp:Label ID="lblAid" runat="server" Text="Put Activity # Here"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 178px; height: 14px; text-align: left">
                    Type of Equipment</td>
                <td colspan="3" style="height: 14px" align="left">
                    <asp:TextBox ID="txtTypeEquip" runat="server" Width="538px" Height="20px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Required" ControlToValidate="txtTypeEquip" Font-Size="9pt"></asp:RequiredFieldValidator></td>
            </tr>
            <tr style="color: #000000">
                <td style="width: 178px; height: 10px; text-align: left">
                    Category</td>
                <td align="right" colspan="2" style="height: 10px; text-align: left">
                    <asp:DropDownList ID="DLB_Category" runat="server" DataSourceID="SDS_Category" DataTextField="txt_category_title"
                        DataValueField="key_category_id" Width="430px">
                    </asp:DropDownList></td>
                <td style="height: 10px; width: 133px;" align="right">
                    </td>
            </tr>
            <tr style="color: #000000">
                <td style="width: 178px; height: 9px; text-align: left">
                    <asp:Label ID="Label1" runat="server" Font-Bold="False" Text="Function Code" Width="110px"></asp:Label></td>
                <td align="left" style="width: 209px; height: 9px">
                    <asp:DropDownList ID="DLB_FunCode" runat="server" DataSourceID="SDS_FunctionCODE"
                        DataTextField="txt_function_code_desc" DataValueField="key_function_code_id"
                        Width="300px" Enabled="False">
                    </asp:DropDownList></td>
                <td align="right" style="width: 187px; height: 9px">
                </td>
                <td align="right" style="width: 133px; height: 9px">
                </td>
            </tr>
            <tr>
                <td style="width: 178px; height: 21px; text-align: left" valign="top">
                    <asp:Label ID="Label3" runat="server" Font-Bold="False" Text="Core Indicators"></asp:Label></td>
                <td colspan="3" style="height: 21px; text-align: left; font-weight: bold;" valign="top">
                    <asp:CheckBoxList ID="cblCoreIndicators" runat="server" DataSourceID="SDS_CoreIndicators"
                        DataTextField="Column1" DataValueField="key_core_indicator_id" OnDataBound="cblCoreIndicators_DataBound" Font-Bold="False">
                    </asp:CheckBoxList></td>
            </tr>
            <tr>
                <td style="width: 178px; height: 21px; text-align: left" valign="top">
                </td>
                <td colspan="3" style="font-weight: bold; height: 21px; text-align: left" valign="top">
                    <asp:CustomValidator ID="cvCoreInd" runat="server" ClientValidationFunction="cvCoreIndValFunc"
                        ErrorMessage="* Required (At least one core indicator has to be selected)" SetFocusOnError="True" Font-Bold="False"></asp:CustomValidator></td>
            </tr>
            <tr style="color: #000099">
                <td colspan="4" style="text-align: left;">
                   <asp:label ID="labelsupport" runat="server" ForeColor="black">Supporting Program/Activities</asp:label></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 85px; text-align: left">
                    <asp:TextBox ID="txtSupProgram" runat="server" Height="114px" Width="743px" TextMode="MultiLine" Font-Names="Trebuchet MS" Font-Size="9pt"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSupProgram"
                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
            </tr>
            <tr style="color: #000000">
                <td colspan="4" style="height: 7px; text-align: left">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td style="width: 300px">
                    Available Fund:
                            </td>
                            <td>
                    <asp:TextBox ID="txtAvailableFunds" runat="server" ReadOnly="True" BorderStyle="None"></asp:TextBox></td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 300px">
                                Total Line Item Cannot Exceed:</td>
                            <td>
                                <asp:Label ID="lblNewTotalLineItem" runat="server"></asp:Label></td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="color: #000000">
                <td colspan="4" style="height: 7px; text-align: left">
                    <radG:RadGrid ID="TRG_Funds" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                        AllowAutomaticUpdates="True" AutoGenerateColumns="False" DataSourceID="SDS_ActivityBudgetFunds"
                        EnableAJAX="True" GridLines="None" Skin="Default" OnDataBound="TRG_Funds_DataBound" OnItemCreated="TRG_Funds_ItemCreated">
                        <MasterTableView DataKeyNames="key_line_item_type_id" DataSourceID="SDS_ActivityBudgetFunds">
                            <Columns>
                                <radG:GridBoundColumn DataField="key_line_item_type_id" DataType="System.Int32" HeaderText="Key"
                                    ReadOnly="True" SortExpression="key_line_item_type_id" UniqueName="key_line_item_type_id">
                                </radG:GridBoundColumn>
                    
                                <radG:GridBoundColumn DataField="txt_line_item_desc" SortExpression="Fund" UniqueName="txt_line_item_desc">
                                </radG:GridBoundColumn>
                                <radG:GridTemplateColumn  UniqueName="TemplateColumn">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txt_Funds" runat="server" Style="position: relative" Width="105px" Font-Names="Trebuchet MS" Font-Size="9pt">0.00</asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="cvFunds"
                                            ErrorMessage="* Total Line Item Exceeds Allowed Amount"></asp:CustomValidator>
                                    </ItemTemplate>
                                </radG:GridTemplateColumn>
                            </Columns>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px" />
                            </ExpandCollapseColumn>
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                        </MasterTableView>
              
          
                     
                        
                    </radG:RadGrid></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; background-color: gainsboro; text-align: left">
                    <strong>Line Item Adjustments</strong></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    <asp:SqlDataSource ID="SqlDsReimbursements" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_act_reimbursements_qtr_list_get" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="-1" Name="p_key_activity_id" QueryStringField="id"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <radG:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDsReimbursements" GridLines="None"
                        Skin="Default" OnItemDataBound="RadGrid1_ItemDataBound">
                        <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDsReimbursements" ShowFooter="True">
                            <RowIndicatorColumn>
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn>
                                <HeaderStyle Width="20px" />
                            </ExpandCollapseColumn>
                            <Columns>
                                <radG:GridBoundColumn DataField="Line Item" HeaderText="Line Item" SortExpression="Line Item"
                                    UniqueName="Line Item">
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="amt_amount" DataType="System.Decimal" HeaderText="Original Amount"
                                    SortExpression="amt_amount" UniqueName="amt_amount" DataFormatString="{0:N}">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="Qtr 1" DataType="System.Decimal" HeaderText="Qtr 1"
                                    ReadOnly="True" SortExpression="Qtr 1" UniqueName="Qtr 1" DataFormatString="{0:N}">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="Qtr 2" DataType="System.Decimal" HeaderText="Qtr 2"
                                    ReadOnly="True" SortExpression="Qtr 2" UniqueName="Qtr 2" DataFormatString="{0:N}">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="Qtr 3" DataType="System.Decimal" HeaderText="Qtr 3"
                                    ReadOnly="True" SortExpression="Qtr 3" UniqueName="Qtr 3" DataFormatString="{0:N}">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="Qtr 4" DataType="System.Decimal" HeaderText="Qtr 4"
                                    ReadOnly="True" SortExpression="Qtr 4" UniqueName="Qtr 4" DataFormatString="{0:N}">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                <radG:GridBoundColumn DataField="nbr_total_adjustments" DataType="System.Decimal"
                                    HeaderText="Adjustments" ReadOnly="True" SortExpression="nbr_total_adjustments"
                                    UniqueName="nbr_total_adjustments" DataFormatString="{0:N}">
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridBoundColumn>
                                
                                                                                                                              
                                <radG:GridTemplateColumn HeaderText="Total" UniqueName="TemplateColumn">
                                    <FooterTemplate>
                                        <asp:Label ID="lblSum" runat="server"></asp:Label>
                                    </FooterTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </radG:GridTemplateColumn>
                            </Columns>
                            <FooterStyle BackColor="LightSteelBlue" HorizontalAlign="Left" />
                        </MasterTableView>
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                        
                    </radG:RadGrid></td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    <asp:Label ID="InjectScript" runat="server"></asp:Label>
                    <table style="width: 751px;">
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                <strong>Date Updated &nbsp;</strong><asp:Label ID="lblDateUpdated" runat="server"
                                    Width="93px"></asp:Label>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; <strong>Updated By</strong>
                                <asp:Label ID="lblUpdatedBy" runat="server" Width="106px"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                <strong><span style="color: #000099">For System Office Use Only</span></strong></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                <strong>Approved by System Office&nbsp;</strong>
                                <asp:CheckBox ID="cbApproved" runat="server" />
                                &nbsp; <strong>Locked by System Office</strong>&nbsp;
                                <asp:CheckBox ID="cbLocked" runat="server" /></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; background-color: gainsboro; text-align: left">
                                <strong>Status &nbsp;</strong></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                <asp:DropDownList ID="ddStatus" runat="server" DataSourceID="SqlDataSource1" DataTextField="txt_level_desc"
                                    DataValueField="key_level_id" Width="416px">
                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                    SelectCommand="SELECT [key_level_id], [txt_level_desc] FROM [scs_level]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; background-color: gainsboro; text-align: left">
                                <strong style="background-color: gainsboro">System Office Notes</strong></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                <asp:TextBox ID="txtSystemOfficeNotes" runat="server" Height="120px" TextMode="MultiLine"
                                    Width="743px"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    &nbsp; &nbsp; &nbsp; &nbsp;
                    <br />
                    <asp:HiddenField ID="hfDelete" runat="server" />
                    <asp:HiddenField ID="hfLpId" runat="server" />
                    <asp:HiddenField ID="hfPageInfo" runat="server" />
                    <asp:HiddenField ID="hfFlgSave" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    &nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 7px; text-align: left">
                    <radW:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Vista">
                        <Windows>
                            <radw:RadWindow ID="UserListDialog" runat="server" Title="Task Information"
                               Left="150px" Behavior="Minimize, Maximize, Move, Reload"  BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top=""  />
                        </Windows>
                    </radW:RadWindowManager>
                </td>
            </tr>
        </table>
                        </radTS:PageView>
                        <radTS:PageView ID="PgViewChangeRequest" runat="server" Width="100%">
                            <table width="100%">
                                <tr>
                                    <td colspan="3" align="left">
                                        <div id="hlAcr" style="display:inline;" runat="server" >
                                            <asp:HyperLink ID="hlActivityChangeRequest" runat="server" NavigateUrl="#" Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="9pt">[New Change Request]</asp:HyperLink>    
                                        </div>
                                                                                
                                        <asp:SqlDataSource ID="SqlActivitieChanges" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                            SelectCommand="SELECT [key_activity_id], [key_act_change_id], [txt_activity_name_new], [txt_activity_desc_new], [txt_activity_core_indicator_desc_new], [flg_approved] FROM [act_change] WHERE ([key_activity_id] = @key_activity_id)" DeleteCommand="pr_act_change_request_del" DeleteCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:QueryStringParameter DefaultValue="" Name="key_activity_id" QueryStringField="id"
                                                    Type="Int32" />
                                            </SelectParameters>
                                            <DeleteParameters>
                                                <asp:Parameter Name="key_act_change_id" Type="Int32" />
                                            </DeleteParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td align="right" colspan="1">
                                        
                                            <asp:Button ID="btnClose2" runat="server" Text="Close" Width="100px" CausesValidation="False" OnClick="btnClose_Click" OnClientClick="confirmClose()" Font-Bold="False" Font-Names="Trebuchet MS" />
                                        </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <radG:RadGrid ID="RadGrid2" runat="server" DataSourceID="SqlActivitieChanges" GridLines="None"
                                            Skin="Default" OnDataBound="RadGrid2_DataBound" AllowAutomaticDeletes="True" EnableAJAX="True">
                                            
                                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_act_change_id" DataSourceID="SqlActivitieChanges">
                                                <RowIndicatorColumn>
                                                    <HeaderStyle Width="20px" />
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle Width="20px" />
                                                </ExpandCollapseColumn>
                                                <Columns>
                                                    <radG:GridTemplateColumn UniqueName="TemplateColumn">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hlEdit" runat="server" ImageUrl="~/images/Edit.gif" NavigateUrl="#">Edit</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Top" />
                                                    </radG:GridTemplateColumn>
                                                    <radG:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" HeaderText="key_activity_id"
                                                        SortExpression="key_activity_id" UniqueName="key_activity_id" Display="False">
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="key_act_change_id" DataType="System.Int32" HeaderText="key_act_change_id"
                                                        ReadOnly="True" SortExpression="key_act_change_id" UniqueName="key_act_change_id" Display="False">
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="txt_activity_name_new" HeaderText="New Activity Name"
                                                        SortExpression="txt_activity_name_new" UniqueName="txt_activity_name_new">
                                                        <ItemStyle VerticalAlign="Top" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="txt_activity_desc_new" HeaderText="New Activity Desc"
                                                        SortExpression="txt_activity_desc_new" UniqueName="txt_activity_desc_new">
                                                        <ItemStyle VerticalAlign="Top" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="txt_activity_core_indicator_desc_new" HeaderText="New Core Indicator Desc"
                                                        SortExpression="txt_activity_core_indicator_desc_new" UniqueName="txt_activity_core_indicator_desc_new" Display="False">
                                                        <ItemStyle VerticalAlign="Top" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridTemplateColumn DataField="flg_Approved" HeaderText="Approved" SortExpression="flg_Approved"
                                                        UniqueName="flg_Approved">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbReqApproved" runat="server" Checked='<%# Eval("flg_approved") %>'
                                                                Enabled="False" />
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Top" />
                                                    </radG:GridTemplateColumn>
                                                    <radG:GridClientDeleteColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this Change Request?"
                                                        Text="Delete" UniqueName="DeleteColumn" ImageUrl="~/images/Delete.gif">
                                                        <ItemStyle VerticalAlign="Top" />
                                                    </radG:GridClientDeleteColumn>
                                                </Columns>
                                            </MasterTableView>
                                            <ClientSettings>
                                                <ClientEvents OnRowDeleted="forcePostback()" />
                                            </ClientSettings>
                           
                                           
                                        </radG:RadGrid></td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                    </td>
                                </tr>
                            </table>
                            <br />
                            
                        </radTS:PageView>
                        &nbsp;&nbsp;
                        <radTS:PageView ID="pv_History" runat="server" Width="100%">
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                            <asp:SqlDataSource ID="ds_History" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                            SelectCommand="pr_rpt_act_activity_transactions" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblAid" Name="p_key_activity_id" PropertyName="Text"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <telerik:RadGrid ID="rg_History" runat="server" DataSourceID="ds_History" GridLines="None"
                                OnItemDataBound="RadGrid3_ItemDataBound" Skin="Office2007_SCTCS" EnableEmbeddedSkins="False">
                                <MasterTableView AutoGenerateColumns="False" DataSourceID="ds_History" ShowFooter="True"
                                    ShowGroupFooter="True">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" Display="False"
                                            HeaderText="key_activity_id" ReadOnly="True" SortExpression="key_activity_id"
                                            UniqueName="key_activity_id">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="key_activity_line_item_id" DataType="System.Int32"
                                            Display="False" HeaderText="key_activity_line_item_id" ReadOnly="True" SortExpression="key_activity_line_item_id"
                                            UniqueName="key_activity_line_item_id">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="txt_line_item_desc" Display="False" HeaderText="txt_line_item_desc"
                                            ReadOnly="True" SortExpression="txt_line_item_desc" UniqueName="txt_line_item_desc">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="dte_created_date" DataFormatString="{0:d}" DataType="System.DateTime"
                                            HeaderText="Created Date" ReadOnly="True" SortExpression="dte_created_date" UniqueName="dte_created_date">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="nbr_credit_amount" DataFormatString="{0:N2}"
                                            DataType="System.Decimal" HeaderText="Credit Amount" ReadOnly="True" SortExpression="nbr_credit_amount"
                                            UniqueName="nbr_credit_amount">
                                            <FooterStyle HorizontalAlign="Right" />
                                            <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="nbr_debit_amount" DataFormatString="{0:N2}" DataType="System.Decimal"
                                            HeaderText="Debit Amount" ReadOnly="True" SortExpression="nbr_debit_amount" UniqueName="nbr_debit_amount">
                                            <FooterStyle HorizontalAlign="Right" />
                                            <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn HeaderText="Balance" UniqueName="TemplateColumn">
                                            <FooterTemplate>
                                                <asp:Label ID="lbl_Sum" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" />
                                            <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="txt_desc" HeaderText="Description" ReadOnly="True"
                                            SortExpression="txt_desc" UniqueName="txt_desc">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                    <GroupByExpressions>
                                        <telerik:GridGroupByExpression>
                                            <SelectFields>
                                                <telerik:GridGroupByField FieldAlias="txt_line_item_desc" FieldName="txt_line_item_desc" HeaderText="Line Item" FormatString="" />
                                            </SelectFields>
                                            <GroupByFields>
                                                <telerik:GridGroupByField FieldAlias="txt_line_item_desc" FieldName="txt_line_item_desc" HeaderText="Line Item" FormatString=""  />
                                            </GroupByFields>
                                        </telerik:GridGroupByExpression>
                                    </GroupByExpressions>
                                    <GroupHeaderItemStyle HorizontalAlign="Left" />
                                    <EditFormSettings>
                                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                            UpdateImageUrl="Update.gif">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                                <HeaderContextMenu EnableEmbeddedScripts="False">
                                </HeaderContextMenu>
                                <AlternatingItemStyle BackColor="#F7F7F7" />
                                <FilterMenu EnableEmbeddedScripts="False">
                                </FilterMenu>
                            </telerik:RadGrid>
                        </radTS:PageView>
                    </radTS:RadMultiPage>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Label ID="lblPrintTrigger" runat="server"></asp:Label></td>
            </tr>
        </table>
    
    </div>
        <asp:SqlDataSource ID="sqldsAmendmentReason" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_amendment_reason_id], [txt_amendment_reason_desc] FROM [scs_amendment_reason]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDsActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT     TOP (100) PERCENT key_activity_id, txt_activity_name&#13;&#10;FROM         dbo.v_line_item_balance&#13;&#10;GROUP BY key_local_plan_id, key_activity_id, txt_activity_name&#13;&#10;HAVING      (key_local_plan_id = 101) AND (SUM(nbr_line_item_balance) > 0)&#13;&#10;ORDER BY txt_activity_name">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDsUseOfFunds" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_category_type_id], [txt_category_type_desc] FROM [scs_category_type]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_ActivityType" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_activity_type_id], [txt_activity_type_desc] FROM [scs_activity_type]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_CoreIndicators" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT key_core_indicator_id, txt_core_indiciator_code+ ' - ' +  txt_core_indicator_name  FROM scs_core_indicator">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_Category" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            SelectCommand="pr_scs_category_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_FunctionCODE" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_category_function_assoc_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="DLB_Category" DefaultValue="111" Name="p_key_category_id"
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_radiostuff" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_fa_activity_type_get" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_ActivityBudgetFunds" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_line_item_type_desc_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="106" Name="p_key_line_item_type_id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Panel ID="Panel1" runat="server" Height="50px" Style="position: relative" Width="125px">
            <asp:SqlDataSource ID="SqlDS_RLactivityGET" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_act_activity_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="id"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_RLActivityLineGet" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_act_activity_line_item_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="id"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_RLcoreindi_Get" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_act_activity_core_indicator_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="id"
                        Type="Int32" />
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_change_id" QueryStringField="acrId"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SQLDS_RLGETBALANCE" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
                SelectCommand="pr_lp_local_plan_balance_get " SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:ControlParameter ControlID="hfLpId" Name="p_key_local_plan_id" PropertyName="Value"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <asp:HiddenField ID="hfTotBal" runat="server" />
        <asp:HiddenField ID="hfGridTot" runat="server" />
        <br />
    </form>
</body>
</html>
