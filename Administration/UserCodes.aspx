<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="UserCodes.aspx.cs" Inherits="Maintain_User_Codes" Title="User Codes" %>

<%@ Register Assembly="RadEditor.Net2" Namespace="Telerik.WebControls" TagPrefix="radE" %>


<%@ Register Assembly="RadCalendar.Net2" Namespace="Telerik.WebControls" TagPrefix="radCln" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>


<%@ Register Assembly="RadAjax.Net2" Namespace="Telerik.WebControls" TagPrefix="radA" %>
<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>



<asp:Content ID="Content2" ContentPlaceHolderID="mainCopy" runat="Server">
    <script type="text/javascript">
        function copyCatTypeValue()
        {         
            document.getElementById(window['hfKeyValue']).value = document.getElementById(window['ddCatType']).value;       
        }
    </script>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" >
        <tr>
            <td style="height: 10px; width: 958px;">
                <asp:SqlDataSource ID="SqlDataSourceSelect" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT [system_tables_key_id], [txt_Name] FROM [scs_system_tables] ORDER BY [txt_Name]"></asp:SqlDataSource>
                <table style="width: 885px;">
                    <tr>
                        <td colspan="3" style="border-bottom: black 1px groove; height: 32px;">
                            <span><strong><span style="font-size:9pt;">
                                <asp:Label ID="Label1" runat="server" Font-Bold="False"
                                     Text="Select User Table" Width="119px"></asp:Label>
                <asp:DropDownList ID="ddIndicator" runat="server" DataSourceID="SqlDataSourceSelect" DataTextField="txt_Name" DataValueField="system_tables_key_id" OnDataBound="ddIndicator_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddIndicator_SelectedIndexChanged" Width="200px" >
                </asp:DropDownList>
                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="position: relative"
                                    Text="Button" Visible="False" /></span></strong></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                
                
                <asp:MultiView id="mvMultiView1" runat="server"><asp:View id="vCategories" runat="server"><radG:RadGrid id="gCategories" runat="server" Width="100%" Skin="Default" DataSourceID="SqlDataSourceCat" AutoGenerateColumns="False" OnItemCreated="gCategories_ItemCreated" OnItemDataBound="gCategories_ItemDataBound" AllowAutomaticUpdates="True" AllowAutomaticInserts="True" AllowAutomaticDeletes="True" OnNeedDataSource="gCategories_NeedDataSource" GridLines="Horizontal" EnableAJAX="True">
                            <MasterTableView CommandItemDisplay="Bottom" DataKeyNames="key_category_id"
                                DataSourceID="SqlDataSourceCat" PageSize="5"  GridLines="Horizontal" SkinID="booksSkin" CellPadding="1" CellSpacing="1">
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~\images\Edit.gif"
                                        InsertImageUrl="~\images\Insert.gif" UpdateImageUrl="~\images\Update.gif">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_category_id" DataType="System.Int32" Display="False"
                                        HeaderText="key_category_id" ReadOnly="True" SortExpression="key_category_id"
                                        UniqueName="key_category_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="txt_category_code" HeaderText="Code" SortExpression="txt_category_code"
                                        UniqueName="txt_category_code">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_category_codeLabel" runat="server" Text='<%# Eval("txt_category_code") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_category_codeTextBox" runat="server" Text='<%# Bind("txt_category_code") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_category_codeTextBox"
                                                ErrorMessage="* Required" EnableClientScript="False"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemStyle  VerticalAlign="Top" />
                                    </radG:GridTemplateColumn>
                                    <radG:GridTemplateColumn DataField="txt_category_title" HeaderText="Title" SortExpression="txt_category_title"
                                        UniqueName="txt_category_title">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_category_titleLabel" runat="server" Text='<%# Eval("txt_category_title") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_category_titleTextBox" runat="server" Text='<%# Bind("txt_category_title") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_category_titleTextBox"
                                                ErrorMessage="* Required" EnableClientScript="False"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemStyle  VerticalAlign="Top" />
                                    </radG:GridTemplateColumn>
                                    <radG:GridTemplateColumn DataField="txt_category_desc" HeaderText="Description" SortExpression="txt_category_desc"
                                        UniqueName="txt_category_desc">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_category_descLabel" runat="server" Text='<%# Eval("txt_category_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_category_descTextBox" runat="server" Height="100px" Text='<%# Bind("txt_category_desc") %>'
                                                TextMode="MultiLine" Width="600px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridTemplateColumn>
                                    <radG:GridTemplateColumn DataField="key_category_type_id" DataType="System.Int32"
                                        Display="False" HeaderText="Category Type" SortExpression="key_category_type_id"
                                        UniqueName="key_category_type_id">
                                        <ItemTemplate>
                                            <asp:Label ID="key_category_type_idLabel" runat="server" Text='<%# Eval("key_category_type_id") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddCatType" runat="server" DataSourceID="SqlDataSourceCatType"
                                                DataTextField="txt_category_type_desc" DataValueField="key_category_type_id"
                                                Width="200px">
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" InitialValue="-1" runat="server" ControlToValidate="ddCatType"
                                                ErrorMessage="* Required" EnableClientScript="False"></asp:RequiredFieldValidator>
                                            <asp:HiddenField ID="hfKeyValue" runat="server" Value='<%# Bind("key_category_type_id") %>' />
                                        </EditItemTemplate>
                                        <ItemStyle  VerticalAlign="Top" />
                                    </radG:GridTemplateColumn>
                                    <radG:GridBoundColumn DataField="txt_category_type_desc" HeaderText="Type Description"
                                        SortExpression="txt_category_type_desc" UniqueName="txt_category_type_desc" ReadOnly="True">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridBoundColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ImageUrl="~\images\Delete.gif"
                                        Text="Delete" UniqueName="DeleteColumn" ConfirmText="Are you sure you want to delete this Category?">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn ButtonType="ImageButton" UpdateImageUrl="~/images/Update.gif" CancelImageUrl="~/images/Cancel.gif" UniqueName="EditCommandColumn1" />
                                </EditFormSettings>
                                
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                            </MasterTableView>
               
                            
                        </radG:RadGrid><br /><asp:SqlDataSource id="SqlDataSourceCat" runat="server" SelectCommand="pr_scs_category_get" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" UpdateCommandType="StoredProcedure" UpdateCommand="pr_scs_category_upd" InsertCommandType="StoredProcedure" InsertCommand="pr_scs_category_ins" DeleteCommandType="StoredProcedure" DeleteCommand="pr_scs_category_del" SelectCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="key_category_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_category_id" Type="Int32" />
                                <asp:Parameter Name="txt_category_code" Type="String" />
                                <asp:Parameter Name="txt_category_title" Type="String" />
                                <asp:Parameter Name="txt_category_desc" Type="String" />
                                <asp:Parameter Name="key_category_type_id" Type="Int32" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                                <asp:Parameter Name="dte_updated_date" Type="DateTime" />
                                <asp:Parameter Name="txt_updated_user" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_category_code" Type="String" />
                                <asp:Parameter Name="txt_category_title" Type="String" />
                                <asp:Parameter Name="txt_category_desc" Type="String" />
                                <asp:Parameter Name="key_category_type_id" Type="Int32" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:Parameter DefaultValue="1" Name="p_txt_category_type" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource> &nbsp; </asp:View> <asp:View id="vCoreIndicators" runat="server">
                        <radg:radgrid id="gCoreIndicator" runat="server" DataSourceID="SqlDataSourceInd" GridLines="None" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" EnableAJAX="True" Skin="Default" Width="100%">
                            <MasterTableView DataSourceID="SqlDataSourceInd" AutoGenerateColumns="False" DataKeyNames="key_core_indicator_id" CommandItemDisplay="Bottom" PageSize="6">
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditFormHeaderTextFormat="{0}"
                                        EditImageUrl="~\images\Edit.gif" InsertImageUrl="~\images\Insert.gif" UpdateImageUrl="~\images\Update.gif">
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_core_indicator_id" DataType="System.Int32" Display="False"
                                        HeaderText="Id" ReadOnly="True" SortExpression="key_core_indicator_id"
                                        UniqueName="key_core_indicator_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="txt_core_indiciator_code" HeaderText="Code" SortExpression="txt_core_indiciator_code"
                                        UniqueName="txt_core_indiciator_code">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_core_indiciator_codeLabel" runat="server" Text='<%# Eval("txt_core_indiciator_code") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_core_indiciator_codeTextBox" runat="server" Text='<%# Bind("txt_core_indiciator_code") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txt_core_indiciator_codeTextBox"
                                                ErrorMessage="* Required" EnableClientScript="False"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridTemplateColumn DataField="txt_core_indicator_name" HeaderText="Name" SortExpression="txt_core_indicator_name"
                                        UniqueName="txt_core_indicator_name">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_core_indicator_nameLabel" runat="server" Text='<%# Eval("txt_core_indicator_name") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_core_indicator_nameTextBox" runat="server" Text='<%# Bind("txt_core_indicator_name") %>'
                                                Width="200px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txt_core_indicator_nameTextBox"
                                                ErrorMessage="* Required" EnableClientScript="False"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridTemplateColumn DataField="txt_core_indicator_desc" HeaderText="Description"
                                        SortExpression="txt_core_indicator_desc" UniqueName="txt_core_indicator_desc">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_core_indicator_descLabel" runat="server" Text='<%# Eval("txt_core_indicator_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_core_indicator_descTextBox" runat="server" Height="100px" Text='<%# Bind("txt_core_indicator_desc") %>'
                                                TextMode="MultiLine" Width="600px"></asp:TextBox>
                                        </EditItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridBoundColumn DataField="txt_created_user" Display="False" HeaderText="txt_created_user"
                                        SortExpression="txt_created_user" UniqueName="txt_created_user" ReadOnly="True">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="dte_updated_date" DataType="System.DateTime" Display="False"
                                        HeaderText="dte_updated_date" SortExpression="dte_updated_date" UniqueName="dte_updated_date" ReadOnly="True">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_updated_user" Display="False" HeaderText="txt_updated_user"
                                        SortExpression="txt_updated_user" UniqueName="txt_updated_user" ReadOnly="True">
                                    </radG:GridBoundColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this core indicator?"
                                        ImageUrl="~/images/Delete.gif" Text="Delete" UniqueName="column">
                                    </radG:GridButtonColumn>
                                </Columns>                             
                                <EditFormSettings>
                                    <EditColumn ButtonType="ImageButton" UpdateImageUrl="~/images/Update.gif" CancelImageUrl="~/images/Cancel.gif" UniqueName="EditCommandColumn1" />
                                </EditFormSettings>                             
                            </MasterTableView>
                        </radg:radgrid>                    
                        <asp:SqlDataSource ID="SqlDataSourceInd" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_scs_core_indicator_get" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSourceInd_Selecting" DeleteCommand="pr_scs_core_indicator_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_scs_core_indicator_ins" InsertCommandType="StoredProcedure" UpdateCommand="pr_scs_core_indicator_upd" UpdateCommandType="StoredProcedure"> 
                            <DeleteParameters>
                                <asp:Parameter Name="key_core_indicator_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_core_indicator_id" Type="Int32" />
                                <asp:Parameter Name="txt_core_indiciator_code" Type="String" />
                                <asp:Parameter Name="txt_core_indicator_name" Type="String" />
                                <asp:Parameter Name="txt_core_indicator_desc" Type="String" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_core_indiciator_code" Type="String" />
                                <asp:Parameter Name="txt_core_indicator_name" Type="String" />
                                <asp:Parameter Name="txt_core_indicator_desc" Type="String" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:View> <asp:View id="vAssurance" runat="server">
                            <radG:RadGrid ID="gAssurance" runat="server" DataSourceID="SqlDataSourceAss"
                            GridLines="None" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" EnableAJAX="True" Skin="Default" Width="100%">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_assurance_id" DataSourceID="SqlDataSourceAss" CommandItemDisplay="Bottom" PageSize="6">
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditFormHeaderTextFormat="{0}"
                                        EditImageUrl="~\images\Edit.gif" InsertImageUrl="~\images\Insert.gif" UpdateImageUrl="~\images\Update.gif">
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_assurance_id" DataType="System.Int32" HeaderText="key_assurance_id"
                                        ReadOnly="True" SortExpression="key_assurance_id" UniqueName="key_assurance_id" Display="False">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="txt_assurance_desc" HeaderText="Description"
                                        SortExpression="txt_assurance_desc" UniqueName="txt_assurance_desc">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_assurance_descLabel" runat="server" Text='<%# Eval("txt_assurance_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_assurance_descTextBox" runat="server" Height="100px" Text='<%# Bind("txt_assurance_desc") %>'
                                                TextMode="MultiLine" Width="600px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txt_assurance_descTextBox"
                                                ErrorMessage="* Required" EnableClientScript="False"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this assurance?"
                                        ImageUrl="~\images\Delete.gif" Text="Delete" UniqueName="column">
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn ButtonType="ImageButton" UpdateImageUrl="~/images/Update.gif" CancelImageUrl="~/images/Cancel.gif" UniqueName="EditCommandColumn1" />
                                </EditFormSettings>
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                            </MasterTableView>
                        </radG:RadGrid>
                        <asp:SqlDataSource ID="SqlDataSourceAss" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            DeleteCommand="pr_scs_assurance_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_scs_assurance_ins"
                            InsertCommandType="StoredProcedure" SelectCommand="pr_scs_assurance_get" SelectCommandType="StoredProcedure"
                            UpdateCommand="pr_scs_assurance_upd" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="key_assurance_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_assurance_id" Type="Int32" />
                                <asp:Parameter Name="txt_assurance_desc" Type="String" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_assurance_desc" Type="String" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:View> <br />
                    
                    
                    <asp:View id="vNarrative" runat="server">
                        
                        <radG:RadGrid ID="gNarrative" runat="server" DataSourceID="SqlDataSourceNar" GridLines="None" EnableAJAX="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" Skin="Default" Width="100%" OnItemCommand="gNarrative_ItemCommand">
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceNar" DataKeyNames="key_narrative_id" CommandItemDisplay="Bottom">
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditFormHeaderTextFormat="{0}"
                                        EditImageUrl="~\images\Edit.gif" InsertImageUrl="~\images\Insert.gif" UpdateImageUrl="~\images\Update.gif">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_narrative_id" DataType="System.Int32" Display="False"
                                        HeaderText="key_narrative_id" ReadOnly="True" SortExpression="key_narrative_id"
                                        UniqueName="key_narrative_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="txt_narrative_section_title" HeaderText="Section Title"
                                        SortExpression="txt_narrative_section_title" UniqueName="txt_narrative_section_title">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_narrative_section_titleLabel" runat="server" Text='<%# Eval("txt_narrative_section_title") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_narrative_section_titleTextBox" runat="server" Text='<%# Bind("txt_narrative_section_title") %>'
                                                Width="600px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txt_narrative_section_titleTextBox"
                                                ErrorMessage="* Required" EnableClientScript="False"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridTemplateColumn>
                                    <radG:GridTemplateColumn DataField="txt_narrative_desc" HeaderText="Description"
                                        SortExpression="txt_narrative_desc" UniqueName="txt_narrative_desc" EditFormHeaderTextFormat="{0}">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_narrative_descLabel" runat="server" Text='<%# Eval("txt_narrative_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <radE:RadEditor ID="txt_narrative_descTextBox" runat="server" ConvertTagsToLower="True"
                                                ConvertToXhtml="False" DocumentsFilters="*.*" EnableClientSerialize="True" EnableContextMenus="True"
                                                EnableDocking="True" EnableEnhancedEdit="True" EnableHtmlIndentation="True" EnableServerSideRendering="True"
                                                EnableTab="True" Html='<%# Bind("txt_narrative_desc") %>' ImagesFilters="*.gif,*.xbm,*.xpm,*.png,*.ief,*.jpg,*.jpe,*.jpeg,*.tiff,*.tif,*.rgb,*.g3f,*.xwd,*.pict,*.ppm,*.pgm,*.pbm,*.pnm,*.bmp,*.ras,*.pcd,*.cgm,*.mil,*.cal,*.fif,*.dsf,*.cmx,*.wi,*.dwg,*.dxf,*.svf"
                                                MediaFilters="*.asf,*.asx,*.wm,*.wmx,*.wmp,*.wma,*.wax,*.wmv,*.wvx,*.avi,*.wav,*.mpeg,*.mpg,*.mpe,*.mov,*.m1v,*.mp2,*.mpv2,*.mp2v,*.mpa,*.mp3,*.m3u,*.mid,*.midi,*.rm,*.rma,*.rmi,*.rmv,*.aif,*.aifc,*.aiff,*.au,*.snd"
                                                OnClientCancel="" OnClientCommandExecuted="" OnClientCommandExecuting="" OnClientInit=""
                                                OnClientLoad="" OnClientModeChange="" OnClientSubmit="" PassSessionData="True"
                                                RenderAsTextArea="False" ShowHtmlMode="False" ShowPreviewMode="False" ShowSubmitCancelButtons="False"
                                                Skin="Vista" SpellEditDistance="1" TemplateFilters="*.html,*.htm" ToolbarMode="Default"
                                                ToolsFile="~/Editor/SpellcheckerTypes/AjaxSpell.xml" ToolsWidth="">
                                            </radE:RadEditor>
                                            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txt_narrative_descTextBox"
                                                ErrorMessage="* Required" EnableClientScript="False"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridTemplateColumn>
                                    <radG:GridBoundColumn DataField="nbr_fiscal_year" DataType="System.Int32"
                                        HeaderText="Fiscal Year" SortExpression="nbr_fiscal_year"
                                        UniqueName="nbr_fiscal_year">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridBoundColumn>
                                    
                                    <radG:GridCheckBoxColumn DataField="flg_optional" DataType="System.Boolean" HeaderText="Optional"
                                        SortExpression="flg_optional" UniqueName="flg_optional">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this narrative?"
                                        ImageUrl="~\images\Delete.gif" Text="Delete" UniqueName="column">
                                        <ItemStyle VerticalAlign="Top" />
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn ButtonType="ImageButton" UpdateImageUrl="~/images/Update.gif" CancelImageUrl="~/images/Cancel.gif" UniqueName="EditCommandColumn1" >
                                        <HeaderStyle Font-Underline="False" />
                                    </EditColumn>
                                    <FormStyle Font-Size="Large" />
                                </EditFormSettings>
                                <EditItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                    Font-Underline="False" Wrap="True" />
                            </MasterTableView>
                            <HeaderStyle Font-Size="Small" />
                           
                            <ItemStyle Font-Size="Medium" />
                            <CommandItemStyle Font-Size="Medium" />
                            <EditItemStyle Font-Size="Medium" />
                           
                           
                            
                        </radG:RadGrid>
                      
                        <br />
                        <asp:SqlDataSource ID="SqlDataSourceNar" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            DeleteCommand="pr_scs_narrative_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_scs_narrative_ins"
                            InsertCommandType="StoredProcedure" SelectCommand="pr_scs_narrative_get" SelectCommandType="StoredProcedure"
                            UpdateCommand="pr_scs_narrative_upd" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="key_narrative_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_narrative_id" Type="Int32" />
                                <asp:Parameter Name="txt_narrative_section_title" Type="String" />
                                <asp:Parameter Name="txt_narrative_desc" Type="String" />
                                <asp:Parameter Name="nbr_fiscal_year" Type="Int32" />
                                <asp:Parameter Name="flg_optional" Type="Boolean" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_narrative_section_title" Type="String" />
                                <asp:Parameter Name="txt_narrative_desc" Type="String" />
                                <asp:Parameter Name="nbr_fiscal_year" Type="Int32" />
                                <asp:Parameter Name="flg_optional" Type="Boolean" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:View> 
                    
                    
                    <asp:View id="vFaActivityType" runat="server">
                        <radG:RadGrid ID="gFaActivity" runat="server" DataSourceID="SqlDataSourceFaActivity"
                            EnableAJAX="True" GridLines="None" Skin="Default" Width="100%">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_fa_activity_type_id"
                                DataSourceID="SqlDataSourceFaActivity">
                                <Columns>
                                    <radG:GridBoundColumn DataField="key_fa_activity_type_id" DataType="System.Int32"
                                        HeaderText="Activity Type Id" ReadOnly="True" SortExpression="key_fa_activity_type_id"
                                        UniqueName="key_fa_activity_type_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_fa_activity_desc" HeaderText="Description" SortExpression="txt_fa_activity_desc"
                                        UniqueName="txt_fa_activity_desc">
                                    </radG:GridBoundColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                </Columns>
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                            </MasterTableView>
                        </radG:RadGrid><br />
                        <asp:SqlDataSource ID="SqlDataSourceFaActivity" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_scs_fa_activity_type_get" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                    </asp:View> <asp:View id="vFunctionCode" runat="server">
                        <radG:RadGrid ID="gFunctionCode" runat="server" DataSourceID="SqlDataSourceFunctionCode"
                            EnableAJAX="True" GridLines="None" Skin="Default" Width="100%" Height="100%">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_function_code_id"
                                DataSourceID="SqlDataSourceFunctionCode" CellPadding="2" CellSpacing="2" GridLines="None">
                                <Columns>
                                    <radG:GridBoundColumn DataField="key_function_code_id" DataType="System.Int32" HeaderText="Code Id"
                                        ReadOnly="True" SortExpression="key_function_code_id" UniqueName="key_function_code_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_function_code" HeaderText="Code" SortExpression="txt_function_code"
                                        UniqueName="txt_function_code">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_function_code_desc" HeaderText="Description"
                                        SortExpression="txt_function_code_desc" UniqueName="txt_function_code_desc">
                                    </radG:GridBoundColumn>
                                </Columns>
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                            </MasterTableView>
                        </radG:RadGrid><br />
                        <asp:SqlDataSource ID="SqlDataSourceFunctionCode" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_scs_function_code_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </asp:View> <asp:View id="vLineItemType" runat="server">
                        <radG:RadGrid ID="gLineItem" runat="server" DataSourceID="SqlDataSourceLineItem"
                            EnableAJAX="True" GridLines="None" Skin="Default" Width="100%">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_line_item_type_id"
                                DataSourceID="SqlDataSourceLineItem">
                                <Columns>
                                    <radG:GridBoundColumn DataField="key_line_item_type_id" DataType="System.Int32" HeaderText="Id"
                                        ReadOnly="True" SortExpression="key_line_item_type_id" UniqueName="key_line_item_type_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_line_item_desc" HeaderText="Description" SortExpression="txt_line_item_desc"
                                        UniqueName="txt_line_item_desc">
                                    </radG:GridBoundColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                </Columns>
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                            </MasterTableView>
                        </radG:RadGrid><br />
                        <asp:SqlDataSource ID="SqlDataSourceLineItem" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_scs_line_item_type_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </asp:View> <asp:View id="vLocalPlanLevel" runat="server">
                        <radG:RadGrid ID="gLocalPlan" runat="server" DataSourceID="SqlDataSourceLocalPlan"
                            EnableAJAX="True" GridLines="None" Skin="Default" Width="100%">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_local_plan_level_id"
                                DataSourceID="SqlDataSourceLocalPlan">
                                <Columns>
                                    <radG:GridBoundColumn DataField="key_local_plan_level_id" DataType="System.Int32"
                                        HeaderText="Id" ReadOnly="True" SortExpression="key_local_plan_level_id" UniqueName="key_local_plan_level_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="nbr_local_plan_level" DataType="System.Int32" HeaderText="Level"
                                        SortExpression="nbr_local_plan_level" UniqueName="nbr_local_plan_level">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_local_plan_level_status" HeaderText="Status"
                                        SortExpression="txt_local_plan_level_status" UniqueName="txt_local_plan_level_status">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_local_plan_level_status_desc" HeaderText="Status Description"
                                        SortExpression="txt_local_plan_level_status_desc" UniqueName="txt_local_plan_level_status_desc">
                                    </radG:GridBoundColumn>
                                </Columns>
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                            </MasterTableView>
                        </radG:RadGrid><br />
                        <asp:SqlDataSource ID="SqlDataSourceLocalPlan" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_scs_local_plan_level_get" SelectCommandType="StoredProcedure">
                        </asp:SqlDataSource>
                    </asp:View> <asp:View id="vActivityLevel" runat="server">
                        <radG:RadGrid ID="RadGrid3" runat="server" DataSourceID="SqlDataSourceActivityLevel"
                            EnableAJAX="True" GridLines="None" OnNeedDataSource="RadGrid3_NeedDataSource" Skin="Default" Width="100%">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_level_id"
                                DataSourceID="SqlDataSourceActivityLevel">
                                <Columns>
                                    <radG:GridBoundColumn DataField="key_level_id" DataType="System.Int32" Display="False"
                                        HeaderText="key_level_id" ReadOnly="True" SortExpression="key_level_id" UniqueName="key_level_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="nbr_level_nbr" DataType="System.Int32" HeaderText="Level Number"
                                        SortExpression="nbr_level_nbr" UniqueName="nbr_level_nbr">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_level_desc" HeaderText="Level Desc" SortExpression="txt_level_desc"
                                        UniqueName="txt_level_desc">
                                    </radG:GridBoundColumn>
                                </Columns>
                                <ExpandCollapseColumn Visible="False">
                                    <HeaderStyle Width="19px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                            </MasterTableView>
                     
                        </radG:RadGrid><br />
                        <asp:SqlDataSource ID="SqlDataSourceActivityLevel" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_scs_activity_level_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    </asp:View> &nbsp;
                    <asp:View ID="vw_documentCategories" runat="server">
                        <radG:RadGrid ID="rd_documentcategories" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="sqlds_documentCategories" GridLines="None"  Skin="Default" AutoGenerateColumns="False">
                            <MasterTableView DataKeyNames="key_document_category_id"
                                DataSourceID="sqlds_documentCategories" CommandItemDisplay="Bottom" >
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn CancelImageUrl="~\images\Cancel.gif" EditImageUrl="~\images\Edit.gif"
                                        InsertImageUrl="~\images\Insert.gif" UpdateImageUrl="~\images\Update.gif" ButtonType="ImageButton">
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_document_category_id" DataType="System.Int32"
                                        HeaderText="key_document_category_id" ReadOnly="True" SortExpression="key_document_category_id"
                                        UniqueName="key_document_category_id" Visible="False">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_document_category_name" HeaderText="Document Category"
                                        SortExpression="txt_document_category_name" UniqueName="txt_document_category_name">
                                    </radG:GridBoundColumn>
                                    <radG:GridButtonColumn CommandName="Delete" ConfirmText="Are you sure you wish to delete this Document Category"
                                        ImageUrl="~\images\delete.gif" Text="Delete" UniqueName="column" ButtonType="ImageButton">
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </radG:RadGrid>
                        
                        <asp:SqlDataSource ID="sqlds_documentCategories" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" DeleteCommand="pr_scs_document_category_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_scs_document_category_ins" InsertCommandType="StoredProcedure" SelectCommand="pr_scs_document_category_get_list" SelectCommandType="StoredProcedure" UpdateCommand="pr_scs_document_category_upd" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="key_document_category_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_document_category_id" Type="Int32" />
                                <asp:Parameter Name="txt_document_category_name" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_document_category_name" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:View>
                    <br />
                    <asp:View ID="v_Accountability_Narrative" runat="server">                      
                        <radG:RadGrid ID="rg_Accountability_Narrative" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="ds_Accountability_Narrative" GridLines="None"  Skin="Default" AutoGenerateColumns="False">
                            <MasterTableView DataKeyNames="key_accountability_narrative_id"
                                DataSourceID="ds_Accountability_Narrative" CommandItemDisplay="Top" >
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/images/Edit.gif"
                                        InsertImageUrl="~/images/Insert.gif" UpdateImageUrl="~/images/Update.gif">
                                        <ItemStyle Width="0.5in" />
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_accountability_narrative_id" DataType="System.Int32"
                                        HeaderText="key_accountability_narrative_id" ReadOnly="True" SortExpression="key_accountability_narrative_id"
                                        UniqueName="key_accountability_narrative_id" Display="False">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_narrative_section_title" HeaderText="Title"
                                        SortExpression="txt_narrative_section_title" UniqueName="txt_narrative_section_title">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="txt_narrative_desc" HeaderText="Description"
                                        SortExpression="txt_narrative_desc" UniqueName="txt_narrative_desc">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_narrative_descTextBox" runat="server" Height="75px" Text='<%# Bind("txt_narrative_desc") %>'
                                                TextMode="MultiLine" Width="700px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="txt_narrative_descLabel" runat="server" Text='<%# Eval("txt_narrative_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_optional" DataType="System.Boolean" HeaderText="Optional"
                                        SortExpression="flg_optional" UniqueName="flg_optional">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridTemplateColumn DataField="dte_created_date" DataType="System.DateTime"
                                        HeaderText="Created Date" SortExpression="dte_created_date" UniqueName="dte_created_date">
                                        <EditItemTemplate>
                                            <radCln:RadDatePicker ID="dte_created_dateTextBox" runat="server" Culture="English (United States)"
                                                MinDate="1900-01-01" DBSelectedDate='<%# Bind("dte_created_date") %>' Skin="Office2007">
                                                <DateInput Skin="Office2007">
                                                </DateInput>
                                                <Calendar Skin="Office2007">
                                                </Calendar>
                                            </radCln:RadDatePicker>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="dte_created_dateLabel" runat="server" Text='<%# string.Format("{0:d}", Eval("dte_created_date")) %>'></asp:Label>
                                        </ItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridBoundColumn DataField="txt_created_user" HeaderText="Created User"
                                        SortExpression="txt_created_user" UniqueName="txt_created_user">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="dte_updated_date" DataType="System.DateTime"
                                        HeaderText="Updated Date" SortExpression="dte_updated_date" UniqueName="dte_updated_date">
                                        <EditItemTemplate>
                                            <radCln:RadDatePicker ID="dte_updated_dateTextBox" runat="server" Culture="English (United States)"
                                                MinDate="1900-01-01" DBSelectedDate='<%# Bind("dte_updated_date") %>' Skin="Office2007">
                                                <DateInput Skin="Office2007">
                                                </DateInput>
                                                <Calendar Skin="Office2007">
                                                </Calendar>
                                            </radCln:RadDatePicker>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="dte_updated_dateLabel" runat="server" Text='<%# string.Format("{0:d}", Eval("dte_updated_date")) %>'></asp:Label>
                                        </ItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridBoundColumn DataField="txt_updated_user" HeaderText="Updated User"
                                        SortExpression="txt_updated_user" UniqueName="txt_updated_user">
                                    </radG:GridBoundColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this accountability narrative?"
                                        ImageUrl="~/images/Delete.gif" Text="Delete" UniqueName="DeleteColumn">
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </radG:RadGrid>
                        <asp:SqlDataSource ID="ds_Accountability_Narrative" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_scs_accountability_narrative_get" SelectCommandType="StoredProcedure" InsertCommand="pr_scs_accountability_narrative_ins" InsertCommandType="StoredProcedure" DeleteCommand="pr_scs_accountability_narrative_del" DeleteCommandType="StoredProcedure" UpdateCommand="pr_scs_accountability_narrative_upd" UpdateCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="txt_narrative_section_title" Type="String" />
                                <asp:Parameter Name="txt_narrative_desc" Type="String" />
                                <asp:Parameter Name="flg_optional" Type="Boolean" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                                <asp:Parameter Name="dte_created_date" Type="DateTime" />
                                <asp:Parameter Name="txt_created_user" Type="String" />
                                <asp:Parameter Name="dte_updated_date" Type="DateTime" />
                                <asp:Parameter Name="txt_updated_user" Type="String" />
                            </InsertParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="key_accountability_narrative_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_accountability_narrative_id" Type="Int32" />
                                <asp:Parameter Name="txt_narrative_section_title" Type="String" />
                                <asp:Parameter Name="txt_narrative_desc" Type="String" />
                                <asp:Parameter Name="flg_optional" Type="Boolean" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                                <asp:Parameter Name="dte_created_date" Type="DateTime" />
                                <asp:Parameter Name="txt_created_user" Type="String" />
                                <asp:Parameter Name="dte_updated_date" Type="DateTime" />
                                <asp:Parameter Name="txt_updated_user" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </asp:View>
                    <br />
                    <asp:View ID="v_Imp_Plan_Narrative" runat="server">
                        <radG:RadGrid ID="RadGrid1" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="ds_Imp_Plan_Narratives" GridLines="None"  Skin="Default" AutoGenerateColumns="False" EnableAJAX="True">
                            <MasterTableView DataKeyNames="key_ip_narrative_id"
                                DataSourceID="ds_Imp_Plan_Narratives" CommandItemDisplay="Top" >
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/images/Edit.gif"
                                        InsertImageUrl="~/images/Insert.gif">
                                        <ItemStyle Width="0.5in" />
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_ip_narrative_id" DataType="System.Int32"
                                        HeaderText="key_ip_narrative_id" ReadOnly="True" SortExpression="key_ip_narrative_id"
                                        UniqueName="key_ip_narrative_id" Display="False">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_narrative_section_title" HeaderText="Title"
                                        SortExpression="txt_narrative_section_title" UniqueName="txt_narrative_section_title">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="txt_narrative_desc" HeaderText="Description"
                                        SortExpression="txt_narrative_desc" UniqueName="txt_narrative_desc">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_narrative_descTextBox" runat="server" Height="75px" Text='<%# Bind("txt_narrative_desc") %>'
                                                TextMode="MultiLine" Width="700px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="txt_narrative_descLabel" runat="server" Text='<%# Eval("txt_narrative_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_optional" DataType="System.Boolean" HeaderText="Optional"
                                        SortExpression="flg_optional" UniqueName="flg_optional">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridTemplateColumn DataField="dte_created_date" DataType="System.DateTime"
                                        HeaderText="Created Date" SortExpression="dte_created_date" UniqueName="dte_created_date">
                                        <EditItemTemplate>
                                            <radCln:RadDatePicker ID="dte_created_dateTextBox" runat="server" Culture="English (United States)"
                                                MinDate="1900-01-01" DBSelectedDate='<%# Bind("dte_created_date") %>' Skin="Office2007">
                                                <DateInput Skin="Office2007">
                                                </DateInput>
                                                <Calendar Skin="Office2007">
                                                </Calendar>
                                            </radCln:RadDatePicker>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="dte_created_dateLabel" runat="server" Text='<%# string.Format("{0:d}", Eval("dte_created_date")) %>'></asp:Label>
                                        </ItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridBoundColumn DataField="txt_created_user" HeaderText="Created User"
                                        SortExpression="txt_created_user" UniqueName="txt_created_user">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="dte_updated_date" DataType="System.DateTime"
                                        HeaderText="Updated Date" SortExpression="dte_updated_date" UniqueName="dte_updated_date">
                                        <EditItemTemplate>
                                            <radCln:RadDatePicker ID="dte_updated_dateTextBox" runat="server" Culture="English (United States)"
                                                MinDate="1900-01-01" DBSelectedDate='<%# Bind("dte_updated_date") %>' Skin="Office2007">
                                                <DateInput Skin="Office2007">
                                                </DateInput>
                                                <Calendar Skin="Office2007">
                                                </Calendar>
                                            </radCln:RadDatePicker>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="dte_updated_dateLabel" runat="server" Text='<%# string.Format("{0:d}", Eval("dte_updated_date")) %>'></asp:Label>
                                        </ItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridBoundColumn DataField="txt_updated_user" HeaderText="Updated User"
                                        SortExpression="txt_updated_user" UniqueName="txt_updated_user">
                                    </radG:GridBoundColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this Improvement Plan Narrative?"
                                        ImageUrl="~/images/Delete.gif" Text="Delete" UniqueName="column">
                                        <ItemStyle Width="0.5in" />
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </radG:RadGrid>
                        <asp:SqlDataSource ID="ds_Imp_Plan_Narratives" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_scs_improvement_plan_narrative_get" SelectCommandType="StoredProcedure" InsertCommand="pr_scs_improvement_plan_narrative_ins" InsertCommandType="StoredProcedure" DeleteCommand="pr_scs_improvement_plan_narrative_del" DeleteCommandType="StoredProcedure" UpdateCommand="pr_scs_improvement_plan_narrative_upd" UpdateCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="txt_narrative_section_title" Type="String" />
                                <asp:Parameter Name="txt_narrative_desc" Type="String" />
                                <asp:Parameter Name="flg_optional" Type="Boolean" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                                <asp:Parameter Name="dte_created_date" Type="DateTime" />
                                <asp:Parameter Name="txt_created_user" Type="String" />
                                <asp:Parameter Name="dte_updated_date" Type="DateTime" />
                                <asp:Parameter Name="txt_updated_user" Type="String" />
                            </InsertParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="key_ip_narrative_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_ip_narrative_id" Type="Int32" />
                                <asp:Parameter Name="txt_narrative_section_title" Type="String" />
                                <asp:Parameter Name="txt_narrative_desc" Type="String" />
                                <asp:Parameter Name="flg_optional" Type="Boolean" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                                <asp:Parameter Name="dte_created_date" Type="DateTime" />
                                <asp:Parameter Name="txt_created_user" Type="String" />
                                <asp:Parameter Name="dte_updated_date" Type="DateTime" />
                                <asp:Parameter Name="txt_updated_user" Type="String" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </asp:View>
                    <br />
                    <asp:View ID="v_Spe_Pop_Cat" runat="server">
                        <radG:RadGrid ID="rg_Sp_Cat" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="ds_Sp_Categories" GridLines="None"  Skin="Default" AutoGenerateColumns="False" EnableAJAX="True">
                            <MasterTableView DataKeyNames="key_special_population_id"
                                DataSourceID="ds_Sp_Categories" CommandItemDisplay="Top" >
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/images/Edit.gif"
                                        InsertImageUrl="~/images/Insert.gif" UpdateImageUrl="~/images/Update.gif">
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_special_population_id" DataType="System.Int32"
                                        Display="False" HeaderText="key_special_population_id" ReadOnly="True" SortExpression="key_special_population_id"
                                        UniqueName="key_special_population_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridTemplateColumn DataField="txt_desc" HeaderText="Description" SortExpression="txt_desc"
                                        UniqueName="txt_desc">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_descTextBox" runat="server" Text='<%# Bind("txt_desc") %>' Width="400px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="txt_descLabel" runat="server" Text='<%# Eval("txt_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this Special Population?"
                                        ImageUrl="~/images/Delete.gif" Text="Delete" UniqueName="column">
                                        <HeaderStyle HorizontalAlign="Right" Width="0.5in" />
                                        <ItemStyle Width="0.5in" />
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </radG:RadGrid>
                        <asp:SqlDataSource ID="ds_Sp_Categories" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_scs_special_population_get" SelectCommandType="StoredProcedure" DeleteCommand="pr_scs_special_population_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_scs_special_population_ins" InsertCommandType="StoredProcedure" UpdateCommand="pr_scs_special_population_upd" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="key_special_population_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_special_population_id" Type="Int32" />
                                <asp:Parameter Name="txt_desc" Type="String" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_desc" Type="String" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:View>
                    <br />
                    <asp:View ID="v_Gender" runat="server">
                        <radG:RadGrid ID="rg_Gender" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="ds_Gender" GridLines="None"  Skin="Default" AutoGenerateColumns="False" EnableAJAX="True">
                            <MasterTableView DataKeyNames="key_gender_id"
                                DataSourceID="ds_Gender" CommandItemDisplay="Top" >
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/images/Edit.gif"
                                        InsertImageUrl="~/images/Insert.gif" UpdateImageUrl="~/images/Update.gif">
                                        <ItemStyle Width="0.2in" />
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_gender_id" DataType="System.Int32" HeaderText="Gender Id"
                                        ReadOnly="True" SortExpression="key_gender_id" UniqueName="key_gender_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_gender_name" HeaderText="Gender Name" SortExpression="txt_gender_name"
                                        UniqueName="txt_gender_name">
                                    </radG:GridBoundColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this Gender?"
                                        ImageUrl="~/images/Delete.gif" Text="Delete" UniqueName="column">
                                        <ItemStyle HorizontalAlign="Right" Width="0.2in" />
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </radG:RadGrid>
                        <asp:SqlDataSource ID="ds_Gender" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_scs_gender_get" SelectCommandType="StoredProcedure" DeleteCommand="pr_scs_gender_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_scs_gender_ins" InsertCommandType="StoredProcedure" UpdateCommand="pr_scs_gender_upd" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="key_gender_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_gender_id" Type="Int32" />
                                <asp:Parameter Name="txt_gender_name" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_gender_name" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:View>
                    <br />
                    <asp:View ID="v_Race" runat="server">
                        <radG:RadGrid ID="RadGrid5" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="ds_Race" GridLines="None"  Skin="Default" AutoGenerateColumns="False" EnableAJAX="True">
                            <MasterTableView DataKeyNames="key_race_id"
                                DataSourceID="ds_Race" CommandItemDisplay="Top" >
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/images/Edit.gif"
                                        InsertImageUrl="~/images/Insert.gif" UpdateImageUrl="~/images/Update.gif">
                                        <ItemStyle Width="0.2in" />
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_race_id" DataType="System.Int32" HeaderText="Race Id"
                                        ReadOnly="True" SortExpression="key_race_id" UniqueName="key_race_id">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_race_name" HeaderText="Race Name" SortExpression="txt_race_name"
                                        UniqueName="txt_race_name">
                                    </radG:GridBoundColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this Race?"
                                        ImageUrl="~/images/Delete.gif" Text="Delete" UniqueName="column">
                                        <ItemStyle Width="0.2in" />
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </radG:RadGrid>
                        <asp:SqlDataSource ID="ds_Race" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_scs_race_get" SelectCommandType="StoredProcedure" DeleteCommand="pr_scs_race_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_scs_race_ins" InsertCommandType="StoredProcedure" UpdateCommand="pr_scs_race_upd" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="key_race_id" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="key_race_id" Type="Int32" />
                                <asp:Parameter Name="txt_race_name" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_race_name" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:View>
                    <br />
                <asp:View id="FiscalYearSchedule" runat="server" OnPreRender="FiscalYearSchedule_PreRender">&nbsp; <radG:RadGrid style="POSITION: relative" id="RD_FISCALSCHEDULE" runat="server" Skin="Default" DataSourceID="SQLDS_RLFISCALYEARSCHEDULE" AutoGenerateColumns="False" GridLines="None" OnDataBinding="RD_FISCALSCHEDULE_DataBinding" OnItemCommand="RD_FISCALSCHEDULE_ItemCommand" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True">
