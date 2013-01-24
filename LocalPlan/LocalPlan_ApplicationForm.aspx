<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LocalPlan_ApplicationForm.aspx.cs" Inherits="LocalPlan_LocalPlan_ApplicationForm" %>

<%@ Register Assembly="Microsoft.Web.Atlas" Namespace="Microsoft.Web.UI" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--Create Date: RL 11-13-2007 -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Perkins Application</title>
    <link rel="stylesheet" type="text/css" href="LocalPlan_application.css" />
    <link id="WhichOne" rel="stylesheet" type="text/css" runat="server" />

</head>

<body style="background-color: #ffffff" >   
    <div id="FundHEADER" class="HEADER">
       
    <label class="Headers">Appendix C: Uses of Funds Activity Form 2A</label><br />
    <label class="Headers">Perkins IV Local Plan Application</label>
    <br />
      
    
        <asp:Label CssClass="SubHeaders" ID="lbl_FY" runat="server" Text="FY"></asp:Label><span
            style="font-size: 1.2em; font-family: Verdana"><span style="font-size: 18pt">&nbsp;</span><span
                style="font-size: 10pt"><span style="font-size: 9pt"> </span><span style="font-size: 9pt">
        
        <span class="fundsspan" style="font-size: 18pt"><label class="SubHeaders">Use of Funds Activity Form(Form 2A)</label></span>
        <span class="equipspan"><label class="SubHeaders">Use of Equipment Activity Form(Form 2A)</label></span> </span>
            </span></span>
    </div>
   

