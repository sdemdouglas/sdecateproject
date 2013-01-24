<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Assurances.aspx.cs" Inherits="LocalPlans_Assurances" Title="Assurances" %>

<%@ Register Assembly="RadComboBox.Net2" Namespace="Telerik.WebControls" TagPrefix="radC" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
        function Print(format)
        {
          var PID =  document.getElementById('<%= hfLpid.ClientID %>').value; 
           var fiscalyear =  document.getElementById('ctl00$DropDownList2');
       //  alert(fiscalyear.value);
            window.open("../Reports/ViewReport.aspx?type=FiscalAssurances&planid=" + PID + "&format=" + format + "&FiscalYear=" +fiscalyear.value );
        }
    </script>
    <table width="100%">
        <tr>
            <td style="text-align: center">
                <asp:Label ID="lblErr" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Panel ID="Panel1" runat="server" Width="100%">
                <table width="100%">
                    <tr>
            <td align="center" colspan="3" style="text-align: left; width: 632px;">
                <asp:CheckBox ID="cbAccepted" runat="server"
                    Text="I agree to all the assurances" />&nbsp;
                                <asp:Button ID="btnSubmit" runat="server" Text="Save" OnClick="btnSubmit_Click" Width="100px" />&nbsp;
                            <asp:Button ID="btnPrint" runat="server" Text="Print PDF" Width="100px" OnClientClick="javascript:Print('pdf')" />
                <asp:Button ID="btn_Print_Word" runat="server" Text="Print Word" Width="100px" OnClientClick="javascript:Print('AWDOCX')" /></td>
        </tr>
        <tr>
            <td align="center" colspan="3" style="text-align: left; width: 632px;">
                <radg:radgrid id="RadGrid1"  runat="server" 
                            AllowAutomaticUpdates="True" AutoGenerateColumns="False" EnableAJAX="True" GridLines="Horizontal" Skin="Default" Style="font-size: 9pt;" Width="100%" datasourceid="sqlAssurancesDs">
                            
<MasterTableView DataSourceID="sqlAssurancesDs" GridLines="Horizontal"   Style="border-bottom: #319aea 1px solid" HorizontalAlign="NotSet" >
                
                             <PagerStyle Height="20px" CssClass="GridPager" Mode="NumericPages"></PagerStyle> 

                           
<Columns>
<radG:GridBoundColumn ReadOnly="True" DataField="nbr_row_number" DataType="System.Int64" UniqueName="nbr_row_number" SortExpression="nbr_row_number" HeaderText="#">
<ItemStyle Width="0.4in" ></ItemStyle>
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="txt_assurance_desc" UniqueName="txt_assurance_desc" SortExpression="txt_assurance_desc" HeaderText="Description">
<ItemStyle Width="95%" ></ItemStyle>
</radG:GridBoundColumn>
</Columns>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

    
</MasterTableView>
                   <HeaderStyle Font-Overline="False" Font-Strikeout="False" />
               
                    <GroupHeaderItemStyle Font-Bold="True" BackColor="Silver" BorderColor="Black" />
                   
            
</radg:radgrid></td>
        </tr>
        
                    <tr>
                        <td colspan="3" align="center" style="width: 632px">
    <asp:SqlDataSource ID="sqlAssurancesDs" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_lp_assurance_get" SelectCommandType="StoredProcedure" OnInit="sqlAssurancesDs_Init">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfFiscalYear" Name="p_nbr_fiscal_year"
                PropertyName="Value" Type="Int32" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
                </td>
        </tr>
        <tr>
            <td colspan="3" style="width: 632px" >
                &nbsp; &nbsp;&nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="3" style="width: 632px" >
                </td>
        </tr>
        <tr>
            <td align="left" colspan="3" style="height: 44px; width: 632px;">
                <asp:HiddenField ID="hfLpid" runat="server" />
                <asp:HiddenField ID="hfFiscalYear" runat="server" />
                </td>
        </tr>
    </table>
                </asp:Panel>
                <br />
            </td>
        </tr>
    </table>
    <br />
    <br />
    &nbsp;<br />
    <br />
</asp:Content>


