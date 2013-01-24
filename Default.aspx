<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Title="Fiscal Year Schedule" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <table style="width:100%" align="left">
        <tr>
            <td colspan="1">               
                 <strong>Section Descriptions for Perkins Data System </strong></td>
        </tr>
        <tr>
            <td colspan="1">
            </td>
        </tr>
        <tr>
            <td colspan="1">
          <radG:RadGrid ID="RadGrid1" runat="server" DataSourceID="sqlDsSchedule" GridLines="None"
              Skin="Default" Width="99%" style="margin-left: 0px" CellPadding="5" CellSpacing="6">
              <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlDsSchedule">
                  <RowIndicatorColumn Visible="False">
                      <HeaderStyle Width="20px" />
                  </RowIndicatorColumn>
                  <ExpandCollapseColumn Visible="False">
                      <HeaderStyle Width="19px" />
                  </ExpandCollapseColumn>
                  <Columns>
                      <radG:GridBoundColumn DataField="txt_section_name" HeaderText="Section" SortExpression="txt_section_name"
                          UniqueName="txt_section_name" Visible="False">
                      </radG:GridBoundColumn>
                      <radG:GridTemplateColumn UniqueName="TemplateColumn">
                          <ItemTemplate>
                              <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="9pt"
                                  Text='<%# Eval("txt_section_name") %>' Width="203px"></asp:Label>
                              <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Trebuchet MS" Font-Size="9pt"
                                  Text='<%# Eval("txt_periodmonth") %>' Width="211px"></asp:Label>
                              <asp:Label ID="Label2" runat="server" Text='<%# Eval("txt_section_description") %>'
                                  Width="731px"></asp:Label><br />
                          </ItemTemplate>
                      </radG:GridTemplateColumn>
                  </Columns>
              </MasterTableView>
          </radG:RadGrid></td>
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
    <br />
    <br />
    <br />
  
    <asp:SqlDataSource ID="sqlDsSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_fiscal_year_schedule_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="102" Name="p_key_fiscal_year_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HFFiscalyear" runat="server" />

</asp:Content>


