<%@ Control language="c#" AutoEventWireup="false" Inherits="DictionaryConfiguration.EditDictionary" %>
<b>Select Dictionary: </b><asp:dropdownlist id="dictionarySelector" Runat="server"></asp:dropdownlist><br/>
<asp:Label id="messageLabel" runat="server" Width="265px"></asp:Label>
<table width="100%">
	<tr>
		<td valign="top">
			<asp:panel id="searchPanel" runat="server" class="module">
				<asp:Label id="Label2" runat="server">Find word:</asp:Label>
				<asp:TextBox id="findWordBox" runat="server"></asp:TextBox>
				<asp:Button id="findButton" runat="server" Text="Find" CssClass="button"></asp:Button>
				<p>
				<asp:ListBox id="wordsFound" runat="server" Height="164px" Width="298px" SelectionMode="Multiple"></asp:ListBox><br/>
				<asp:Button id="deleteButton" runat="server" Text="Delete selected" CssClass="button" width="298"></asp:Button>
				</p>
			</asp:panel>
		</td>
		<td valign="top">
			<asp:panel id="importPanel" runat="server" class="module" style="height:124px;margin-bottom:6px;">
				<br/><br/><asp:Label id="Label3" runat="server">Import wordlist:</asp:Label>
				<INPUT id="importedFile" type="file" name="importedFile" runat="server">
				<asp:Button id="importButton" runat="server" Text="Import" CssClass="button"></asp:Button>
			</asp:panel>
			<asp:panel id="addPanel" runat="server" class="module" style="height:124px;">
				<br/><br/><br/>
				<asp:Label id="Label1" runat="server">Add a word:</asp:Label>
				<asp:TextBox id="addWordBox" runat="server"></asp:TextBox>
				<asp:Button id="addButton" runat="server" Text="Add" class="button"></asp:Button>
			</asp:panel>
		</td>
	</tr>
</table>