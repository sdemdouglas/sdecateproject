<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Documents.aspx.cs" Inherits="DocumentLibrary_DocumentView" Title="Local Plan Document Setup" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<asp:Content ID="Content2" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
        function GetPathValue()
        { 
            // hfPath is an ID of the control in EditTemplateColumn                    
            document.getElementById(window['hfPath']).value = document.getElementById(window['fuPath']).value;
            
            //alert(document.getElementById(window['hidPath']).value);                               
        }
    </script>
    <radg:radgrid id="gDoc" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="SqlDataSourceDoc" GridLines="None" OnItemCreated="gDoc_ItemCreated" OnInsertCommand="gDoc_InsertCommand" Skin="Default" Width="746px" OnEditCommand="gDoc_EditCommand" OnItemDataBound="gDoc_ItemDataBound" OnItemCommand="gDoc_ItemCommand">
<MasterTableView AutoGenerateColumns="False" CommandItemDisplay="Bottom" DataKeyNames="key_doc_file_storage_id" DataSourceID="SqlDataSourceDoc">
<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>

<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>
    <CommandItemSettings AddNewRecordText="Add New Document" />
    <Columns>
        <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~\images\Edit.gif"
            InsertImageUrl="~\images\Insert.gif" UpdateImageUrl="~\images\Update.gif">
            <ItemStyle Width="0.6in" />
        </radG:GridEditCommandColumn>
        <radG:GridBoundColumn DataField="key_doc_file_storage_id" DataType="System.Int32" Display="False"
            HeaderText="key_doc_file_storage_id" ReadOnly="True" SortExpression="key_doc_file_storage_id" UniqueName="key_doc_file_storage_id">
        </radG:GridBoundColumn>
        
        
        <radG:GridTemplateColumn DataField="txt_File_Title" HeaderText="Document Title" SortExpression="txt_File_Title"
            UniqueName="txt_File_Title">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='#' Text='<%# Eval("txt_File_Title") %>' Target="_blank"></asp:HyperLink>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtDocument" runat="server" Text='<%# Bind("txt_File_Title") %>' Width="300px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDocument"
                    ErrorMessage="* Required"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemStyle Width="5in" />
        </radG:GridTemplateColumn>
        <radG:GridTemplateColumn DataField="Location" HeaderText="Location" SortExpression="bin_binaryFile_data"
            UniqueName="Location" Visible="False">
            <ItemTemplate>
                <asp:Label ID="pathLabel" runat="server" ></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>                
                <asp:FileUpload ID="fuPath" runat="server" Width="578px" />                                
            </EditItemTemplate>
        </radG:GridTemplateColumn>
        <radG:GridTemplateColumn DataField="key_document_category_id" DataType="System.Int32"
            Display="False" HeaderText="Category" SortExpression="key_document_category_id"
            UniqueName="key_document_category_id">
            <EditItemTemplate>                
                <asp:HiddenField ID="hf_CategoryValue" runat="server" Value='<%# Bind("key_document_category_id") %>' />
                <asp:DropDownList ID="DD_category" runat="server" DataSourceID="SqlDataSource1" DataTextField="txt_document_category_name"
                    DataValueField="key_document_category_id" Width="335px" >
                    <asp:ListItem Selected="True">1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="key_document_category_idLabel" runat="server" Text='<%# Eval("key_document_category_id") %>'></asp:Label>
                
            </ItemTemplate>
        </radG:GridTemplateColumn>
        <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this document?"
            ImageUrl="~\images\Delete.gif" Text="Delete" UniqueName="column">
        </radG:GridButtonColumn>
    </Columns>
    <EditFormSettings>
        <EditColumn ButtonType="ImageButton" UpdateImageUrl="~/images/Update.gif" CancelImageUrl="~/images/Cancel.gif" UniqueName="EditCommandColumn1" />
    </EditFormSettings>
</MasterTableView>
  
</radg:radgrid>
    <asp:SqlDataSource ID="SqlDataSourceDoc" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" DeleteCommand="pr_documents_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_documents_ins" InsertCommandType="StoredProcedure" SelectCommand="pr_doc_files_get_by_Category" UpdateCommand="pr_documents_upd" UpdateCommandType="StoredProcedure" SelectCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="key_doc_id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="key_doc_id" Type="Int32" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="path" Type="String" />
            <asp:Parameter Name="int_category_id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="path" Type="String" />
            <asp:Parameter Name="int_category_id" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="-1" Name="key_document_category_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_document_category_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="-1" Name="key_document_category_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp;
    &nbsp;&nbsp;&nbsp;
    <br />
</asp:Content>

