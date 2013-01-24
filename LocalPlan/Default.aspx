<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="LocalPlan_Default" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <radg:radgrid id="RadGrid1" runat="server" datasourceid="sqlDsActivities" gridlines="Horizontal"
            skin="Web20">
<MasterTableView DataSourceID="sqlDsActivities" AutoGenerateColumns="False" DataKeyNames="key_activity_id"><Columns>
<radG:GridBoundColumn ReadOnly="True" DataField="key_activity_id" DataType="System.Int32" UniqueName="key_activity_id" SortExpression="key_activity_id" HeaderText="key_activity_id"></radG:GridBoundColumn>
<radG:GridBoundColumn DataField="txt_activity_name" UniqueName="txt_activity_name" SortExpression="txt_activity_name" HeaderText="txt_activity_name"></radG:GridBoundColumn>
<radG:GridBoundColumn DataField="txt_activity_type_desc" UniqueName="txt_activity_type_desc" SortExpression="txt_activity_type_desc" HeaderText="txt_activity_type_desc"></radG:GridBoundColumn>
<radG:GridBoundColumn DataField="txt_category_title" UniqueName="txt_category_title" SortExpression="txt_category_title" HeaderText="txt_category_title"></radG:GridBoundColumn>
<radG:GridBoundColumn DataField="txt_function_code_desc" UniqueName="txt_function_code_desc" SortExpression="txt_function_code_desc" HeaderText="txt_function_code_desc"></radG:GridBoundColumn>
<radG:GridBoundColumn ReadOnly="True" DataField="nbr_activity_total" DataType="System.Decimal" UniqueName="nbr_activity_total" SortExpression="nbr_activity_total" HeaderText="nbr_activity_total"></radG:GridBoundColumn>
<radG:GridBoundColumn ReadOnly="True" DataField="nbr_activity_balance" DataType="System.Int32" UniqueName="nbr_activity_balance" SortExpression="nbr_activity_balance" HeaderText="nbr_activity_balance"></radG:GridBoundColumn>
<radG:GridCheckBoxColumn DataField="flg_locked" DataType="System.Boolean" UniqueName="flg_locked" SortExpression="flg_locked" HeaderText="flg_locked"></radG:GridCheckBoxColumn>
<radG:GridCheckBoxColumn DataField="flg_approved" DataType="System.Boolean" UniqueName="flg_approved" SortExpression="flg_approved" HeaderText="flg_approved"></radG:GridCheckBoxColumn>
<radG:GridCheckBoxColumn DataField="flg_is_amendment" DataType="System.Boolean" UniqueName="flg_is_amendment" SortExpression="flg_is_amendment" HeaderText="flg_is_amendment"></radG:GridCheckBoxColumn>
</Columns>

<ExpandCollapseColumn Visible="False">
<HeaderStyle Width="19px"></HeaderStyle>
</ExpandCollapseColumn>

<RowIndicatorColumn Visible="False">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>
</MasterTableView>
</radg:radgrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT     a.key_activity_id, a.txt_activity_name, scs_activity_type.txt_activity_type_desc, c.txt_category_title, f.txt_function_code_desc, SUM(l.amt_amount) &#13;&#10;                      AS nbr_activity_total, 0 AS nbr_activity_balance, a.flg_locked, a.flg_approved, a.flg_is_amendment&#13;&#10;FROM         act_activity AS a INNER JOIN&#13;&#10;                      scs_category AS c ON a.key_category_id = c.key_category_id INNER JOIN&#13;&#10;                      scs_function_code AS f ON a.key_function_code_id = f.key_function_code_id INNER JOIN&#13;&#10;                      act_activity_line_item AS l ON a.key_activity_id = l.key_activity_id INNER JOIN&#13;&#10;                      scs_activity_type ON a.key_activity_type_id = scs_activity_type.key_activity_type_id&#13;&#10;WHERE     (a.key_local_plan_id = 101) AND (a.flg_is_amendment = 0)&#13;&#10;GROUP BY a.key_activity_id, a.txt_activity_name, c.txt_category_title, f.txt_function_code_desc, a.flg_locked, a.flg_approved, &#13;&#10;                      scs_activity_type.txt_activity_type_desc, flg_is_amendment">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDsActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT     a.key_activity_id, a.txt_activity_name, scs_activity_type.txt_activity_type_desc, c.txt_category_title, f.txt_function_code_desc, SUM(l.amt_amount) &#13;&#10;                      AS nbr_activity_total, 0 AS nbr_activity_balance, a.flg_locked, a.flg_approved, a.flg_is_amendment&#13;&#10;FROM         act_activity AS a INNER JOIN&#13;&#10;                      scs_category AS c ON a.key_category_id = c.key_category_id INNER JOIN&#13;&#10;                      scs_function_code AS f ON a.key_function_code_id = f.key_function_code_id INNER JOIN&#13;&#10;                      act_activity_line_item AS l ON a.key_activity_id = l.key_activity_id INNER JOIN&#13;&#10;                      scs_activity_type ON a.key_activity_type_id = scs_activity_type.key_activity_type_id&#13;&#10;WHERE     (a.key_local_plan_id = 101) AND (a.flg_is_amendment = 0)&#13;&#10;GROUP BY a.key_activity_id, a.txt_activity_name, c.txt_category_title, f.txt_function_code_desc, a.flg_locked, a.flg_approved, &#13;&#10;                      scs_activity_type.txt_activity_type_desc, flg_is_amendment">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
