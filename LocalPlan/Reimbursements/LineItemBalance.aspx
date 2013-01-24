<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="LineItemBalance.aspx.cs" Inherits="LocalPlan_Reimbursements_LineItemBalance"  %>
<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>

        
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
        function OpenReportRDL()
        {
            var planid = document.getElementById("<%= hfLocal_plan_id.ClientID %>").value;
            var wide = window.screen.availWidth-30;
                var high = window.screen.availHeight-30;

                window.open("../../../Reports/ViewReport.aspx?type=fundingplan&Keyid=" + planid + "&reportformat=rdl",null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
     
        }
    </script>
    
<table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="text-align: center">
                <asp:Label ID="lblErr" runat="server" ForeColor="Red" Font-Size="9pt"></asp:Label>
            </td>
           
        </tr>
        <tr>
            <td align="left" >
                <asp:Panel ID="Panel1" runat="server" Width="100%">
                     <table width="100%" cellpadding="0" cellspacing="0">        
                         <tr>
                             <td style="height: 24px">
                                 <span style="font-size: 9pt"><span style="font-size: 9pt">Select Category</span> </span>
    <asp:DropDownList ID="ddlLineItemCategory" runat="server" Width="431px" AutoPostBack="True" OnSelectedIndexChanged="ddlLineItemCategory_SelectedIndexChanged" OnDataBound="ddlLineItemCategory_DataBound" Font-Names="Trebuchet MS" Font-Size="9pt" SkinID="ddList">
        <asp:ListItem Value="pr_rb_reimbursements_by_category_function_get">Display Reimbursements By Category</asp:ListItem>
        <asp:ListItem Value="pr_rb_line_item_reimbursements_by_activity_get">Display Reimbursements by Activity</asp:ListItem>
        <asp:ListItem Value="pr_rb_balance_by_category_function_get">Line Item Balance by Category and Function</asp:ListItem>
        <asp:ListItem Value="pr_rb_line_item_balance_by_activity_get">Line Item Balance by Activity</asp:ListItem>
    </asp:DropDownList>&nbsp;&nbsp;
                                <asp:Button ID="btnExportToExcel" runat="server" CausesValidation="False" OnClick="btnExportToExcel_Click"
                                    Text="Export to Excel" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt" />
                                <asp:Button ID="btnPrint" runat="server" OnClientClick="OpenReportRDL()" Text="Print"
                                    Width="100px" Visible="False" /></td>
                            <td style="height: 24px" align="right">
                                &nbsp;</td>
                         </tr>
                        <tr>
                            <td colspan="2">
    <a href="../../LocalPlan/Reimbursements/LineItemBalance.aspx"></a>
                                <asp:SqlDataSource ID="dsRei" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                    SelectCommand="pr_rb_reimbursements_by_category_function_get" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="hfLocal_plan_id" DefaultValue="-1" Name="p_key_local_plan_id"
                                            PropertyName="Value" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
    <rad:radgrid id="gvFundingPlan" runat="server" enableajax="True"
        gridlines="None" skin="Default" width="93%" OnItemDataBound="gvFundingPlan_ItemDataBound">
                                        
                                        <MasterTableView AutoGenerateColumns="False" ShowFooter="True">
                                            <RowIndicatorColumn Visible="False">
                                                <HeaderStyle Width="20px"   />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn Visible="False">
                                                <HeaderStyle Width="19px"   />
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <rad:GridBoundColumn DataField="txt_category_code" HeaderText="Category" SortExpression="txt_category_code"
                                                    UniqueName="txt_category_code">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_function_code" HeaderText="Function" SortExpression="txt_function_code"
                                                    UniqueName="txt_function_code">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_category_title" HeaderText="Title" SortExpression="txt_category_title"
                                                    UniqueName="txt_category_title">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_activity_name" HeaderText="Activity" SortExpression="txt_activity_name"
                                                    UniqueName="txt_activity_name">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Salary" DataType="System.Decimal" HeaderText="(100) Salary"
                                                    ReadOnly="True" SortExpression="Salary" UniqueName="Salary" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right"   />
                                                    <HeaderStyle HorizontalAlign="Right"   />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in"   />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Fixed Charges" DataType="System.Decimal" HeaderText="(200) Fixed Charges"
                                                    ReadOnly="True" SortExpression="Fixed Charges" UniqueName="Fixed Charges" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right"   />
                                                    <HeaderStyle HorizontalAlign="Right"   />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in"   />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Purchased Services" DataType="System.Decimal" HeaderText="(300) Purchased Services"
                                                    ReadOnly="True" SortExpression="Purchased Services" UniqueName="Purchased Services" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right"   />
                                                    <HeaderStyle HorizontalAlign="Right"   />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in"   />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Instructional Supplies" DataType="System.Decimal"
                                                    HeaderText="(400) Instructional Supplies" ReadOnly="True" SortExpression="Instructional Supplies"
                                                    UniqueName="Instructional Supplies" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right"   />
                                                    <HeaderStyle HorizontalAlign="Right"   />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in"   />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Equipment" DataType="System.Decimal" HeaderText="(500) Equipment"
                                                    ReadOnly="True" SortExpression="Equipment" UniqueName="Equipment" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right"   />
                                                    <HeaderStyle HorizontalAlign="Right"   />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in"   />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Indirect Costs" DataType="System.Decimal" HeaderText="(700) Indirect Costs"
                                                    ReadOnly="True" SortExpression="Indirect Costs" UniqueName="Indirect Costs" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right"   />
                                                    <HeaderStyle HorizontalAlign="Right"   />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in"   />
                                                </rad:GridBoundColumn>
                                                <rad:GridTemplateColumn HeaderText="Total" UniqueName="TemplateColumn">
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblFooterSum" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSum" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterStyle HorizontalAlign="Right"   />
                                                    <HeaderStyle HorizontalAlign="Right"   />
                                                    <ItemStyle HorizontalAlign="Right" Width="1.1in"   />
                                                </rad:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </rad:radgrid></td>
                        <tr>
                     </tr>
                     </table>
                    <asp:HiddenField ID="hfLocal_plan_id" runat="server" />
                </asp:Panel>
            </td>
            
        </tr>
</table>                                    
</asp:Content>


