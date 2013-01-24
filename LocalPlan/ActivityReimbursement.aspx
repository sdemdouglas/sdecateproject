<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ActivityReimbursement.aspx.cs" Inherits="LocalPlan_ActivityReimbursement" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Activity Reimbursement</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
</head>
<body>
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
            var actid =  document.getElementById("<%= hdnactivityid.ClientID %>").value
            GetRadWindow().Close();
            GetRadWindow().BrowserWindow.refreshGrid('',actid);                    
        }
        
        function Err(errmsg)
        {
            confirm(errmsg);
        }
     </script>
    <form id="form1" runat="server">
    <div style="text-align: left">
        <div id="content_header" style="width: 326px; height: 139px; text-align: left">
        <table align="center" width="600" border="0" cellpadding="0" cellspacing="5">
            <tr>
                <td colspan="2" rowspan="1" style="background-color: lightsteelblue; text-align: center"
                    valign="top">
                    <asp:Label ID="lblErr" runat="server" ForeColor="Red"></asp:Label></td>
            </tr>
            <tr>
                <td rowspan="5" style="width: 500px; background-color: lightsteelblue;" valign="top">
                    <table width="100%">
                        <tr>
                            <td style="width: 88px; height: 15px" valign="top">
                    <asp:Label ID="Label4" runat="server" Text="Activity Name:" Width="85px" Font-Bold="True" Font-Italic="True"></asp:Label></td>
                            <td style="width: 419px; height: 15px;" valign="top">
                    <asp:Label ID="lblActivityName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 88px" valign="top">
                    <asp:Label ID="Label5" runat="server" Text="Description:" Font-Bold="True" Font-Italic="True"></asp:Label></td>
                            <td style="width: 419px" valign="top">
                    </td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="top">
                    <asp:Label ID="lblDescription" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 88px; height: 16px" valign="top">
                    <asp:Label ID="Label7" runat="server" Text="Balance:" Font-Bold="True" Font-Italic="True" Width="100px"></asp:Label></td>
                            <td style="width: 419px; height: 16px" valign="top">
                                &nbsp;<asp:Label ID="lblBalance" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 88px; height: 16px" valign="top">
                                <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Italic="True" Text="Original Amt:"
                                    Visible="False" Width="100px"></asp:Label></td>
                            <td style="width: 419px; height: 16px" valign="top">
                                <asp:Label ID="lblLITotal" runat="server" Visible="False"></asp:Label></td>
                        </tr>
                    </table>
                </td>
                <td rowspan="5" valign="top">
                    <table width="100%">
                        <tr>
                            <td style="width: 88px; height: 15px" valign="top">
                    <asp:Label ID="Label3" runat="server" Text="Quarter"></asp:Label></td>
                            <td style="width: 300px; height: 15px;" valign="top">
                    <asp:DropDownList ID="ddlQuarter" runat="server" DataSourceID="SqlDSQtr" DataTextField="nbr_quarter"
                        DataValueField="key_fiscal_year_quarter_id"
                        Width="112px" OnDataBound="ddlQuarter_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlQuarter_SelectedIndexChanged">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlQuarter"
                        ErrorMessage="* Required" InitialValue="-1"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 88px" valign="top">
                    <asp:Label ID="Label2" runat="server" Text="Line Item" Width="78px"></asp:Label></td>
                            <td style="width: 300px" valign="top">
                    <asp:DropDownList ID="ddlActivityLineItem" runat="server" DataSourceID="sqlDsActivityLineItem"
                        DataTextField="txt_line_item_desc" DataValueField="key_activity_line_item_id"
                        Width="180px" OnDataBound="ddlActivityLineItem_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddlActivityLineItem_SelectedIndexChanged">
                    </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlActivityLineItem"
                        ErrorMessage="* Required" InitialValue="-1"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 88px" valign="top">
                    <asp:Label ID="Label1" runat="server" Text="Amount $" Width="67px"></asp:Label></td>
                            <td style="width: 300px" valign="top">
                    <asp:TextBox ID="txtAmount" runat="server" Width="65px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAmount"
                        ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 88px" valign="top">
                            </td>
                            <td style="width: 300px" valign="top">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAmount"
                        ErrorMessage="**Invalid Entry, Must be currency with 2 or less Decimal Precision"
                        Style="left: -139px; top: -408px" ValidationExpression="^[0-9]+(,[0-9]{3})*(\.[0-9]{2})?$" Width="250px" Height="21px"></asp:RegularExpressionValidator></td>
                        </tr>
                        <tr>
                            <td style="height: 16px" valign="top" colspan="2">
                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click"
                        Text="Save" />&nbsp;
                                <asp:Button ID="btnClose" runat="server" Text="Close" OnClientClick="Close()" OnClick="btnClose_Click" />&nbsp;
                    <asp:Button ID="btnClear" runat="server" OnClick="btnClear_Click"
                        Text="Reset Values" CausesValidation="False" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
        </table>
            <strong><span style="font-size: 9pt">
                <hr style="width: 600px" />
                Reimbursements by Quarter</span><radG:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDsReimbursements"
                        Skin="Default" Width="600px" OnItemDataBound="RadGrid1_ItemDataBound1" GridLines="None">
