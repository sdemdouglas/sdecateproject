<%@ Control language="c#" AutoEventWireup="false" Inherits="DictionaryConfiguration.Import" %>
<p>Import files are text files, having one word per line with no leading or 
	trailing whitespace.&nbsp; Old TDF files are suitable too.</p>
<span>Pick a file to import:</span> <INPUT type="file" id="importedFile" runat="server">
	<asp:Button id="importButton" accessKey="i" runat="server" Text="Import" cssclass="button"></asp:Button>
<asp:Panel id="errorPanel" runat="server" Visible="False">
	<asp:Label id="errorMessage" runat="server" ForeColor="Red"></asp:Label>
</asp:Panel>
<br/><br/>
<b>Available Dictionaries:</b>
<asp:DataGrid id="importedFiles" runat="server" AutoGenerateColumns="False" ShowHeader="False" gridlines="none" cssclass="module" height="40px" width="300">

	<Columns>
		<asp:TemplateColumn>
			<ItemTemplate>
				<asp:HyperLink id="fileLink" runat="server" Text="" NavigateUrl=""></asp:HyperLink>
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:ButtonColumn Text="Delete" CommandName="Delete"></asp:ButtonColumn>
	</Columns>
</asp:DataGrid>
