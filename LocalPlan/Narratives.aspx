<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Narratives.aspx.cs" Inherits="LocalPlans_Narratives" Title="Narratives" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
    
    function Sizeit(windowname) 
{ 
        var rwManager = GetRadWindowManager(); 
        var rWindow = rwManager.GetWindowByName(windowname); 
        var screenHeight = screen.height;

        rWindow.SetHeight(parseFloat(screenHeight/1.2 )); 
      
        rWindow.Center(); 
} 

        function ShowNarrativeDetails(vNid)
        {
            var nid =  vNid;
           
            var wObj = window.radopen("NarrativeDetails.aspx?nid=" + nid + "&level=-1", "UserListDialog");                       
            var wW = Math.round(document.documentElement.clientWidth *95/100);            
            var wH = Math.round(document.documentElement.clientHeight *95/100);
            
            wObj.SetSize(wW,wH);
            wObj.Center();      
        }
        function refreshGrid(arg1,arg)   
        {  
            /*if(!arg)   
            {   
              window["<%=RadGrid1.ClientID %>"].AjaxRequest('<%= RadGrid1.UniqueID %>', 'Rebind');   
            }   
            else   
            {   
              window["<%=RadGrid1.ClientID %>"].AjaxRequest('<%= RadGrid1.UniqueID %>', 'RebindAndNavigate');   
            }  */
           
            window.open("Narratives.aspx?keynid=" + arg + "&level=-1","_parent");  
            //alert(arg);
        }  
    </script>
    <table width="100%">
        <tr>
            <td align="center" colspan="4">
                <asp:Label ID="lblErr" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>       
        <tr>
            <td align="center" colspan="3" style="width: 675px">
            </td>
            <td align="center" colspan="1">
                <asp:LinkButton ID="hl_UpdateApprovals" runat="server" OnClick="hl_UpdateApprovals_Click">[Update Approvals]</asp:LinkButton></td>
        </tr>
        <tr>
            <td colspan="4" >
                <asp:Panel ID="Panel1" runat="server" Width="100%">
    <table width="100%">
        <tr>
            <td colspan="4" valign="top" >            
            <radG:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDataSourceNar" GridLines="Horizontal"
        OnItemDataBound="RadGrid1_ItemDataBound" OnItemCreated="RadGrid1_ItemCreated" Skin="Default" Width="99%" EnableAJAX="True" OnDataBound="RadGrid1_DataBound">
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_local_plan_narrative_id"
            DataSourceID="SqlDataSourceNar" GridLines="Horizontal">
            <Columns>
                <radG:GridTemplateColumn UniqueName="TemplateColumn">
                    <ItemTemplate>
                        <asp:HyperLink ID="lbView" runat="server" ImageUrl="~/images/Edit.gif"
                            Style="position: relative">View</asp:HyperLink>
                    </ItemTemplate>
                </radG:GridTemplateColumn>
                <radG:GridBoundColumn DataField="key_local_plan_narrative_id" DataType="System.Int32" HeaderText="#" ReadOnly="True" SortExpression="key_local_plan_narrative_id"
                    UniqueName="key_local_plan_narrative_id">
                </radG:GridBoundColumn>
                <radG:GridTemplateColumn DataField="txt_narrative_section_title" HeaderText="Section Title"
                    SortExpression="txt_narrative_section_title" UniqueName="txt_narrative_section_title">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlSection" runat="server" Text='<%# Eval("txt_narrative_section_title") %>'  NavigateUrl='#'></asp:HyperLink>
                        <asp:HiddenField ID="hfNid" runat="server" Value='<%# Eval("key_local_plan_narrative_id") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txt_narrative_section_titleTextBox" runat="server" Text='<%# Bind("txt_narrative_section_title") %>' Width="600px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemStyle  Width="5in" />
                </radG:GridTemplateColumn>
                <radG:GridCheckBoxColumn DataField="flg_locked" DataType="System.Boolean" HeaderText="Locked"
                    SortExpression="flg_locked" UniqueName="flg_locked">
                </radG:GridCheckBoxColumn>
                <radG:GridTemplateColumn DataField="flg_approved" HeaderText="Approved" UniqueName="flg_approved">
                    <ItemTemplate>
                        <asp:CheckBox ID="chb_approvals" runat="server" Checked='<%# Eval("flg_approved") %>' />
                    </ItemTemplate>
                </radG:GridTemplateColumn>
                <radG:GridTemplateColumn HeaderText="Responded" UniqueName="flg_narrative_response">
                    <ItemTemplate>
                        <asp:CheckBox ID="chk_narrative_response" runat="server" /><asp:Label ID="lbl_narrative_response" runat="server" Text='<%# Eval("flg_narrative_response") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                </radG:GridTemplateColumn>
            </Columns>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px" />
            </ExpandCollapseColumn>
            <RowIndicatorColumn>
                <HeaderStyle Width="20px" />
            </RowIndicatorColumn>
            <ItemStyle Font-Overline="False" />
        </MasterTableView>
                <ClientSettings>
                    <Selecting AllowRowSelect="True" />
                </ClientSettings>
            
      

    </radG:RadGrid>
            <br />
                
    
    <asp:SqlDataSource ID="SqlDataSourceNar" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_lp_local_plan_narrative_get_list" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="hfLocal_plan_id" Name="key_local_plan_id" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    </table>
    </asp:Panel>
                <asp:HiddenField ID="hfLocal_plan_id" runat="server" />
    
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT     lp.key_local_plan_narrative_id, dbo.scs_narrative.txt_narrative_section_title, lp.flg_locked, lp.flg_approved&#13;&#10;FROM         dbo.scs_narrative INNER JOIN&#13;&#10;                      dbo.lp_local_plan_narrative AS lp ON dbo.scs_narrative.key_narrative_id = lp.key_narrative_id&#13;&#10;WHERE key_local_plan_id = @key_local_plan_id&#13;&#10;&#13;&#10;">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfLocal_plan_id" Name="key_local_plan_id" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <br />
    <br />
    &nbsp;<br />
    <br />
    <radW:RadWindowManager ID="RadNarrativeDetail" runat="server" Skin="Vista" Behavior="Minimize, Maximize, Move, Reload" >
        <Windows>
            <radw:RadWindow ID="UserListDialog" runat="server" Title="Narrative"
               Left="150px" BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Height="600px" Width="400px" Top="" />
        </Windows>
        
        
    </radW:RadWindowManager>
</asp:Content>


