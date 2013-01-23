<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="AccountabilityReport.aspx.cs" Inherits="Accountability_AccountabilityReport" Title="Accountability Report" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
<script language="javascript" >
function OpenReports(accoutablityid)
{
 
 var winobj = window.radopen("reports/ReportList_View.aspx?acctid=" + accoutablityid, "littlepop");
 winobj.Center();
}
function OpenErrors()
    {   
        var winobj = window.radopen("reports/ValidationErrors.aspx", "MainPop");
        winobj.Center();
    }
    </script>

    <table style="font-weight: bold; width: 94%">
        <tr>
            <td style="width: 134px">
    <asp:Label ID="Label2" runat="server" Text="Fiscal Year:"></asp:Label></td>
            <td style="text-align: left; ">
    <asp:DropDownList ID="ddl_fiscalyear" runat="server" Width="119px" DataSourceID="SqlDS_fisYear" DataTextField="nbr_fiscal_year" DataValueField="nbr_fiscal_year" AutoPostBack="True" OnSelectedIndexChanged="ddl_College_FiscalYear_SelectedIndexChanged">
    </asp:DropDownList>&nbsp;
                <asp:Button ID="btnCreate" runat="server" Text="Create" Font-Bold="True" Width="59px" OnClick="btnCreate_Click" Visible="False" />&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 134px">
            </td>
            <td style="text-align: left">
                <asp:Label ID="lbl_error" runat="server" Text="</br><image src='../images/msgIcons/stop.jpg' style='WIDTH: 25px;VERTICAL-ALIGN: middle; valign=middle; BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; HEIGHT: 26px; BORDER-BOTTOM-STYLE: none' />  There is no Accountablity Report for the selected year! Please contact system office."
                    Visible="False"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 134px">
                <asp:Label ID="Label3" runat="server" Text="Accountability ID:" Visible="False"></asp:Label></td>
            <td style="text-align: left; width: 665px;">
                <asp:Label ID="lbl_Acc_Id" runat="server" Visible="False"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 134px">
                <asp:Label ID="Label4" runat="server" Text="Level:" Visible="False"></asp:Label></td>
            <td style="text-align: left; width: 665px;">
                <asp:Label ID="lbl_Level" runat="server" Visible="False"></asp:Label>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="width: 134px">
                <asp:Label ID="Label5" runat="server" Text="Next Level:" Visible="False"></asp:Label></td>
            <td style="text-align: left; width: 665px;">
                <asp:DropDownList ID="ddl_Acct_Next_Level" runat="server" DataSourceID="ds_Acct_Next_Level"
                    DataTextField="txt_level_desc" DataValueField="nbr_next_level_nbr" Width="396px" Visible="False">
                </asp:DropDownList><asp:SqlDataSource ID="ds_Acct_Next_Level" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="pr_acct_report_next_level_get" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hf_Level_Id" Name="p_nbr_current_next_level_nbr"
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 134px" valign="top">
                <asp:Label ID="Label6" runat="server" Text="System Office Notes:" Visible="False"></asp:Label>
                <asp:Button ID="btn_Save" runat="server" OnClick="btn_Save_Click" Text="Save Notes" Width="98px" Font-Bold="True" Visible="False" /></td>
            <td style="text-align: left; width: 665px;">
                <asp:TextBox ID="txt_Note" runat="server" Height="200px" TextMode="MultiLine" Width="587px" Visible="False"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 134px; height: 20px;">
            </td>
            <td style="text-align: left; width: 665px; height: 20px;">
                <asp:LinkButton ID="lnkSubmit" runat="server" Font-Bold="False" OnClick="lnkSubmit_Click" Visible="False">[Submit Accountability Report]</asp:LinkButton>&nbsp;
                <asp:HyperLink ID="HL_RPLIST" runat="server" Font-Bold="False" ForeColor="Blue" Style="left: 39px;
                    top: -406px" Visible="False">[Print Accountability Report]</asp:HyperLink>
                &nbsp;
                <asp:HyperLink ID="HL_Errors" runat="server" Font-Bold="False" ForeColor="Red" Style="left: 80px;
                    top: 25px" Visible="False" Width="291px">[Update Failed, Click Here to view errors]</asp:HyperLink></td>
        </tr>
    </table>
    <br />
    &nbsp;<br />
    <asp:SqlDataSource ID="sqlds_submitLevelUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        OnUpdated="sqlds_submitLevelUpdate_Updated" SelectCommand="pr_acc_accountability_validation_errors_get"
        SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_level_upd"
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="p_key_err_msg_hdr_id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="hf_Accountability_Id" Name="p_key_accountability_id"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="ddl_Acct_Next_Level" Name="p_key_accountability_plan_level_id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="p_txt_created_user" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <rad:RadWindowManager ID="RadWindowManager1" Skin="Vista" runat="server" Style="position: relative" Modal="True">
    
     
                 <windows>
                                <rad:RadWindow ID="MainPop"  runat="server" Title="" Height="600px"
                          Width="800px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="10px" Left="" />
                                <rad:RadWindow ID="littlepop"  runat="server" Title="" Height="325px"
                          Width="300px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="10px" Left="" />
             
               </windows>
               
    </rad:RadWindowManager>
    <br />
  
    <asp:SqlDataSource ID="SQLDS_Accountablity" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        InsertCommand="pr_acc_accountability_ins" InsertCommandType="StoredProcedure"
        SelectCommand="pr_acc_accountability_get" SelectCommandType="StoredProcedure"
        UpdateCommand="pr_acc_accountability_upd" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_College" Name="p_key_college_id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="ddl_fiscalyear" Name="p_nbr_fiscal_year" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="p_key_accountability_id" Type="Int32" />
            <asp:Parameter Name="p_key_college_id" Type="Int32" />
            <asp:Parameter Name="p_nbr_fiscal_year" Type="Int32" />
            <asp:Parameter Name="p_key_accountability_level_id" Type="Int32" />
            <asp:Parameter Name="p_txt_note" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="p_key_college_id" Type="Int32" />
            <asp:Parameter Name="p_nbr_fiscal_year" Type="Int32" />
            <asp:Parameter Name="p_txt_created_by" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <div style="visibility:hidden">
    <asp:Label ID="Label1" runat="server" Text="College: "></asp:Label><asp:DropDownList ID="ddl_College" runat="server" Width="172px" DataSourceID="SqlDsCollege" DataTextField="txt_college_short_name" DataValueField="key_college_id" AutoPostBack="True" OnSelectedIndexChanged="ddl_College_FiscalYear_SelectedIndexChanged">
    </asp:DropDownList></div>
    <asp:SqlDataSource ID="SqlDsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT key_college_id, txt_college_name AS txt_college_short_name FROM scs_college WHERE (key_college_id < @key_college_id)&#13;&#10;Order by txt_college_name">
        <SelectParameters>
            <asp:Parameter DefaultValue="18" Name="key_college_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
                <asp:SqlDataSource ID="ds_Level" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="pr_acct_report_level_get" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hf_Accountability_Id" Name="p_key_accountability_id"
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="hf_Level_Id" runat="server" />
    <asp:SqlDataSource ID="SqlDS_fisYear" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_fiscal_year_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:HiddenField ID="hf_Accountability_Id" runat="server" />
    <asp:SqlDataSource ID="sqlds_accountablityCheck" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_acc_accountability_check" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddl_College" Name="p_key_college_id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="ddl_fiscalyear" Name="p_nbr_fiscal_year" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp;
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

