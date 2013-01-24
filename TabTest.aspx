<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="TabTest.aspx.cs" Inherits="TabTest" Title="Untitled Page" %>
<%@ Register TagPrefix="rad" Namespace="Telerik.WebControls" Assembly="RadTabStrip.NET2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
    &nbsp;<br />
			<br />
    <rad:RadTabStrip ID="RadTabStrip1" runat="server" AutoPostBack="True" Skin="Outlook">
    </rad:RadTabStrip>
			<br />
		
			
</asp:Content>

