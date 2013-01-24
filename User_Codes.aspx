<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Maintain_User_Codes.aspx.cs" Inherits="Maintain_User_Codes" Title="Untitled Page" %>

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
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size: 9pt">
        <tr>
            <td style="height: 10px">
                <asp:SqlDataSource ID="SqlDataSourceSelect" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT [system_tables_key_id], [txt_Name] FROM [scs_system_tables] ORDER BY [txt_Name]"></asp:SqlDataSource>
                <hr />
                &nbsp;
                <span style="color: black">
                <strong><span>
                Select &nbsp;System Table:</span></strong>&nbsp;</span>
                <asp:DropDownList ID="ddIndicator" runat="server" DataSourceID="SqlDataSourceSelect" DataTextField="txt_Name" DataValueField="system_tables_key_id" OnDataBound="ddIndicator_DataBound" AutoPostBack="True" OnSelectedIndexChanged="ddIndicator_SelectedIndexChanged" Width="200px">
                </asp:DropDownList>
                <br />
                <hr />
            </td>
        </tr>
        <tr>
            <td style="height: 12px">
                <radA:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Width="100%">
                <asp:MultiView ID="mvMultiView1" runat="server">
                    <asp:View ID="vCategories" runat="server">
                        <radG:RadGrid ID="gCategories" runat="server" AllowPaging="True" DataSourceID="SqlDataSourceCat"
                            EnableAJAX="True" GridLines="Horizontal" OnNeedDataSource="gCategories_NeedDataSource" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" OnItemDataBound="gCategories_ItemDataBound" OnItemCreated="gCategories_ItemCreated" Width="98%" AutoGenerateColumns="False" Skin="Telerik" >
                            <MasterTableView CommandItemDisplay="Bottom" DataKeyNames="key_category_id"
                                DataSourceID="SqlDataSourceCat" PageSize="5" Font-Overline="False"  GridLines="Horizontal" SkinID="booksSkin" CellPadding="1" CellSpacing="1">
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~\images\Edit.gif"
                                        InsertImageUrl="~\images\Insert.gif" UpdateImageUrl="~\images\Update.gif">
                                    </radG:GridEditCommandColumn>
                                    <radG:GridBoundColumn DataField="key_category_id" DataType="System.Int32" Display="False"
                                        HeaderText="key_category_id" ReadOnly="True" SortExpression="key_category_id"
                                        UniqueName="key_category_id">
                                        <ItemStyle />
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
                                                ErrorMessage="* Required"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemStyle Font-Size="9pt" />
                                    </radG:GridTemplateColumn>
                                    <radG:GridTemplateColumn DataField="txt_category_title" HeaderText="Title" SortExpression="txt_category_title"
                                        UniqueName="txt_category_title">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_category_titleLabel" runat="server" Text='<%# Eval("txt_category_title") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_category_titleTextBox" runat="server" Text='<%# Bind("txt_category_title") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txt_category_titleTextBox"
                                                ErrorMessage="* Required"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemStyle  Font-Size="9pt" />
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
                                        <ItemStyle Font-Size="9pt" />
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
                                                ErrorMessage="* Required"></asp:RequiredFieldValidator>
                                            <asp:HiddenField ID="hfKeyValue" runat="server" Value='<%# Bind("key_category_type_id") %>' />
                                        </EditItemTemplate>
                                        <ItemStyle Font-Size="9pt" />
                                    </radG:GridTemplateColumn>
                                    <radG:GridBoundColumn DataField="txt_category_type_desc" HeaderText="Type Description"
                                        SortExpression="txt_category_type_desc" UniqueName="txt_category_type_desc" ReadOnly="True">
                                        <ItemStyle Font-Size="9pt" />
                                    </radG:GridBoundColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ImageUrl="~\images\Delete.gif"
                                        Text="Delete" UniqueName="DeleteColumn" ConfirmText="Are you sure you want to delete this Category?">
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
                            <GroupPanel Visible="True">
                            </GroupPanel>
                            
                        </radG:RadGrid><br />
                        <asp:SqlDataSource ID="SqlDataSourceCat" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_scs_category_get" SelectCommandType="StoredProcedure" DeleteCommand="pr_scs_category_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_scs_category_ins" InsertCommandType="StoredProcedure" UpdateCommand="pr_scs_category_upd" UpdateCommandType="StoredProcedure">
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
                        </asp:SqlDataSource>
                        &nbsp;
                    </asp:View>
                    <asp:View ID="vCoreIndicators" runat="server">
                        <radg:radgrid id="gCoreIndicator" runat="server" DataSourceID="SqlDataSourceInd" GridLines="None" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowPaging="True" EnableAJAX="True" Skin="Telerik" Width="98%">
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
                                                ErrorMessage="* Required"></asp:RequiredFieldValidator>
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
                                                ErrorMessage="* Required"></asp:RequiredFieldValidator>
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
                    </asp:View>                    
                    <asp:View ID="vAssurance" runat="server">
                            <radG:RadGrid ID="gAssurance" runat="server" DataSourceID="SqlDataSourceAss"
                            GridLines="None" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowPaging="True" EnableAJAX="True" Skin="Telerik" Width="98%">
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
                                                ErrorMessage="* Required"></asp:RequiredFieldValidator>
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
                                    <EditColumn ButtonType="ImageButton" UpdateImageUrl="~/images/Update.gif" CancelImageUrl="~/images/Cancel.gif" />
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
                    </asp:View>
                    <br />
                    <asp:View ID="vNarrative" runat="server">
                        <radG:RadGrid ID="gNarrative" runat="server" DataSourceID="SqlDataSourceNar" GridLines="None" AllowPaging="True" EnableAJAX="True" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" Skin="Telerik" Width="98%">
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSourceNar" DataKeyNames="key_narrative_id" CommandItemDisplay="Bottom">
                                <ExpandCollapseColumn Visible="False" Resizable="False">
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <RowIndicatorColumn Visible="False">
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <Columns>
                                    <radG:GridEditCommandColumn ButtonType="ImageButton" EditFormHeaderTextFormat="{0}"
                                        EditImageUrl="~\images\Edit.gif" InsertImageUrl="~\images\Insert.gif" UpdateImageUrl="~\images\Update.gif">
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
                                                Width="200px" BorderStyle="None"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txt_narrative_section_titleTextBox"
                                                ErrorMessage="* Required"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridTemplateColumn DataField="txt_narrative_desc" HeaderText="Description"
                                        SortExpression="txt_narrative_desc" UniqueName="txt_narrative_desc">
                                        <ItemTemplate>
                                            <asp:Label ID="txt_narrative_descLabel" runat="server" Text='<%# Eval("txt_narrative_desc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            &nbsp;<radE:RadEditor ID="RadEditor1" runat="server" ConvertTagsToLower="True" ConvertToXhtml="False"
                                                DocumentsFilters="*.*" EnableClientSerialize="True" EnableContextMenus="True"
                                                EnableDocking="True" EnableEnhancedEdit="True" EnableHtmlIndentation="True" EnableServerSideRendering="True"
                                                EnableTab="True" Height="195px" Html='<%# Bind("txt_narrative_desc") %>' ImagesFilters="*.gif,*.xbm,*.xpm,*.png,*.ief,*.jpg,*.jpe,*.jpeg,*.tiff,*.tif,*.rgb,*.g3f,*.xwd,*.pict,*.ppm,*.pgm,*.pbm,*.pnm,*.bmp,*.ras,*.pcd,*.cgm,*.mil,*.cal,*.fif,*.dsf,*.cmx,*.wi,*.dwg,*.dxf,*.svf"
                                                MediaFilters="*.asf,*.asx,*.wm,*.wmx,*.wmp,*.wma,*.wax,*.wmv,*.wvx,*.avi,*.wav,*.mpeg,*.mpg,*.mpe,*.mov,*.m1v,*.mp2,*.mpv2,*.mp2v,*.mpa,*.mp3,*.m3u,*.mid,*.midi,*.rm,*.rma,*.rmi,*.rmv,*.aif,*.aifc,*.aiff,*.au,*.snd"
                                                OnClientCancel="" OnClientCommandExecuted="" OnClientCommandExecuting="" OnClientInit=""
                                                OnClientLoad="" OnClientModeChange="" OnClientSubmit="" PassSessionData="True"
                                                RenderAsTextArea="False" Skin="Office2007" SpellEditDistance="1" TemplateFilters="*.html,*.htm"
                                                ToolbarMode="Default" ToolsWidth="" Width="570px"></radE:RadEditor>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txt_narrative_descTextBox"
                                                ErrorMessage="* Required"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </radG:GridTemplateColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_optional" DataType="System.Boolean" HeaderText="Optional"
                                        SortExpression="flg_optional" UniqueName="flg_optional">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="Inactive"
                                        SortExpression="flg_inactive" UniqueName="flg_inactive">
                                    </radG:GridCheckBoxColumn>
                                    <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this narrative?"
                                        ImageUrl="~\images\Delete.gif" Text="Delete" UniqueName="column">
                                    </radG:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn ButtonType="ImageButton" UpdateImageUrl="~/images/Update.gif" CancelImageUrl="~/images/Cancel.gif" UniqueName="EditCommandColumn1" />
                                </EditFormSettings>
                            </MasterTableView>
                  
                        </radG:RadGrid><br />
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
                                <asp:Parameter Name="flg_optional" Type="Boolean" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="txt_narrative_section_title" Type="String" />
                                <asp:Parameter Name="txt_narrative_desc" Type="String" />
                                <asp:Parameter Name="flg_optional" Type="Boolean" />
                                <asp:Parameter Name="flg_inactive" Type="Boolean" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                    </asp:View>
                    <asp:View ID="vFaActivityType" runat="server">
                        <radG:RadGrid ID="gFaActivity" runat="server" AllowPaging="True" DataSourceID="SqlDataSourceFaActivity"
                            EnableAJAX="True" GridLines="None" Skin="Telerik" Width="98%">
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
                    </asp:View>
                    <asp:View ID="vFunctionCode" runat="server">
                        <radG:RadGrid ID="gFunctionCode" runat="server" AllowPaging="True" DataSourceID="SqlDataSourceFunctionCode"
                            EnableAJAX="True" GridLines="None" Skin="Telerik" Width="98%" Height="252px">
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
                    </asp:View>
                    <asp:View ID="vLineItemType" runat="server">
                        <radG:RadGrid ID="gLineItem" runat="server" AllowPaging="True" DataSourceID="SqlDataSourceLineItem"
                            EnableAJAX="True" GridLines="None" Skin="Telerik" Width="98%">
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
                    </asp:View>
                    <asp:View ID="vLocalPlanLevel" runat="server">
                        <radG:RadGrid ID="gLocalPlan" runat="server" AllowPaging="True" DataSourceID="SqlDataSourceLocalPlan"
                            EnableAJAX="True" GridLines="None" Skin="Telerik" Width="98%">
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
                    </asp:View>
                    <asp:View ID="vActivityLevel" runat="server">
                        <radG:RadGrid ID="RadGrid3" runat="server" AllowPaging="True" DataSourceID="SqlDataSourceActivityLevel"
                            EnableAJAX="True" GridLines="None" OnNeedDataSource="RadGrid3_NeedDataSource" Skin="Telerik" Width="98%">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_activity_level_id"
                                DataSourceID="SqlDataSourceActivityLevel">
                                <Columns>
                                    <radG:GridBoundColumn DataField="key_activity_level_id" DataType="System.Int32" HeaderText="Id"
                                        ReadOnly="True" SortExpression="key_activity_level_id" UniqueName="key_activity_level_id" Visible="False">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="nbr_activity_level_nbr" DataType="System.Int32"
                                        HeaderText="Level Number" SortExpression="nbr_activity_level_nbr" UniqueName="nbr_activity_level_nbr">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_activity_level_status" HeaderText="Status" SortExpression="txt_activity_level_status"
                                        UniqueName="txt_activity_level_status">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_activity_level_desc" HeaderText="Description"
                                        SortExpression="txt_activity_level_desc" UniqueName="txt_activity_level_desc">
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
                    </asp:View>
                </asp:MultiView></radA:RadAjaxPanel>
                </td>
        </tr>
        <tr>
            <td style="height: 12px">
                &nbsp;<br />
                <br />
            </td>
        </tr>
        <tr>
            <td style="height: 12px">
                <radA:RadAjaxManager ID="RadAjaxManager1" runat="server">
                    <AjaxSettings>
                        <radA:AjaxSetting AjaxControlID="ddIndicator">
                            <UpdatedControls>
                                <radA:AjaxUpdatedControl ControlID="RadAjaxPanel1" />
                            </UpdatedControls>
                        </radA:AjaxSetting>
                    </AjaxSettings>
                </radA:RadAjaxManager>
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

