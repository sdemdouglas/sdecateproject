<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CountCharRemain.ascx.cs" Inherits="UserControls_WebUserControl" %>
<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width: 55px;">
            <asp:TextBox ID="txtCharCount" runat="server" BorderStyle="Solid"
                Width="50px"></asp:TextBox></td>
        <td colspan="2" style="height: 22px; text-align: left;" align="left">
            &nbsp;characters remaining <asp:RangeValidator ID="RangeValidator1" runat="server"
                ControlToValidate="txtCharCount" ErrorMessage="* Number of characters exceeds the allowed limit."
                MinimumValue="0" SetFocusOnError="True" MaximumValue="2000" Display="Dynamic" Type="Integer"></asp:RangeValidator></td>
    </tr>
</table>
