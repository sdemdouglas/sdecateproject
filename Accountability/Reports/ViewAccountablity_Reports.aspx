<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewAccountablity_Reports.aspx.cs" Inherits="Accountability_Reports_ViewAccountablity_Reports" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body onload="StayOnTop()" style="background-color:White;">
 <script type="text/javascript">
        function StayOnTop()
        {
            self.focus()
        }    
    </script>
    <form id="form1" runat="server">
    <div>
        &nbsp; &nbsp;&nbsp;<rsweb:reportviewer id="RS_Veiwer" runat="server" height="600px" width="800px">
        </rsweb:reportviewer>
            </div>
    </form>
</body>
</html>
