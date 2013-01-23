<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="EnrollmentForm.aspx.cs" Inherits="Accountability_EnrollmentForm_v2" Title="Enrollment Form" %>

<%@ Register Assembly="RadAjax.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="RadInput.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">

    <script type="text/javascript">
        function OpenReports()
        {        
           
//            var winobj = window.radopen("reports/ViewAccountablity_Reports.aspx", "popupimprov");
//            var wW = Math.round(document.documentElement.clientWidth *95/100);            
//            var wH = Math.round(document.documentElement.clientHeight *95/100);

//            winobj.SetSize(wW,wH);
//            winobj.Center();
            var hf_Accountability_Id = document.getElementById("<%= hf_Accountability_Id.ClientID %>").value;
            window.open("../Reports/ViewReport.aspx?format=pdf&type=rpt_annual_performance_report_cte_enrollment&aa_id=" + hf_Accountability_Id);
        }
        
        function  parsevalue(inval)
        {    
            inval = inval.replace(",","");
            try
            {
            if(inval.length == 0)
                return parseInt(0);
            else
            
              /*return parseInt(inval);*/
              if (Math.round(parseFloat(inval)) < 0)
                return parseInt(0);
              else
                return Math.round(parseFloat(inval));
            }
            catch(err)
            {
               return parseInt(0);
            }    
        }
    
        function RowChanged(sender, eventArgs)
        {
            var Gender_Total = 0;
            var Race_Total = 0;
            var Spec_Total = 0;
            
            var grid = $find("<%= rg_Enrollment.ClientID %>");
            var MasterTable = grid.get_masterTableView();
          
            var rows = MasterTable.get_dataItems();
            for (var i = 0; i < rows.length; i++)
            {
                var row = rows[i];
                
               // var nbr_studentsTextBox = row.findControl("nbr_studentsTextBox");
               // var cell = MasterTable.getCellByColumnUniqueName(row, "nbr_students")
                //here cell.innerHTML holds the value of the cell
                //alert(nbr_studentsTextBox);
            }
            
            
            
            for( var i =5; i < 8; i = i+2)
            {
                Gender_Total += parsevalue(document.getElementById("ctl00_mainCopy_rg_Enrollment_ctl00_ctl0" + i + "_nbr_studentsTextBox_text").value);                
            }
            document.getElementById("Total0").innerHTML = Gender_Total + "";
            
            for( var i =11; i < 22; i = i+2)
            {
                Race_Total += parsevalue(document.getElementById("ctl00_mainCopy_rg_Enrollment_ctl00_ctl" + i + "_nbr_studentsTextBox_text").value);                
            }
            document.getElementById("Total1").innerHTML = Race_Total + "";
            
            
            for( var i =25; i < 36; i = i+2)
            {
                Spec_Total += parsevalue(document.getElementById("ctl00_mainCopy_rg_Enrollment_ctl00_ctl" + i + "_nbr_studentsTextBox_text").value);                
            }
            document.getElementById("Total2").innerHTML = Spec_Total + "";
            
            if(Race_Total != Gender_Total)
            {
                document.getElementById("<% =lbl_error.ClientID  %>").innerHTML  = "* Gender and Ethnicity totals must equal";
                document.getElementById("<% =btn_Save.ClientID  %>").disabled = true;
            }
            else
            {
                document.getElementById("<% =lbl_error.ClientID  %>").innerHTML  = "";
                document.getElementById("<% =btn_Save.ClientID  %>").disabled = false;
            }
        }

    </script>
