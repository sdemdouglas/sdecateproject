<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="LocalPlan.aspx.cs" Inherits="LocalPlans_GeneralInfo" Title="College Local Plan" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
<script language="javascript">
function OpenReportLIst(planid, fiscalyear)
{
 
 var winobj = window.radopen("../Reports/ReportList_Form.aspx?planid=" + planid + "&fiscalyear=" + fiscalyear, "littlepop");
 winobj.Center();
}
function OpenErrors(planid)
    {    
        var winobj = window.radopen("ValidationErrors.aspx?id=" + planid, "MainPop");
      //  winobj.Center();
    }
</script>
    <div style="text-align: left;">
    <table width="100%">
        <tr>
            <td colspan="3" style="text-align: center;">
                <asp:Label ID="lblErr" runat="server" ForeColor="Red" Font-Bold="False"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Panel ID="Panel1" runat="server" Width="100%">
    <table style="width: 99%; font-size: 9pt; font-family: 'Trebuchet MS'; font-weight: bold;">
        <tr>
            <td style="text-align: right; height: 7px;" colspan="2">
                <span style="font-size: 9pt">
                    Local Plan Number</span></td>
            <td colspan="1" style="width: 22px; height: 7px; text-align: right">
            </td>
            <td style="height: 7px;" colspan="3">
                <asp:TextBox ID="txtLocalPlanId" runat="server" BorderColor="White" Style="background-color: transparent"
                    Width="57px" Font-Names="Trebuchet MS" Font-Size="9pt" ReadOnly="True">110</asp:TextBox>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; <span></span></td>
        </tr>
        <tr>
            <td style="text-align: right; height: 14px;" colspan="2">
                <span style="font-size: 9pt">College</span></td>
            <td colspan="1" style="width: 22px; text-align: right; height: 14px;">
            </td>
            <td colspan="3" style="height: 14px;">
                <asp:TextBox ID="txtCollegeName" runat="server" BorderColor="White" Style="background-color: transparent"
                    Width="362px" Font-Names="Trebuchet MS" Font-Size="9pt" ReadOnly="True">Low Country Technical College</asp:TextBox><span style="font-size: 10pt"></span></td>
        </tr>
        <tr>
            <td style="height: 3px; text-align: right" colspan="2">
                <span style="font-family: Trebuchet MS"><span style="font-size: 9pt">
                    <span>Fiscal Year</span></span></span></td>
            <td colspan="1" style="width: 22px; height: 3px; text-align: right">
            </td>
            <td style="height: 3px" colspan="3">
                <asp:TextBox ID="txtFiscalYear" runat="server" BorderColor="White" Style="background-color: transparent"
                    Width="210px" Font-Names="Trebuchet MS" Font-Size="9pt" ReadOnly="True">2008</asp:TextBox></td>
        </tr>
        <tr>
            <td style="text-align: right" colspan="2">
                <span style="font-family: Trebuchet MS; font-size: 9pt;">
                Fiscal Year Appropriation</span></td>
            <td colspan="1" style="font-size: 9pt; width: 22px;">
            </td>
            <td style="height: 10px" colspan="3">
                <asp:TextBox ID="txtFiscalYearAppropiation" runat="server" BorderColor="White" Style="background-color: transparent"
                   Font-Names="Trebuchet MS" Font-Size="9pt" Width="210px"  ReadOnly="True">171,000</asp:TextBox></td>
        </tr>
        <tr>
            <td style="height: 9px; text-align: right" colspan="2">
                <span style="font-size: 9pt; font-family: Trebuchet MS">
                Total Funded Activities</span></td>
            <td colspan="1" style="width: 22px; height: 9px; text-align: right">
            </td>
            <td style="height: 9px" colspan="3">
                <asp:TextBox ID="txtTotalActivities" runat="server" BorderColor="White" Style="background-color: transparent"
                 Font-Names="Trebuchet MS" Font-Size="9pt"   Width="210px"  ReadOnly="True">150,500</asp:TextBox></td>
        </tr>
        <tr>
            <td style="height: 9px; text-align: right" colspan="2">
                <span style="font-size: 9pt; font-family: Trebuchet MS">
                Balance</span></td>
            <td colspan="1" style="width: 22px; height: 9px; text-align: right">
            </td>
            <td style="height: 9px" colspan="3">
                <asp:TextBox ID="txtBalance" runat="server" BorderColor="White" Style="background-color: transparent"
                  Font-Names="Trebuchet MS" Font-Size="9pt"  Width="210px" ReadOnly="True"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="height: 11px; text-align: right" colspan="2">
                <span style="font-size: 9pt; font-family: Trebuchet MS">
                Total Expenditures</span></td>
            <td colspan="1" style="width: 22px; height: 11px; text-align: right">
            </td>
            <td style="height: 11px" colspan="3">
                <asp:TextBox ID="txtExpenditures" runat="server" BorderColor="White" Style="background-color: transparent"
                   Font-Names="Trebuchet MS" Font-Size="9pt" Width="210px"  ReadOnly="True">0</asp:TextBox></td>
        </tr>
        <tr>
            <td style="height: 2px; text-align: right" colspan="2">
                <span style="font-size: 9pt; font-family: Trebuchet MS">
                Assurances Accepted</span></td>
            <td colspan="1" style="width: 22px; height: 2px; text-align: right">
            </td>
            <td style="height: 2px" colspan="3">
                <asp:CheckBox ID="cbAccepted" runat="server" /></td>
        </tr>
        <tr>
            <td style="height: 16px; text-align: right" colspan="2" valign="top">
                <span style="font-family: Trebuchet MS"><span><span style="font-size: 9pt">
                <span>Level</span></span></td>
            <td colspan="1" style="width: 22px; height: 16px; text-align: right" valign="top">
            </td>
            <td style="height: 16px" colspan="3">
                &nbsp;<asp:Label ID="lblLevel" runat="server"></asp:Label>
                <asp:DropDownList ID="ddlLevel" runat="server" DataSourceID="SQLDsLocalPlanLevel"
                    DataTextField="txt_local_plan_level_status_desc" DataValueField="key_local_plan_level_id"
                    Width="288px" Visible="False">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2" style="height: 12px; text-align: right">
                <span style="font-size: 9pt; font-family: Trebuchet MS">
                Next Action</span></td>
            <td colspan="1" style="width: 22px; height: 12px; text-align: right">
            </td>
            <td style="height: 12px" colspan="3">
                <asp:DropDownList ID="ddlLpNExtLevel" runat="server" DataSourceID="sqlDsLPNextlevel"
                    DataTextField="txt_level_desc" DataValueField="nbr_next_level_nbr" Width="289px" OnDataBound="ddlLpNExtLevel_DataBound">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlLpNExtLevel"
                    ErrorMessage="* Required" InitialValue="0" Font-Bold="False" ></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="sqlDsLPNextlevel" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="pr_scs_local_plan_next_level_get" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlLevel" Name="p_nbr_current_lp_next_level_nbr"
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="height: 24px; text-align: right" valign = "top">
                <span style="font-size: 9pt; font-family: Trebuchet MS">
                System Office Notes<br />
                    &nbsp;
                    <asp:Button ID="btnSaveNote" runat="server" Text="Save Notes" ValidationGroup="Note"
                        Visible="False" Width="100px" Enabled="False" OnClick="btnSaveNote_Click" /></span></td>
            <td colspan="1" style="width: 22px; height: 24px; text-align: right" valign="top">
            </td>
            <td colspan="3" style="height: 24px">
                <asp:TextBox ID="txtSystemOfficeNotes" runat="server" Height="109px" Width="84%" TextMode="MultiLine" CssClass="txtBox"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 69px; height: 38px; text-align: right">
            </td>
            <td style="width: 111px; height: 38px; text-align: right">
                <span style="color: #ff0000"></span>
            </td>
            <td style="width: 22px; height: 38px; text-align: right">
            </td>
            <td colspan="3" style="height: 38px">
                <asp:LinkButton ID="lnkSubmit" runat="server" Font-Bold="False"  OnClick="lnkSubmit_Click">[Submit Local Plan]</asp:LinkButton>
                |
                <asp:HyperLink ID="HL_RPLIST" runat="server" Style="left: 39px; top: -406px;" Font-Bold="False"  ForeColor="Blue">[Print Local Plan]</asp:HyperLink>&nbsp; |
                <asp:HyperLink ID="HL_Errors" runat="server" ForeColor="Red" Style="left: 80px; top: 25px;" Visible="False" Font-Bold="False" Width="291px">[Update Failed, Click Here to view errors]</asp:HyperLink></td>
        </tr>
        <tr>
            <td style="width: 69px; height: 24px; text-align: right">
            </td>
            <td style="width: 111px; height: 24px; text-align: right">
            </td>
            <td style="width: 22px; height: 24px; text-align: right">
            </td>
            <td colspan="3" style="height: 24px">
            </td>
        </tr>
    </table>
                </asp:Panel>
                <asp:Button ID="btnSubmitPlan" runat="server"
                    Text="Submit" OnClick="btnSubmitPlan_Click" Visible="False" /></td>
        </tr>
    </table>
    <radW:RadWindowManager ID="RadWindowManager1" Skin="Vista" runat="server" Style="position: relative" Modal="True">
               
                 <windows>
                                <radw:RadWindow ID="MainPop"  runat="server" Title="Error Report" Height="600px"
                          Width="800px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="10px" Left="" />
                                <radw:RadWindow ID="littlepop"  runat="server" Title="Error Report" Height="325px"
                          Width="300px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="10px" Left="" />
             
               </windows>
               
     
    </radW:RadWindowManager>
                </div>
    &nbsp;<br />
    &nbsp;<br />
    <asp:HiddenField ID="hfLpid" runat="server" />
    <asp:SqlDataSource ID="SQLDsLocalPlanLevel" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="SELECT [key_local_plan_level_id], [txt_local_plan_level_status_desc] FROM [scs_local_plan_level]">
                </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SQLRL_EMAILRECEP" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>" SelectCommand="pr_local_plan_level_email_recipient" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="hfLpid" Name="p_key_local_plan_id" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SQLRL_EMAILBODYSUB" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>" SelectCommand="pr_local_plan_level_email" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="hfLpid" Name="p_key_local_plan_id" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLRL_SAVENOTES" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>" UpdateCommand="pr_lp_local_plan_system_office_notes_upd" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="hfLpid" Name="p_key_local_plan_id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="txtSystemOfficeNotes" Name="p_txt_system_office_notes"
                PropertyName="Text" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>


