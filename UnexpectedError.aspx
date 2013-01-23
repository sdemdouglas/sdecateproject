<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UnexpectedError.aspx.cs" Inherits="UnexpectedError" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Unexpected Error</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>You have reached this page due to unexpected Error to return to the front page click <a href="Default.aspx">Home</a> <br /> If this error Persist please Email Help Desk Using the Following Form</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            <asp:Label ID="Label1" runat="server" Style="position: relative" Text="Your Email Address:"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" Style="position: relative" Width="160px"></asp:TextBox></center>
        <center>
            <asp:Label ID="Label2" runat="server" Style="position: relative" Text="Describe Error and Steps to Recreate:"></asp:Label>&nbsp;</center>
        <center>
            <asp:TextBox ID="TextBox2" runat="server" Height="237px" Style="position: relative"
                TextMode="MultiLine" Width="524px"></asp:TextBox>&nbsp;</center>
        <center>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="position: relative"
                Text="Button" />&nbsp;</center>
    </div>
    </form>
</body>
</html>