<asp:Panel ID="pan_topInfo" runat="server" Width="100%">    
    <asp:SqlDataSource ID="ds_Enrollment" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_acountability_cte_enrollment_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_cte_participant_enrollment_upd" UpdateCommandType="StoredProcedure" OnUpdated="ds_Enrollment_Updated">
        <SelectParameters>
            <asp:ControlParameter ControlID="hf_Accountability_Id" Name="p_key_accountability_id"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="hf_Created_By" Name="p_txt_created_by" PropertyName="Value"
                Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="p_key_cte_enrollment_id" Type="Int32" />
            <asp:Parameter Name="p_nbr_students" Type="Int32" />
            <asp:Parameter Name="p_txt_updated_by" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hf_Accountability_Id" runat="server" /><asp:HiddenField ID="hf_Created_By" runat="server" />
   
   <table width="100%"><tr>
       <td valign="top" >
        <span style="font-weight:bold;" >
            <asp:Label ID="lbl_CurrfiscalYear" runat="server" Font-Bold="True"></asp:Label></span></td>
       <td align="right" width="400px">    
           <table>
               <tr>
                   <td style="width: 1px">
            <asp:Button ID="btn_Save" runat="server" OnClick="btn_Save_Click" Text="Save" Visible="False" Font-Bold="True" Width="49px" />
                   </td>
                   <td style="width: 1px">
            <asp:Button ID="btn_print" runat="server" Font-Bold="True" OnClientClick="OpenReports()"
                Text="Print Report" OnClick="btn_print_Click" />
                   </td>
                   <td>
            <asp:Button ID="btn_Export_Excel" runat="server" Font-Bold="True"
                   Text="Export Excel" OnClick="btn_Export_Excel_Click" /></td>
               </tr>
           </table>
       </td></tr>
       <tr>
           <td align="right" colspan="2" style="height: 18px">
    <asp:Label ID="lbl_error" runat="server" ForeColor="Red"></asp:Label></td>
       </tr>
       <tr>
           <td colspan="2">
    <telerik:RadGrid ID="rg_Enrollment" runat="server" GridLines="None" Skin="Office2007_SCTCS" AllowAutomaticUpdates="True" DataSourceID="ds_Enrollment" OnDataBound="rg_Enrollment_DataBound" AutoGenerateColumns="False" Width="100%" EnableEmbeddedSkins="False" OnItemDataBound="rg_Enrollment_ItemDataBound">
        <MasterTableView DataKeyNames="key_cte_enrollment_id" DataSourceID="ds_Enrollment" ShowGroupFooter="True">
            <EditFormSettings>
       
                <EditColumn UniqueName="EditCommandColumn1" CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif">
                </EditColumn>
            </EditFormSettings>
            <Columns>
                
                
                
                <telerik:GridBoundColumn DataField="key_cte_enrollment_id" DataType="System.Int32" HeaderText="key_cte_enrollment_id"
                    ReadOnly="True" SortExpression="key_cte_enrollment_id" UniqueName="key_cte_enrollment_id" Display="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="key_accountability_id" DataType="System.Int32" HeaderText="key_accountability_id"
                    SortExpression="key_accountability_id" UniqueName="key_accountability_id" Display="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="txt_desc" HeaderText="Description" SortExpression="txt_desc"
                    UniqueName="txt_desc">
                    <ItemStyle Font-Size="10pt" />
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="nbr_students" DataType="System.Int32" HeaderText="# Of Students"
                    SortExpression="nbr_students" UniqueName="nbr_students">
                    <ItemTemplate>
                        <rad:RadNumericTextBox ID="nbr_studentsTextBox" runat="server"
                            Culture="English (United States)" DbValue='<%# Eval("nbr_students") %>' LabelCssClass="radLabelCss_Default" Skin="Vista" Width="90px" Font-Size="9pt" MinValue="0" style="text-align: right" ButtonsPosition="Left" Font-Names="Trebutche MS">
                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
                        </rad:RadNumericTextBox>
                        <asp:HiddenField ID="hf_kp_id" runat="server" Value='<%# Bind("key_cte_enrollment_id") %>' />
                    </ItemTemplate>
                    <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                        Font-Underline="False" HorizontalAlign="Right" Wrap="True" />
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn UniqueName="TemplateColumn">
                    <ItemStyle Width="1in" />
                </telerik:GridTemplateColumn>
            </Columns>
             <GroupByExpressions>
                <telerik:GridGroupByExpression>
                <GroupByFields>
                <telerik:GridGroupByField  FieldAlias="key_population_category_id" FieldName="key_population_category_id" FormatString=""/>
                </GroupByFields>
                <SelectFields>
                        <telerik:GridGroupByField FieldAlias="txt_category_desc" FieldName="txt_category_desc" FormatString="&lt;font color=Red&gt;{0}&lt;/font&gt;" HeaderText=" " HeaderValueSeparator="" />
                
                </SelectFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
        </MasterTableView>
        <AlternatingItemStyle Font-Size="9pt" />
        <GroupHeaderItemStyle Font-Bold="True" />
        <HeaderContextMenu EnableEmbeddedSkins="False">
        </HeaderContextMenu>
        <FilterMenu EnableEmbeddedSkins="False">
        </FilterMenu>
    </telerik:RadGrid></td>
       </tr>
   </table>
    <br />
    &nbsp;</asp:Panel>
    <br />
    <asp:Panel ID="pan_noNarrative" runat="server" HorizontalAlign="Center">
        <asp:Label ID="lbl_errortext" runat="server" Text="Label"></asp:Label></asp:Panel>
    <br />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnablePageHeadUpdate="False"><AjaxSettings>
<telerik:AjaxSetting AjaxControlID="ds_Enrollment"><UpdatedControls>
<telerik:AjaxUpdatedControl ControlID="btn_Save"></telerik:AjaxUpdatedControl>
<telerik:AjaxUpdatedControl ControlID="lbl_error"></telerik:AjaxUpdatedControl>
<telerik:AjaxUpdatedControl ControlID="rg_Enrollment"></telerik:AjaxUpdatedControl>
</UpdatedControls>
</telerik:AjaxSetting>
</AjaxSettings>
</telerik:RadAjaxManager>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

