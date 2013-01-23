<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ValidationErrors.aspx.cs" Inherits="LocalPlan_ValidationErrors" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Accountability Business Rule Errors</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:SqlDataSource ID="SQLDsValidationErrors" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_acc_accountability_validation_errors_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hf_accID" Name="p_key_accountability_id" PropertyName="Value"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <table style="width: 681px">
            <tr>
                <td colspan="3" style="text-align: left">
                    <strong>The Accountability Report cannot be submitted due to the following business rule errors</strong></td>
            </tr>
            <tr>
                <td colspan="3">
                    <radg:radgrid id="rdg_errors" runat="server" datasourceid="SQLDsValidationErrors" gridlines="None"
                        skin="Default" width="692px">
<MasterTableView DataSourceID="SQLDsValidationErrors" AutoGenerateColumns="False" DataKeyNames="key_error_dict_id">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
<Columns>
    <radG:GridBoundColumn DataField="key_error_dict_id" DataType="System.Int32" HeaderText="key_error_dict_id"
        ReadOnly="True" SortExpression="key_error_dict_id" UniqueName="key_error_dict_id" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="key_error_id" HeaderText="Error Code" SortExpression="key_error_id"
        UniqueName="key_error_id">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_message" HeaderText="Error Message" SortExpression="txt_message"
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
        <asp:HiddenField ID="hf_accID" runat="server" />
    </form>
</body>
</html>
