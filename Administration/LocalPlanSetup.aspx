<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="LocalPlanSetup.aspx.cs" Inherits="Administration_CollegeAppropiation" %>

<%@ Register Assembly="RadAjax.Net2" Namespace="Telerik.WebControls" TagPrefix="radA" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
<script language="javascript" type="text/javascript">
// <!CDATA[

function TABLE1_onclick() {

}

// ]]>
</script>

    <div class="container" style="width: 542px">
        <div id="contactForm">
            <div style="margin-top: 1em">
                <table style="width: 536px; margin-left: 0.3in;">
                    <tr>
                        <td style="width: 136px;">
                            College&nbsp;</td>
                        <td colspan="5">
                            <asp:DropDownList ID="ddCollege" runat="server" DataSourceID="sqlCollegeDs" DataTextField="txt_college_name"
                                DataValueField="key_college_id" Width="268px" OnDataBound="ddCollege_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddCollege_SelectedIndexChanged">
                            </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="ddCollege" ErrorMessage="* Required" InitialValue="-1" ValidationGroup="Go"></asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td style="width: 136px;">
                            <asp:Label ID="Label1" runat="server" Text="Fiscal Year"></asp:Label></td>
                        <td colspan="5">
                            <asp:DropDownList ID="ddFiscalYear" runat="server" OnDataBound="ddFiscalYear_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddFiscalYear_SelectedIndexChanged" DataSourceID="SqlDataSource1" DataTextField="nbr_fiscal_year" DataValueField="nbr_fiscal_year">
                                <asp:ListItem>2008</asp:ListItem>
                                <asp:ListItem>2007</asp:ListItem>
                            </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddFiscalYear"
                                ErrorMessage="*" InitialValue="-1" ValidationGroup="Go"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 136px;">
                            Local Plan #</td>
                        <td colspan="5">
                            <asp:Label ID="lblLocalPlan" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 136px">
                            Appropriation</td>
                        <td colspan="5">
                            <asp:TextBox ID="txtAppropiation" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAppropiation"
                                ErrorMessage="* Required" ValidationGroup="Go" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtAppropiation"
                                Display="Dynamic" ErrorMessage="* Invalid Appropriation Amount" MaximumValue="10000000"
                                MinimumValue="0.01" Type="Currency"></asp:RangeValidator></td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 136px;">
                            Total All Activities</td>
                        <td colspan="5">
                            &nbsp;<asp:Label ID="lblTotalAllAct" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 136px">
                            Balance</td>
                        <td colspan="5">
                            &nbsp;<asp:Label ID="lblBalance" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 136px; height: 21px;">
                            Locked</td>
                        <td colspan="5" style="height: 21px">
                            <asp:CheckBox ID="cbLocked" runat="server" /></td>
                    </tr>
                    <tr>
                        <td style="width: 136px">
                            Status</td>
                        <td colspan="5">
                            &nbsp;<asp:Label ID="lblStatus" runat="server" Width="331px"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 136px">
                            Level</td>
                        <td colspan="5">
                            &nbsp;<asp:Label ID="lblLevel" runat="server" Width="333px"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 136px;">
                        </td>
                        <td colspan="5" >
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" ValidationGroup="Go" /><asp:Button ID="btnCreatePlan" runat="server" Text="Create Local Plan" OnClick="btnCreatePlan_Click" ValidationGroup="Go" /></td>
                    </tr>
                    <tr>
                        <td style="width: 136px">
                        </td>
                        <td colspan="5">
                            <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
                    </tr>
                </table>
        <asp:SqlDataSource ID="sqlCollegeDs" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_college_id], [txt_college_name] FROM [scs_college] WHERE ([key_college_id] < @key_college_id) ORDER BY [txt_college_name]">
            <SelectParameters>
                <asp:Parameter DefaultValue="19" Name="key_college_id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT [nbr_fiscal_year] FROM [scs_fiscal_year] WHERE ([flg_period_open] = @flg_period_open)">
        <SelectParameters>
            <asp:Parameter DefaultValue="True" Name="flg_period_open" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>


