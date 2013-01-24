<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Amendment_Adjustments_HostPage.aspx.cs" Inherits="LocalPlan_Amendment_Adjustments_HostPage" Title="Untitled Page" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>
<asp:Content ID="Content2" ContentPlaceHolderID="mainCopy" Runat="Server">
    <radW:RadWindowManager ID="RadWindowManager1" runat="server" Style="position: relative" VisibleStatusbar="False" VisibleTitlebar="False" BorderWidth="0px" Top="" OnClientShow="OnClientShow" Behavior="Maximize" Modal="True" >
       <windows>
                                <radw:RadWindow ID="MainPop" runat="server" Title="Dash Report" Height="600px"
                        Width="1000px" Left="188px"  ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="100px" />
             
               </windows>
    </radW:RadWindowManager>
    
    
    <script language="javascript">
window.onload = ShowAdjustWizard();
function ShowAdjustWizard()
       {
       
  //alert('hello');  
 return window.radopen("Amendment_Adjustments.aspx", "MainPop");
 
    }
    
    
     function OnClientShow(radWindow)
        {
   
            if(document.documentElement && document.documentElement.scrollTop)
            {
           
                var oTop = document.documentElement.scrollTop;
                document.documentElement.scroll = "no";
                document.documentElement.style.overflow = "hidden";
                document.documentElement.scrollTop = oTop;
               
            } else if(document.body)
            { 
                var oTop = document.body.scrollTop;
                document.body.scroll = "no";
                document.body.style.overflow = "hidden";
                document.body.scrollTop = oTop;
            }
        }

     
 
    
    
    
</script>

</asp:Content>