<div id="PageContainer"> &nbsp;<form id="form1" runat="server">
   
        <div id="activity">
        <label>Activity Type &nbsp;</label>&nbsp<asp:DropDownList ID="DLB_ActType" runat="server" DataSourceID="SDS_ActivityType" DataTextField="txt_activity_type_desc" DataValueField="key_activity_type_id" Width="142px" AutoPostBack="True" OnDataBound="DLB_ActType_DataBound" OnSelectedIndexChanged="DLB_ActType_SelectedIndexChanged">
        </asp:DropDownList>
        <br />
       <label>Activity Name</label>&nbsp<asp:TextBox ID="TextBox1" runat="server" Width="142px"></asp:TextBox>
        </div>
     <div id="useoffund">
     <label>Use of Funds:</label>&nbsp
         <asp:RadioButtonList ID="RadioButtonList1" runat="server">
         </asp:RadioButtonList>
         
      </div>  <br /> 
         <div id="category">
         <label>Category:</label>&nbsp<asp:DropDownList ID="DLB_Category" runat="server" DataSourceID="SDS_Category" DataTextField="txt_category_title" DataValueField="key_category_id" Width="212px">
         </asp:DropDownList>
         <label>Function Code:</label>&nbsp<asp:DropDownList ID="DLB_FunCode" runat="server" DataSourceID="SDS_FunctionCODE" DataTextField="txt_function_code_desc" DataValueField="key_function_code_id" Width="142px">
         </asp:DropDownList>
         <br />
             <asp:RadioButtonList ID="RadioButtonList2" runat="server" DataSourceID="SDS_radiostuff"
                 DataTextField="txt_fa_activity_desc" DataValueField="key_fa_activity_type_id"
                 Style="position: relative" RepeatDirection="Horizontal">
             </asp:RadioButtonList></div>&nbsp
     
     
     <div id="coreindicators">
     <label>Core Indicatior(s) Being Addressed:</label><br />
         <radG:RadGrid ID="TRG_CoreIndicators" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateColumns="False" EnableAJAX="True" GridLines="None" DataSourceID="SDS_CoreIndicators" ShowStatusBar="True" Skin="Telerik" Width="222px">
             <MasterTableView CommandItemDisplay="Bottom" DataSourceID="SDS_CoreIndicators">
                 <ExpandCollapseColumn Visible="False">
                     <HeaderStyle Width="19px" />
                 </ExpandCollapseColumn>
                 <RowIndicatorColumn Visible="False">
                     <HeaderStyle Width="20px" />
                 </RowIndicatorColumn>
                 <NoRecordsTemplate>
                     No Records to Display
                 </NoRecordsTemplate>
                 <Columns>
                     <radG:GridTemplateColumn UniqueName="TemplateColumn">
                     </radG:GridTemplateColumn>
                 </Columns>
             
             </MasterTableView>
             <CommandItemStyle VerticalAlign="Bottom" />
             <EditItemStyle VerticalAlign="Bottom" />
         </radG:RadGrid>
     </div>
     <div id="activityDescription">
    <label> Description of Activity (Proposed Use of Funds):</label>
         <asp:TextBox ID="txt_activityDescription" runat="server" Height="216px" TextMode="MultiLine" Width="100%" ></asp:TextBox>
     
     </div>
     <div id="ActivityDesciption_meetsindicator">
     <label>Description of how the activity helps meet the core indicator:</label><br />
       <asp:TextBox ID="txt_ActivitMeetsIndicator" runat="server" Height="216px" TextMode="MultiLine" Width="100%" CssClass="txtBox" EnableTheming="False"  ></asp:TextBox>
     
     </div>
     <div id="funds">
     <label>Budgeted Funds for Activity:</label><span style="display:inline-block;width:40%"></span><label>Total: $</label><asp:Label
         ID="lbl_FundTotal" runat="server" Text=""></asp:Label><br />
         &nbsp;<asp:ScriptManager ID="ScriptManager2" runat="server">
         </asp:ScriptManager>
         <radG:RadGrid ID="TRG_Funds" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AutoGenerateColumns="False" EnableAJAX="True" GridLines="None" Width="406px" DataSourceID="SDS_ActivityBudgetFunds" Skin="Telerik">
             <MasterTableView DataKeyNames="key_line_item_type_id" DataSourceID="SDS_ActivityBudgetFunds">
                 <Columns>
                     <radG:GridBoundColumn DataField="key_line_item_type_id" DataType="System.Int32" HeaderText="Key"
                         ReadOnly="True" SortExpression="key_line_item_type_id" UniqueName="key_line_item_type_id"
                         Visible="False">
                     </radG:GridBoundColumn>
                     <radG:GridBoundColumn DataField="txt_line_item_desc" HeaderText="Fund"
                         SortExpression="Fund" UniqueName="txt_line_item_desc">
                     </radG:GridBoundColumn>
                     <radG:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Amount">
                         <ItemTemplate>
                             &nbsp;<asp:TextBox ID="txt_Funds" runat="server" Style="position: relative"></asp:TextBox>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_Funds"
                                 ErrorMessage="Value Must be Currency  " Style="position: relative" ValidationExpression="^\$?[0-9]+(,[0-9]{3})*(\.[0-9]{2})?$"></asp:RegularExpressionValidator>
                             &nbsp;
                         </ItemTemplate>
                     </radG:GridTemplateColumn>
                 </Columns>
                 <ExpandCollapseColumn Visible="False">
                     <HeaderStyle Width="19px" />
                 </ExpandCollapseColumn>
                 <RowIndicatorColumn Visible="False">
                     <HeaderStyle Width="20px" />
                 </RowIndicatorColumn>
             </MasterTableView>
         </radG:RadGrid>&nbsp;
     </div>
       
    </form></div> 
         <asp:SqlDataSource ID="SDS_CoreIndicators" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT key_core_indicator_id, txt_core_indiciator_code, txt_core_indicator_name, txt_core_indicator_desc, flg_inactive, dte_created_date, txt_created_user, dte_updated_date, txt_updated_user FROM scs_core_indicator WHERE ( @key = - 1) OR (key_core_indicator_id = @key )">
             <SelectParameters>
                 <asp:Parameter DefaultValue="11" Name="key" />
             </SelectParameters>
         </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_Category" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
        SelectCommand="pr_scs_category_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_FunctionCODE" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_function_code_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_ActivityType" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT [key_activity_type_id], [txt_activity_type_desc], [dte_created_date], [key_created_user_id], [dte_updated_date], [key_updated_user_id] FROM [scs_activity_type]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_radiostuff" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_fa_activity_type_get" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_ActivityBudgetFunds" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_line_item_type_desc_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="p_key_line_item_type_id" Type="Int32" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>
</body>
</html>
