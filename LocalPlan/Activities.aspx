<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Activities.aspx.cs" Inherits="LocalPlans_Activites" Title="Activities"  %>

<%@ Register Assembly="RadAjax.Net2" Namespace="Telerik.WebControls" TagPrefix="radA" %>


<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>


<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
        function ShowActivity(type)
        {           
            
            if(type == 0)
               var wObj = window.radopen("Activities/ActivityForm.aspx?id=-1&level=-1" , "UserListDialog");                       
            else
                 wObj = window.radopen("Activities/ActivityFormEquipment.aspx?id=-1&level=-1" , "UserListDialog");
                 
            var wW = Math.round(document.documentElement.clientWidth *95/100);            
            var wH = Math.round(document.documentElement.clientHeight *95/100);
            
            wObj.SetSize(wW,wH);
            wObj.Center();       
        }
        void function OpenFundingplan(planid)
        {
          var wW = Math.round(document.documentElement.clientWidth *95/100);            
            var wH = Math.round(document.documentElement.clientHeight *95/100);
        var winobj = window.radopen("fundingPlan.aspx?id=" + planid , "MainPop");
         winobj.SetSize(wW,wH);
            winobj.Center();  
        
        
        }
        void function popup(id, type, amendmentreason)
        {

            var link;

            //alert(type + ", " + amendmentreason);
            
            
            if(type == 'Equipment')
            {
                if (amendmentreason == '102')
                    link = 'Amendments/AmendmentForm2.aspx?keyid=' + id + "&level=-1";
                else
                    link = 'Activities/ActivityFormEquipment.aspx?id=' + id + "&view=0" + "&level=-1";
            }
            else if(type== 'Funded')
            {
                if (amendmentreason == '102')
                    link = 'Amendments/AmendmentForm2.aspx?keyid=' + id + "&level=-1";
                else
                    link = 'Activities/ActivityForm.aspx?id=' + id + "&level=-1";
            }else if (type == 'Transfer of Funds')
            {
                link = 'Amendments/AmendmentForm.aspx?keyid=' + id + "&level=-1";
            }
            

           var rWindow = window.radopen(link, "UserListDialog");
                       
           var wW = Math.round(document.documentElement.clientWidth *95/100);            
           var wH = Math.round(document.documentElement.clientHeight *95/100);
                    
           rWindow.SetSize(wW,wH);
           rWindow.Center();
        } 
        function refreshActivities(arg,kid,level)   
        {   
            if (arg == "Activities")
                window.open("../Activities.aspx?KeyActid=" + kid + "&level=-1", "_parent"); 
            else if (arg == "Amendment")
                window.open("../Activities.aspx?KeyActid=" + kid + "&level=-1", "_parent");  

//            window["<%=RadGrid1.ClientID %>"].AjaxRequest('<%= RadGrid1.UniqueID %>', 'Rebind');           
        }   
        function refreshGrid(arg,kid)   
        {   
           
                window.open("Activities.aspx?KeyActid=" + kid + "&level=-1", "_parent"); 
           

//            window["<%=RadGrid1.ClientID %>"].AjaxRequest('<%= RadGrid1.UniqueID %>', 'Rebind');           
        }  
        
        function openReimbursement(id)
        {
           var rWindow = window.radopen("ActivityReimbursement.aspx?aid=" + id, "UserListDialog2");
            
         
           rWindow.SetSize(800,550);
           rWindow.Center();
        }        
        
    </script>
    <table width="100%">
        <tr>
            <td align="center"><asp:Label ID="lblErr" runat="server" ForeColor="Red" Font-Names="Trebuchet MS"></asp:Label></td>
        </tr>        
        <tr>
            <td align="left" colspan="3" valign="top">
                <asp:Panel ID="Panel1" runat="server" Width="100%">
                    <table width="100%">
                        <tr>
                            <td colspan="3" style="height: 18px">
                                <asp:HyperLink ID="hlNewFA" runat="server" NavigateUrl="#" Font-Bold="False" Font-Italic="False" Font-Names="Trebuchet MS" Font-Size="9pt">[New Funded Activity]</asp:HyperLink>&nbsp;
                                <asp:HyperLink ID="hlNewEA" runat="server" NavigateUrl="#" Font-Bold="False" Font-Italic="False" Font-Names="Trebuchet MS" Font-Size="9pt">[New Equipment Activity]</asp:HyperLink>&nbsp;
                                <asp:HyperLink ID="hl_fundpl" runat="server" Font-Bold="False" Font-Italic="False"
                                    Font-Names="Trebuchet MS" Font-Size="9pt" NavigateUrl="#">[Show Funding Plan]</asp:HyperLink>
                            </td>
                            <td colspan="1" style="height: 18px" align="right">
                                <asp:LinkButton ID="hl_UpdateApprovals" runat="server" OnClick="hl_UpdateApprovals_Click">[Update Approvals]</asp:LinkButton><asp:Button
                                    ID="btnExportToExcel" runat="server" OnClick="btnExportToExcel_Click" Text="Export to Excel"
                                    Width="100px" /></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <radG:RadGrid DataSourceID="sqlDsActivities" GridLines="Horizontal" ID="RadGrid1" runat="server" Skin="Default" Width="99%" OnDataBound="RadGrid1_DataBound1" EnableAJAX="True" onitemdatabound="RadGrid1_ItemDataBound">
                <MasterTableView AutoGenerateColumns="False" CommandItemDisplay ="Top" DataKeyNames="key_activity_id" DataSourceID="sqlDsActivities" CellPadding="0" GridLines="Horizontal" Font-Size="9pt" Font-Strikeout="False">
                    <Columns>
                        <radG:GridTemplateColumn UniqueName="TemplateColumn">
                            <ItemStyle VerticalAlign="Top" Width="0.4in"  />
                            <ItemTemplate>
                                &nbsp;<asp:HyperLink ID="lbView" runat="server"  ImageUrl="~/images/Edit.gif">View</asp:HyperLink>
                            </ItemTemplate>
                        </radG:GridTemplateColumn>
                        <radG:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" HeaderText="#" ReadOnly="True" SortExpression="key_activity_id" UniqueName="key_activity_id">
                            <ItemStyle VerticalAlign="Top" Width="0.4in" />
                            <HeaderStyle Font-Size="9pt" />
                        </radG:GridBoundColumn>
                        <radG:GridTemplateColumn HeaderText="Activity Name" UniqueName="TemplateColumn">
                            <ItemStyle VerticalAlign="Top" Width="3.5in" />
                            <ItemTemplate>
                                <b>
                                    </b>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("txt_activity_name") %>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <HeaderStyle Font-Size="9pt" />
                        </radG:GridTemplateColumn>
                        <radG:GridBoundColumn DataField="txt_activity_type_desc" HeaderText="Type" SortExpression="txt_activity_type_desc"
                            UniqueName="txt_activity_type_desc">
                            <ItemStyle VerticalAlign="Top"
                                Width="1in" />
                         
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="txt_category_title" HeaderText="Category" SortExpression="txt_category_title"
                            UniqueName="txt_category_title" Visible="False">
                            <ItemStyle VerticalAlign="Top" />
                      
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="txt_function_code_desc" HeaderText="Function" SortExpression="txt_function_code_desc"
                            UniqueName="txt_function_code_desc" Visible="False">
                            <ItemStyle VerticalAlign="Top" />
                  
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="nbr_activity_total" DataFormatString="{0:n}" DataType="System.Decimal"
                            HeaderText="Budget" ReadOnly="True" SortExpression="nbr_activity_total" UniqueName="nbr_activity_total">
                            <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" Width="1in" />
                            <HeaderStyle Font-Size="9pt" HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                        </radG:GridBoundColumn>
                        <radG:GridBoundColumn DataField="nbr_activity_balance" DataFormatString="{0:n}" HeaderText="Balance"
                            SortExpression="nbr_activity_balance" UniqueName="nbr_activity_balance">
                            <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" Width="1.2in" />
                            <FooterStyle HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" />
                        </radG:GridBoundColumn>
                        <radG:GridCheckBoxColumn DataField="flg_locked" DataType="System.Boolean" HeaderText="Locked"
                            SortExpression="flg_locked" UniqueName="flg_locked">
                            <ItemStyle VerticalAlign="Top" Width="1in" HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" />
                     
                        </radG:GridCheckBoxColumn>
                        <radG:GridTemplateColumn DataField="flg_approved" DataType="System.Boolean" HeaderText="Approved"
                            UniqueName="flg_approved">
                            <ItemTemplate>
                                <asp:CheckBox ID="chb_approvals" runat="server" Checked='<%# Eval("flg_approved") %>' />
                            </ItemTemplate>
                            <ItemStyle VerticalAlign="Top" HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" />
                        </radG:GridTemplateColumn>
                        
                        <radG:GridBoundColumn DataField="key_amendment_reason_id" DataType="System.Int32" HeaderText="key_amendment_reason_id" ReadOnly="True" SortExpression="key_activity_id" UniqueName="key_amendment_reason_id" Display="False">
                            <ItemStyle VerticalAlign="Top" />
                       
                        </radG:GridBoundColumn>
                        
                        
                        <radG:GridTemplateColumn UniqueName="TemplateColumn" Visible="False">
                            <ItemTemplate>
                                &nbsp;<asp:HyperLink ID="hlReimbursement" runat="server"
                                    ImageUrl="~/images/reimb_03.gif">Reimbursement</asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="0.5in" />
                        </radG:GridTemplateColumn>
                        <radG:GridBoundColumn DataField="txt_activity_group" UniqueName="txt_activity_group" Visible="False">
                        </radG:GridBoundColumn>
                    </Columns>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px" />
                    </ExpandCollapseColumn>
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px" />
                    </RowIndicatorColumn>
  
                    
                        <CommandItemTemplate>
                  
                </CommandItemTemplate>
                    <GroupByExpressions>
                        <radG:GridGroupByExpression>
                             <GroupByFields>
                                 <radG:GridGroupByField FieldAlias="txt_activity_group" FieldName="txt_activity_group" HeaderText = "Group" FormatString="" />
                           </GroupByFields>
                           <SelectFields>
                               <radG:GridGroupByField FieldAlias="txt_activity_group" FieldName="txt_activity_group" HeaderText = "Group" FormatString="" />
                           </SelectFields>
                        </radG:GridGroupByExpression>
                    </GroupByExpressions>

         
                </MasterTableView>
                    <AlternatingItemStyle Font-Italic="False" Font-Overline="False" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
              
                    <ItemStyle BorderStyle="None" Font-Strikeout="False" />
                    <GroupPanel>
                        <PanelItemsStyle CellPadding="0" CellSpacing="0" />
                    </GroupPanel>
        <GroupHeaderItemStyle BackColor="Transparent" Font-Bold="True" ForeColor="Maroon" Font-Italic="True" />
       
                                          
            </radG:RadGrid>&nbsp;
            
                            
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 16px">
                                &nbsp;<asp:Label ID="Label1" runat="server" Width="54px"></asp:Label>
                                </td>
                            <td colspan="1" style="height: 16px">
                            </td>
        </tr>
        
                        <tr>
                            <td colspan="3">
                                &nbsp; &nbsp; &nbsp; &nbsp;</td>
                            <td colspan="1">
                            </td>
                        </tr>
                  
        <tr>
            <td colspan="3">
                </td>
            <td colspan="1">
            </td>
        </tr>
        <tr>
            <td>
                <asp:HiddenField ID="hfLocal_plan_id" runat="server" />
                <asp:SqlDataSource ID="sqlDsActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_act_activity_list_get" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfLocal_plan_id" Name="p_key_local_plan_id" PropertyName="Value"
                            Type="Int32" />
                    </SelectParameters>
    </asp:SqlDataSource>
                </td>
            <td>
                <asp:SqlDataSource ID="SqlDsActivityStatus" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="SELECT [key_level_id], [txt_level_desc] FROM [scs_level]">
                    </asp:SqlDataSource>
            </td>
            <td>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        </table>
            
     </asp:Panel>
            </td>
        </tr>
    </table>
    <radW:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Vista" SingleNonMinimizedWindow="True" >
         <Windows>
            <radw:RadWindow ID="UserListDialog" runat="server" 
               Left="150px" Behavior="Minimize, Maximize, Move, Reload"  BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top=""  />
            <radw:RadWindow ID="UserListDialog2" runat="server" Title="Task Information"
               Left="150px" Behavior="Minimize, Maximize, Reload"  BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top=""  />
            <radw:RadWindow ID="MainPop" runat="server" Title="Fund Report" Height="600px"
                          Width="800px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="10px" Left="" />
             
     </Windows>
    </radW:RadWindowManager>
    &nbsp;
</asp:Content>


