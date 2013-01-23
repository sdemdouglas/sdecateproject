<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GeneralReport.aspx.cs" Inherits="Reports_GeneralReport" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <script type="text/javascript">
        function printReport(report, keyid, type)
        {
            if(report == 'rpt_local_plan_activity')
            {
                if(type== 'pdf')
                {
                    window.open("../../Reports/ViewReport.aspx?type=rpt_local_plan_activity&Keyid=" + keyid );
                }
                else
                {
                    window.open("../../Reports/ViewReport.aspx?type=rpt_local_plan_activity&Keyid=" + keyid + "&reportformat=rdl" );
                }
            }
        }
    
    </script>
    <form id="form1" runat="server">
    <div>
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="pr_rpt_local_plan_activity" runat="server">
                <table border="0" cellpadding="0" cellspacing="0" width="98%">
                    <tr>
                        <td colspan="3" style="height: 18px">
                            LOCAL PLAN ACTIVITIES REPORT</td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <asp:HyperLink ID="hlPrintRdl" runat="server" ImageUrl="~/images/48folderopen.jpg"> Print Report as RDL</asp:HyperLink>
                            &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                            <asp:HyperLink ID="hlPrintPdf"
                                    runat="server" ImageUrl="~/images/Reader-32.gif" >Print Report in PDF</asp:HyperLink>
                            &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            <asp:ImageButton
                                        ID="ImageButton1" runat="server" AlternateText="Export to Excel" ImageUrl="~/images/Excel_Icon_SMALL.gif" OnClick="ImageButton1_Click" /></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                <radG:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSource1" GridLines="None"
                    Skin="Default" OnItemDataBound="RadGrid1_ItemDataBound">
                    
                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_activity_id" DataSourceID="SqlDataSource1" ShowFooter="True">
                        <RowIndicatorColumn Visible="False">
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn Resizable="False" Visible="False">
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <Columns>
                            <radG:GridBoundColumn DataField="key_local_plan_id" DataType="System.Int32" HeaderText="key_local_plan_id"
                                SortExpression="key_local_plan_id" UniqueName="key_local_plan_id" Display="False">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" HeaderText="Activity Id"
                                ReadOnly="True" SortExpression="key_activity_id" UniqueName="key_activity_id">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="txt_activity_name" HeaderText="Activity Name"
                                SortExpression="txt_activity_name" UniqueName="txt_activity_name">
                            </radG:GridBoundColumn>
                            
                            <radG:GridBoundColumn DataField="key_category_id" HeaderText="Category"
                                SortExpression="key_category_id" UniqueName="key_category_id">
                            </radG:GridBoundColumn>
                            
                            <radG:GridBoundColumn DataField="key_function_code_id" HeaderText="Function Code"
                                SortExpression="key_function_code_id" UniqueName="key_function_code_id">
                            </radG:GridBoundColumn>
                            
                            
                            <radG:GridBoundColumn DataField="Salary" DataType="System.Decimal" HeaderText="Salary"
                                ReadOnly="True" SortExpression="Salary" UniqueName="Salary" DataFormatString="{0:F}">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="Fixed Charges" DataType="System.Decimal" HeaderText="Fixed Charges"
                                ReadOnly="True" SortExpression="Fixed Charges" UniqueName="Fixed Charges" DataFormatString="{0:F}">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="Purchased Services" DataType="System.Decimal" HeaderText="Purchased Services"
                                ReadOnly="True" SortExpression="Purchased Services" UniqueName="Purchased Services" DataFormatString="{0:F}">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="Instructional Supplies" DataType="System.Decimal"
                                HeaderText="Instructional Supplies" ReadOnly="True" SortExpression="Instructional Supplies"
                                UniqueName="Instructional Supplies" DataFormatString="{0:F}">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="Indirect Costs" DataType="System.Decimal" HeaderText="Indirect Costs"
                                ReadOnly="True" SortExpression="Indirect Costs" UniqueName="Indirect Costs" DataFormatString="{0:F}">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="Equipment" DataType="System.Decimal" HeaderText="Equipment"
                                ReadOnly="True" SortExpression="Equipment" UniqueName="Equipment" DataFormatString="{0:F}">
                            </radG:GridBoundColumn>
                            <radG:GridBoundColumn DataField="Total" DataType="System.Decimal" HeaderText="Total"
                                ReadOnly="True" SortExpression="Total" UniqueName="Total" DataFormatString="{0:C}">
                            </radG:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </radG:RadGrid><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="pr_rpt_local_plan_activity" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="-1" Name="p_key_local_plan_id" QueryStringField="keyid"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                &nbsp;</asp:View>
        </asp:MultiView></div>
    </form>
</body>
</html>
