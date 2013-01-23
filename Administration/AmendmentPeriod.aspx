<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="AmendmentPeriod.aspx.cs" Inherits="Administration_AmendmentPeriod" Title="Amendment Period" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.3, Version=6.3.20063.53, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebListbar.v6.3, Version=6.3.20063.53, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebListbar" TagPrefix="iglbar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <table>
        <tr>
            <td colspan="3">
                Fiscal Year &nbsp;<asp:DropDownList ID="ddlFiscalYear" runat="server" Width="89px" AutoPostBack="True" Font-Names="Trebuchet MS" DataSourceID="dsFiscalYear" DataTextField="nbr_fiscal_year" DataValueField="nbr_fiscal_year">
                    <asp:ListItem>2007</asp:ListItem>
                    <asp:ListItem>2008</asp:ListItem>
                    <asp:ListItem>2009</asp:ListItem>
                </asp:DropDownList>&nbsp;
                <asp:SqlDataSource ID="dsFiscalYear" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="pr_scs_fiscal_year_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <radG:RadGrid ID="radGdLockAmd" runat="server" DataSourceID="sqlDsLockAmd" GridLines="None"
                    Width="622px" AllowAutomaticUpdates="True" Skin="Default" OnItemCreated="radGdLockAmd_ItemCreated" OnItemDataBound="radGdLockAmd_ItemDataBound">
<MasterTableView DataKeyNames="key_local_plan_id" DataSourceID="sqlDsLockAmd" AutoGenerateColumns="False" GridLines="None">
<RowIndicatorColumn Visible="False">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="False" Resizable="False">
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
<Columns>
    <radG:GridTemplateColumn UniqueName="TemplateColumn" EditFormHeaderTextFormat="{0}">
        <EditItemTemplate>
            &nbsp;
        </EditItemTemplate>
        <ItemTemplate>
        <!--
            <asp:Button runat="server" CausesValidation="false" CommandName="Edit" Text="Edit"  />
          -->
            <asp:ImageButton ID="imbEdit" ImageUrl="~/images/Edit.gif" runat="server" CausesValidation="false" CommandName="Edit" />
        </ItemTemplate>
    </radG:GridTemplateColumn>
<radG:GridBoundColumn DataField="key_local_plan_id" ReadOnly="True" HeaderText="Id" SortExpression="key_local_plan_id" UniqueName="key_local_plan_id" DataType="System.Int32"></radG:GridBoundColumn>
<radG:GridBoundColumn DataField="txt_college_name" HeaderText="College" SortExpression="txt_college_name" UniqueName="txt_college_name" ReadOnly="True">
<ItemStyle Width="2.5in"></ItemStyle>
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="nbr_fiscal_year" HeaderText="Fiscal Year" SortExpression="nbr_fiscal_year" UniqueName="nbr_fiscal_year" DataType="System.Int32" ReadOnly="True"></radG:GridBoundColumn>
<radG:GridCheckBoxColumn DataField="flg_lock_amendment_period" HeaderText="Locked" SortExpression="flg_lock_amendment_period" UniqueName="flg_lock_amendment_period" DataType="System.Boolean"></radG:GridCheckBoxColumn>
    <radG:GridTemplateColumn UniqueName="TemplateColumn" Display="False">
        <ItemTemplate>
            <asp:TextBox ID="txtLevelId" runat="server" Text='<%# Eval("key_local_plan_level_id") %>'></asp:TextBox>
        </ItemTemplate>
    </radG:GridTemplateColumn>
</Columns>
                                            <EditFormSettings>
                                                <FormTableItemStyle Wrap="False" />
                                                <FormCaptionStyle CssClass="EditFormHeader" />
                                                <FormMainTableStyle BackColor="White" CellPadding="3" CellSpacing="0" GridLines="Horizontal"
                                                    Width="100%" />
                                                <FormTableStyle BackColor="White" CellPadding="2" CellSpacing="0" CssClass="module"
                                                    Height="110px" />
                                                <FormTableAlternatingItemStyle Wrap="False" />
                                                <EditColumn ButtonType="ImageButton" CancelImageUrl="~\images\Cancel.gif" CancelText="Cancel Edit"
                                                    EditImageUrl="~\images\Edit.gif" InsertImageUrl="~\images\Insert.gif" InsertText="Insert Order"
                                                    UniqueName="EditCommandColumn1" UpdateImageUrl="~\images\Update.gif" UpdateText="Update record">
                                                </EditColumn>
                                                <FormTableButtonRowStyle CssClass="EditFormButtonRow" HorizontalAlign="Left" />
                                            </EditFormSettings>
                    </MasterTableView>
             
</radG:RadGrid><asp:SqlDataSource ID="sqlDsLockAmd" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="SELECT     TOP (100) PERCENT dbo.lp_local_plan.key_local_plan_id, dbo.scs_college.txt_college_name, dbo.lp_local_plan.nbr_fiscal_year, &#13;&#10;                      ISNULL(dbo.lp_local_plan.flg_lock_amendment_period, 1) AS flg_lock_amendment_period, lp_local_plan.key_local_plan_level_id&#13;&#10;FROM         dbo.lp_local_plan INNER JOIN&#13;&#10;                      dbo.scs_college ON dbo.lp_local_plan.key_college_id = dbo.scs_college.key_college_id&#13;&#10;WHERE     (dbo.lp_local_plan.nbr_fiscal_year = @nbr_fiscal_year)&#13;&#10;ORDER BY dbo.scs_college.txt_college_name" UpdateCommand="pr_lp_local_plan_flg_Locked_Amendment_upd" UpdateCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlFiscalYear" DefaultValue="-1" Name="nbr_fiscal_year"
            PropertyName="SelectedValue" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="key_local_plan_id" Type="Int32" />
        <asp:Parameter Name="flg_lock_amendment_period" Type="Boolean" />
    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>


