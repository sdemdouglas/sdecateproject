<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ValidationErrors.aspx.cs" Inherits="LocalPlan_ValidationErrors" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Local Plan Business Rule Errors</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:SqlDataSource ID="SQLDsValidationErrors" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_local_plan_level_errors_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="p_key_local_plan_id" QueryStringField="id"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <table style="width: 681px">
            <tr>
                <td colspan="3" style="text-align: left">
                    <strong>The Local Plan cannot be submitted due to the following business rule errors</strong></td>
            </tr>
            <tr>
                <td colspan="3">
                    <radg:radgrid id="RadGrid1" runat="server" datasourceid="SQLDsValidationErrors" gridlines="None"
                        skin="Default" width="692px">
<MasterTableView DataSourceID="SQLDsValidationErrors" AutoGenerateColumns="False">
<RowIndicatorColumn Visible="False">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="False">
<HeaderStyle Width="19px"></HeaderStyle>
</ExpandCollapseColumn>
<Columns>
<radG:GridBoundColumn DataField="txt_error_desc" HeaderText="Category" SortExpression="txt_error_desc" UniqueName="txt_error_desc">
<ItemStyle Width="1in"></ItemStyle>
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="key_error_id" HeaderText="Rule #" SortExpression="key_error_id" UniqueName="key_error_id">
<ItemStyle Width="0.8in"></ItemStyle>
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="txt_message" HeaderText="Description" SortExpression="txt_message" UniqueName="txt_message">
<ItemStyle Width="4in"></ItemStyle>
</radG:GridBoundColumn>
</Columns>
</MasterTableView>
</radg:radgrid>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
