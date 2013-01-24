<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Sctcs Grants Perkins</title> 
</head>
<body>
    <form id="form1" runat="server">
   <div style="text-align: center">
        <br />
        <strong><span style="font-size: 14pt; color: #ff0000; font-family: Arial">
            <asp:Label ID="Label1" runat="server" Text="You have successfully
            logged out."></asp:Label><br />
             <asp:Label ID="Lockedlabel" runat="server" Visible="false" Text="Your Account is Locked Please Speak with an Administrator"></asp:Label>
            <br />
            <br />
            <asp:HyperLink ID="HL_Login" runat="server" NavigateUrl="~/default.aspx">Log Back In</asp:HyperLink><br />
        </span></strong>
    
    </div>
    </form>
</body>
</html>