<MasterTableView DataSourceID="SqlDsReimbursements" AutoGenerateColumns="False" ShowFooter="True">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
<FooterStyle Height="20px" HorizontalAlign="Right"></FooterStyle>

<Columns>
<radG:GridBoundColumn DataField="Line Item" HeaderText="Line Item" SortExpression="Line Item" UniqueName="Line Item"></radG:GridBoundColumn>
<radG:GridBoundColumn DataField="amt_amount" HeaderText="Original Amount" SortExpression="amt_amount" UniqueName="amt_amount" DataType="System.Decimal" Visible="False"></radG:GridBoundColumn>
<radG:GridBoundColumn DataField="Qtr 1" ReadOnly="True" HeaderText="Qtr 1" SortExpression="Qtr 1" UniqueName="Qtr 1" DataType="System.Decimal" DataFormatString="{0:N}">
    <HeaderStyle HorizontalAlign="Right" />
    <ItemStyle HorizontalAlign="Right" />
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="Qtr 2" ReadOnly="True" HeaderText="Qtr 2" SortExpression="Qtr 2" UniqueName="Qtr 2" DataType="System.Decimal" DataFormatString="{0:N}">
    <HeaderStyle HorizontalAlign="Right" />
    <ItemStyle HorizontalAlign="Right" />
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="Qtr 3" ReadOnly="True" HeaderText="Qtr 3" SortExpression="Qtr 3" UniqueName="Qtr 3" DataType="System.Decimal" DataFormatString="{0:N}">
    <HeaderStyle HorizontalAlign="Right" />
    <ItemStyle HorizontalAlign="Right" />
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="Qtr 4" ReadOnly="True" HeaderText="Qtr 4" SortExpression="Qtr 4" UniqueName="Qtr 4" DataType="System.Decimal" DataFormatString="{0:N}" FooterText="Total Qtr 4">
    <HeaderStyle HorizontalAlign="Right" />
    <ItemStyle HorizontalAlign="Right" />
</radG:GridBoundColumn>
    <radG:GridTemplateColumn HeaderText="Total" UniqueName="Total">
        <ItemTemplate>
            <asp:Label ID="lblTotal" runat="server" Text="Label" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt"></asp:Label>
        </ItemTemplate>
        <FooterStyle HorizontalAlign="Right" />
        <HeaderStyle HorizontalAlign="Right" />
        <ItemStyle HorizontalAlign="Right" />
        <FooterTemplate>
            <asp:Label ID="lblSum" runat="server" Text="Label" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt"></asp:Label>
        </FooterTemplate>
    </radG:GridTemplateColumn>
</Columns>
</MasterTableView>

<ClientSettings>
<Selecting AllowRowSelect="True"></Selecting>
</ClientSettings>
                    <ItemStyle Font-Bold="True" />
                    
