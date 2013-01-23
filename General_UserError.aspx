
<%@ Page Language="C#" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>General Error</title>

<script language="javascript" type="text/javascript">
  function OnClientClose(radWindow)
                {
                
                    alert (radWindow.Name + " is being closed");
                }


function CloseWindow()
{
 
 try
 {
 var oWnd = GetRadWindow().BrowserWindow; 
  GetRadWindow().Close(); 
         
              
           oWnd.location.href = '../default.aspx';
           }
           catch(err)
           {
           location.href = '../default.aspx';
           }
}


 function GetRadWindow()
        {
           var oWindow = null;
           if (window.radWindow) oWindow = window.radWindow;
           else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
           return oWindow;
        }
</script>
</head>



<body>
    <form id="form1" runat="server">
    <div>
    <label>You have reached this page in error most likely due to Access Rights, Contact your Database Administrator</label>
  <br /> 
        <radW:RadWindowManager ID="RadWindowManager1" runat="server" OnClientClose="OnClientClose">
        </radW:RadWindowManager>
        <a href="javascript:CloseWindow();">Home</a>
    </div>
    </form>
</body>
</html>
