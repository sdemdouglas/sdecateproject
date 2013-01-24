<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="DocumentsFiles.aspx.cs" Inherits="Administration_DocumentsFiles" Title="Documents" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    <asp:SqlDataSource ID="SQLDS_DocumetFile_list" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_doc_files_get_by_Category" SelectCommandType="StoredProcedure" DeleteCommand="pr_scs_document_file_del" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="key_document_category_id" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="RADG_DocumentList" Name="key_doc_file_storage_id"
                PropertyName="SelectedValue" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLDS_Category_List" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_document_category_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="-1" Name="key_document_category_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Label ID="lbl_Category" runat="server" Text="Category"></asp:Label>
    <asp:DropDownList ID="DDL_Category" runat="server" AutoPostBack="True" DataSourceID="SQLDS_Category_List"
        DataTextField="txt_document_category_name" DataValueField="key_document_category_id"
        OnDataBound="DDL_Category_DataBound" OnSelectedIndexChanged="DDL_Category_SelectedIndexChanged"
        Width="226px">
    </asp:DropDownList>
    <radG:RadGrid ID="RADG_DocumentList" runat="server" DataSourceID="SQLDS_DocumetFile_list"
        GridLines="None" Skin="Default"
        Width="746px" OnItemDataBound="RADG_DocumentList_ItemDataBound" OnDeleteCommand="RADG_DocumentList_DeleteCommand" OnInsertCommand="RADG_DocumentList_InsertCommand" OnEditCommand="RADG_DocumentList_EditCommand" OnItemCommand="RADG_DocumentList_ItemCommand" OnUpdateCommand="RADG_DocumentList_UpdateCommand" >
        <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="Bottom" DataSourceID="SQLDS_DocumetFile_list" DataKeyNames ="key_doc_file_storage_id">
            <CommandItemSettings AddNewRecordText="Add New Document" />
            <RowIndicatorColumn>
                <HeaderStyle Width="20px" />
            </RowIndicatorColumn>
            <ExpandCollapseColumn>
                <HeaderStyle Width="20px" />
            </ExpandCollapseColumn>
            <Columns>
                <radG:GridEditCommandColumn ButtonType="ImageButton" EditImageUrl="~/images/Edit.gif">
                </radG:GridEditCommandColumn>
                <radG:GridBoundColumn DataField="key_doc_file_storage_id" DataType="System.Int32"
                    HeaderText="key_doc_file_storage_id" ReadOnly="True" SortExpression="key_doc_file_storage_id"
                    UniqueName="key_doc_file_storage_id" Visible="False">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="txt_File_Title" HeaderText="File Title" SortExpression="txt_File_Title"
                    UniqueName="txt_File_Title" ReadOnly="True">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="dte_file_timeStamp" DataType="System.DateTime" HeaderText="Upload Date"
                    ReadOnly="True" SortExpression="dte_file_timeStamp" UniqueName="dte_file_timeStamp">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="txt_file_mimetype" HeaderText="txt_file_mimetype"
                    SortExpression="txt_file_mimetype" UniqueName="txt_file_mimetype" ReadOnly="True" Visible="False">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="key_document_category_id" DataType="System.Int32" HeaderText="key_doc_category_id"
                    SortExpression="key_doc_category_id" UniqueName="key_doc_category_id" ReadOnly="True" Visible="False">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="key_doc_security_id" DataType="System.Int32" HeaderText="key_doc_security_id"
                    SortExpression="key_doc_security_id" UniqueName="key_doc_security_id" ReadOnly="True" Visible="False">
                </radG:GridBoundColumn>
                <radG:GridBoundColumn DataField="txt_document_category_name" HeaderText="Document Category"
                    ReadOnly="True" UniqueName="txt_document_category_name">
                </radG:GridBoundColumn>
                <radG:GridButtonColumn CommandName="Delete" Text="Delete" UniqueName="column" ButtonType="ImageButton" ConfirmText="Are you sure you want to delete this document?" ImageUrl="~/images/Delete.gif">
                </radG:GridButtonColumn>
                <radG:GridTemplateColumn UniqueName="TemplateColumn" EditFormHeaderTextFormat="{0}">
                    <EditItemTemplate>
                        <asp:Label ID="LBL_Category" runat="server">Category</asp:Label>
                        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                        <asp:DropDownList ID="DD_categoryList" runat="server" DataSourceID="SQLDS_Category_List"
                            DataTextField="txt_document_category_name" DataValueField="key_document_category_id" Width="253px">
                        </asp:DropDownList><br />
                        <asp:Label ID="LBL_docTitle" runat="server">Document Title</asp:Label>
                        <asp:TextBox ID="TXT_DocTitle" runat="server" Text='<%# Eval(" txt_File_Title") %>' Width="250px"></asp:TextBox>&nbsp;
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TXT_DocTitle"
                            ErrorMessage="* Required"></asp:RequiredFieldValidator><br />
                        <asp:Label ID="lblLocation" runat="server">Location</asp:Label>
                        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                        <asp:FileUpload ID="UPF_uploadedFile" runat="server" Width="500px" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UPF_uploadedFile"
                            ErrorMessage="* Required"></asp:RequiredFieldValidator><br />
                        <asp:HiddenField ID="HF_catid" runat="server" Value='<%# Eval("key_document_category_id") %>' />
                        &nbsp;
                    </EditItemTemplate>
                </radG:GridTemplateColumn>
            </Columns>
            <EditFormSettings>
                <EditColumn ButtonType="ImageButton" CancelImageUrl="~/images/Cancel.gif" UniqueName="EditCommandColumn1"
                    UpdateImageUrl="~/images/Update.gif">
                </EditColumn>
            </EditFormSettings>
        </MasterTableView>
    </radG:RadGrid>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

