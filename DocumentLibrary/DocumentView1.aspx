<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="DocumentView.aspx.cs" Inherits="DocumentLibrary_DocumentView" Title="Local Plan Documents" %>

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

    <asp:Label ID="lbl_Category" runat="server" Text="Category"></asp:Label><asp:DropDownList
        ID="DDL_Category" runat="server" AutoPostBack="True" DataSourceID="SQLDS_Category_List"
        DataTextField="txt_document_category_name" DataValueField="key_document_category_id"
        OnDataBound="DDL_Category_DataBound" OnSelectedIndexChanged="DDL_Category_SelectedIndexChanged"
        Width="226px">
    </asp:DropDownList><br />
    <radg:radgrid id="gDoc" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" DataSourceID="SQLDS_DocumetFile_list" GridLines="None" OnItemCreated="gDoc_ItemCreated" OnInsertCommand="gDoc_InsertCommand" OnItemDataBound="gDoc_ItemDataBound" OnItemCommand="gDoc_ItemCommand" Skin="Default" Width="776px">
<MasterTableView AutoGenerateColumns="False" DataSourceID="SQLDS_DocumetFile_list">
<ExpandCollapseColumn Visible="False">
<HeaderStyle Width="19px"></HeaderStyle>
</ExpandCollapseColumn>

<RowIndicatorColumn Visible="False">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>
    <CommandItemSettings AddNewRecordText="Add New Document" />
    <Columns>
        <radG:GridBoundColumn DataField="key_doc_file_storage_id" DataType="System.Int32"
            HeaderText="key_doc_file_storage_id" ReadOnly="True" SortExpression="key_doc_file_storage_id"
            UniqueName="key_doc_file_storage_id" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_File_Title" HeaderText="File Title" SortExpression="txt_File_Title"
            UniqueName="txt_File_Title">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_file_name" HeaderText="File Name" SortExpression="txt_file_name"
            UniqueName="txt_file_name">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="dte_file_timeStamp" DataFormatString="{0:MM/dd/yyyy}"
            DataType="System.DateTime" HeaderText="File Upload Date" SortExpression="dte_file_timeStamp"
            UniqueName="dte_file_timeStamp">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_file_mimetype" HeaderText="txt_file_mimetype"
            SortExpression="txt_file_mimetype" UniqueName="txt_file_mimetype" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="key_document_category_id" DataType="System.Int32"
            HeaderText="key_document_category_id" SortExpression="key_document_category_id"
            UniqueName="key_document_category_id" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="key_doc_security_id" DataType="System.Int32" HeaderText="key_doc_security_id"
            SortExpression="key_doc_security_id" UniqueName="key_doc_security_id" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="key_college_owner" DataType="System.Int32" HeaderText="key_college_owner"
            SortExpression="key_college_owner" UniqueName="key_college_owner" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="key_user_uploader" HeaderText="key_user_uploader"
            SortExpression="key_user_uploader" UniqueName="key_user_uploader" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_document_category_name" HeaderText="Category"
            UniqueName="txt_document_category_name">
        </radG:GridBoundColumn>
    </Columns>
    <EditFormSettings>
        <EditColumn ButtonType="ImageButton" UpdateImageUrl="~/images/Update.gif" CancelImageUrl="~/images/Cancel.gif" UniqueName="EditCommandColumn1" />
    </EditFormSettings>
</MasterTableView>
        
     
</radg:radgrid>
    <asp:SqlDataSource ID="SqlDataSourceDoc" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" DeleteCommand="pr_documents_del" DeleteCommandType="StoredProcedure" InsertCommand="pr_documents_ins" InsertCommandType="StoredProcedure" SelectCommand="SELECT [key_doc_id], [name], [path] FROM [documents]" UpdateCommand="pr_documents_upd" UpdateCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="key_doc_id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="key_doc_id" Type="Int32" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="path" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="path" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    &nbsp;&nbsp;&nbsp;<asp:SqlDataSource ID="SQLDS_Category_List" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_document_category_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="-1" Name="key_document_category_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="SQLDS_DocumetFile_list" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        DeleteCommand="pr_scs_document_file_del" DeleteCommandType="StoredProcedure"
        SelectCommand="pr_doc_files_get_by_Category" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter DefaultValue="-1" Name="key_document_category_id" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="RADG_DocumentList" Name="key_doc_file_storage_id"
                PropertyName="SelectedValue" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>

