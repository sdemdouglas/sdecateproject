<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transfer_ValidationErrors.aspx.cs" Inherits="LocalPlan_Transfer_ValidationErrors" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Local Plan Business Rule Errors</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;<table style="width: 681px">
            <tr>
                <td colspan="3" style="text-align: left">
                    <strong>Errors from try to transfer funds</strong></td>
            </tr>
            <tr>
                <td colspan="3">
                    <radg:radgrid id="RadGrid1" runat="server" datasourceid="SQLDS_erros" gridlines="None"
                        skin="Default" width="692px">
<MasterTableView DataSourceID="SQLDS_erros" AutoGenerateColumns="False">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
<Columns>
    <radG:GridBoundColumn DataField="txt_error_desc" HeaderText="txt_error_desc" SortExpression="txt_error_desc"
        UniqueName="txt_error_desc">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="key_error_id" HeaderText="key_error_id" SortExpression="key_error_id"
        UniqueName="key_error_id">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_message" HeaderText="txt_message" SortExpression="txt_message"
        UniqueName="txt_message">
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
        <asp:SqlDataSource ID="SQLDS_erros" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString1 %>"
            SelectCommand="pr_at_amendment_transfer_validation_errors_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="p_key_err_msg_amndmnt_hdr_id" QueryStringField="id"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