</radG:RadGrid></strong><asp:SqlDataSource ID="SqlDsReimbursements" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_act_reimbursements_qtr_list_get" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="-1" Name="p_key_activity_id" QueryStringField="aid"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlDsActivityLineItem" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="SELECT     l.key_activity_line_item_id, t.txt_line_item_desc&#13;&#10;FROM         dbo.act_activity_line_item AS l INNER JOIN&#13;&#10;                      dbo.scs_line_item_type AS t ON l.key_line_item_type_id = t.key_line_item_type_id&#13;&#10;WHERE     (l.key_activity_id = @p_key_activity_id)&#13;&#10;">
                        <SelectParameters>
                            <asp:QueryStringParameter DefaultValue="-1" Name="p_key_activity_id" QueryStringField="aid" />
                        </SelectParameters>
                    </asp:SqlDataSource>
            <hr style="width: 600px" />
            <span style="font-size: 9pt"><strong>
                <br />
                Detailed Reimbursements</strong><br />
                <radG:RadGrid ID="RadGrid2" runat="server" DataSourceID="sqlDsDetailReimbursments" Skin="Default" Width="626px" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" GridLines="None" OnItemDeleted="RadGrid2_ItemDeleted">
                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_reimbursement_id"
                        DataSourceID="sqlDsDetailReimbursments">
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <Columns>
                            <radG:GridBoundColumn DataField="key_reimbursement_id" DataType="System.Int32" HeaderText="Id"
                                ReadOnly="True" SortExpression="key_reimbursement_id" UniqueName="key_reimbursement_id">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="txt_quarter" HeaderText="Quarter" ReadOnly="True"
                                SortExpression="txt_quarter" UniqueName="txt_quarter" Visible="False">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="txt_line_item_desc" HeaderText="Desc"
                                SortExpression="txt_line_item_desc" UniqueName="txt_line_item_desc">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="key_fiscal_year_quarter_id" DataType="System.Int32"
                                HeaderText="key_fiscal_year_quarter_id" SortExpression="key_fiscal_year_quarter_id"
                                UniqueName="key_fiscal_year_quarter_id" Visible="False">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="key_activity_line_item_id" DataType="System.Int32"
                                HeaderText="key_activity_line_item_id" SortExpression="key_activity_line_item_id"
                                UniqueName="key_activity_line_item_id" Visible="False">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="nbr_amount" DataType="System.Decimal" HeaderText="Amount"
                                SortExpression="nbr_amount" UniqueName="nbr_amount" DataFormatString="{0:N}">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="dte_date_created" DataFormatString="{0:d}" DataType="System.DateTime"
                                HeaderText="Date Created" SortExpression="dte_date_created" UniqueName="dte_date_created">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="txt_created_user" HeaderText="User"
                                SortExpression="txt_created_user" UniqueName="txt_created_user">
                            </radG:GridBoundColumn>
                            <radG:GridButtonColumn CommandName="Delete" ImageUrl="~/images/Delete.gif" Text="Delete"
                                UniqueName="column" AutoPostBackOnFilter="True" ButtonType="ImageButton" ConfirmText="Are you sure you want to delete this Reimbursement?">
                            </radG:GridButtonColumn>
                        </Columns>
                        
                                    <GroupByExpressions>
                        <radG:GridGroupByExpression>
                             <GroupByFields>
                                 <radG:GridGroupByField FieldAlias="txt_quarter" FieldName="txt_quarter" HeaderText = "Group" FormatString="" />
                           </GroupByFields>
                           <SelectFields>
                               <radG:GridGroupByField FieldAlias="txt_quarter" FieldName="txt_quarter" HeaderText = "Quarter " FormatString="" />
                           </SelectFields>
                        </radG:GridGroupByExpression>
                    </GroupByExpressions>


                    </MasterTableView>

                
                </radG:RadGrid><asp:SqlDataSource ID="sqlDsDetailReimbursments" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="pr_act_activity_reimbursement_get_list" SelectCommandType="StoredProcedure" DeleteCommand="pr_act_activity_reimbursement_del" DeleteCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="-1" Name="p_key_activity_id" QueryStringField="aid"
                            Type="Int32" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="key_reimbursement_id" Type="Int32" />
                    </DeleteParameters>
                </asp:SqlDataSource>
                <br />
                <asp:Label ID="lblInject" runat="server"></asp:Label><br />
                <asp:HiddenField ID="hfLpId" runat="server" /><asp:HiddenField ID="hdnactivityid" runat="server" />
            </span>
        </div>
        <br />
        <br />
        <br />
                    <asp:SqlDataSource ID="SqlDSQtr" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="SELECT key_fiscal_year_quarter_id, nbr_quarter FROM scs_fiscal_year_quarter ORDER BY nbr_quarter">
                    </asp:SqlDataSource>
        <br />
        &nbsp;<div id="search">
        </div>
        <div id="browse">
            <div id="body" style="text-align: left">
                <div id="content">
                    &nbsp;
                    <asp:SqlDataSource ID="SqlDS_fisYear" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_scs_fiscal_year_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    &nbsp;&nbsp;
                </div>
            </div>
        </div>
        &nbsp;
        <br />
    
    </div>
    </form>
</body>
</html>
