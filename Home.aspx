<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="_Default" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <table style="width: 738px">
        <tr>
            <td colspan="3" style="height: 3px">
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:SqlDataSource ID="sqlDsSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="SELECT     se.key_section_id, se.txt_section_name, fs.dte_date_from, fs.dte_date_to, se.txt_section_description&#13;&#10;FROM         dbo.scs_section AS se INNER JOIN&#13;&#10;                      dbo.scs_fiscal_year_schedule AS fs ON se.key_section_id = fs.key_section_id">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="SELECT [key_college_id], [txt_college_name] FROM [scs_college]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 146px">
            </td>
            <td style="width: 193px">
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>

