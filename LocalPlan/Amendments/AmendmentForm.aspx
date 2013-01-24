<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AmendmentForm.aspx.cs" Inherits="LocalPlan_Amendments_AmendmentForm" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Amendment</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
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
            var level = document.getElementById("<%= hfLevel.ClientID %>").value;
            GetRadWindow().Close();
            GetRadWindow().BrowserWindow.refreshActivities("Amendments");
        }

        function Rebind()
        {
            GetRadWindow().BrowserWindow.location.reload();
        }
        
        function CloseAndRebind(openWindow)
        {         
           // Close();   
           // GetRadWindow().BrowserWindow.refreshGrid("RadGrid1");  
           GetRadWindow().Close(); 
         
           var oWnd = GetRadWindow().BrowserWindow;  
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

        
  
  function confirmDelete()
        {
            var args = confirm("Are you sure you want to delete this record?");
            
            if(args == false)
            {
            window.event.cancelBubble = true;
window.event.returnValue = false;
            }
        
    }
        function Print(format)
        {        
            var keyid= document.getElementById("FormView1_Label1").innerText;

            //   var oBrowserWnd = GetRadWindow().BrowserWindow; 
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;


            window.open("../../Reports/ViewReport.aspx?type=transferfunds&Keyid=" + keyid + "&format=" + format,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
        }
    </script>
    
    <div style="background-color: white; text-align: center;">
      <asp:FormView ID="FormView1" runat="server" Style="position: relative;"  DataSourceID="SqlDS_RLactivityGET" OnPageIndexChanging="FormView1_PageIndexChanging">
        <ItemTemplate>
        <table style="font-size: 9pt; width: 703px; font-family: 'Trebuchet MS'">
            <tr>
                <td colspan="4" style="border-bottom: black 1px groove">
                    <strong> <span style="font-size: 11pt">Local Plan Amendment Form (Form 4) - 
                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="11pt"></asp:Label>&nbsp;
                        
                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Text="" Font-Size="11pt"></asp:Label></span></strong></td>
            </tr>
            <tr>
                <td colspan="4" style="border-bottom: black 1px groove; text-align: right">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4" style="border-bottom: black 1px groove; text-align: right">
                    <asp:Button ID="btnSave" runat="server" Text="Save" Width="100px" OnClick="btnSave_Click" />
                    
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CausesValidation="False" Width="100px" OnClientClick="confirmDelete()" OnClick="btnDelete_Click" />
                    
                    
                   <asp:Button ID="btnPrint" runat="server" CausesValidation="False" OnClick="btnPrint_Click"
                                                        OnClientClick="Print('pdf')" Text="Print PDF" Width="100px" />
                                                        <asp:Button ID="btnPrintWord" runat="server" CausesValidation="False" OnClick="btnPrint_Click"
                                                        OnClientClick="Print('AWDOCX')" Text="Print Word" Width="100px" />
                    
                    
                    <asp:Button ID="btnClose" runat="server" Text="Close" CausesValidation="False" OnClick="btnClose_Click" Width="100px" OnClientClick="Close()" /></td>
            </tr>
            <tr style="font-size: 9pt">
                <td style="width: 146px; height: 21px; text-align: left">
                    Amendment #</td>
                <td colspan="3" style="width: 670px; height: 21px; text-align: left">
                    <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "key_activity_id") %>'></asp:Label></td>
            </tr>
            <tr style="font-size: 9pt">
                <td style="width: 146px; height: 22px; text-align: left">
                    Amendment Name</td>
                <td colspan="3" style="height: 22px; width: 670px;" align="left">
                    <asp:TextBox ID="txtActivityName" runat="server" Width="558px" Text='<%# DataBinder.Eval(Container.DataItem, "txt_activity_name") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtActivityName"
                        ErrorMessage="* Required" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
            </tr>
            <tr style="font-size: 9pt">
                <td style="height: 10px; text-align: left; border-bottom: dimgray 1px groove;" valign="top" colspan="4">
                    &nbsp;&nbsp;</td>
            </tr>
            <tr style="font-size: 9pt">
                <td style="height: 10px; text-align: left;" valign="top" colspan="4">
                    <span style="font-family: Trebuchet MS">Describe the proposed change in funds and/or
                        new activity &nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDescActivity"
                            ErrorMessage="* Required"></asp:RequiredFieldValidator></span></td>
            </tr>
            <tr style="font-size: 9pt">
                <td style="width: 100%; height: 10px; text-align: left" valign="top" colspan="4">
                    <asp:TextBox ID="txtDescActivity" runat="server" Height="158px" Width="99%" TextMode="MultiLine" Text='<%# DataBinder.Eval(Container.DataItem, "txt_activity_desc") %>' Font-Names="Trebuchet MS" Font-Size="9pt"></asp:TextBox>
                    </td>
            </tr>
            <tr style="font-size: 9pt">
                <td style="height: 10px; text-align: left;" valign="top" colspan="4">
                    <span style="font-family: Trebuchet MS">
                    Describe how the proposed change in funds and/or new activity will help meet the core indicators &nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescCoreInd"
                            ErrorMessage="* Required"></asp:RequiredFieldValidator></span></td>
            </tr>
            <tr style="font-size: 9pt">
                <td style="height: 10px; text-align: left" valign="top" colspan="4">
                    <asp:TextBox ID="txtDescCoreInd" runat="server" Height="161px" Width="99%" TextMode="MultiLine" Text='<%# DataBinder.Eval(Container.DataItem, "txt_activity_core_indicator_desc") %>' Font-Names="Trebuchet MS" Font-Size="9pt"></asp:TextBox></td>
            </tr>
            <tr style="font-size: 9pt">
                <td colspan="4" style="height: 10px; text-align: left;" valign="top">
                    <span style="font-family: Trebuchet MS">
                    Explain how the reduction of funds will impact the original activity.&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAmdReductionDesc"
                            ErrorMessage="* Required"></asp:RequiredFieldValidator></span></td>
            </tr>
            <tr style="font-size: 9pt">
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                    <asp:TextBox ID="txtAmdReductionDesc" runat="server" Height="151px" Width="99%" Text='<%# DataBinder.Eval(Container.DataItem, "txt_funds_reduction_impact_desc") %>' Font-Names="Trebuchet MS" Font-Size="9pt" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr style="font-size: 9pt">
                <td colspan="4" style="height: 10px; text-align: left; border-top-style: groove; border-right-style: groove; border-left-style: groove; border-bottom-style: groove;" valign="top">
                    Detail Funding Reallocation</td>
            </tr>
            <tr style="font-size: 9pt">
                <td colspan="4" style="height: 10px; text-align: left" valign="top">
                  
                    <table style="width: 759px">
                        <tr>
                            <td style="width: 364px; text-align: center; border-top-width: 1px; border-left-width: 1px; border-left-color: dimgray; border-top-color: dimgray; border-bottom: dimgray 1px groove; border-right-width: 1px; border-right-color: dimgray;">
                                MOVE FROM</td>
                            <td colspan="2" style="text-align: center; border-bottom: dimgray 1px groove;">
                                MOVE TO</td>
                        </tr>
                        <tr>
                            <td style="width: 364px; text-align: left; height: 16px;">
                                Activity -
                                <asp:Label ID="lblAcitvityFrom" runat="server" Text="Label"></asp:Label></td>
                            <td colspan="2" style="text-align: left; height: 16px;">
                                Activity -
                                <asp:Label ID="lblActivityTo" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 364px; text-align: left; height: 16px;">
                                Category -
                                <asp:Label ID="lblCategoryFrom" runat="server" Text="Label"></asp:Label></td>
                            <td colspan="2" style="text-align: left; height: 16px;">
                                Category -
                                <asp:Label ID="lblCategoryTo" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 364px; text-align: left; border-bottom: dimgray 1px groove; height: 16px;">
                                Function -
                                <asp:Label ID="lblFunctionFrom" runat="server" Text="Label"></asp:Label></td>
                            <td colspan="2" style="text-align: left; border-bottom: dimgray 1px groove; height: 16px;">
                                Function -
                                <asp:Label ID="lblFunctionTo" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 364px; height: 16px; text-align: left">
                                &nbsp;
                            </td>
                            <td colspan="2" style="height: 16px; text-align: left">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 364px; border-right: dimgray 1px groove;" valign = "top">
                                <radG:RadGrid ID="RadMoveFrom" runat="server" DataSourceID="SQLDsMoveFrom" GridLines="None" Skin="Default" Height="127px">
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
                                            <radG:GridBoundColumn DataField="nbr_amount" DataType="System.Decimal" HeaderText="Amount"
                                                ReadOnly="True" SortExpression="nbr_amount" UniqueName="nbr_amount" DataFormatString="{0:c}">
                                            </radG:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </radG:RadGrid>
                            </td>
                            <td colspan="2" valign = "top" style="border-left: dimgray 1px groove">
                                <radG:RadGrid ID="RadMoveTo" runat="server" DataSourceID="SqlDsMoveTo" GridLines="None" Height="149px" Skin="Default">
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
                                            <radG:GridBoundColumn DataField="nbr_amount" DataType="System.Decimal" HeaderText="Amount"
                                                ReadOnly="True" SortExpression="nbr_amount" UniqueName="nbr_amount" DataFormatString="{0:c}">
                                            </radG:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </radG:RadGrid>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 16px; border-bottom: dimgray 1px groove;" colspan="3">
                                &nbsp;</td>
                        </tr>
                    </table>
                   
                </td>
            </tr>
            <tr style="font-size: 9pt">
                <td colspan="4" style="height: 7px; text-align: left">
                    <br />
                    &nbsp;<asp:Label ID="InjectScript" runat="server"></asp:Label>
                        <br />
                        <table style="width: 751px;">
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                <strong>Date Updated &nbsp;</strong><asp:Label ID="lblDateUpdated" runat="server"
                                    Width="93px" Text='<%# DataBinder.Eval(Container.DataItem, "dte_updated_date") %>'></asp:Label>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <strong>Updated By</strong>
                                <asp:Label ID="lblUpdatedBy" runat="server" Width="106px" Text='<%# DataBinder.Eval(Container.DataItem, "txt_updated_user") %>'></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; background-color: gainsboro; text-align: left">
                                <hr style="color: black" />
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
                                    DataValueField="key_level_id" Width="416px" SelectedValue='<%# DataBinder.Eval(Container.DataItem, "key_level_id") %>'>
                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                    SelectCommand="SELECT [key_level_id], [txt_level_desc] FROM [scs_level]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="background-color: gainsboro; text-align: left">
                                <strong style="background-color: gainsboro">System Office Notes</strong></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="height: 7px; text-align: left">
                                <asp:TextBox ID="txtSystemOfficeNotes" runat="server" Height="120px" TextMode="MultiLine"
                                    Width="743px" Text='<%# DataBinder.Eval(Container.DataItem, "txt_system_office_notes") %>'></asp:TextBox></td>
                        </tr>
                    </table>
                    </td>
            </tr>
            <tr style="font-size: 9pt">
                <td colspan="4" style="height: 7px; text-align: left">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    <asp:HiddenField ID="hfDelete" runat="server" />
                    <asp:HiddenField ID="hfTotalBudget" runat="server" />
                        <asp:HiddenField ID="hfItem" runat="server" />
                </td>
            </tr>
            <tr style="font-size: 9pt">
                <td colspan="4" style="height: 7px; text-align: left">
                    </td>
            </tr>
                                     </table>
        <asp:SqlDataSource ID="SqlDsMoveTo" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                    SelectCommand="pr_at_amendment_move_to" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:QueryStringParameter Name="p_key_activity_id" QueryStringField="keyid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        </ItemTemplate>
      </asp:FormView>
        <asp:Panel ID="Panel1" runat="server" Style="position: relative" Height="50px" Width="125px">
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="SqlDS_RLactivityGET" runat="server" SelectCommand="pr_act_activity_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="keyid" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="SqlDS_RLActivityLineGet" runat="server" SelectCommand="pr_act_activity_line_item_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="keyid" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="SqlDS_RLcoreindi_Get" runat="server" SelectCommand="pr_act_activity_core_indicator_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="id" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="SqlDataSource2" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>" runat="server" SelectCommand="pr_scs_category_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <br>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="SQLDS_RLMOVEFROM_CAT" runat="server" SelectCommand="pr_at_amendment_move_from_category_function" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="p_key_activity_id" QueryStringField="keyid" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ID="sqlds_rlmoveto_cat" runat="server" SelectCommand="pr_at_amendment_move_to_category_function" SelectCommandType="StoredProcedure">
                <SelectParameters>
                                        <asp:QueryStringParameter Name="p_key_activity_id" QueryStringField="keyid" Type="Int32"  />
                                    </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="SQLRL_AmendDelete" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                DeleteCommand="pr_act_activity_del" DeleteCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>">
                <DeleteParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:QueryStringParameter Name="key_activity_id" QueryStringField="keyid" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <asp:Label ID="InjectScript" runat="server" Style="position: relative"></asp:Label>
        &nbsp;
        <br />
    
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
            SelectCommand="pr_scs_function_code_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_radiostuff" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_fa_activity_type_get" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        <asp:HiddenField ID="hfOpenWindow" runat="server" />
        &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:SqlDataSource ID="SQLDsMoveFrom" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_at_amendment_move_from" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:QueryStringParameter Name="p_key_activity_id" QueryStringField="keyid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hfLevel" runat="server" />
        <asp:HiddenField ID="hfLocal_plan_id" runat="server" />
                            <br />
    </form>
</body>
</html>
