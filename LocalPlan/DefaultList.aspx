<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="DefaultList.aspx.cs" Inherits="LocalPlan_DefaultList" Title="Main Status Page"  %>

<%@ Register Assembly="RadAjax.Net2" Namespace="Telerik.WebControls" TagPrefix="radA" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">


    <script language="javascript">
    
    void function popup(activetype, id, admendtype)
    {

        var ddlStatus = document.getElementById("<%= ddlStatus.ClientID %>");
    
        //alert(ddlStatus.options[ddlStatus.selectedIndex].value);
    
        var level = ddlStatus.options[ddlStatus.selectedIndex].value;
    
    var link;

   if(activetype == '101')
   {
       if(admendtype == '102')
       {
       link = 'Amendments/AmendmentForm2.aspx?keyid=' + id + '&level=' + level;
         }
       else
       {
       link = 'Activities/ActivityForm.aspx?id=' + id + '&level=' + level;
       }
   }
   
   
   
   if(activetype ==  '102')
   {
       if(admendtype == '102')
       {
       link = 'amendments/AmendmentForm2.aspx?keyid=' + id + '&level=' + level;
       }
       else
       {
       link = 'Activities/ActivityFormEquipment.aspx?id=' + id + '&level=' + level;
       }
   }
   
   
   if(activetype == '103')
   {
    link = 'amendments/AmendmentForm.aspx?keyid=' + id + '&level=' + level;
   }
  
  
   if(activetype == '999')
   {
    link = 'NarrativeDetails.aspx?nid=' + id + '&level=' + level;
   }
   
   
   
   
//    if(type == 'Equipment Activity')
//    {
//    link = 'Activities/ActivityFormEquipment.aspx?id=' + id;

//    }
//    else if(type== 'Funded Activity')
//    {
//    link = 'Activities/ActivityForm.aspx?id=' + id;
//    }
//    else if(type=='Narrative')
//    {
//        link = 'NarrativeDetails.aspx?nid=' + id;
//    }


    window.radopen(link,"Size1");


    }

    function Sizeit(windowname) 
    { 
       var rwManager = GetRadWindowManager(); 
       var rWindow = rwManager.GetWindowByName(windowname); 
       var screenHeight = screen.height;

       //rWindow.SetHeight(screenHeight*95/100 ); 
      
       //rWindow.Center(); 
       var wW = Math.round(document.documentElement.clientWidth *95/100);            
       var wH = Math.round(document.documentElement.clientHeight *95/100);
                
       rWindow.SetSize(wW,wH);
       rWindow.Center();
    } 

    function refreshGrid(arg,KID,level)   
    {    
        /*if(!arg)   
        {   
          window["<%=RadGrid1.ClientID %>"].AjaxRequest('<%= RadGrid1.UniqueID %>', 'Rebind');   
        }   
        else   
        {   
          window["<%=RadGrid1.ClientID %>"].AjaxRequest('<%= RadGrid1.UniqueID %>', 'RebindAndNavigate');   
        }   */
        if (arg == "Activities" || arg == "Amendments")
            window.open("../DefaultList.aspx?KEYNID=" + KID + "&level=" + level, "_parent");
        else
            window.open("DefaultList.aspx?KEYNID=" + KID + "&level=" + level, "_parent");
        
    }
    
       function refreshActivities(arg,KID,level)   
    {    
       
        if (arg == "Activities" || arg == "Amendments")
            window.open("../DefaultList.aspx?KEYNID=" + KID + "&level=" + level, "_parent");
        else
            window.open("DefaultList.aspx?KEYNID=" + KID + "&level=" + level, "_parent");
        
    }
    
        
    </script>

    <table width="99%">
        <tr>
            <td colspan="3" style="text-align: center;" valign="top">
                <asp:Label ID="lblErr" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="3" style="height: 227px" valign ="top" >
                <asp:Panel ID="Panel1" runat="server" Width="99%">
                    &nbsp;<span>Select&nbsp; Level</span>
                    <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="SqlDsStatus" DataTextField="txt_level_desc"
                        DataValueField="key_level_id" Width="367px" AutoPostBack="True" Font-Size="9pt" Font-Names="Trebuchet MS" OnDataBound="ddlStatus_DataBound">
                    </asp:DropDownList>&nbsp;
                    <asp:CheckBox ID="chkApproved" runat="server" Font-Names="Trebuchet MS" Font-Size="9pt" Text="Include Approved Items" AutoPostBack="True" OnCheckedChanged="chkApproved_CheckedChanged" />
                    <asp:TextBox ID="txtShowAll" runat="server" Visible="False"></asp:TextBox>
                 
                <radg:radgrid id="RadGrid1" runat="server" DataSourceID="SqlDsStatuses"   OnDataBound="RadGrid1_DataBound" 
                Width="100%" 
               
                GridLines="Horizontal"
                Style="border-bottom: #319aea 1px solid" Skin="Default" EnableAJAX="True" OnItemDataBound="RadGrid1_ItemDataBound" >
                
                             <PagerStyle Height="20px" CssClass="GridPager" Mode="NumericPages"></PagerStyle> 
                

<MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDsStatuses" GridLines="Horizontal" CellPadding="0">
<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

<RowIndicatorColumn>
    <HeaderStyle Width="20px" />
</RowIndicatorColumn>
                       
                        
    <Columns>
        <radG:GridTemplateColumn UniqueName="TemplateColumn">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" Style="position: relative" ImageUrl="~/images/Edit.gif">view...</asp:HyperLink>
            </ItemTemplate>
            <ItemStyle Width="0.4in" />
        </radG:GridTemplateColumn>
        <radG:GridBoundColumn DataField="key_local_plan_narrative_id" DataType="System.Int32"
            HeaderText="#" ReadOnly="True" SortExpression="key_local_plan_narrative_id"
            UniqueName="key_local_plan_narrative_id">
            <ItemStyle Width="0.5in" />
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_type" HeaderText="Type" ReadOnly="True"
            SortExpression="txt_type" UniqueName="txt_type">
            <ItemStyle Width="2.3in" />
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_narrative_section_title" HeaderText="Description"
            ReadOnly="True" SortExpression="txt_narrative_section_title" UniqueName="txt_narrative_section_title">
            <ItemStyle Width="5.5in" />
        </radG:GridBoundColumn>
        <radG:GridCheckBoxColumn DataField="flg_locked" DataType="System.Boolean" HeaderText="Locked"
            ReadOnly="True" SortExpression="flg_locked" UniqueName="flg_locked">
            <ItemStyle Width="0.8in" />
        </radG:GridCheckBoxColumn>
        <radG:GridCheckBoxColumn DataField="flg_approved" DataType="System.Boolean" HeaderText="Approved"
            ReadOnly="True" SortExpression="flg_approved" UniqueName="flg_approved">
            <ItemStyle Width="0.8in" />
        </radG:GridCheckBoxColumn>
        <radG:GridBoundColumn DataField="key_status_level_id" DataType="System.Int32" HeaderText="key_status_level_id"
            ReadOnly="True" SortExpression="key_status_level_id" UniqueName="key_status_level_id" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_level_desc" HeaderText="txt_level_desc" ReadOnly="True"
            SortExpression="Status" UniqueName="txt_level_desc" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="key_activity_type_id" HeaderText="Type Key" SortExpression="key_activity_type_id"
            UniqueName="key_activity_type_id" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="key_level_id" UniqueName="key_level_id" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="key_amendment_reason_id" UniqueName="key_amendment_reason_id" Visible="False">
        </radG:GridBoundColumn>
    </Columns>


    <GroupByExpressions>
       <radG:GridGroupByExpression >
           <GroupByFields>
               <radG:GridGroupByField FieldAlias="Level" FieldName="txt_level_desc" />
           </GroupByFields>
           <SelectFields>
               <radG:GridGroupByField FieldAlias="Level" FieldName="txt_level_desc" />
           </SelectFields>
       </radG:GridGroupByExpression>
       
    </GroupByExpressions>
    
    
    <GroupHeaderItemStyle BorderStyle="None" Font-Bold="True" Font-Italic="True"  Font-Overline="False" ForeColor="Maroon" />

                       
                       

</MasterTableView>
                   <HeaderStyle Font-Overline="False" Font-Strikeout="False" Font-Bold="False" Font-Italic="False" Font-Underline="False" Wrap="True" />
                    <ItemStyle  CssClass="Row" />
                    
                    <ClientSettings AllowExpandCollapse="True">
                    </ClientSettings>
                    <GroupHeaderItemStyle BorderStyle="None" />
                   
                    
              
</radg:radgrid></asp:Panel>
            </td>
        </tr>
    </table>
                <asp:HiddenField ID="hfLpid" runat="server" />
    <br />
<asp:SqlDataSource ID="SqlDsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="SELECT -1 as [key_level_id], 'View All' as [txt_level_desc]&#13;&#10;UNION&#13;&#10;SELECT [key_level_id], [txt_level_desc] FROM [scs_level]">
                    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDsStatuses" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_lp_item_status_list" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlStatus" Name="p_key_level_id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="hfLpid" Name="key_local_plan_id" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="txtShowAll" DefaultValue="0" Name="p_flg_show_all"
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <radW:RadWindowManager ID="WinManger" runat="server" Style="Position:relative; top: 0px;" Skin="Vista" Behavior="Minimize, Maximize, Reload" >
      <Windows>
                       <radw:RadWindow ID="Size1" runat="server" Title="Local Plan" Height="600px" OnClientShow="Sizeit('Size1');"
                        Width="780px" Left="30px"   ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins"  Top="40px" />
             </Windows>
    </radW:RadWindowManager>
    
    
</asp:Content>