<MasterTableView DataKeyNames="key_fiscal_year_schedule_id" DataSourceID="SQLDS_RLFISCALYEARSCHEDULE" CommandItemDisplay="Bottom">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
<Columns>
<radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/images/Edit.gif"></radG:GridEditCommandColumn>
<radG:GridBoundColumn DataField="key_fiscal_year_schedule_id" ReadOnly="True" HeaderText="key_fiscal_year_schedule_id" SortExpression="key_fiscal_year_schedule_id" UniqueName="key_fiscal_year_schedule_id" DataType="System.Int32"></radG:GridBoundColumn>
    <radG:GridTemplateColumn DataField="key_fiscal_year_id" DataType="System.Int32" HeaderText="key_fiscal_year_id"
        SortExpression="key_fiscal_year_id" UniqueName="key_fiscal_year_id">
        <EditItemTemplate>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1"
                DataTextField="nbr_fiscal_year" DataValueField="key_fiscal_year_id" SelectedValue='<%# Bind("key_fiscal_year_id") %>'
                Style="position: relative" Width="141px" OnDataBound="DropDownList1_DataBound">
              
            </asp:DropDownList>&nbsp;&nbsp;
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="key_fiscal_year_idLabel" runat="server" Text='<%# Eval("key_fiscal_year_id") %>'></asp:Label>
        </ItemTemplate>
    </radG:GridTemplateColumn>
    <radG:GridTemplateColumn DataField="dte_date_from" DataType="System.DateTime" HeaderText="dte_date_from"
        SortExpression="dte_date_from" UniqueName="dte_date_from">
        <EditItemTemplate>
            <radCln:RadDatePicker ID="RDDate_DATEFROM" runat="server" AllowEmpty="False" Culture="English (United States)"
                Style="position: relative" SelectedDate='<%# Eval("dte_date_from") %>'>
                <DateInput CatalogIconImageUrl="" Description="" DisplayPromptChar="_" PromptChar=" "
                    Title="" TitleIconImageUrl="" TitleUrl=""></DateInput>
            </radCln:RadDatePicker>
            &nbsp;
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="dte_date_fromLabel" runat="server" Text='<%# Eval("dte_date_from") %>'></asp:Label>
        </ItemTemplate>
    </radG:GridTemplateColumn>
    <radG:GridTemplateColumn DataField="dte_date_to" DataType="System.DateTime" HeaderText="dte_date_to"
        SortExpression="dte_date_to" UniqueName="dte_date_to">
        <EditItemTemplate>
            <radCln:RadDatePicker ID="RadDatePicker2" runat="server" AllowEmpty="False" Culture="English (United States)"
                Style="position: relative">
                <DateInput CatalogIconImageUrl="" Description="" DisplayPromptChar="_" PromptChar=" "
                    Title="" TitleIconImageUrl="" TitleUrl=""></DateInput>
            </radCln:RadDatePicker>
            &nbsp;
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="dte_date_toLabel" runat="server" Text='<%# Eval("dte_date_to") %>'></asp:Label>
        </ItemTemplate>
    </radG:GridTemplateColumn>
    <radG:GridTemplateColumn DataField="txt_section_name" HeaderText="txt_section_name"
        SortExpression="txt_section_name" UniqueName="txt_section_name">
        <EditItemTemplate>
            <asp:TextBox ID="txt_section_nameTextBox" runat="server" Text='<%# Bind("txt_section_name") %>'
                Width="225px"></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="txt_section_nameLabel" runat="server" Text='<%# Eval("txt_section_name") %>'></asp:Label>
        </ItemTemplate>
    </radG:GridTemplateColumn>
    <radG:GridTemplateColumn DataField="txt_section_description" HeaderText="txt_section_description"
        SortExpression="txt_section_description" UniqueName="txt_section_description">
        <EditItemTemplate>
            <asp:TextBox ID="txt_section_descriptionTextBox" runat="server" Height="177px" Text='<%# Bind("txt_section_description") %>'
                TextMode="MultiLine" Width="386px"></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="txt_section_descriptionLabel" runat="server" Text='<%# Eval("txt_section_description") %>'></asp:Label>
        </ItemTemplate>
    </radG:GridTemplateColumn>
<radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="column" ImageUrl="~/images/Delete.gif"></radG:GridButtonColumn>
</Columns>
    <EditFormSettings EditFormType="Template">
        <EditColumn UniqueName="EditCommandColumn1">
        </EditColumn>
    </EditFormSettings>
</MasterTableView>
</radG:RadGrid>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_scs_fiscal_year_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        &nbsp; <asp:SqlDataSource id="SQLDS_RLFISCALYEARSCHEDULE" runat="server" SelectCommand="pr_scs_fiscal_year_schedule_get" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" UpdateCommandType="StoredProcedure" UpdateCommand="pr_scs_fiscal_year_schedule_upd" InsertCommandType="StoredProcedure" InsertCommand="pr_scs_fiscal_year_schedule_ins" DeleteCommandType="StoredProcedure" DeleteCommand="pr_scs_fiscal_year_schedule_upd" SelectCommandType="StoredProcedure" OnDataBinding="SQLDS_RLFISCALYEARSCHEDULE_DataBinding"><SelectParameters>
<asp:ControlParameter ControlID="hdF_yearID" PropertyName="Value" DefaultValue="" Name="p_key_fiscal_year_id" Type="Int32"></asp:ControlParameter>
</SelectParameters>
<DeleteParameters>
<asp:Parameter Name="key_fiscal_year_schedule_id" Type="Int32"></asp:Parameter>
<asp:Parameter Name="key_fiscal_year_id" Type="Int32"></asp:Parameter>
<asp:Parameter Name="dte_date_from" Type="DateTime"></asp:Parameter>
<asp:Parameter Name="dte_date_to" Type="DateTime"></asp:Parameter>
<asp:Parameter Name="txt_section_name" Type="String"></asp:Parameter>
<asp:Parameter Name="txt_section_description" Type="String"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="key_fiscal_year_schedule_id" Type="Int32"></asp:Parameter>
<asp:Parameter Name="key_fiscal_year_id" Type="Int32"></asp:Parameter>
<asp:Parameter Name="dte_date_from" Type="DateTime"></asp:Parameter>
<asp:Parameter Name="dte_date_to" Type="DateTime"></asp:Parameter>
<asp:Parameter Name="txt_section_name" Type="String"></asp:Parameter>
<asp:Parameter Name="txt_section_description" Type="String"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="key_fiscal_year_id" Type="Int32"></asp:Parameter>
<asp:Parameter Name="dte_date_from" Type="DateTime" ></asp:Parameter>
<asp:Parameter Name="dte_date_to" Type="DateTime"></asp:Parameter>
<asp:Parameter Name="txt_section_name" Type="String"></asp:Parameter>
<asp:Parameter Name="txt_section_description" Type="String"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> <asp:SqlDataSource id="SQLDSRL_GETYEARID" runat="server" SelectCommand="SELECT     key_fiscal_year_id, nbr_fiscal_year, dte_date_from, dte_date_to, flg_period_open&#13;&#10;FROM         scs_fiscal_year where nbr_fiscal_year = @yearI" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" OnSelected="SQLDSRL_GETYEARID_Selected"><SelectParameters>
<asp:Parameter Name="yearI"></asp:Parameter>
</SelectParameters>
</asp:SqlDataSource> <asp:HiddenField id="hdF_yearID" runat="server"></asp:HiddenField></asp:View> &nbsp;
                </asp:MultiView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td style="width: 229px">
                        </td>
                    </tr>
                </table>
                <br />
                &nbsp; &nbsp;<span style="color: black"></span>
                <br />
            </td>
        </tr>
        <tr>
            <td style="height: 12px; width: 958px;">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="height: 12px; width: 958px;">
                &nbsp;<br />
                <br />
            </td>
        </tr>
        <tr>
            <td style="height: 12px; width: 958px;">
                
                <radW:RadWindowManager ID="RadWindowManager1" runat="server">
                    <Windows>
                        <radw:RadWindow ID="UserListDialog" runat="server" Title="Task Information" Height="400px"
                            Width="300px" Left="150px" ReloadOnShow="true" Modal="true" Skin="Office2007" />
                    </Windows>
                </radW:RadWindowManager>
                <asp:SqlDataSource ID="SqlDataSourceCatType" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="SELECT [key_category_type_id], [txt_category_type_desc] FROM [scs_category_type] ORDER BY [txt_category_type_desc]">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

