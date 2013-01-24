<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="AccountabilityReport_V2.aspx.cs" Inherits="Accountability_AccountabilityReport_V2" Title="Accountability Report" %>
<%@ Register Assembly="RadAjax.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="RadInput.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
        function ShowNarrativeDetails(vNid)
        {
           // alert("");
            var nid =  vNid;
           
            var wObj = window.radopen("Narrative_Response.aspx?nid=" + nid + "&level=-1", "UserListDialog");                       
            var wW = Math.round(document.documentElement.clientWidth *95/100);            
            var wH = Math.round(document.documentElement.clientHeight *95/100);
            
            wObj.SetSize(wW,wH);
            wObj.Center();      
        }   
        
        function tabClicked(sender, eventArgs)
        {
          var tabStrip = sender;
          var tab = eventArgs.Tab;
          var hdnSelectedvalue = document.getElementById('<%= hdn_tabselectedValue.ClientID %>');
          hdnSelectedvalue.value = tab.Value;

         // alert( tab.Value +  tabStrip.ID );
        } 
    </script>
    
    
    <asp:Label ID="lbl_College" runat="server" Text="College: "></asp:Label>&nbsp;<asp:DropDownList
        ID="ddl_College" runat="server" AutoPostBack="True" DataSourceID="SqlDsCollege"
        DataTextField="txt_college_short_name" DataValueField="key_college_id" OnSelectedIndexChanged="ddl_College_FiscalYear_SelectedIndexChanged"
        Width="172px" OnDataBound="ddl_College_DataBound">
    </asp:DropDownList>
    <asp:Label ID="lbl_FiscalYear" runat="server" Text="Fiscal Year:"></asp:Label>&nbsp;<asp:DropDownList
        ID="ddl_fiscalyear" runat="server" AutoPostBack="True" DataSourceID="SqlDS_fisYear"
        DataTextField="nbr_fiscal_year" DataValueField="nbr_fiscal_year" OnSelectedIndexChanged="ddl_College_FiscalYear_SelectedIndexChanged"
        Width="150px" OnDataBound="ddl_fiscalyear_DataBound">
    </asp:DropDownList>
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    <asp:SqlDataSource ID="SqlDsCollege" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT key_college_id, txt_college_name AS txt_college_short_name FROM scs_college WHERE (key_college_id < @key_college_id)&#13;&#10;Order by txt_college_name">
        <SelectParameters>
            <asp:Parameter DefaultValue="18" Name="key_college_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDS_fisYear" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_fiscal_year_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ds_Acc_Menu" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_sec_Tabs_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="p_parentid" Type="String" />
            <asp:Parameter DefaultValue="101" Name="p_sec_level" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hf_Accountability_Id" runat="server" />
    <asp:HiddenField ID="hdn_tabselectedValue" runat="server" Value="101" />
    <asp:Panel ID="pan_Acc" runat="server" Width="100%" Visible="False">
    
    <rad:RadTabStrip ID="rts_Acc_Menu" runat="server" DataSourceID="ds_Acc_Menu" DataTextField="txt_tab_name"
        Skin="abc" AutoPostBack="True" CausesValidation="False" MultiPageID="RadMultiPage1" OnTabClick="rts_Acc_Menu_TabClick" Visible="False">
    </rad:RadTabStrip>
    <asp:MultiView ID="mv_Acc" runat="server">
        <asp:View ID="pv_Acc" runat="server">
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
            <asp:Parameter Name="p_key_accountability_level_id" Type="Int32" />
            <asp:Parameter Name="p_txt_note" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
            <table width="100%">
                <tr>
                    <td style="width: 134px">
                        Accountability ID:</td>
                    <td>
                        <asp:Label ID="lbl_Acc_Id" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 134px; height: 18px">
                    </td>
                    <td style="height: 18px">
                        <asp:TextBox ID="txt_Note" runat="server" Height="84px" TextMode="MultiLine" Width="587px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 134px">
                        Level:</td>
                    <td>
                        <asp:Label ID="lbl_Level" runat="server"></asp:Label>
                        <asp:HiddenField ID="hf_Level_Id" runat="server" />
                        <asp:SqlDataSource ID="ds_Level" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acct_report_level_get" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hf_Accountability_Id" Name="p_key_accountability_id"
                                    PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td style="width: 134px">
                        Next Level:</td>
                    <td>
                        <asp:DropDownList ID="ddl_Acct_Next_Level" runat="server" Width="232px" DataSourceID="ds_Acct_Next_Level" DataTextField="txt_level_desc" DataValueField="nbr_next_level_nbr">
                        </asp:DropDownList><asp:SqlDataSource ID="ds_Acct_Next_Level" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acct_report_next_level_get" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hf_Level_Id" Name="p_nbr_current_next_level_nbr"
                                    PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td style="width: 134px">
                    </td>
                    <td>
                        <asp:Button ID="btn_Save" runat="server" Text="Save" Width="80px" OnClick="btn_Save_Click1" /></td>
                </tr>
            </table>
        </asp:View>
        <asp:View ID="pv_Narratives" runat="server">
            <rad:RadGrid ID="rg_Narratives" runat="server" DataSourceID="ds_Acc_Narr" EnableAJAX="True"
                GridLines="None" OnItemDataBound="rg_Narratives_ItemDataBound" Skin="Default">
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_accountability_narrative_rec_id"
                    DataSourceID="ds_Acc_Narr">
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px" />
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px" />
                    </ExpandCollapseColumn>
                    <Columns>
                        <rad:GridTemplateColumn UniqueName="EditTemplateColumn">
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:HyperLink ID="lbView" runat="server" ImageUrl="~/images/Edit.gif" NavigateUrl="#"
                                    Style="position: relative">View</asp:HyperLink>
                                <asp:HiddenField ID="hf_Nid" runat="server" Value='<%# Eval("key_accountability_narrative_rec_id") %>' />
                            </ItemTemplate>
                            <ItemStyle Width="0.2in" />
                        </rad:GridTemplateColumn>
                        <rad:GridBoundColumn DataField="key_accountability_narrative_rec_id" DataType="System.Int32"
                            HeaderText="Id" ReadOnly="True" SortExpression="key_accountability_narrative_rec_id"
                            UniqueName="key_accountability_narrative_rec_id">
                            <ItemStyle Width="0.5in" />
                        </rad:GridBoundColumn>
                        <rad:GridTemplateColumn DataField="txt_narrative_section_title" HeaderText="Title"
                            SortExpression="txt_narrative_section_title" UniqueName="txt_narrative_section_title">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_narrative_section_titleTextBox" runat="server" Text='<%# Bind("txt_narrative_section_title") %>'
                                    Width="400px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="txt_narrative_section_titleLabel" runat="server" Text='<%# Eval("txt_narrative_section_title") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="2in" />
                        </rad:GridTemplateColumn>
                        <rad:GridTemplateColumn DataField="txt_narrative_desc" HeaderText="Description" SortExpression="txt_narrative_desc"
                            UniqueName="txt_narrative_desc">
                            <EditItemTemplate>
                                <asp:TextBox ID="txt_narrative_descTextBox" runat="server" Height="75px" Text='<%# Bind("txt_narrative_desc") %>'
                                    TextMode="MultiLine" Width="700px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="txt_narrative_descLabel" runat="server" Text='<%# Eval("txt_narrative_desc") %>'></asp:Label>
                            </ItemTemplate>
                        </rad:GridTemplateColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn UniqueName="EditCommandColumn1">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </rad:RadGrid><asp:SqlDataSource ID="ds_Acc_Narr" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_acc_accountability_narrative_get_list" SelectCommandType="StoredProcedure"
                UpdateCommand="pr_acc_accountability_narrative_upd" UpdateCommandType="StoredProcedure" OnDataBinding="ds_Acc_Narr_DataBinding">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hf_Accountability_Id" DefaultValue="" Name="p_key_accountability_id"
                        PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_accountability_narrative_rec_id" Type="Int32" />
                    <asp:Parameter Name="p_txt_narrative_response" Type="String" />
                    <asp:Parameter Name="p_txt_updated_user" Type="String" />
                    <asp:Parameter Name="p_txt_system_office_notes" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <radW:RadWindowManager ID="RadNarrativeDetail" runat="server" Skin="Vista" Behavior="Minimize, Maximize, Move, Reload" >
        <Windows>
            <radw:RadWindow ID="UserListDialog" runat="server" Title="Narrative"
               Left="150px" BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Height="600px" Width="400px" Top="" />
        </Windows>
        
        
    </radW:RadWindowManager>


        </asp:View>
        <asp:View ID="pv_Per_Ind" runat="server">
            <rad:RadTabStrip ID="rdt_PerfIndcat" runat="server" CausesValidation="False" DataSourceID="SqlDS_ACCT_Tabs"
                DataTextField="txt_core_indicator_abbrv" DataValueField="key_core_indicator_id"
                MultiPageID="RadMultiPage1" OnClientTabSelected="tabClicked" SelectedIndex="0"
                Skin="MySite" Width="884px">
                <Tabs>
                    <rad:Tab runat="server" PageViewID="pg_1p1" Text="1p1">
                    </rad:Tab>
                    <rad:Tab runat="server" PageViewID="pg_2p1" Text="2p1">
                    </rad:Tab>
                    <rad:Tab runat="server" PageViewID="pg_3p1" Text="3p1">
                    </rad:Tab>
                    <rad:Tab runat="server" PageViewID="pg_4p1" Text="4p1">
                    </rad:Tab>
                    <rad:Tab runat="server" PageViewID="pg_5p1" Text="5p1">
                    </rad:Tab>
                    <rad:Tab runat="server" PageViewID="pg_5p2" Text="5p2">
                    </rad:Tab>
                </Tabs>
            </rad:RadTabStrip>
            <asp:SqlDataSource ID="SqlDS_ACCT_Tabs" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="SELECT     key_core_indicator_id, txt_core_indiciator_code + ' ' + txt_core_indicator_abbrv AS txt_core_indicator_abbrv&#13;&#10;FROM         dbo.scs_core_indicator&#13;&#10;">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_Gender" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_acc_accountability_gender_get" SelectCommandType="StoredProcedure"
                UpdateCommand="pr_acc_accountability_gender_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hf_Accountability_Id" Name="p_key_accountability_id"
                        PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:Parameter Name="p_key_acct_gender_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_Race" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_acc_accountability_race_get" SelectCommandType="StoredProcedure"
                UpdateCommand="pr_acc_accountability_race_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hf_Accountability_Id" Name="p_key_accountability_id"
                        PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_race_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_SpecPop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure"
                UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter DefaultValue="101" Name="p_key_core_indicator_id" Type="Int32" />
                    <asp:ControlParameter ControlID="hf_Accountability_Id" DefaultValue="" Name="p_key_accountability_id"
                        PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_spec_population_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students_numerator" Type="Int32" />
                    <asp:Parameter Name="p_nbr_student_denominator" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <rad:RadMultiPage ID="RadMultiPage1" runat="server" Width="1162px">
                <rad:PageView ID="pg_1p1" runat="server">
                    <table width="100%">
                        <tr>
                            <td>
                                <rad:RadGrid ID="rdg_Gender" runat="server" AllowAutomaticUpdates="True" DataSourceID="SqlDS_Gender"
                                    EnableAJAX="True" GridLines="None" ShowFooter="True" Skin="Default" Width="100%">
                                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_gender_id" DataSourceID="SqlDS_Gender">
                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="20px" />
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn>
                                            <HeaderStyle Width="20px" />
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <rad:GridBoundColumn DataField="key_acct_gender_id" DataType="System.Int32" ReadOnly="True"
                                                SortExpression="key_acct_gender_id" UniqueName="key_acct_gender_id" Visible="False">
                                                <ItemStyle Width="30px" />
                                            </rad:GridBoundColumn>
                                            <rad:GridBoundColumn DataField="txt_gender_name" HeaderText="Population" SortExpression="txt_gender_name"
                                                UniqueName="txt_gender_name">
                                                <ItemStyle Width="40%" />
                                            </rad:GridBoundColumn>
                                            <rad:GridTemplateColumn DataField="nbr_students_numerator" DataType="System.Int32"
                                                HeaderText="# Student Numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>'
                                                        Width="12%"></asp:TextBox>&nbsp;
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    &nbsp;<rad:RadNumericTextBox ID="nbr_students_numeratorTextBox" runat="server" Culture="English (United States)"
                                                        DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default"
                                                        Skin="" Width="80%">
                                                        <NumberFormat AllowRounding="True" DecimalDigits="0" />
                                                    </rad:RadNumericTextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lbl_genderNUMSum" runat="server" Text="0"></asp:Label>
                                                </FooterTemplate>
                                                <ItemStyle Width="10%" />
                                            </rad:GridTemplateColumn>
                                            <rad:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Int32"
                                                HeaderText="# Student Denominator" SortExpression="nbr_student_denominator" UniqueName="nbr_student_denominator">
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
                                            <rad:GridTemplateColumn HeaderText="Adjusted Level of Performance" UniqueName="TemplateColumn">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label12" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lb12ltotal" runat="server" Text="0"></asp:Label>
                                                </FooterTemplate>
                                                <ItemStyle Width="10%" />
                                            </rad:GridTemplateColumn>
                                            <rad:GridTemplateColumn HeaderText="Actual Level of Performance" UniqueName="TemplateColumn">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lbl13total" runat="server" Text="0"></asp:Label>
                                                </FooterTemplate>
                                                <ItemStyle Width="10%" />
                                            </rad:GridTemplateColumn>
                                            <rad:GridTemplateColumn HeaderText="Adjusted vs Actuall Performance" UniqueName="TemplateColumn">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lbl14total" runat="server" Text="0"></asp:Label>
                                                </FooterTemplate>
                                                <ItemStyle Width="10%" />
                                            </rad:GridTemplateColumn>
                                            <rad:GridTemplateColumn HeaderText="Met 90% Adjusted Level of Performance (Y,N)"
                                                UniqueName="TemplateColumn">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label ID="lbl15total" runat="server" Text="0"></asp:Label>
                                                </FooterTemplate>
                                                <ItemStyle Width="10%" />
                                            </rad:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </rad:RadGrid>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <rad:RadGrid ID="rdg_Race" runat="server" DataSourceID="SqlDS_Race" EnableAJAX="True"
                                    GridLines="None" ShowFooter="True" ShowHeader="False" Skin="Default" Width="1111px">
                                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_race_id" DataSourceID="SqlDS_Race">
                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="20px" />
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn>
                                            <HeaderStyle Width="20px" />
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <rad:GridBoundColumn DataField="key_acct_race_id" DataType="System.Int32" HeaderText="key_acct_race_id"
                                                ReadOnly="True" SortExpression="key_acct_race_id" UniqueName="key_acct_race_id"
                                                Visible="False">
                                                <ItemStyle Width="20px" />
                                            </rad:GridBoundColumn>
                                            <rad:GridBoundColumn DataField="txt_race_name" HeaderText="txt_race_name" SortExpression="txt_race_name"
                                                UniqueName="txt_race_name">
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
                                                <ItemTemplate>
                                                    <asp:Label ID="Label12" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
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
                                </rad:RadGrid></td>
                        </tr>
                        <tr>
                            <td>
                                <rad:RadGrid ID="rdg_SpecPOPs" runat="server" DataSourceID="SqlDS_SpecPop" EnableAJAX="True"
                                    GridLines="None" ShowFooter="True" ShowHeader="False" Skin="Default">
                                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id"
                                        DataSourceID="SqlDS_SpecPop">
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
                                                UniqueName="txt_desc">
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
                                                    <asp:Label ID="lbl_SpecialPOPSDENSum" runat="server" Text="0"></asp:Label>
                                                </FooterTemplate>
                                                <ItemStyle Width="10%" />
                                            </rad:GridTemplateColumn>
                                            <rad:GridTemplateColumn UniqueName="TemplateColumn">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label12" runat="server" Text="0" Width="40px"></asp:Label></ItemTemplate>
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
                                </rad:RadGrid></td>
                        </tr>
                    </table>
                </rad:PageView>
                <rad:PageView ID="pg_2p1" runat="server">
                    <rad:RadGrid ID="rdg_SpecPOPs2p1" runat="server" DataSourceID="ds_2p1_Spec_Pop" EnableAJAX="True"
                        GridLines="None" ShowFooter="True" ShowHeader="False" Skin="Default">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id"
                            DataSourceID="ds_2p1_Spec_Pop">
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
                                        &nbsp;<rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)"
                                            DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default"
                                            Skin="" Width="80%">
                                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
                                        </rad:RadNumericTextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </rad:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </rad:RadGrid><br />
                    <asp:SqlDataSource ID="ds_2p1_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure"
                        UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="102" Name="p_key_core_indicator_id" Type="Int32" />
                            <asp:ControlParameter ControlID="hf_Accountability_Id" DefaultValue="" Name="p_key_accountability_id"
                                PropertyName="Value" Type="Int32" />
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
                <rad:PageView ID="pg_3p1" runat="server">
                    <rad:RadGrid ID="rdg_SpecPOPs3p1" runat="server" DataSourceID="ds_3p1_Spec_Pop" EnableAJAX="True"
                        GridLines="None" ShowFooter="True" ShowHeader="False" Skin="Default">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id"
                            DataSourceID="ds_3p1_Spec_Pop">
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
                                        <rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)"
                                            DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default"
                                            Skin="" Width="80%">
                                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
                                        </rad:RadNumericTextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </rad:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </rad:RadGrid><br />
                    <asp:SqlDataSource ID="ds_3p1_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure"
                        UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="103" Name="p_key_core_indicator_id" Type="Int32" />
                            <asp:ControlParameter ControlID="hf_Accountability_Id" DefaultValue="" Name="p_key_accountability_id"
                                PropertyName="Value" Type="Int32" />
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
                </rad:PageView>
                <rad:PageView ID="pg_4p1" runat="server">
                    <rad:RadGrid ID="rdg_SpecPOPs4p1" runat="server" DataSourceID="ds_4p1_Spec_Pop" EnableAJAX="True"
                        GridLines="None" ShowFooter="True" ShowHeader="False" Skin="Default">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id"
                            DataSourceID="ds_4p1_Spec_Pop">
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
                                        <rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)"
                                            DbValue='<%# (Eval("nbr_student_denominator") ?? 0) %>' LabelCssClass="radLabelCss_Default"
                                            Skin="" Width="80%">
                                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
                                        </rad:RadNumericTextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </rad:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </rad:RadGrid><br />
                    <asp:SqlDataSource ID="ds_4p1_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure"
                        UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="104" Name="p_key_core_indicator_id" Type="Int32" />
                            <asp:ControlParameter ControlID="hf_Accountability_Id" DefaultValue="" Name="p_key_accountability_id"
                                PropertyName="Value" Type="Int32" />
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
                <rad:PageView ID="pg_5p1" runat="server">
                    <rad:RadGrid ID="rdg_SpecPOPs5p1" runat="server" DataSourceID="ds_5p1_Spec_Pop" EnableAJAX="True"
                        GridLines="None" ShowFooter="True" ShowHeader="False" Skin="Default">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id"
                            DataSourceID="ds_5p1_Spec_Pop">
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
                                        <rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)"
                                            DbValue='<%# (Eval("nbr_student_denominator") ?? 0) %>' LabelCssClass="radLabelCss_Default"
                                            Skin="" Width="80%">
                                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
                                        </rad:RadNumericTextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </rad:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </rad:RadGrid><br />
                    <asp:SqlDataSource ID="ds_5p1_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure"
                        UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="105" Name="p_key_core_indicator_id" Type="Int32" />
                            <asp:ControlParameter ControlID="hf_Accountability_Id" DefaultValue="" Name="p_key_accountability_id"
                                PropertyName="Value" Type="Int32" />
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
                <rad:PageView ID="pg_5p2" runat="server">
                    <rad:RadGrid ID="rdg_SpecPOPs5p2" runat="server" DataSourceID="ds_5p2_Spec_Pop" EnableAJAX="True"
                        GridLines="None" ShowFooter="True" ShowHeader="False" Skin="Default">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acct_spec_population_id"
                            DataSourceID="ds_5p2_Spec_Pop">
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
                                        <rad:RadNumericTextBox ID="nbr_student_denominatorTextBox" runat="server" Culture="English (United States)"
                                            DbValue='<%# (Eval("nbr_student_denominator") ?? 0) %>' LabelCssClass="radLabelCss_Default"
                                            Skin="" Width="80%">
                                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
                                        </rad:RadNumericTextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </rad:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </rad:RadGrid><br />
                    <asp:SqlDataSource ID="ds_5p2_Spec_Pop" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                        SelectCommand="pr_acc_performance_indicator_get" SelectCommandType="StoredProcedure"
                        UpdateCommand="pr_acc_accountability_spec_population_upd" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="106" Name="p_key_core_indicator_id" Type="Int32" />
                            <asp:ControlParameter ControlID="hf_Accountability_Id" DefaultValue="" Name="p_key_accountability_id"
                                PropertyName="Value" Type="Int32" />
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
            <asp:Button ID="btn_Save_PI" runat="server" OnClick="btn_Save_Click" Text="Save"
                Width="80px" /></asp:View>
        &nbsp;
        <asp:View ID="pv_Enrollment" runat="server">
            <asp:SqlDataSource ID="ds_Enrollment" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_acc_cte_participant_enrollment_get" SelectCommandType="StoredProcedure"
                UpdateCommand="pr_acc_cte_participant_enrollment_upd" UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hf_Accountability_Id" Name="p_key_accountability_id"
                        PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="p_key_acct_spec_population_id" Type="Int32" />
                    <asp:Parameter Name="p_nbr_students" Type="Int32" />
                    <asp:Parameter Name="p_txt_updated_by" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <rad:RadGrid id="rg_Enrollment" runat="server" AllowAutomaticUpdates="True" DataSourceID="ds_Enrollment"
                GridLines="None" Skin="Default">
                <mastertableview autogeneratecolumns="False" datakeynames="key_acct_spec_population_id"
                    datasourceid="ds_Enrollment">
            <RowIndicatorColumn>
                <HeaderStyle Width="20px"  />
            </RowIndicatorColumn>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px"  />
            </ExpandCollapseColumn>
            <Columns>
                <rad:GridEditCommandColumn ButtonType="ImageButton" Visible="False">
                    <ItemStyle Width="0.2in"  />
                </rad:GridEditCommandColumn>
                <rad:GridBoundColumn DataField="key_acct_spec_population_id" DataType="System.Int32"
                    HeaderText="key_acct_spec_population_id" ReadOnly="True" SortExpression="key_acct_spec_population_id"
                    UniqueName="key_acct_spec_population_id" Visible="False">
                </rad:GridBoundColumn>
                <rad:GridBoundColumn DataField="txt_desc" HeaderText="Special Population Categories"
                    SortExpression="txt_desc" UniqueName="txt_desc">
                </rad:GridBoundColumn>
                <rad:GridTemplateColumn DataField="nbr_students" DataType="System.Int32" HeaderText="# of Students"
                    SortExpression="nbr_students" UniqueName="nbr_students">
                    <ItemTemplate>
                        <rad:RadNumericTextBox ID="nbr_studentsTextBox" runat="server" Culture="English (United States)"
                            LabelCssClass="radLabelCss_Default" Skin="" DBValue='<%# Eval("nbr_students") %>'
                            Width="125px" AutoPostBack="True" OnTextChanged="nbr_studentsTextBox_TextChanged">
                            <NumberFormat AllowRounding="True" DecimalDigits="0"  />
                        </rad:RadNumericTextBox>
                        <asp:HiddenField ID="hf_kp_id" runat="server" Value='<%# Eval("key_acct_spec_population_id") %>'  />
                    </ItemTemplate>
                </rad:GridTemplateColumn>
            </Columns>
            <EditFormSettings>
       
                <EditColumn UniqueName="EditCommandColumn1">
                </EditColumn>
            </EditFormSettings>
        </mastertableview>
                <alternatingitemstyle font-size="9pt" />
            </rad:RadGrid></asp:View>
        <asp:View ID="pv_Imp_Plan" runat="server">
        </asp:View>
    </asp:MultiView>
    
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

