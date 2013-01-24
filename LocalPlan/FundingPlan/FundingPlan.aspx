<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="FundingPlan.aspx.cs" Inherits="LocalPlan_FundingPlan_FundingPlan" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>
<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
    
    function openreportwindow()
    {
         var planid = document.getElementById("<%= hf_fundingPlanid.ClientID %>").value;
         var versionid = document.getElementById("<%= lblVersion.ClientID  %>").innerText;
       
         var reportids = 0;
      
         if(planid > 0)
         {
            var winobj = window.radopen("FundingPlanReport_list.aspx?planid=" + planid + "&fiscalyear=" + reportids + "&versionid=" + versionid, "littlepop");
            winobj.Center(); 
         }
    }
      
      function refreshGrid(arg,kid,level)   
    { 
    window.open("../fundingplan/fundingplan.aspx", "_parent"); 
    }
      
         function showerrors(errormessage)
    {
    
     var winobj = window.radopen("FundingPlan_TransferError.aspx?errorMessage=" + errormessage, "MainPop");
    
    }
      
      
        function OpenReportRDL()
        {
            var planid = document.getElementById("<%= hf_fundingPlanid.ClientID %>").value;
            var wide = window.screen.availWidth-30;
                var high = window.screen.availHeight-30;
//alert(planid);
                window.open("../../../Reports/ViewReport.aspx?type=fundingplan&Keyid=" + planid + "&reportformat=rdl",null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
     
        }
        
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
        
        void function popup(id, type, amendmentreason)
        {

            var link;

            //alert(type + ", " + amendmentreason);
            
            
            if(type == 'Equipment')
            {
                if (amendmentreason == '102')
                    link = '../Amendments/AmendmentForm2.aspx?keyid=' + id + "&level=-1";
                else
                    link = '../Activities/ActivityFormEquipment.aspx?id=' + id + "&view=0" + "&level=-1";
            }
            else if(type== 'Funded')
            {
                if (amendmentreason == '102')
                    link = '../Amendments/AmendmentForm2.aspx?keyid=' + id + "&level=-1";
                else
                    link = '../Activities/ActivityForm.aspx?id=' + id + "&level=-1";
            }else if (type == 'Transfer of Funds')
            {
                link = '../Amendments/AmendmentForm.aspx?keyid=' + id + "&level=-1";
            }
            

           var rWindow = window.radopen(link, "UserListDialog");
                       
           var wW = Math.round(document.documentElement.clientWidth *95/100);            
           var wH = Math.round(document.documentElement.clientHeight *95/100);
                    
           rWindow.SetSize(wW,wH);
           rWindow.Center();
        } 
        
        function refreshActivities()      
        {
            window["<%=gvActivities.ClientID %>"].AjaxRequest('<%= gvActivities.UniqueID %>', 'Rebind');   
        }
    </script>
    
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="text-align: center">
                <asp:Label ID="lblErr" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:Panel ID="Panel1" runat="server" Width="100%">
                     <table width="100%" cellpadding="0" cellspacing="0">        
                        <tr>
                            <td align="left" style="text-align:left; height: 22px; width: 13%;">
                                <asp:Label ID="lblFP" runat="server" Text="Select Funding Plan: " Font-Names="Trebuchet MS"></asp:Label></td>
                            
                            <td width="55%" style="height: 22px">
                                <asp:DropDownList
                                    ID="cbFundPlanVersion" runat="server" AutoPostBack="True" DataSourceID="dsFundPlanVersion"
                                    DataTextField="txt_version_desc" DataValueField="key_funding_plan_hdr_id" OnDataBound="cbFundPlanVersion_DataBound"
                                    OnSelectedIndexChanged="cbFundPlanVersion_SelectedIndexChanged1" Width="457px"></asp:DropDownList>
                                                </td>    
                            <td align="right" style="height: 22px; width: 31%;">
                                         <div style="visibility:hidden">    <asp:Label ID="lblVersion" runat="server" Visible="True"></asp:Label></div>   
                                <asp:Label ID="tblRes" runat="server" Visible="False">
                                
                                
                                </asp:Label>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp;&nbsp;<span style="font-size:9pt; text-decoration:none;">
                                &nbsp; &nbsp; &nbsp;<asp:Label ID="ReqV_Comments" runat="server" ForeColor="Red"
                                        Text="* Request Comments Required for Revision Request" Width="260px" Visible="False"></asp:Label>
                                    &nbsp; </span>
                            </td>
                        </tr>
                         <tr>
                             <td align="left" style="width: 13%; height: 22px; text-align: left">
                                                <asp:Label ID="Label1" runat="server" Font-Names="Trebuchet MS"
                                                    Text="Next Level: "></asp:Label></td>
                             <td style="height: 22px" width="55%">
                                                <asp:DropDownList ID="ddNextLevel" runat="server" DataSourceID="dsNextLevel" DataTextField="txt_level_desc"
                                                    DataValueField="nbr_next_level_nbr" Width="457px" OnDataBound="ddNextLevel_DataBound" OnSelectedIndexChanged="ddNextLevel_SelectedIndexChanged" AutoPostBack="True">
                                                </asp:DropDownList><asp:HyperLink ID="HL_ErrorMessage" runat="server" ForeColor="Red">[HyperLink1]</asp:HyperLink></td>
                             <td align="right" style="width: 31%; height: 22px">
                                                <asp:Button
                                                    ID="btnPrint" runat="server" Text="Print" Width="51px" OnClientClick="openreportwindow();" Visible="False" /><asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" Width="100px" /><input id="PrintBtn" onclick="Javascript:openreportwindow();" type="button" value="Print" style="Width:100px; font-size: 9pt; font-family: 'Trebuchet MS';" /><asp:Button ID="btnExportToExcel"
                                                        runat="server" Text="Export to Excel" Width="100px" OnClick="btnExportToExcel_Click" /></td>
                         </tr>
       
                        <tr>
                            <td colspan="3">
                                <asp:Panel ID="panFundPlan" Visible="false" runat="server" Width="100%" style="text-align: left">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="3" style="height: 18px; border-top: royalblue 1px groove;">          
                                                <radTS:RadTabStrip ID="tsFundPlan" runat="server" Skin="ClassicBlue" style="margin-left: -0.05in" MultiPageID="RadMultiPage1">
                                                    <Tabs>
                                                        <radTS:Tab ID="Tab1" runat="server" Text="Funding Plan" PageViewID="pvFundPlan">
                                                        </radTS:Tab>
                                                        <radTS:Tab ID="Tab2" runat="server" Text="Activities/Amendments" PageViewID="pvActivities">
                                                        </radTS:Tab>
                                                        <radTS:Tab runat="server" Text="Comments">
                                                        </radTS:Tab>
                                                    </Tabs>
                                                </radTS:RadTabStrip>
                                            </td>
                                        </tr>
                                    </table>
                            <radTS:RadMultiPage ID="RadMultiPage1" runat="server" Width="100%">
                                <radTS:PageView ID="pvFundPlan" runat="server" Width="100%">
                                    <rad:RadGrid ID="gvFundingPlan" runat="server" GridLines="None"
                                        Skin="Default" EnableAJAX="True" OnItemDataBound="gvFundingPlan_ItemDataBound" Width="95%">
                                        
                                        <MasterTableView AutoGenerateColumns="False" ShowFooter="True">
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <rad:GridBoundColumn DataField="txt_category_code" HeaderText="Category" SortExpression="txt_category_code"
                                                    UniqueName="txt_category_code">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_function_code" HeaderText="Function" SortExpression="txt_function_code"
                                                    UniqueName="txt_function_code">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_category_title" HeaderText="Title" SortExpression="txt_category_title"
                                                    UniqueName="txt_category_title">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Salary" DataType="System.Decimal" HeaderText="(100) Salary"
                                                    ReadOnly="True" SortExpression="Salary" UniqueName="Salary" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in" />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Fixed Charges" DataType="System.Decimal" HeaderText="(200) Fixed Charges"
                                                    ReadOnly="True" SortExpression="Fixed Charges" UniqueName="Fixed Charges" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" Width="1in" />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in" />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Purchased Services" DataType="System.Decimal" HeaderText="(300) Purchased Services"
                                                    ReadOnly="True" SortExpression="Purchased Services" UniqueName="Purchased Services" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in" />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Instructional Supplies" DataType="System.Decimal"
                                                    HeaderText="(400) Instructional Supplies" ReadOnly="True" SortExpression="Instructional Supplies"
                                                    UniqueName="Instructional Supplies" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in" />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Equipment" DataType="System.Decimal" HeaderText="(500) Equipment"
                                                    ReadOnly="True" SortExpression="Equipment" UniqueName="Equipment" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in" />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="Indirect Costs" DataType="System.Decimal" HeaderText="(700) Indirect Costs"
                                                    ReadOnly="True" SortExpression="Indirect Costs" UniqueName="Indirect Costs" DataFormatString="{0:c}">
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" Width="0.7in" />
                                                </rad:GridBoundColumn>
                                                <rad:GridTemplateColumn HeaderText="Total" UniqueName="TemplateColumn">
                                                    <FooterTemplate>
                                                        <asp:Label ID="lblFooterSum" runat="server"></asp:Label>
                                                    </FooterTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSum" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                    <FooterStyle HorizontalAlign="Right" />
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" Width="1.1in" />
                                                </rad:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </rad:RadGrid> 
                                    <asp:SqlDataSource ID="dsFundPlan106" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                        SelectCommand="pr_lp_funding_plan_version_get" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbFundPlanVersion" Name="p_key_funding_plan_hdr_id"
                                                PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource><asp:SqlDataSource ID="dsFundPlan" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                        SelectCommand="pr_lp_funding_plan_version_dynamic_get" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbFundPlanVersion" Name="p_key_funding_plan_hdr_id"
                                                PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </radTS:PageView>
                                <radTS:PageView ID="pvActivities" runat="server" Width="100%">
                                    <asp:SqlDataSource ID="dsActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                        SelectCommand="pr_fp_activity_list_get" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbFundPlanVersion" Name="p_key_funding_plan_hdr_id"
                                                PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <rad:RadGrid ID="gvActivities" runat="server" DataSourceID="dsActivities" EnableAJAX="True"
                                        GridLines="None" Skin="Default" OnDataBound="gvActivities_DataBound" Width="95%">
                                        <ClientSettings AllowDragToGroup="True">
                                        </ClientSettings>
                                        
                    
                                        <MasterTableView DataSourceID="dsActivities" AutoGenerateColumns="False" DataKeyNames="key_activity_id">
                                            <Columns>
                                                <rad:GridTemplateColumn UniqueName="TemplateColumn">
                                                    <ItemStyle VerticalAlign="Top" Width="0.4in"  />
                                                    <ItemTemplate>
                                                        &nbsp;<asp:HyperLink ID="lbView" runat="server"   ImageUrl="~/images/Edit.gif">View</asp:HyperLink>
                                                    </ItemTemplate>
                                                </rad:GridTemplateColumn>
                                                <rad:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" HeaderText="#"
                                                    ReadOnly="True" SortExpression="key_activity_id" UniqueName="key_activity_id">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_activity_name" HeaderText="Activity Name" SortExpression="txt_activity_name"
                                                    UniqueName="txt_activity_name">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_activity_group" Display="False" HeaderText="txt_activity_group"
                                                    ReadOnly="True" SortExpression="txt_activity_group" UniqueName="txt_activity_group">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_activity_type_desc" HeaderText="Type" SortExpression="txt_activity_type_desc"
                                                    UniqueName="txt_activity_type_desc">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_category_title" Display="False" HeaderText="txt_category_title"
                                                    SortExpression="txt_category_title" UniqueName="txt_category_title">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="txt_function_code_desc" Display="False" HeaderText="txt_function_code_desc"
                                                    SortExpression="txt_function_code_desc" UniqueName="txt_function_code_desc">
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="nbr_activity_total" DataType="System.Decimal" HeaderText="Budget"
                                                    ReadOnly="True" SortExpression="nbr_activity_total" UniqueName="nbr_activity_total" DataFormatString="{0:C}">
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </rad:GridBoundColumn>
                                                <rad:GridBoundColumn DataField="nbr_activity_balance" DataType="System.Decimal" HeaderText="Balance"
                                                    ReadOnly="True" SortExpression="nbr_activity_balance" UniqueName="nbr_activity_balance" DataFormatString="{0:C}">
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </rad:GridBoundColumn>
                                                <rad:GridCheckBoxColumn DataField="flg_locked" DataType="System.Boolean" HeaderText="Locked"
                                                    SortExpression="flg_locked" UniqueName="flg_locked">
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </rad:GridCheckBoxColumn>
                                                <rad:GridCheckBoxColumn DataField="flg_approved" DataType="System.Boolean" HeaderText="Approved"
                                                    SortExpression="flg_approved" UniqueName="flg_approved">
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </rad:GridCheckBoxColumn>
                                                <rad:GridCheckBoxColumn DataField="flg_is_amendment" DataType="System.Boolean" Display="False"
                                                    HeaderText="flg_is_amendment" SortExpression="flg_is_amendment" UniqueName="flg_is_amendment">
                                                </rad:GridCheckBoxColumn>
                                                <rad:GridBoundColumn DataField="key_amendment_reason_id" DataType="System.Int32"
                                                    Display="False" HeaderText="key_amendment_reason_id" SortExpression="key_amendment_reason_id"
                                                    UniqueName="key_amendment_reason_id">
                                                </rad:GridBoundColumn>
                                            </Columns> 
                                            
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            
                                         
                    
                                        </MasterTableView>
                                        
                    
                    
                                    </rad:RadGrid><br />
                                    <br />
                                                <br />
                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                        SelectCommand="pr_lp_funding_plan_version_get" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbFundPlanVersion" Name="p_key_funding_plan_hdr_id"
                                                PropertyName="SelectedValue" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </radTS:PageView>
                                <radTS:PageView ID="pvComments" runat="server" Width="100%">
                                    <br />
                                                <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Width="98%" Height="196px"></asp:TextBox><br />
                                    <asp:Button ID="btn_Comments" runat="server" OnClick="btn_Comments_Click" Text="Save Comments" />
                                    <asp:SqlDataSource ID="SQLDS_SaveComments" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                        ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
                                        UpdateCommand="pr_fp_funding_plan_comments_upd" UpdateCommandType="StoredProcedure">
                                        <UpdateParameters>
                                            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                            <asp:ControlParameter ControlID="hf_fundingPlanid" Name="key_funding_plan_hdr_id"
                                                PropertyName="Value" Type="Int32" />
                                            <asp:ControlParameter ControlID="txtComments" Name="txt_comments" PropertyName="Text"
                                                Type="String" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                    &nbsp;
                                    <br />
                                </radTS:PageView>
                            </radTS:RadMultiPage>
                                    
                                    
                                        
                                </asp:Panel>
                                <span style="font-size:9pt; text-decoration:none;">
                                    <asp:HyperLink ID="HL_RPLIST" runat="server" Font-Bold="False" ForeColor="Blue" NavigateUrl="javascript:openreportwindow();"
                                    Style="left: 39px; top: -406px" Visible="False">[Print Reports]</asp:HyperLink>
                                </span></td>
                        </tr>
                     
                        <tr>
                            <td colspan="3">
                                <asp:HiddenField ID="hfLocal_plan_id" runat="server" />
                                                <asp:SqlDataSource ID="dsFundPlanVersion" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                                    SelectCommand="pr_fp_lp_funding_plan_list_get" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="hfLocal_plan_id" DefaultValue="-1" Name="p_key_local_plan_id"
                                                            PropertyName="Value" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:SqlDataSource ID="dsHdr" runat="server"></asp:SqlDataSource>
                                                <asp:Label ID="lblLevel" runat="server" Visible="False"></asp:Label><asp:SqlDataSource ID="dsNextLevel" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                                    SelectCommand="pr_fp_plan_next_level_get" SelectCommandType="StoredProcedure">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="p_nbr_current_lp_next_level_nbr" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource><asp:HiddenField ID="hf_fundingPlanid" runat="server" />
                                <asp:HiddenField ID="hf_categoryid" runat="server" />
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
                         <radw:RadWindow ID="littlepop"  runat="server" Title="Error Report" Height="325px" Modal="true"
                          Width="300px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="10px" Left="" />
              
     </Windows>
    </radW:RadWindowManager>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

