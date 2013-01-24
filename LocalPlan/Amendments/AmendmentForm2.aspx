<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AmendmentForm2.aspx.cs" Inherits="LocalPlan_Amendments_AmendmentForm2" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Amendment</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
    <link href="../../Custom_Skins/Grid.Office2007.css"rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript">
        var grid;
        
        function OnGridCreated()  
        {  
            grid=this;  
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
            GetRadWindow().Close();
        }

        function Rebind()
        {
            GetRadWindow().BrowserWindow.location.reload();
        }
        
        function CloseAndRebind(level)
        {         
            Close();   
            GetRadWindow().BrowserWindow.refreshActivities("Amendments");  
        }
        
        function CloseAndReload()
        {         
            Close();   
            GetRadWindow().BrowserWindow.location.reload(); 
        }
        

        function refreshPage()
        {
            window.location.reload(false);
        }
 
        
        function passValue(index)   
        {   
           // var cellVal = grid.MasterTableView.GetCellByColumnUniqueName(grid.MasterTableView.SelectedRows[index], "TemplateColumn");;   
            alert(grid.MasterTableView.GetCellByColumnUniqueName(0,"TemplateColumn"));
        }   

        
  
   
        function Print(format)
        {       
            var keyid= document.getElementById("FormView1_lbl_Amendment_Num").innerText;

            //   var oBrowserWnd = GetRadWindow().BrowserWindow; 
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;


            window.open("../../Reports/ViewReport.aspx?type=FundedAmendment&Keyid=" + keyid + "&format=" + format ,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
           
        }
        
    
//        function Print()
//        {        
//            window.open("../../Reports/ViewReport.aspx?type='activities'");
//        }

        function editActivityChangeRequest(aid, acrId, type)
        {
           //alert(acrId);
           
           var rWindow = window.radopen("../Activities/ActivityChangeRequest.aspx?aid=" + aid + "&acrId=" + acrId + "&type=" + type, "UserListDialog");
                    
           rWindow.SetSize(950,650);
           rWindow.Center();
        }
        
        function cvCoreIndValFunc(source, args)
        {   
            var cblCoreInd = document.getElementById('<%= FormView1.FindControl("chkCoreIndicators").ClientID %>').getElementsByTagName('input');                                  
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
            var args = confirm("Are you sure you want to delete this record?");
            if (args == true)
            {
                document.getElementById("<%= hfDelete.ClientID  %>").value  = "yes";
            }
            else
            {
                document.getElementById("<%= hfDelete.ClientID  %>").value  = "no";                
            }                
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

        <table style="border-top-width: 1px; border-left-width: 1px; border-left-color: gray;
            border-bottom-width: 1px; border-bottom-color: gray; width: 785px; border-top-color: gray;
            border-right-width: 1px; border-right-color: gray">
            <tr>
                <td colspan="3" style="border-bottom: black 1px groove; text-align: center; width: 791px;">
                    <strong><span style="font-size: 11pt"><span style="font-size: 11pt; color: black">Local Plan Amendment Form (Form 4) - Perkins IV
                                                        Postsecondary Funding </span>  </span></strong>
                    <span
                        style="font-size: 11pt"> &nbsp;</span><asp:Label ID="lblFiscalYear" runat="server"
                            Font-Bold="True" Font-Size="11pt" Text=""></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3" style="border-top-width: 1px; border-left-width: 1px; border-left-color: black;
                    border-bottom-width: 1px; border-bottom-color: black; border-top-color: black;
                    border-right-width: 1px; border-right-color: black; width: 791px;">
                    <radTS:RadTabStrip ID="RadTabStrip1" runat="server" Font-Bold="False" Font-Names="Trebuchet MS"
                        Font-Size="9pt" MultiPageID="RadMultiViewActivity" Skin="ClassicBlue" Style="border-bottom: skyblue 1px groove" CausesValidation="False">
                        <Tabs>
                            <radTS:Tab runat="server" PageViewID="PgViewActivity" Text="Amendment Information">
                            </radTS:Tab>
                            <radTS:Tab runat="server" PageViewID="PgViewChangeRequest" Text="Change Requests">
                            </radTS:Tab>
                            <radTS:Tab runat="server" PageViewID="pv_History" Text="Transaction History">
                            </radTS:Tab>
                        </Tabs>
                    </radTS:RadTabStrip>
                </td>
            </tr>
            <tr>
                <td colspan="3" style="width: 791px">
                    <radTS:RadMultiPage ID="RadMultiViewActivity" runat="server" Width="746px">
                        <radTS:PageView ID="PgViewActivity" runat="server">
                            <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDS_RLactivityGET" OnPageIndexChanging="FormView1_PageIndexChanging">
                                <ItemTemplate>
                                    
                                        <table style="border-top-width: 1px; border-left-width: 1px; font-size: 9pt; border-left-color: gray;
                                            border-bottom-width: 1px; border-bottom-color: gray; width: 703px; border-top-color: gray;
                                             border-right-width: 1px; border-right-color: gray">
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="border-bottom: black 1px groove; text-align: right">
                                                    <asp:Label ID="lblMsg" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="border-bottom: black 1px groove; text-align: right;">
                                                    <strong><span>
                                                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" Width="100px" /><asp:Button ID="btnDelete" runat="server" CausesValidation="False" OnClick="btnDelete_Click"
                                                        OnClientClick="confirmDelete()" Text="Delete" Width="100px" />
                                                        <asp:Button ID="btnPrint" runat="server" CausesValidation="False" OnClick="btnPrint_Click"
                                                        OnClientClick="Print('pdf')" Text="Print PDF" Width="100px" />
                                                        <asp:Button ID="btnPrintWord" runat="server" CausesValidation="False" OnClick="btnPrint_Click"
                                                        OnClientClick="Print('AWDOCX')" Text="Print Word" Width="100px" />
                                                     
                                                     
                                                     <asp:Button ID="btnClose" runat="server" CausesValidation="False" OnClick="btnClose_Click"
                                                        Text="Close" Width="100px" /></span></strong></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="width: 146px; height: 21px; text-align: left">
                                                    Amendment #</td>
                                                <td colspan="3" style="width: 670px; height: 21px; text-align: left">
                                                    <asp:Label ID="lbl_Amendment_Num" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "key_activity_id") %>'></asp:Label></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="width: 146px; height: 22px; text-align: left">
                                                    Amendment Name</td>
                                                <td align="left" colspan="3" style="width: 670px; height: 22px">
                                                    <asp:TextBox ID="txtActivityName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "txt_activity_name") %>'
                                                        Width="87%"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtActivityName"
                                                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="width: 146px; height: 2px; text-align: left">
                                                    Amendment Type</td>
                                                <td align="left" colspan="3" style="width: 670px; height: 2px">
                                                    <asp:Label ID="lblAmendmendType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "txt_amendment_reason_desc") %>'></asp:Label></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="width: 146px; height: 4px; text-align: left">
                                                    Activity Type</td>
                                                <td align="left" colspan="3" style="width: 670px; height: 4px">
                                                    <asp:Label ID="lblActivityType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "txt_activity_type_desc") %>'></asp:Label></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="width: 146px; height: 1px; text-align: left">
                                                    Category</td>
                                                <td align="left" colspan="3" style="width: 670px; height: 1px">
                                                    <asp:DropDownList ID="DLB_Category" runat="server" DataSourceID="SDS_Category" DataTextField="txt_category_title"
                                                        DataValueField="key_category_id"  Width="310px" AutoPostBack="True" OnSelectedIndexChanged="DLB_Category_SelectedIndexChanged">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="width: 146px; height: 3px; text-align: left">
                                                    <asp:Label ID="Label2" runat="server" Text="Function Code" Width="84px"></asp:Label></td>
                                                <td align="left" colspan="3" style="width: 670px; height: 3px">
                                                    <asp:DropDownList ID="DLB_FunCode" runat="server" DataSourceID="SDS_FunctionCODE"
                                                        DataTextField="txt_function_code_desc" DataValueField="key_function_code_id"
                                                         Width="256px">
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="width: 146px; height: 13px; text-align: left">
                                                    <asp:Label ID="Label7" runat="server" Text="Use of Funds"></asp:Label></td>
                                                <td align="left" colspan="3" style="width: 670px; height: 13px">
                                                    <asp:TextBox ID="txt_SourceofFunds" runat="server" Style="position: relative"></asp:TextBox>
                                                    &nbsp;
                                                    <asp:Label ID="Label3" runat="server" Text="Program Type"></asp:Label>&nbsp;
                                                    <asp:DropDownList ID="ddlProgramType" runat="server" DataSourceID="SDS_radiostuff"
                                                        DataTextField="txt_fa_activity_desc" DataValueField="key_fa_activity_type_id"
                                                         Width="203px" OnDataBound="ddlProgramType_DataBound">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="ddlUseOfFunds" runat="server" DataSourceID="sqlDsUseOfFunds"
                                                        DataTextField="txt_category_type_desc" DataValueField="key_category_type_id"
                                                        Width="7px" style="position: relative" Visible="False">
                                                    </asp:DropDownList>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="border-top: black 1px groove; width: 146px; height: 6px; text-align: left"
                                                    valign="top">
                                                    Core Indicators</td>
                                                <td align="left" colspan="3" style="border-top: black 1px groove; width: 670px; height: 6px">
                                                    <asp:CheckBoxList ID="chkCoreIndicators" runat="server" DataSourceID="SDS_CoreIndicators"
                                                        DataTextField="Column1" DataValueField="key_core_indicator_id">
                                                    </asp:CheckBoxList></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td style="border-top: black 1px groove; width: 146px; height: 6px; text-align: left"
                                                    valign="top">
                                                </td>
                                                <td align="left" colspan="3" style="border-top: black 1px groove; width: 670px; height: 6px">
                                                    <asp:CustomValidator ID="cvCoreInd" runat="server" ClientValidationFunction="cvCoreIndValFunc"
                                                        ErrorMessage="* Required (At least one core indicator has to be selected)" Font-Bold="False"
                                                       ></asp:CustomValidator></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="border-top: black 1px groove; color: black; height: 10px;
                                                    text-align: left" valign="top">
                                                    Describe the proposed change in funds and/or new activity
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDescActivity"
                                                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr style="font-size:9pt">
                                                <td colspan="4" style="width: 100%; height: 10px; text-align: left" valign="top">
                                                    <asp:TextBox ID="txtDescActivity" runat="server" Height="158px" Text='<%# DataBinder.Eval(Container.DataItem, "txt_activity_desc") %>'
                                                        TextMode="MultiLine" Width="99%" Font-Names="Trebuchet MS"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="color: black; height: 10px; text-align: left" valign="top">
                                                    Describe how the proposed change in funds and/or new activity will help meet the
                                                    core indicators
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescCoreInd"
                                                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                                    <asp:TextBox ID="txtDescCoreInd" runat="server" Height="161px" Text='<%# DataBinder.Eval(Container.DataItem, "txt_activity_core_indicator_desc") %>'
                                                        TextMode="MultiLine" Width="99%" Font-Names="Trebuchet MS"></asp:TextBox></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="color: black; height: 10px; text-align: left" valign="top">
                                                    Explain how the reduction of funds will impact the original activity.
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAmdReductionDesc"
                                                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                                    <asp:TextBox ID="txtAmdReductionDesc" runat="server" Height="151px" Text='<%# DataBinder.Eval(Container.DataItem, "txt_funds_reduction_impact_desc") %>'
                                                        Width="99%" Font-Names="Trebuchet MS" TextMode="MultiLine"></asp:TextBox></td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                                    <table style="border-top-width: 1px; border-left-width: 1px; border-left-color: black;
                                                        border-bottom-width: 1px; border-bottom-color: black; width: 759px; border-top-color: black;
                                                        border-right-width: 1px; border-right-color: black">
                                                        <tr>
                                                            <td colspan="3" style="border-top-width: 1px; border-left-width: 1px; border-left-color: dimgray;
                                                                border-top-color: dimgray; border-bottom: black 1px groove; height: 17px; text-align: left;
                                                                border-right-width: 1px; border-right-color: dimgray">
                                                                Detail Funding Reallocation</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="border-top-width: 1px; border-left-width: 1px; border-left-color: dimgray;
                                                                width: 364px; border-top-color: dimgray; border-bottom: dimgray 1px groove; text-align: center;
                                                                border-right-width: 1px; border-right-color: dimgray">
                                                                MOVE FROM</td>
                                                            <td colspan="2" style="border-bottom: dimgray 1px groove; text-align: center">
                                                                MOVE TO</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 364px; height: 16px; text-align: left">
                                                                Activity -
                                                                <asp:Label ID="lblAcitvityFrom" runat="server" Text="Label"></asp:Label></td>
                                                            <td colspan="2" style="height: 16px; text-align: left">
                                                                Activity -
                                                                <asp:Label ID="lblActivityTo" runat="server" Text="Label"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 364px; height: 16px; text-align: left">
                                                                Category -
                                                                <asp:Label ID="lblCategoryFrom" runat="server" Text="Label"></asp:Label></td>
                                                            <td colspan="2" style="height: 16px; text-align: left">
                                                                Category -
                                                                <asp:Label ID="lblCategoryTo" runat="server" Text="Label"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 364px; border-bottom: dimgray 1px groove; height: 16px; text-align: left">
                                                                Function -
                                                                <asp:Label ID="lblFunctionFrom" runat="server" Text="Label"></asp:Label></td>
                                                            <td colspan="2" style="border-bottom: dimgray 1px groove; height: 16px; text-align: left">
                                                                Function -
                                                                <asp:Label ID="lblFunctionTo" runat="server" Text="Label"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 364px; height: 16px; text-align: left">
                                                                &nbsp;</td>
                                                            <td colspan="2" style="height: 16px; text-align: left">
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td style="border-right: dimgray 1px groove; width: 364px" valign="top">
                                                                <radG:RadGrid ID="RadMoveFrom" runat="server" DataSourceID="SQLDsMoveFrom" GridLines="None"
                                                                    Height="127px" Skin="Default">
                                                                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_activity_line_item_id"
                                                                        DataSourceID="SQLDsMoveFrom">
                                                                        <RowIndicatorColumn Visible="False">
                                                                            <HeaderStyle Width="20px" />
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="False">
                                                                            <HeaderStyle Width="19px" />
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <radG:GridBoundColumn DataField="key_activity_line_item_id" DataType="System.Int32"
                                                                                HeaderText="key_activity_line_item_id" ReadOnly="True" SortExpression="key_activity_line_item_id"
                                                                                UniqueName="key_activity_line_item_id" Visible="False">
                                                                            </radG:GridBoundColumn>
                                                                            <radG:GridBoundColumn DataField="txt_line_item_desc" HeaderText="Line Item Description"
                                                                                SortExpression="txt_line_item_desc" UniqueName="txt_line_item_desc">
                                                                            </radG:GridBoundColumn>
                                                                            <radG:GridBoundColumn DataField="nbr_amount" DataFormatString="{0:c}" DataType="System.Decimal"
                                                                                HeaderText="Amount" ReadOnly="True" SortExpression="nbr_amount" UniqueName="nbr_amount">
                                                                            </radG:GridBoundColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </radG:RadGrid>
                                                            </td>
                                                            <td colspan="2" style="border-left: dimgray 1px groove" valign="top">
                                                                <radG:RadGrid ID="RadMoveTo" runat="server" DataSourceID="SqlDsMoveTo" GridLines="None"
                                                                    Height="149px" Skin="Default">
                                                                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_activity_line_item_id"
                                                                        DataSourceID="SqlDsMoveTo">
                                                                        <RowIndicatorColumn Visible="False">
                                                                            <HeaderStyle Width="20px" />
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="False">
                                                                            <HeaderStyle Width="19px" />
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <radG:GridBoundColumn DataField="key_activity_line_item_id" DataType="System.Int32"
                                                                                HeaderText="key_activity_line_item_id" ReadOnly="True" SortExpression="key_activity_line_item_id"
                                                                                UniqueName="key_activity_line_item_id" Visible="False">
                                                                            </radG:GridBoundColumn>
                                                                            <radG:GridBoundColumn DataField="txt_line_item_desc" HeaderText="Line Item Description"
                                                                                SortExpression="txt_line_item_desc" UniqueName="txt_line_item_desc">
                                                                            </radG:GridBoundColumn>
                                                                            <radG:GridBoundColumn DataField="nbr_amount" DataFormatString="{0:c}" DataType="System.Decimal"
                                                                                HeaderText="Amount" ReadOnly="True" SortExpression="nbr_amount" UniqueName="nbr_amount">
                                                                            </radG:GridBoundColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </radG:RadGrid>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3" style="border-bottom: dimgray 1px groove; height: 16px">
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    &nbsp;
                                                    <br />
                                                    <table style="width: 751px;">
                                                        <tr>
                                                            <td colspan="4" style="height: 7px; text-align: left">
                                                                <strong>Date Updated &nbsp;</strong><asp:Label ID="lblDateUpdated" runat="server"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "dte_updated_date") %>' Width="93px"></asp:Label>
                                                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <strong>Updated By</strong>
                                                                <asp:Label ID="lblUpdatedBy" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "txt_updated_user") %>'
                                                                    Width="106px"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" style="height: 7px; background-color: gainsboro; text-align: left">
                                                                <strong><span style="color: #000099">For System Office Use Only</span></strong></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" style="height: 7px; text-align: left">
                                                                <strong>Approved by System Office&nbsp;</strong>
                                                                <asp:CheckBox ID="cbApproved" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem, "flg_approved") %>' />
                                                                &nbsp; <strong>Locked by System Office</strong>&nbsp;
                                                                <asp:CheckBox ID="cbLocked" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem, "flg_locked") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" style="height: 7px; background-color: gainsboro; text-align: left">
                                                                <strong>Status &nbsp;</strong></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" style="height: 7px; text-align: left">
                                                                <asp:DropDownList ID="ddStatus" runat="server" DataSourceID="SqlDataSource1" DataTextField="txt_level_desc"
                                                                    DataValueField="key_level_id" SelectedValue='<%# DataBinder.Eval(Container.DataItem, "key_level_id") %>'
                                                                    Width="416px">
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
                                                                <asp:TextBox ID="txtSystemOfficeNotes" runat="server" Height="120px" Text='<%# DataBinder.Eval(Container.DataItem, "txt_system_office_notes") %>'
                                                                    TextMode="MultiLine" Width="743px" Font-Names="Trebuchet MS"></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr style="font-size: 9pt">
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    </td>
                                            </tr>
                                        </table>
                                   
                                    <asp:HiddenField ID="hdnKeyActivityTypeID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "key_activity_type_id") %>' />
        <asp:SqlDataSource ID="SDS_Category" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_category_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnKeyActivityTypeID" DefaultValue="1" Name="p_txt_category_type"
                    PropertyName="Value" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource><asp:HiddenField ID="hfCategory" runat="server" />
                                </ItemTemplate>
                            </asp:FormView>
                            <br />
                            </radTS:PageView>
                        <radTS:PageView ID="PgViewChangeRequest" runat="server" Width="100%" >
                            <br />
                            <table width="100%">
                                <tr>
                                    <td colspan="3" valign="top" align="left">
                                        <div Id="hlAcr" style="Display:inline;" runat="server">
                                            <asp:HyperLink ID="hlActivityChangeRequest" runat="server" Font-Bold="True" Font-Names="Trebuchet MS"
                                                Font-Size="9pt" NavigateUrl="#">[New Change Request]</asp:HyperLink>
                                        </div>
                                    </td>
                                    <td align="right" colspan="1" valign="top">
                                        &nbsp; &nbsp;
                                        <asp:Button ID="btnClose" runat="server" CausesValidation="False" OnClick="btnClose_Click"
                                                        Text="Close" Width="100px" />&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 172px" valign="top">
                                        <radG:RadGrid ID="RadGrid2" runat="server" AllowAutomaticDeletes="True" DataSourceID="SqlActivitieChanges"
                                            GridLines="None" OnDataBound="RadGrid2_DataBound" Skin="Default" EnableAJAX="True">
                                   
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
                                                    <radG:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" Display="False"
                                                        HeaderText="key_activity_id" SortExpression="key_activity_id" UniqueName="key_activity_id">
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="key_act_change_id" DataType="System.Int32" Display="False"
                                                        HeaderText="key_act_change_id" ReadOnly="True" SortExpression="key_act_change_id"
                                                        UniqueName="key_act_change_id">
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
                                                        SortExpression="txt_activity_core_indicator_desc_new" UniqueName="txt_activity_core_indicator_desc_new">
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
                                        </radG:RadGrid><asp:SqlDataSource ID="SqlActivitieChanges" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                            DeleteCommand="pr_act_change_request_del" DeleteCommandType="StoredProcedure"
                                            SelectCommand="SELECT [key_activity_id], [key_act_change_id], [txt_activity_name_new], [txt_activity_desc_new], [txt_activity_core_indicator_desc_new], [flg_approved] FROM [act_change] WHERE ([key_activity_id] = @key_activity_id)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="keyid"
                                                    Type="Int32" />
                                            </SelectParameters>
                                            <DeleteParameters>
                                                <asp:Parameter Name="key_act_change_id" Type="Int32" />
                                            </DeleteParameters>
                                        </asp:SqlDataSource>
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                    </td>
                                    <td colspan="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="height: 18px">
                                        
                                    </td>
                                    <td colspan="1" style="height: 18px">
                                    </td>
                                </tr>
                            </table>
                            <br />
                        </radTS:PageView>
                        &nbsp;&nbsp;
                        <radTS:PageView ID="pv_History" runat="server" Width="100%">
                            <asp:SqlDataSource ID="ds_History" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                SelectCommand="pr_rpt_act_activity_transactions" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hf_Amendment_Id" DefaultValue="" Name="p_key_activity_id"
                                        PropertyName="Value" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                            <telerik:RadGrid ID="rg_History" runat="server" DataSourceID="ds_History" GridLines="None"
                                OnItemDataBound="rg_History_ItemDataBound" Skin="Office2007_SCTCS" EnableEmbeddedSkins="False">
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
                                                <telerik:GridGroupByField FieldAlias="txt_line_item_desc" FieldName="txt_line_item_desc" HeaderText="Line Item" />
                                            </SelectFields>
                                            <GroupByFields>
                                                <telerik:GridGroupByField FieldAlias="txt_line_item_desc" FieldName="txt_line_item_desc" />
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
                            </telerik:RadGrid></radTS:PageView>
                    </radTS:RadMultiPage>
                   
                </td>
            </tr>
        </table>
        <asp:Label ID="InjectScript" runat="server"></asp:Label>
                                                    <asp:HiddenField ID="hfPageInfo" runat="server" />
                                                    <asp:HiddenField ID="hfDelete" runat="server" />
                                                    <asp:HiddenField ID="hfTotalBudget" runat="server" />
                                                    <asp:HiddenField ID="hfItem" runat="server" />
                                                    <asp:HiddenField ID="hfLpId" runat="server" />
                                                    <asp:HiddenField ID="hfFlgSave" runat="server" />
        &nbsp;&nbsp;<br />
        <asp:HiddenField ID="hfCategory" runat="server" />
        <br />

        
        <asp:Panel ID="Panel1" runat="server" style="position: relative" Height="50px" Width="125px">
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="SqlDataSource2" runat="server" SelectCommand="SELECT [key_level_id], [txt_level_desc] FROM [scs_level]"></asp:SqlDataSource>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="SQLDS_RLMOVEFROM_CAT" runat="server" SelectCommand="pr_at_amendment_move_from_category_function" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="p_key_activity_id" QueryStringField="keyid" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="sqlds_rlmoveto_cat" runat="server" SelectCommand="pr_at_amendment_move_to_category_function" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="p_key_activity_id" QueryStringField="keyid" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:SqlDataSource ID="SqlDS_RLcoreindi_Get" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_act_activity_core_indicator_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="keyid"
                        Type="Int32" />
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_change_id" QueryStringField="acrId"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_RLactivityGET" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_act_activity_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="keyid"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <br />
    
   
        <asp:SqlDataSource ID="sqlDsActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT     TOP (100) PERCENT key_activity_id, txt_activity_name&#13;&#10;FROM         dbo.v_line_item_balance&#13;&#10;GROUP BY key_local_plan_id, key_activity_id, txt_activity_name&#13;&#10;HAVING      (key_local_plan_id = 101) AND (SUM(nbr_line_item_balance) > 0)&#13;&#10;ORDER BY txt_activity_name">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDsUseOfFunds" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_category_type_id], [txt_category_type_desc] FROM [scs_category_type]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SQLDsMoveFrom" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                    SelectCommand="pr_at_amendment_move_from" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter DefaultValue="-1" Name="p_key_activity_id" QueryStringField="keyid"
                                            Type="Int32" />
                                    </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDsMoveTo" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_at_amendment_move_to" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="-1" Name="p_key_activity_id" QueryStringField="keyid"
                    Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
        &nbsp;&nbsp;
        <asp:SqlDataSource ID="SDS_CoreIndicators" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT key_core_indicator_id, txt_core_indiciator_code+ ' - ' +  txt_core_indicator_name  FROM scs_core_indicator">
        </asp:SqlDataSource>
        &nbsp;
        <asp:SqlDataSource ID="SDS_FunctionCODE" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_category_function_assoc_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hfCategory" DefaultValue="-1" Name="p_key_category_id"
                    PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_radiostuff" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_fa_activity_type_get" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:HiddenField ID="hfLocal_plan_id" runat="server" /><asp:HiddenField ID="hf_Amendment_Id" runat="server" />
        <br />
        <radW:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Vista">
        </radW:RadWindowManager>
    </form>
</body>
</html>
