<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="narrative.aspx.cs" Inherits="Accountability_narrative" Title="Accountability Narratives" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
        function ShowNarrativeDetails(vNid, levelid)
        {
           // alert("");
            var nid =  vNid;
           
            var wObj = window.radopen("Narrative_Response.aspx?nid=" + nid + "&level=" + levelid , "UserListDialog");                       
            var wW = Math.round(document.documentElement.clientWidth *95/100);            
            var wH = Math.round(document.documentElement.clientHeight *95/100);
            
            wObj.SetSize(wW,wH);
            wObj.Center();      
        }    
        
        
        
        function OpenReports(acctid)
        {
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;
            var activitytypeid=0;
      

            
                window.open("../Reports/ViewReport.aspx?type=rpt_acc_accountability_narrative_get_rec_id&n_id=-1" + "&format=pdf&Reportid=8"  + "&aa_id=" + acctid +"&accoutablityID=" + acctid ,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
        }
    </script>
 <asp:Panel ID="PanelTops" runat="server" width="100%">
    <table style="width: 100%">
        <tr>
            <td colspan="2" valign="top">
                <span style="font-weight:bold;">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Fiscal Year:"></asp:Label>
                    <asp:Label ID="lbl_Fiscal_Year" runat="server"></asp:Label>
                </span>
            </td>
                    
            <td align="right">
                <asp:Button ID="btn_print" runat="server" Font-Bold="True" Text="Print Report" Width="100px" />
                <asp:Button ID="btn_Export_Excel" runat="server" Font-Bold="True" Text="Export Excel" OnClick="btn_Export_Excel_Click" Width="100px" />
                <asp:ImageButton
                    ID="imgb_Excel" runat="server" AlternateText="Export to Excel" Height="18px"
                    ImageUrl="~/images/Excel_Icon_SMALL.gif" OnClick="imgb_Excel_Click" Width="22px" Visible="False" />
            </td>                    
        </tr>
        <tr>
            <td colspan="3">
    
    
    <telerik:RadGrid ID="rg_Narratives" runat="server" DataSourceID="ds_Acc_Narr" EnableAJAX="True" GridLines="None" Skin="Office2007_SCTCS" OnItemDataBound="rg_Narratives_ItemDataBound" EnableEmbeddedSkins="False">
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_accountability_narrative_rec_id"
            DataSourceID="ds_Acc_Narr">
            <Columns>
                <telerik:GridTemplateColumn UniqueName="EditTemplateColumn">
                    <EditItemTemplate>
                        &nbsp;
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="lbView" runat="server" ImageUrl="~/images/Edit.gif" Style="position: relative" NavigateUrl="#">View</asp:HyperLink>
                        <asp:HiddenField ID="hf_Nid" runat="server" Value='<%# Eval("key_accountability_narrative_rec_id") %>' />
                    </ItemTemplate>
                    <ItemStyle Width="0.2in" />
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="key_accountability_narrative_rec_id" DataType="System.Int32"
                    HeaderText="Id" ReadOnly="True" SortExpression="key_accountability_narrative_rec_id"
                    UniqueName="key_accountability_narrative_rec_id">
                    <ItemStyle Width="0.5in" />
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="txt_narrative_section_title" HeaderText="Title"
                    SortExpression="txt_narrative_section_title" UniqueName="txt_narrative_section_title" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_narrative_section_titleTextBox" runat="server" Text='<%# Bind("txt_narrative_section_title") %>'
                            Width="400px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="txt_narrative_section_titleLabel" runat="server" Text='<%# Eval("txt_narrative_section_title") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="2in" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="txt_narrative_desc" HeaderText="Description" SortExpression="txt_narrative_desc"
                    UniqueName="txt_narrative_desc">
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_narrative_descTextBox" runat="server" Height="75px" Text='<%# Bind("txt_narrative_desc") %>'
                            TextMode="MultiLine" Width="700px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="txt_narrative_descLabel" runat="server" Text='<%# Eval("txt_narrative_desc") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="flg_narrative_response" DataType="System.Boolean"
                    HeaderText="Responded" UniqueName="flg_narrative_response">
                    <EditItemTemplate>
                        <asp:TextBox ID="flg_narrative_responseTextBox" runat="server" Text='<%# Bind("flg_narrative_response") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        &nbsp;<asp:CheckBox ID="chk_narrative_response" runat="server" />
                        <asp:Label ID="lbl_narrative_response" runat="server" Text='<%# Eval("flg_narrative_response") %>'
                            Visible="False"></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
            <EditFormSettings>
                <EditColumn UniqueName="EditCommandColumn1" CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif">
                </EditColumn>
            </EditFormSettings>
        </MasterTableView>
    </telerik:RadGrid></td>
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
    
    <asp:SqlDataSource ID="ds_Acc_Narr" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_accountability_narrative_get_list" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_narrative_upd" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hf_Accountability_Id" Name="p_key_accountability_id"
                PropertyName="Value" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="p_key_accountability_narrative_rec_id" Type="Int32" />
            <asp:Parameter Name="p_txt_narrative_response" Type="String" />
            <asp:Parameter Name="p_txt_updated_user" Type="String" />
            <asp:Parameter Name="p_txt_system_office_notes" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hf_Accountability_Id" runat="server" />
    
    <radW:RadWindowManager ID="RadNarrativeDetail" runat="server" Skin="Vista" Behavior="Minimize, Maximize, Move, Reload" >
        <Windows>
            <radw:RadWindow ID="UserListDialog" runat="server" Title="Narrative"
               Left="150px" BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Height="600px" Width="400px" Top="" />
        </Windows>
        
        
    </radW:RadWindowManager>
    <asp:SqlDataSource ID="SQLDS_Accountablity" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_acc_accountability_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="p_key_college_id" Type="Int32" />
            <asp:Parameter Name="p_nbr_fiscal_year" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    </asp:Panel>
    <asp:Panel ID="pan_noNarrative" runat="server" HorizontalAlign="Center">
        <asp:Label ID="lbl_errortext" runat="server" Text="Label"></asp:Label></asp:Panel>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

