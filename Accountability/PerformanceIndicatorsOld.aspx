<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="PerformanceIndicatorsOld.aspx.cs" Inherits="Accountability_PerformanceIndicators" Title="Untitled Page" %>

<%@ Register Assembly="RadInput.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server" >
<script language="javascript" type="text/javascript">

function tabClicked(sender, eventArgs)
{
  var tabStrip = sender;
  var tab = eventArgs.Tab;
  var hdnSelectedvalue = document.getElementById('<%= hdn_tabselectedValue.ClientID %>');
  hdnSelectedvalue.value = tab.Value;

 // alert( tab.Value +  tabStrip.ID );
}


function do_calulation_checks (radgrid, totalvalue)
{

}
function copyperformancenumbers(controlname, gridname,rownumber,controlnamecollection)
{
try
{
   var radgrid =  document.getElementById(gridname);
    var radtextbox = document.getElementById(controlname);
    
    var newallvalue = radtextbox.value;
  //  var rowposi = document.getElementById(radgrid).rows;
        //alert(radtextbox.value);
        //alert(gridname);
      //  var temp = radgrid.get_dataItems().Rows.length; 
     //   alert(temp);
    //    for(var i = 0; i< radgrid.rows.length;i++)
    //    {
     //   }
     var splitresults = controlnamecollection.split(",");
     for(var i =0; i< splitresults.length-1; i++)
     {
        alert(splitresults[i]);
        var radgridelement =  document.getElementById(splitresults[i]);
 
        radgridelement.value= newallvalue;
  //radgridelement.text(newallvalue);
 //radgridelement.Text  = newallvalue;
        alert(radgridelement.value);
     }
       // alert(rowcollection);
 }
 catch(err)
 {
 alert("Client Error" + err);
 }
     
}
</script>

    <asp:Label ID="lbl_CurrfiscalYear" runat="server" Text="Label"></asp:Label><br />
    <rad:RadTabStrip ID="rdt_PerfIndcat" runat="server" Skin="MySite" Width="884px" CausesValidation="False" MultiPageID="RadMultiPage1" DataSourceID="SqlDS_ACCT_Tabs" DataTextField="txt_core_indicator_abbrv" DataValueField="key_core_indicator_id" OnClientTabSelected="tabClicked" SelectedIndex="0">
        <Tabs>
            <rad:Tab runat="server" Text="1p1" PageViewID="pg_1p1">
            </rad:Tab>
            <rad:Tab runat="server" Text="2p1" PageViewID="pg_2p1">
            </rad:Tab>
            <rad:Tab runat="server" Text="3p1" PageViewID="pg_3p1">
            </rad:Tab>
            <rad:Tab runat="server" Text="4p1" PageViewID="pg_4p1">
            </rad:Tab>
            <rad:Tab runat="server" Text="5p1" PageViewID="pg_5p1">
            </rad:Tab>
            <rad:Tab runat="server" Text="5p2" PageViewID="pg_5p2">
            </rad:Tab>
        </Tabs>
    </rad:RadTabStrip>
    <rad:RadMultiPage ID="RadMultiPage1" runat="server" Width="100%">
        <rad:PageView ID="pg_1p1" runat="server" >
       <table style="width:100%;">
       <tr><td>
           <rad:RadGrid ID="rdg_grandtotal" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDS_GrandTotalsTOP_GRid"
               GridLines="None" Skin="Default">
               <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
               </ClientSettings>
               <MasterTableView DataSourceID="SqlDS_GrandTotalsTOP_GRid">
                   <RowIndicatorColumn>
                       <HeaderStyle Width="20px" />
                   </RowIndicatorColumn>
                   <ExpandCollapseColumn>
                       <HeaderStyle Width="20px" />
                   </ExpandCollapseColumn>
                   <Columns>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn" Visible="False">
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn HeaderText="Population" UniqueName="TemplateColumn">
                           <ItemTemplate>
                               <asp:Label ID="Label8" runat="server" Text="Grand Total"></asp:Label>
                           </ItemTemplate>
                           <ItemStyle Width="40%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn HeaderText="# of Students in the Numerator" UniqueName="TemplateColumn">
                           <ItemTemplate>
                               <rad:RadNumericTextBox ID="nbr_students_numeratortext" runat="server" Culture="English (United States)"
                                   DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                                   Skin="" Width="80%">
                                   <NumberFormat AllowRounding="True" />
                               </rad:RadNumericTextBox>
                           </ItemTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn HeaderText="# of Students in the Denominator" UniqueName="TemplateColumn">
                           <ItemTemplate>
                               <rad:RadNumericTextBox ID="nbr_student_denominatortext" runat="server" Culture="English (United States)"
                                   DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default"
                                   Skin="" Width="80%">
                                   <NumberFormat AllowRounding="True" />
                               </rad:RadNumericTextBox>
                           </ItemTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn HeaderText="State Adjusted Level of Performance" UniqueName="TemplateColumn">
                           <ItemTemplate>
                               <rad:RadNumericTextBox ID="RadNumericTextBox1" runat="server" Width="80%">
                                   <NumberFormat AllowRounding="True" />
                               </rad:RadNumericTextBox>
                           </ItemTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn HeaderText="Actual Level of Performance" UniqueName="TemplateColumn">
                           <ItemTemplate>
                               <asp:Label ID="Label71" runat="server" Text="0"></asp:Label>
                           </ItemTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn HeaderText="Adjusted vs. Actual Level of Performance" UniqueName="TemplateColumn">
                           <ItemTemplate>
                               <asp:Label ID="Label72" runat="server" Text="0"></asp:Label>
                           </ItemTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn HeaderText="Met 90% of Adjusted Level of Performance (Y,N)"
                           UniqueName="TemplateColumn">
                           <ItemTemplate>
                               <asp:Label ID="Label73" runat="server" Text="0"></asp:Label>
                           </ItemTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                   </Columns>
               </MasterTableView>
           </rad:RadGrid></td></tr>
       <tr>
       <td>
           <rad:RadGrid ID="rdg_Gender" runat="server" DataSourceID="SqlDS_Gender" GridLines="None" ShowFooter="True" EnableAJAX="True" AllowAutomaticUpdates="True"  Skin="Default" ShowHeader="False" OnItemDataBound="gridDataBinds_ItemDataBound" >
               <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_gender_id" DataSourceID="SqlDS_Gender"  >
                   <RowIndicatorColumn>
                       <HeaderStyle Width="20px" />
                   </RowIndicatorColumn>
                   <ExpandCollapseColumn>
                       <HeaderStyle Width="20px" />
                   </ExpandCollapseColumn>
                   <Columns>
                       <rad:GridBoundColumn DataField="key_acct_gender_id" DataType="System.Int32"
                           ReadOnly="True" SortExpression="key_acct_gender_id" UniqueName="key_acct_gender_id" Visible="False">
                           <ItemStyle Width="30px" />
                       </rad:GridBoundColumn>
                       <rad:GridBoundColumn DataField="txt_gender_name" HeaderText="Population" SortExpression="txt_gender_name"
                           UniqueName="txt_gender_name">
                           <ItemStyle Width="40%" />
                       </rad:GridBoundColumn>
                       <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                           HeaderText="# Student Numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                           <EditItemTemplate>
                               <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>' Width="12%" ></asp:TextBox>&nbsp;
                           </EditItemTemplate>
                           <ItemTemplate>
                               &nbsp;<rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)" DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default" Skin="" Width="80%">
                                   <NumberFormat AllowRounding="True" DecimalDigits="0" />
                               </rad:RadNumericTextBox>
                           </ItemTemplate>
                           <FooterTemplate>
                           <asp:Label ID="lbl_genderNUMSum" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                           HeaderText="# Student Denominator" SortExpression="nbr_student_denominator"
                           UniqueName="nbr_student_denominator">
                           <EditItemTemplate>
                               <asp:TextBox ID="nbr_student_denominatorTextBox" runat="server" Text='<%# Bind("nbr_student_denominator") %>'></asp:TextBox>
                           </EditItemTemplate>
                           <ItemTemplate>
                               &nbsp;<rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)"
                                   DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default"
                                   Skin="" Width="80%">
                                   <NumberFormat AllowRounding="True" DecimalDigits="0" />
                               </rad:RadNumericTextBox>
                           </ItemTemplate>
                            <FooterTemplate>
                           <asp:Label ID="lbl_genderDENSum" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Adjusted Level of Performance">
                         <ItemTemplate><rad:RadNumericTextBox ID="adjustedPerformance" runat="server" Culture="English (United States)" LabelCssClass="radLabelCss_Default"
                                 MinValue="0" Skin="" Width="80%">
                             <NumberFormat AllowRounding="True" />
                         </rad:RadNumericTextBox>
                         </ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lb12ltotal" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Actual Level of Performance">
                       <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                         <FooterTemplate>
                           <asp:Label ID="lbl13total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Adjusted vs Actuall Performance">
                       <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lbl14total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Met 90% Adjusted Level of Performance (Y,N)">
                       <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lbl15total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                      
                   </Columns>
               
               </MasterTableView>
           </rad:RadGrid>
       </td></tr>
     <tr><td>
     <rad:RadGrid ID="rdg_Race" runat="server" ShowHeader="False" DataSourceID="SqlDS_Race" GridLines="None" ShowFooter="True" EnableAJAX="True" Skin="Default" OnItemDataBound="gridDataBinds_ItemDataBound">
         <MasterTableView DataSourceID="SqlDS_Race" AutoGenerateColumns="False" DataKeyNames="key_acct_race_id">
             <RowIndicatorColumn>
                 <HeaderStyle Width="20px" />
             </RowIndicatorColumn>
             <ExpandCollapseColumn>
                 <HeaderStyle Width="20px" />
             </ExpandCollapseColumn>
             <Columns>
                 <rad:GridBoundColumn DataField="key_acct_race_id" DataType="System.Int32" HeaderText="key_acct_race_id"
                     ReadOnly="True" SortExpression="key_acct_race_id" UniqueName="key_acct_race_id" Visible="False">
                     <ItemStyle Width="20px" />
                 </rad:GridBoundColumn>
                 <rad:GridBoundColumn DataField="txt_race_name" HeaderText="txt_race_name" SortExpression="txt_race_name"
                     UniqueName="txt_race_name" > <ItemStyle Width="40%" />
                 </rad:GridBoundColumn>
                 <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                     HeaderText="nbr_students_numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                     <EditItemTemplate>
                         <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         &nbsp;<rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)"
                             DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                             Skin="" Width="80%">
                             <NumberFormat AllowRounding="True" DecimalDigits="0" />
                         </rad:RadNumericTextBox>
                     </ItemTemplate>
                      <FooterTemplate>
                           <asp:Label ID="lbl_RaceNUMSum" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                     <ItemStyle Width="10%" />
                 </rad:GridTemplateColumn>
                 <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                     HeaderText="nbr_student_denominator" SortExpression="nbr_student_denominator"
                     UniqueName="nbr_student_denominator">
                     <EditItemTemplate>
                         <asp:TextBox ID="nbr_student_denominatorTextBox" runat="server" Text='<%# Bind("nbr_student_denominator") %>'></asp:TextBox>
                     </EditItemTemplate>
                     <ItemTemplate>
                         &nbsp;<rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)"
                             DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default"
                             Skin="" Width="80%">
                             <NumberFormat AllowRounding="True" DecimalDigits="0" />
                         </rad:RadNumericTextBox>
                     </ItemTemplate>
                      <FooterTemplate>
                           <asp:Label ID="lbl_RaceDENSum" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                     <ItemStyle Width="10%" />
                 </rad:GridTemplateColumn>
                 
                  <rad:GridTemplateColumn UniqueName="TemplateColumn">
                         <ItemTemplate><rad:RadNumericTextBox ID="adjustedPerformance" runat="server" Culture="English (United States)" LabelCssClass="radLabelCss_Default"
                                 MinValue="0" Skin="" Width="80%">
                             <NumberFormat AllowRounding="True" />
                         </rad:RadNumericTextBox>
                         </ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lb12ltotal" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                      <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn">
                       <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                         <FooterTemplate>
                           <asp:Label ID="lbl13total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn">
                       <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lbl14total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn">
                       <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lbl15total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                 
                 
                 
             </Columns>
         </MasterTableView>
     </rad:RadGrid></td></tr>
        <tr><td><rad:RadGrid ID="rdg_SpecPOPs" runat="server" ShowHeader="False" DataSourceID="SqlDS_SpecPop" GridLines="None" ShowFooter="True" EnableAJAX="True" Skin="Default" OnItemDataBound="gridDataBinds_ItemDataBound" OnDataBound="RadGrid_DataBound">
            <MasterTableView DataSourceID="SqlDS_SpecPop" AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id">
                <RowIndicatorColumn>
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="20px" />
                </ExpandCollapseColumn>
                <Columns>
                    <rad:GridBoundColumn DataField="key_acct_spec_population_id" DataType="System.Int32"
                        HeaderText="key_acct_spec_population_id" ReadOnly="True" SortExpression="key_acct_spec_population_id"
                        UniqueName="key_acct_spec_population_id" Visible="False">
                        <ItemStyle Width="20px" />
                    </rad:GridBoundColumn>
                    <rad:GridBoundColumn DataField="txt_desc" HeaderText="txt_desc" SortExpression="txt_desc"
                        UniqueName="txt_desc" >
                        <ItemStyle Width="40%" />
                    </rad:GridBoundColumn>
                    <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                        HeaderText="nbr_students_numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            &nbsp;<rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)"
                                DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                                Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                         <FooterTemplate>
                           <asp:Label ID="lbl_SpecialPOPNUMSum" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                        HeaderText="nbr_student_denominator" SortExpression="nbr_student_denominator"
                        UniqueName="nbr_student_denominator" >
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_student_denominatorTextBox" runat="server" Text='<%# Bind("nbr_student_denominator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            &nbsp;<rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)" DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                         <FooterTemplate>
                           <asp:Label ID="lbl_SpecialPOPSDENSum" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    
                    
                     <rad:GridTemplateColumn UniqueName="nbr_adjusted_level_of_performance" DataField="nbr_adjusted_level_of_performance" HeaderText="nbr_adjusted_level_of_performance">
                         <ItemTemplate  >
                             <rad:RadNumericTextBox ID="adjustedPerformance" runat="server" Culture="English (United States)"
                                 DbValue='<%# Bind("nbr_adjusted_level_of_performance") %>' LabelCssClass="radLabelCss_Default"
                                 MinValue="0" Skin="" Width="80%" AutoPostBack="True" OnTextChanged="adjustedPerformance_TextChanged">
                                 <NumberFormat AllowRounding="True" />
                             </rad:RadNumericTextBox>
                         </ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lb12ltotal" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                         <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn">
                       <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("nbr_actual_level_of_performance") %>' Width="40px"></asp:Label></ItemTemplate>
                         <FooterTemplate>
                           <asp:Label ID="lbl13total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn">
                       <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("nbr_perfomance_variance") %>' Width="40px"></asp:Label></ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lbl14total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                       <rad:GridTemplateColumn UniqueName="TemplateColumn">
                       <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("flg_performance_level_pass") %>' Width="40px"></asp:Label></ItemTemplate>
                              <FooterTemplate>
                           <asp:Label ID="lbl15total" runat="server" Text="0"></asp:Label>
                           </FooterTemplate>
                           <ItemStyle Width="10%" />
                       </rad:GridTemplateColumn>
                    
                    
                    
                </Columns>
            </MasterTableView>
        </rad:RadGrid></td></tr>
       </table>
            <br />
            <asp:SqlDataSource ID="SqlDS_ACCT_Tabs" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT     key_core_indicator_id, txt_core_indiciator_code + ' ' + txt_core_indicator_abbrv AS txt_core_indicator_abbrv&#13;&#10;FROM         dbo.scs_core_indicator&#13;&#10;"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_Gender" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_accountability_gender_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_gender_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txt_AcctID" Name="p_key_accountability_id" PropertyName="Text"
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:Parameter Name="p_key_acct_gender_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_Race" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_accountability_race_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_race_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txt_AcctID" Name="p_key_accountability_id" PropertyName="Text"
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_race_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_SpecPop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="p_key_core_indicator_id" Type="Int32" DefaultValue="101" />
                    <asp:ControlParameter ControlID="txt_AcctID" DefaultValue="" Name="p_key_accountability_id"
                        PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_spec_population_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                    <asp:Parameter Name="p_nbr_adjusted_level_of_performance" Type="Decimal" />
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource><asp:SqlDataSource ID="SqlDS_GrandTotalsTOP_GRid" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT key_acct_gdTotal_id, key_accountability_id, nbr_students_numerator, nbr_student_denominator, dte_date_created, dte_date_updated, txt_updated_by, txt_created_by FROM acc_accountability_GrandTotals" CacheExpirationPolicy="Sliding">
            </asp:SqlDataSource>
            <br />
            
            
            </rad:PageView>
        <rad:PageView ID="pg_2p1" runat="server"><rad:RadGrid ID="rdg_SpecPOPs2p1" runat="server" ShowHeader="False" DataSourceID="ds_2p1_Spec_Pop" GridLines="None" ShowFooter="True" EnableAJAX="True" Skin="Default">
            <MasterTableView DataSourceID="ds_2p1_Spec_Pop" AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id">
                <RowIndicatorColumn>
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="20px" />
                </ExpandCollapseColumn>
                <Columns>
                    <rad:GridBoundColumn DataField="key_acct_spec_population_id" DataType="System.Int32"
                        HeaderText="key_acct_spec_population_id" ReadOnly="True" SortExpression="key_acct_spec_population_id"
                        UniqueName="key_acct_spec_population_id" Visible="False">
                    </rad:GridBoundColumn>
                    <rad:GridBoundColumn DataField="txt_desc" HeaderText="txt_desc" SortExpression="txt_desc"
                        UniqueName="txt_desc">
                        <ItemStyle Width="40%" />
                    </rad:GridBoundColumn>
                    <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                        HeaderText="nbr_students_numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                        <ItemTemplate>
                            &nbsp;<rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)"
                                DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                                Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                        HeaderText="nbr_student_denominator" SortExpression="nbr_student_denominator"
                        UniqueName="nbr_student_denominator">
                        <ItemTemplate>
                            &nbsp;<rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)" DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn UniqueName="TemplateColumn">
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="adjustedPerformance" runat="server" Culture="English (United States)"
                                 DbValue='<%# Bind("nbr_adjusted_level_of_performance") %>' LabelCssClass="radLabelCss_Default"
                                 MinValue="0" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                    </rad:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </rad:RadGrid><br />
            1
            <asp:SqlDataSource ID="ds_2p1_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="102" Name="p_key_core_indicator_id" Type="Int32" />
                    <asp:ControlParameter ControlID="txt_AcctID" DefaultValue="" Name="p_key_accountability_id"
                        PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_spec_population_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            &nbsp;<br />
            &nbsp;</rad:PageView>
        <rad:PageView ID="pg_3p1" runat="server"><rad:RadGrid ID="rdg_SpecPOPs3p1" runat="server" ShowHeader="False" DataSourceID="ds_3p1_Spec_Pop" GridLines="None" ShowFooter="True" EnableAJAX="True" Skin="Default">
            <MasterTableView DataSourceID="ds_3p1_Spec_Pop" AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id">
                <RowIndicatorColumn>
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="20px" />
                </ExpandCollapseColumn>
                <Columns>
                    <rad:GridBoundColumn DataField="key_acct_spec_population_id" DataType="System.Int32"
                        HeaderText="key_acct_spec_population_id" ReadOnly="True" SortExpression="key_acct_spec_population_id"
                        UniqueName="key_acct_spec_population_id" Visible="False">
                    </rad:GridBoundColumn>
                    <rad:GridBoundColumn DataField="txt_desc" HeaderText="txt_desc" SortExpression="txt_desc"
                        UniqueName="txt_desc">
                        <ItemStyle Width="40%" />
                    </rad:GridBoundColumn>
                    <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                        HeaderText="nbr_students_numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)"
                                DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                                Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                        HeaderText="nbr_student_denominator" SortExpression="nbr_student_denominator"
                        UniqueName="nbr_student_denominator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_student_denominatorTextBox" runat="server" Text='<%# Bind("nbr_student_denominator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)" DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn UniqueName="TemplateColumn">
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="adjustedPerformance" runat="server" Culture="English (United States)"
                                 DbValue='<%# Bind("nbr_adjusted_level_of_performance") %>' LabelCssClass="radLabelCss_Default"
                                 MinValue="0" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                    </rad:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </rad:RadGrid><br />
            2<asp:SqlDataSource ID="ds_3p1_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="103" Name="p_key_core_indicator_id" Type="Int32" />
                    <asp:ControlParameter ControlID="txt_AcctID" DefaultValue="" Name="p_key_accountability_id"
                        PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_spec_population_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            &nbsp;<br />
        </rad:PageView>
        <rad:PageView ID="pg_4p1" runat="server"><rad:RadGrid ID="rdg_SpecPOPs4p1" runat="server" ShowHeader="False" DataSourceID="ds_4p1_Spec_Pop" GridLines="None" ShowFooter="True" EnableAJAX="True" Skin="Default">
            <MasterTableView DataSourceID="ds_4p1_Spec_Pop" AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id">
                <RowIndicatorColumn>
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="20px" />
                </ExpandCollapseColumn>
                <Columns>
                    <rad:GridBoundColumn DataField="key_acct_spec_population_id" DataType="System.Int32"
                        HeaderText="key_acct_spec_population_id" ReadOnly="True" SortExpression="key_acct_spec_population_id"
                        UniqueName="key_acct_spec_population_id" Visible="False">
                    </rad:GridBoundColumn>
                    <rad:GridBoundColumn DataField="txt_desc" HeaderText="txt_desc" SortExpression="txt_desc"
                        UniqueName="txt_desc">
                        <ItemStyle Width="40%" />
                    </rad:GridBoundColumn>
                    <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                        HeaderText="nbr_students_numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)"
                                DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                                Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                        HeaderText="nbr_student_denominator" SortExpression="nbr_student_denominator"
                        UniqueName="nbr_student_denominator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_student_denominatorTextBox" runat="server" Text='<%# Bind("nbr_student_denominator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)" DbValue='<%# (Eval("nbr_student_denominator") ?? 0) %>' LabelCssClass="radLabelCss_Default" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn UniqueName="column">
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="adjustedPerformance" runat="server" Culture="English (United States)"
                                 DbValue='<%# Bind("nbr_adjusted_level_of_performance") %>' LabelCssClass="radLabelCss_Default"
                                 MinValue="0" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                    </rad:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </rad:RadGrid><br />
            3<asp:SqlDataSource ID="ds_4p1_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="104" Name="p_key_core_indicator_id" Type="Int32" />
                    <asp:ControlParameter ControlID="txt_AcctID" DefaultValue="" Name="p_key_accountability_id"
                        PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_spec_population_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            &nbsp;</rad:PageView>
        <rad:PageView ID="pg_5p1" runat="server"><rad:RadGrid ID="rdg_SpecPOPs5p1" runat="server" ShowHeader="False" DataSourceID="ds_5p1_Spec_Pop" GridLines="None" ShowFooter="True" EnableAJAX="True" Skin="Default">
            <MasterTableView DataSourceID="ds_5p1_Spec_Pop" AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id">
                <RowIndicatorColumn>
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="20px" />
                </ExpandCollapseColumn>
                <Columns>
                    <rad:GridBoundColumn DataField="key_acct_spec_population_id" DataType="System.Int32"
                        HeaderText="key_acct_spec_population_id" ReadOnly="True" SortExpression="key_acct_spec_population_id"
                        UniqueName="key_acct_spec_population_id" Visible="False">
                    </rad:GridBoundColumn>
                    <rad:GridBoundColumn DataField="txt_desc" HeaderText="txt_desc" SortExpression="txt_desc"
                        UniqueName="txt_desc">
                        <ItemStyle Width="40%" />
                    </rad:GridBoundColumn>
                    <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                        HeaderText="nbr_students_numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)"
                                DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                                Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                        HeaderText="nbr_student_denominator" SortExpression="nbr_student_denominator"
                        UniqueName="nbr_student_denominator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_student_denominatorTextBox" runat="server" Text='<%# Bind("nbr_student_denominator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)" DbValue='<%# (Eval("nbr_student_denominator") ?? 0) %>' LabelCssClass="radLabelCss_Default" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn UniqueName="TemplateColumn">
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="adjustedPerformance" runat="server" Culture="English (United States)"
                                 DbValue='<%# Bind("nbr_adjusted_level_of_performance") %>' LabelCssClass="radLabelCss_Default"
                                 MinValue="0" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                    </rad:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </rad:RadGrid><br />
            4<asp:SqlDataSource ID="ds_5p1_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="105" Name="p_key_core_indicator_id" Type="Int32" />
                    <asp:ControlParameter ControlID="txt_AcctID" DefaultValue="" Name="p_key_accountability_id"
                        PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_spec_population_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </rad:PageView>
        <rad:PageView ID="pg_5p2" runat="server"><rad:RadGrid ID="rdg_SpecPOPs5p2" runat="server" ShowHeader="False" DataSourceID="ds_5p2_Spec_Pop" GridLines="None" ShowFooter="True" EnableAJAX="True" Skin="Default">
            <MasterTableView DataSourceID="ds_5p2_Spec_Pop" AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id">
                <RowIndicatorColumn>
                    <HeaderStyle Width="20px" />
                </RowIndicatorColumn>
                <ExpandCollapseColumn>
                    <HeaderStyle Width="20px" />
                </ExpandCollapseColumn>
                <Columns>
                    <rad:GridBoundColumn DataField="key_acct_spec_population_id" DataType="System.Int32"
                        HeaderText="key_acct_spec_population_id" ReadOnly="True" SortExpression="key_acct_spec_population_id"
                        UniqueName="key_acct_spec_population_id" Visible="False">
                    </rad:GridBoundColumn>
                    <rad:GridBoundColumn DataField="txt_desc" HeaderText="txt_desc" SortExpression="txt_desc"
                        UniqueName="txt_desc">
                        <ItemStyle Width="40%" />
                    </rad:GridBoundColumn>
                    <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                        HeaderText="nbr_students_numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)"
                                DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                                Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                        HeaderText="nbr_student_denominator" SortExpression="nbr_student_denominator"
                        UniqueName="nbr_student_denominator">
                        <EditItemTemplate>
                            <asp:TextBox ID="nbr_student_denominatorTextBox" runat="server" Text='<%# Bind("nbr_student_denominator") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)" DbValue='<%# (Eval("nbr_student_denominator") ?? 0) %>' LabelCssClass="radLabelCss_Default" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" DecimalDigits="0" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                        <ItemStyle Width="10%" />
                    </rad:GridTemplateColumn>
                    <rad:GridTemplateColumn UniqueName="TemplateColumn">
                        <ItemTemplate>
                            <rad:RadNumericTextBox ID="adjustedPerformance" runat="server" Culture="English (United States)"
                                 DbValue='<%# Bind("nbr_adjusted_level_of_performance") %>' LabelCssClass="radLabelCss_Default"
                                 MinValue="0" Skin="" Width="80%">
                                <NumberFormat AllowRounding="True" />
                            </rad:RadNumericTextBox>
                        </ItemTemplate>
                    </rad:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </rad:RadGrid><br />
            5<asp:SqlDataSource ID="ds_5p2_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="106" Name="p_key_core_indicator_id" Type="Int32" />
                    <asp:ControlParameter ControlID="txt_AcctID" DefaultValue="" Name="p_key_accountability_id"
                        PropertyName="Text" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_spec_population_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </rad:PageView>
    </rad:RadMultiPage>
    <asp:HiddenField ID="hdn_tabselectedValue" runat="server" Value="101" />
    <asp:Button ID="btn_Save" runat="server" OnClick="btn_Save_Click" Text="Save" /><br />
    <br />
    <br />
    <div style="visibility:hidden;">
        <asp:Label ID="Label1" runat="server" Text="Accountablity ID:"></asp:Label>
    <asp:TextBox ID="txt_AcctID" runat="server" ReadOnly="True"></asp:TextBox>
        <br />
    <asp:Label ID="Label2" runat="server" Text="College ID:"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp;
    <asp:TextBox ID="txt_CollegeID" runat="server" ReadOnly="True"></asp:TextBox>
        <br />
    <asp:Label ID="Label6" runat="server" Text="Fiscal Year:"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp;<asp:TextBox ID="txt_FiscalYear" runat="server" ReadOnly="True"></asp:TextBox></div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

