<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Amendments.aspx.cs" Inherits="LocalPlans_Admendments" Title="Amendments" %>
<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">    
    <script language="javascript">
    
    function openmywindow()
    {          
      //window.location = "Amendment_AdjustmentsV2.aspx";
      var hf_lp_id = document.getElementById("<%= hfLocal_plan_id.ClientID %>").value;
      var hf_role_id = document.getElementById("<%= hf_Role_Id.ClientID %>").value;
      
        var winobj = window.radopen("Amendment_AdjustmentsV3.aspx?aid=-1&lpid= " + hf_lp_id + "&roleId=" + hf_role_id , "MainPop");
        var wW = Math.round(document.documentElement.clientWidth *95/100);            
        var wH = Math.round(document.documentElement.clientHeight *95/100);
        
        winobj.SetSize(wW,wH);
        winobj.Center();
        winobj.Center();
    }
    
    function open_admentForm(activeid)
    {
        var winobj = window.radopen("./amendments/AmendmentForm.aspx?keyid=" + activeid + "&level=-1", "MainPop");
        var wW = Math.round(document.documentElement.clientWidth *95/100);            
        var wH = Math.round(document.documentElement.clientHeight *95/100);
        
        winobj.SetSize(wW,wH);
        winobj.Center();
    }
     function open_admentForm2(activeid)
    {
        //alert(activeid);
        var winobj = window.radopen("./amendments/AmendmentForm2.aspx?keyid=" + activeid + "&level=-1", "MainPop");
         var wW = Math.round(document.documentElement.clientWidth *95/100);            
        var wH = Math.round(document.documentElement.clientHeight *95/100);
        
        winobj.SetSize(wW,wH);
        winobj.Center();
     //   winobj.Center();
    }
    
    function refreshGrid(arg,kid,level)   
    {   
        if (arg == "Amendments")
            window.open("../Amendments.aspx?KeyActid=" + kid +"&level=-1", "_parent");  
        
        if (arg =="LocalPlan_Amendments")
            window.open("Amendments.aspx?KeyActid=" + kid +"&level=-1", "_parent");  
              
    } 
    
    
    function refreshActivities()      
    {
        window["<%=RadGrid1.ClientID %>"].AjaxRequest('<%= RadGrid1.UniqueID %>', 'Rebind');   
    }
     
    void function OpenFundingplan(planid) 
    {
      var wW = Math.round(document.documentElement.clientWidth *95/100);            
      var wH = Math.round(document.documentElement.clientHeight *95/100);
      var winobj = window.radopen("fundingPlan.aspx?id=" + planid , "FundingPlan");
      winobj.SetSize(wW,wH);
      winobj.Center();      
    }    
    </script>
    
    <table border="0" width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center"><asp:Label ID="lblErr" runat="server" ForeColor="Red" Font-Names="Trebuchet MS" Font-Size="9pt"></asp:Label></td>
        </tr>  
                                               
        <tr>
            <td>
                <asp:Panel ID="Panel1" runat="server" Width="100%">
                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><asp:HyperLink ID="hlNewAmendment" runat="server"
                    NavigateUrl="#" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="9pt">[New Amendment]</asp:HyperLink>
                    |
                    <asp:HyperLink ID="hl_fundpl" runat="server" Font-Bold="False" Font-Italic="False"
                        Font-Names="Trebuchet MS" Font-Size="9pt" NavigateUrl="#">[Show Funding Plan]</asp:HyperLink>
                    
                            </td>
                            <td style="text-align: right">
                                <asp:Button ID="btnExportToExcel" runat="server" OnClick="btnExportToExcel_Click"
                                    Text="Export to Excel" Width="100px" /></td>
                        </tr>  
                    </table>        
                    
               
                    <radG:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" DataSourceID="sqlDsAmendments"
        EnableAJAX="True" GridLines="None" Skin="Default" Width="100%" OnItemDataBound="RadGrid1_ItemDataBound" OnItemCreated="RadGrid1_ItemCreated">
        <ItemStyle Font-Bold="False" />
        <HeaderStyle Font-Bold="False" Font-Overline="False" Font-Strikeout="False" />
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_activity_id" DataSourceID="sqlDsAmendments"
            PageSize="50">
            <Columns>
             <radG:GridTemplateColumn UniqueName="TemplateColumn">
                    <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server"  Visible="False">View..</asp:LinkButton>
                        <asp:HyperLink ID="hlView" runat="server" ImageUrl="~/images/Edit.gif" NavigateUrl="#">View</asp:HyperLink>
                    </ItemTemplate>
                </radG:GridTemplateColumn>
                <radG:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" HeaderText="#"
                    ReadOnly="True" SortExpression="key_activity_id" UniqueName="key_activity_id">
                    <ItemStyle VerticalAlign="Top" Width="0.6in" />
                </radG:GridBoundColumn>
                <radG:GridTemplateColumn HeaderText="Name" UniqueName="TemplateColumn">
                    <ItemStyle VerticalAlign="Top" Width="3in" />
                    <ItemTemplate>
                        <b>
                            <asp:Label ID="Label1" runat="server" Font-Bold="False" Font-Names="Trebuchet MS"
                                Font-Size="9pt" Text='<%# Eval("txt_activity_name") %>'></asp:Label></b>
                    </ItemTemplate>
                    <EditItemTemplate>
                        &nbsp;
                    </EditItemTemplate>
                </radG:GridTemplateColumn>
                <radG:GridBoundColumn DataField="txt_activity_type_desc" HeaderText="Type" SortExpression="txt_activity_type_desc"
                    UniqueName="txt_activity_type_desc">
                    <ItemStyle VerticalAlign="Top"
                        Width="2in" />
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="txt_category_title" HeaderText="Category" SortExpression="txt_category_title"
                    UniqueName="txt_category_title" Visible="False">
                    <ItemStyle VerticalAlign="Top" />
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="txt_function_code_desc" HeaderText="Function" SortExpression="txt_function_code_desc"
                    UniqueName="txt_function_code_desc" Visible="False">
                    <ItemStyle VerticalAlign="Top" />
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="nbr_activity_total" DataFormatString="{0:C}" DataType="System.Decimal"
                    HeaderText="Total" ReadOnly="True" SortExpression="nbr_activity_total" UniqueName="nbr_activity_total">
                    <ItemStyle VerticalAlign="Top" />
                </radG:GridBoundColumn>
                <radG:GridCheckBoxColumn DataField="flg_locked" DataType="System.Boolean" HeaderText="Locked"
                    SortExpression="flg_locked" UniqueName="flg_locked">
                    <ItemStyle VerticalAlign="Top" />
                </radG:GridCheckBoxColumn>
                <radG:GridCheckBoxColumn DataField="flg_approved" DataType="System.Boolean" HeaderText="Approved"
                    SortExpression="flg_approved" UniqueName="flg_approved">
                    <ItemStyle VerticalAlign="Top" />
                </radG:GridCheckBoxColumn>
               
                <radG:GridBoundColumn DataField="key_activity_type_id" UniqueName="key_activity_type_id" Visible="False">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="key_amendment_reason_id" UniqueName="key_amendment_reason_id"
                    Visible="False">
                </radG:GridBoundColumn>
            </Columns>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px" />
            </ExpandCollapseColumn>
            <RowIndicatorColumn>
                <HeaderStyle Width="20px" />
            </RowIndicatorColumn>
      
       <GroupByExpressions>
                        <radG:GridGroupByExpression>
                             <GroupByFields>
                                 <radG:GridGroupByField FieldAlias="txt_funding_plan_version" FieldName="txt_funding_plan_version" HeaderText = "Group" FormatString="" />
                           </GroupByFields>
                           <SelectFields>
                               <radG:GridGroupByField FieldAlias="txt_funding_plan_version" FieldName="txt_funding_plan_version" HeaderText = "Group" FormatString="" />
                           </SelectFields>
                        </radG:GridGroupByExpression>
                    </GroupByExpressions> 
                            
        </MasterTableView>
        <GroupHeaderItemStyle BackColor="Transparent" Font-Bold="True" ForeColor="Maroon" Font-Italic="True" />
      
    </radG:RadGrid>
       
            <br />
            <radW:RadWindowManager ID="RadWindowManager1" runat="server" VisibleStatusbar="False" BorderWidth="0px" Top="10px" Modal="True" BorderStyle="Solid" Skin="Vista" >
                <windows>
                    <radw:RadWindow ID="MainPop" runat="server" Title="" Height="600px"
                          Width="800px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Behavior="None" Top="10px" Left=""  />             
                    <radw:RadWindow ID="FundingPlan" runat="server" Title="Fund Report" Height="600px"
                          Width="800px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="10px" Left="" />                          
               </windows>
    </radW:RadWindowManager>
    
 
    <asp:SqlDataSource ID="sqlDsAmendments" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_act_amendment_list_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfLocal_plan_id" Name="p_key_local_plan_id" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp; &nbsp;
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click"  Text="New Amendment"  Visible="False"  />&nbsp;
    <asp:HiddenField ID="hfLocal_plan_id" runat="server" /><asp:HiddenField ID="hf_Role_Id" runat="server" />
                    <asp:SqlDataSource ID="SQLDS_RLGETPLANSTATUS" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="SELECT     flg_locked&#13;&#10;FROM         lp_local_plan where key_local_plan_id = @keyid">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hfLocal_plan_id" Name="keyid" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HiddenField ID="hdn_FinishedStatus" runat="server" />
                    <asp:SqlDataSource ID="SQLDS_DeleteUnfinishedActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        DeleteCommand="pr_at_amendment_incomplete_amd_del" DeleteCommandType="StoredProcedure"
                        SelectCommand="select * from sec_roles">
                        <DeleteParameters>
                            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                            <asp:Parameter Name="p_key_activity_id" Type="Int32" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
                    &nbsp;<br />
      
                 </asp:Panel>
            </td>          
        </tr>       
    </table>


</asp:Content>


