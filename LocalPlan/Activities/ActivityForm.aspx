<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ActivityForm.aspx.cs" Title = "Activity Form" Inherits="LocalPlan_Activities_ActivityForm" %>

<%@ Register Assembly="RadInput.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Src="../../UserControls/CountCharRemain.ascx" TagName="CountCharRemain"
    TagPrefix="uc2" %>


<%@ Register Assembly="RadAjax.Net2" Namespace="Telerik.WebControls" TagPrefix="radA" %>

<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Appendix C: Uses of Funds Activity Form</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
    <link href="../../Custom_Skins/Grid.Office2007.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript">
        var grid;
            
        function OnGridCreated()  
        {  
            grid=this;  
        }  

        function GetRadWindow()
        {
           var oWindow = null;
           if (window.radWindow) oWindow = window.radWindow;
           else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
           return oWindow;
        }
        
        function Close()
        {
            GetRadWindow().Close();
        }

function Save750_Rule()
{

//var dd_cont =  document.getElementById("<%= DLB_Category.ClientID %>");
//var dd_value = dd_cont.options[dd_cont.selectedIndex].value;
//var total_val = document.getElementById("<%= lblTotalBudget.ClientID %>").innerText;
////101, 102, 103, 104, 105, 106, 108
////alert(dd_value);
////alert(total_val);
//if((dd_value == 101 || dd_value == 102 || dd_value == 103 || dd_value == 104 || dd_value == 105 || dd_value == 106 || dd_value == 108) && (parseFloat(total_val) < 750))
//{
//alert("Total Line Item Amout must be over $750 for selected Category");
//window.event.cancelBubble = true;
//window.event.returnValue = false; 
//}

}






        function Rebind()
        {
            GetRadWindow().BrowserWindow.location.reload();
        }
        
        function CloseAndRebind(level)
        {    //var nid =  
        var hfid = document.getElementById("<%= lblAvtivityNbr.ClientID %>").innerText;
             
            Close();   
            GetRadWindow().BrowserWindow.refreshActivities("Activities",hfid,level);  
        }
        
        function CloseAndReload()
        {         
            Close();   
            GetRadWindow().BrowserWindow.location.reload(); 
        }
        

        function refreshPage(kid)
        {
            //window.location.reload(false);
            Close();
            var wObj = GetRadWindow().BrowserWindow.radopen("Activities/ActivityForm.aspx?id=" + kid, "UserListDialog");
            
            var wW = Math.round(document.documentElement.clientWidth *95/100);            
            var wH = Math.round(document.documentElement.clientHeight *95/100);
            
            wObj.SetSize(wW,wH);
            wObj.Center();
        }
        
        function getGridSize()
        {
            //var grid = document.getElementById("<%= TRG_Funds.ClientID  %>");
            var row = grid.MasterTableView.Rows[0];
            if (grid != null)
                alert(row);
            else
                alert("Grid not found");
            
        }
        
        function passValue(index)   
        {   
           // var cellVal = grid.MasterTableView.GetCellByColumnUniqueName(grid.MasterTableView.SelectedRows[index], "TemplateColumn");;   
            //alert(grid.MasterTableView.GetCellByColumnUniqueName(0,"TemplateColumn"));
        }   

        function formatCurrency(num, type) {
            num = num.toString().replace(/\$|\,/g,'');
            if(isNaN(num))
            num = "0";
            sign = (num == (num = Math.abs(num)));
            num = Math.floor(num*100+0.50000000001);
            cents = num%100;
            num = Math.floor(num/100).toString();
            if(cents<10)
            cents = "0" + cents;
            for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
            num = num.substring(0,num.length-(4*i+3))+','+
            num.substring(num.length-(4*i+3));
            return (((sign)?'':'-') + ((type)=='C'?'$':'') + num + '.' + cents);
        }

        function getItemValue(id)
        {
            var itemVal = document.getElementById(id).value.replace(/\$|\,/g,'');
            
            if(itemVal.length > 0)
            {
                if(!isNaN(parseFloat(itemVal)))
                {
                    document.getElementById("<%= hfItem.ClientID %>").value = itemVal;
                }
            }
            else
            {
                document.getElementById("<%= hfItem.ClientID %>").value = 0;                                       
            }
            //alert("Get Item value");
        }
        function updateTotal(id)
        {
            
            var itemVal = parseFloat(document.getElementById(id).value.replace(/\$|\,/g,''));
                        
            var cTotal = parseFloat(document.getElementById("<%= lblTotalBudget.ClientID %>").innerText.replace(/\$|\,/g,''));
            var preVal = parseFloat(document.getElementById("<%= hfItem.ClientID %>").value);
            var nTotal;
                      
            if(!isNaN(itemVal))
            {
                nTotal = cTotal - preVal + itemVal;     
                document.getElementById(id).value = formatCurrency(itemVal,'N2');           
            }
            else
            {
                nTotal = cTotal - preVal;
                document.getElementById("<%= hfItem.ClientID %>").value = 0;
                document.getElementById(id).value = "0.00";
            }
            document.getElementById("<%= lblTotalBudget.ClientID %>").innerText = formatCurrency(nTotal,'N2') ;
            document.getElementById("<%= hfTempTotal.ClientID %>").value = nTotal.toFixed(2) ;
            
           // alert("Update Total value");                 
        }
        
        function confirmDelete()
        {
            var ans = confirm("Are you sure you want to Delete this Activity?");
            if(ans==true)
            {
                document.getElementById("<%= hfDelete.ClientID %>").value = "Yes";
            }
            else
            {
                document.getElementById("<%= hfDelete.ClientID %>").value = "No";
                document.getElementById("<%=hfTotalBudget.ClientID %>").value = document.getElementById("<%=lblTotalBudget.ClientID %>").innerText;
            }
        }
        
        function Print(type,format)
        {       
            var keyid= document.getElementById("<%= lblAvtivityNbr.ClientID %>").innerText;
       
            //   var oBrowserWnd = GetRadWindow().BrowserWindow; 
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;


            window.open("../../Reports/ViewReport.aspx?type=" + type + "&Keyid=" + keyid +"&format=" + format,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
 
           // window.open("../../Reports/ViewReport.aspx?type='activities'");
        }
        
        function cvTotalBudget(source, args)
        {   
            document.getElementById("<%= lblMsg.ClientID %>").innerText = "";
            
            //alert(document.getElementById("<%= lblTotalBudget.ClientID %>").innerText);     
            var totalBudget = parseFloat(document.getElementById("<%= lblTotalBudget.ClientID %>").innerText);            
            //alert(totalBudget);
            
            if (totalBudget > 0)
                args.IsValid = true;
            else
                args.IsValid = false;               
        }
        
        function cvCoreIndValFunc(source, args)
        {   
            var cblCoreInd = document.getElementById("<%= cblCoreIndicators.ClientID %>").getElementsByTagName('input');                                  
            //alert(cblCoreInd.length);                 
            args.IsValid = false;
            for (var i=0; i < cblCoreInd.length; i++)
            {
                if(cblCoreInd[i].checked)
                    args.IsValid = true;
            }                        
        }
        
        function cvTotalLineItem(source, args)
        {
            var txt_Funds = document.getElementById("<%= lblTotalBudget.ClientID %>").innerText.replace(/\$|\,/g,'');
            var hfTotBal = document.getElementById("<%= hfTotBal.ClientID %>").value;
            var hfGridTot = document.getElementById("<%= hfGridTot.ClientID %>").value;
            
//            alert(hfTotBal);
//            alert(hfGridTot);                        
//            alert(txt_Funds);   
            
            
            
            var newBalance = parseFloat(hfTotBal) + parseFloat(hfGridTot) - parseFloat(txt_Funds);
            
            args.IsValid = false;
            
            if (txt_Funds != null)
            {                                
                if (txt_Funds.length  > 0)
                {                    
                    if(!isNaN(txt_Funds) && parseFloat(txt_Funds) >= 0)
                    {
                        //alert(newBalance);
                        if (newBalance >= 0)
                        {
                            args.IsValid = true;                  
                        }                        
                    }
                }               
            }
        }
        
        function pageInfoChanged(source)
        {
            //alert(source);
            if (source != null)
            {
                if (source == "cbl")
                {   
                    //alert(document.getElementById("cblCoreIndicators_0").disabled);
                    
                    if(document.getElementById("cblCoreIndicators_0").disabled != true)
                    {                                                
                        document.getElementById("<%= lblMsg.ClientID %>").innerText = "";
                        document.getElementById("<%= hfPageInfo.ClientID %>").value = "1";
                    }                                       
                } 
                else if(source == "txtDescActivity")
                    calCharNumber();
                else if(source == "txtDescCoreInd")
                    calCharNumber1()
                                      
            }
            else
            {
                //alert(source);
                document.getElementById("<%= lblMsg.ClientID %>").innerText = "";
                document.getElementById("<%= hfPageInfo.ClientID %>").value = "1";
            }
            
        }
        
        function confirmClose()
        {
            var ans;
            
            if (document.getElementById("<%= hfPageInfo.ClientID %>").value == "1")
                ans = confirm("Information on this page has been changed but not saved yet. Do you want to process to close?");      
            
            if(ans==true)
                document.getElementById("<%= hfFlgSave.ClientID %>").value = "yes";
            else
                document.getElementById("<%= hfFlgSave.ClientID %>").value = "no";     
        }
        
//        function openActivityChangeRequest(aid, type)
//        {
//           var rWindow = window.radopen("ActivityChangeRequest.aspx?aid=" + aid + "&acrId=-1", "UserListDialog");
//            
//         
//           rWindow.SetSize(800,550);
//           rWindow.Center();
//        }  
//      
       
        function PositionWindow(rWindow)
        {
            alert(screen.availWidth);
        }    
        function editActivityChangeRequest(aid, acrId, type)
        {
           //alert(acrId);
           
           var rWindow = window.radopen("ActivityChangeRequest.aspx?aid=" + aid + "&acrId=" + acrId + "&type=" + type, "UserListDialog");
                    
           rWindow.SetSize(850,550);
           rWindow.Center();           
                      
          // alert(left);
           if (acrId == -1)      
           {
            var left = rWindow.GetLeftPosition();                
            rWindow.MoveTo(left,50);
           }                           
        } 
        function confirmDeleteChangeRequest()
        {
            var ans = confirm("Are you sure you want to Delete this Change Request?");
            if(ans==true)
            {
                document.getElementById("<%= hfDelete.ClientID %>").value = "Yes";
            }
            else
            {
                document.getElementById("<%= hfDelete.ClientID %>").value = "No";
                document.getElementById("<%=hfTotalBudget.ClientID %>").value = document.getElementById("<%=lblTotalBudget.ClientID %>").innerText;
            }
        } 
        
        function saveCurrentBudget()
        {
            document.getElementById("<%=hfTotalBudget.ClientID %>").value = document.getElementById("<%=lblTotalBudget.ClientID %>").innerText;
        }
        
        function calCharNumber()
        {
            var remCharlength = 2000;                        
            var des = document.getElementById("<%= txtDescActivity.ClientID %>").value;
            document.getElementById("CountCharRemain1_txtCharCount").value = (remCharlength - des.length);           
        }
         
        function calCharNumber1()
        {
            var remCharlength = 2000;                        
            var des = document.getElementById("<%= txtDescCoreInd.ClientID %>").value;
            document.getElementById("CountCharRemain2_txtCharCount").value = (remCharlength - des.length);           
        }
        
        function refreshChangeRequest(action)      
        {        
            window["<%=RadGrid2.ClientID %>"].AjaxRequest('<%= RadGrid2.UniqueID %>', action); 
                         
        }
        
        function forcePostback()
        {
            var divAcr = document.getElementById("hlAcr");            
            divAcr.style.display = 'inline';  
            refreshChangeRequest('Rebind');
        }
        
    </script>
    
    <div style="background-color: white">
        &nbsp;<table style="border-top-width: 1px; border-left-width: 1px; border-left-color: gray;
            border-bottom-width: 1px; border-bottom-color: gray; width: 785px; border-top-color: gray;
            border-right-width: 1px; border-right-color: gray">
            <tr>
                <td colspan="3" style="border-bottom-width: 2px; border-bottom-color: black; text-align: center; width: 788px;">
                    <strong><span><span style="font-size: 9pt"> Uses of Funds Activity Form 2A</span> - </span></strong>
                    <asp:Label ID="lblCollege" runat="server" Font-Bold="True" Text="Trident Technical College"></asp:Label><span>
                            - &nbsp;</span><asp:Label ID="lblFiscalYear" runat="server" Font-Bold="True" Text="2008"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="3" style="border-top: black 1px groove; border-left-width: 1px; border-left-color: black;
                    border-bottom: black 1px groove; border-right-width: 1px; border-right-color: black; text-align: right; width: 788px;">
                    <radTS:RadTabStrip ID="RadTabStrip1" runat="server" CausesValidation="False" MultiPageID="RadMultiViewActivity"
                        Skin="ClassicBlue" style="border-bottom: #33ccff 1px groove">
                        <Tabs>
                            <radTS:Tab ID="Tab1" runat="server" PageViewID="PgViewActivity" Text="Activity Information">
                            </radTS:Tab>
                            <radTS:Tab ID="Tab2" runat="server" PageViewID="PgViewChangeRequest" Text="Change Requests">
                            </radTS:Tab>
                            <radTS:Tab runat="server" PageViewID="pv_History" Text="Transaction History">
                            </radTS:Tab>
                        </Tabs>
                    </radTS:RadTabStrip>
                                        <asp:Label ID="lblMsg" runat="server" ForeColor="Black"></asp:Label>&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="width: 788px">
                    <radTS:RadMultiPage ID="RadMultiViewActivity" runat="server" Width="746px">
                        <radTS:PageView ID="PgViewActivity" runat="server">
                            <table style="width: 703px; font-family: 'Trebuchet MS'">
                                <tr>
                                    <td colspan="4" style="border-bottom: black 1px groove; height: 21px; text-align: right">
                                        <asp:Label ID="Label2" runat="server" ForeColor="Red" Style="position: relative"
                                            Text="The Total of the Line Item(s) on this Activity exceeds the Available Funds."
                                            Visible="False"></asp:Label>
                                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" Width="100px" Font-Bold="False" Height="25px" />
                                        <asp:Button ID="btnDelete" runat="server" CausesValidation="False" OnClick="Button1_Click"
                                            OnClientClick="confirmDelete()" Text="Delete" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS"  Height="25px" />
                                        <asp:Button ID="btn_Print_History" runat="server" Font-Bold="False" Font-Names="Trebuchet MS"
                                            OnClick="btn_Print_History_Click" Text="Print History" Width="100px" />
                                        <asp:Button ID="btnPrint" runat="server" OnClick="btnPrint_Click" Text="Print PDF" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS" Height="25px" />
                                        <asp:Button ID="btnPrintWord" runat="server" OnClick="btnPrintWord_Click" Text="Print Word" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS" Height="25px" />
                                        <asp:Button ID="btnClose" runat="server" CausesValidation="False" OnClick="btnClose_Click"
                                            OnClientClick="confirmClose()" Text="Close" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS"  Height="25px" /></td>
                                </tr>
                                <tr>
                                    <td style="width: 146px; height: 21px; text-align: left">
                                        Activity #</td>
                                    <td colspan="3" style="width: 679px; height: 21px; text-align: left">
                                        <asp:Label ID="lblAvtivityNbr" runat="server" Font-Names="Trebuchet MS"
                                            Text="Put activity # here" Width="213px"></asp:Label></td>
                                </tr>
                                <tr style="font-weight: bold">
                                    <td style="width: 146px; height: 21px; text-align: left">
                                        <asp:Label ID="Label1" runat="server" Font-Bold="False" Font-Names="Trebuchet MS"
                                            Text="Activity Type"></asp:Label></td>
                                    <td colspan="3" style="width: 679px; height: 21px; text-align: left">
                                        <asp:DropDownList ID="DLB_ActType" runat="server" AutoPostBack="True" DataSourceID="SDS_ActivityType"
                                            DataTextField="txt_activity_type_desc" DataValueField="key_activity_type_id"
                                            Enabled="False" Font-Names="Trebuchet MS"  Width="142px">
                                        </asp:DropDownList>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 146px; height: 22px; text-align: left">
                    Activity Name</td>
                                    <td align="left" colspan="3" style="width: 679px; height: 22px">
                                        <asp:TextBox ID="txtActivityName" runat="server" Font-Names="Trebuchet MS"
                                            Width="524px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtActivityName"
                                            ErrorMessage="* Required"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr style="color: #000000; ">
                                    <td style="width: 146px; height: 18px; text-align: left" valign="top">
                                        <span style="font-family: Trebuchet MS">
                    Category</span></td>
                                    <td align="left" colspan="3" style="width: 679px; height: 18px" valign="top">
                                        <asp:DropDownList ID="DLB_Category" runat="server" DataSourceID="SDS_Category" DataTextField="txt_category_title"
                                            DataValueField="key_category_id" Font-Names="Trebuchet MS"  OnDataBound="DLB_Category_DataBound"
                                            Width="422px" AutoPostBack="True" OnSelectedIndexChanged="DLB_Category_SelectedIndexChanged"  >
                                        </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                            ControlToValidate="DLB_Category" ErrorMessage="* Required" InitialValue="-1"></asp:RequiredFieldValidator>
                                        &nbsp;&nbsp; &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 146px; height: 18px; text-align: left" valign="top">
                                        <span style="font-family: Trebuchet MS">Function Code</span><strong> </strong>
                                    </td>
                                    <td align="left" colspan="3" style="width: 679px; height: 18px" valign="top">
                                        <asp:DropDownList ID="DLB_FunCode" runat="server" DataSourceID="SDS_FunctionCODE"
                                            DataTextField="txt_function_code_desc" DataValueField="key_function_code_id"
                                            Font-Names="Trebuchet MS" OnDataBound="DLB_FunCode_DataBound"
                                            Width="242px">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="DLB_FunCode"
                                            ErrorMessage="* Required" InitialValue="-1"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr style="font-weight: bold;color: #000000;">
                                    <td style="width: 146px; height: 19px; text-align: left">
                                        <asp:Label ID="Label7" runat="server" Font-Bold="False" Font-Names="Trebuchet MS"
                                             Text="Use of Funds"></asp:Label></td>
                                    <td colspan="3" style="width: 679px; height: 19px; text-align: left">
                                        <asp:TextBox ID="txt_UseOfFunds" runat="server" Style="position: relative"></asp:TextBox>
                                        &nbsp;&nbsp;
                                        <asp:Label ID="Label3" runat="server" Font-Bold="False" Font-Names="Trebuchet MS"
                                            Text="Program Type"></asp:Label><span> &nbsp;&nbsp; </span>
                                        <asp:DropDownList ID="ddlProgramType" runat="server" DataSourceID="SDS_radiostuff"
                                            DataTextField="txt_fa_activity_desc" DataValueField="key_fa_activity_type_id"
                                            OnDataBound="ddlProgramType_DataBound" Width="138px">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="ddlProgramType"
                                            ErrorMessage="* Required" InitialValue="-1"></asp:RequiredFieldValidator><asp:DropDownList ID="ddlUseOfFunds" runat="server" DataSourceID="sqlDsUseOfFunds"
                                            DataTextField="txt_category_type_desc" DataValueField="key_category_type_id"
                                            Font-Names="Trebuchet MS"  OnDataBound="ddlUseOfFunds_DataBound"
                                            Width="1px" style="position: relative" Visible="False">
                                        </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                            ControlToValidate="ddlUseOfFunds" ErrorMessage="* Required" Font-Bold="False"
                                            InitialValue="-1" style="position: relative" Enabled="False"></asp:RequiredFieldValidator>
                                        </td>
                                </tr>
                                <tr style="color: #000000;">
                                    <td style="width: 146px; height: 10px; text-align: left" valign="top">
                                        <asp:Label ID="Label4" runat="server" Font-Bold="False" Font-Names="Trebuchet MS"
                                            Text="Core Indicators"></asp:Label></td>
                                    <td colspan="3" style="font-weight: bold; width: 679px; height: 10px; text-align: left"
                                        valign="top">
                                        <asp:CheckBoxList ID="cblCoreIndicators" runat="server" DataSourceID="SDS_CoreIndicators"
                                            DataTextField="Column1" DataValueField="key_core_indicator_id" Font-Bold="False"
                                            OnDataBound="cblCoreIndicators_DataBound">
                                        </asp:CheckBoxList>
                                        <asp:CustomValidator ID="cvCoreInd" runat="server" ClientValidationFunction="cvCoreIndValFunc"
                                            ErrorMessage="* Required (At least one core indicator has to be selected)" Font-Bold="False"
                                            ></asp:CustomValidator></td>
                                </tr>
                                <tr style=" color: #000000;">
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <span style="font-family: Trebuchet MS">
                    Description of Activity (Proposed Use of Funds)
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDescActivity"
                                            ErrorMessage="* Required"></asp:RequiredFieldValidator></span></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="width: 100%; height: 10px; text-align: left" valign="top">
                                        <asp:TextBox ID="txtDescActivity" runat="server" Font-Names="Trebuchet MS" 
                                            Height="158px" TextMode="MultiLine" Width="745px"></asp:TextBox>
                                        </td>
                                </tr>
                                <tr style="color: #000000;">
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <uc2:CountCharRemain ID="CountCharRemain1" runat="server" />
                                    </td>
                                </tr>
                                <tr style="color: #000000;">
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        &nbsp;
                                        </td>
                                </tr>
                                <tr style="color: #000000;">
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <span style="font-family: Trebuchet MS">
                    Describe how the activity will help meet the core indicator(s):
                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDescCoreInd"
                                                ErrorMessage="* Required" ></asp:RequiredFieldValidator></span></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <asp:TextBox ID="txtDescCoreInd" runat="server" Font-Names="Trebuchet MS" 
                                            Height="161px" TextMode="MultiLine" Width="99%"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <uc2:CountCharRemain ID="CountCharRemain2" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                    </td>
                                </tr>
                                <tr >
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                    
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td style="width: 300px">
                    Available Fund:
                            </td>
                            <td>
                    <asp:TextBox ID="txtAvailableFunds" runat="server" ReadOnly="True" BorderStyle="None"></asp:TextBox></td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 300px; height: 16px;">
                                Total Line Item Cannot Exceed:</td>
                            <td style="height: 16px">
                                <asp:Label ID="lblNewTotalLineItem" runat="server"></asp:Label></td>
                            <td style="height: 16px">
                            </td>
                        </tr>
                    </table>
                    
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <span style="font-family: Trebuchet MS">
                    Budgeted Funds for Activity </span>
                                    </td>
                                </tr>
                                <tr >
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <radG:RadGrid ID="TRG_Funds" runat="server" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                                            AllowAutomaticUpdates="True" AutoGenerateColumns="False" DataSourceID="SDS_ActivityBudgetFunds"
                                            EnableAJAX="True" GridLines="None" OnDataBound="TRG_Funds_DataBound" OnItemCreated="TRG_Funds_ItemCreated"
                                            Skin="Default" Width="100%">
                                            <MasterTableView DataKeyNames="key_line_item_type_id" DataSourceID="SDS_ActivityBudgetFunds">
                                                <Columns>
                                                    <radG:GridBoundColumn DataField="key_line_item_type_id" DataType="System.Int32" Display="False"
                                                        HeaderText="Key" ReadOnly="True" SortExpression="key_line_item_type_id" UniqueName="key_line_item_type_id">
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="txt_line_item_desc" SortExpression="Fund" UniqueName="txt_line_item_desc">
                                                    </radG:GridBoundColumn>
                                                    <radG:GridTemplateColumn UniqueName="TemplateColumn">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txt_Funds" runat="server" Style="position: relative; left: 0px;" Width="97px">0.00</asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_Funds"
                                                                ErrorMessage="Value Must be Currency  " Style="position: relative" ValidationExpression="^\$?[0-9]+(,[0-9]{3})*(\.[0-9]{2})?$" Enabled="False"></asp:RegularExpressionValidator><br />
                                                            
                                                            <asp:Label ID="indycost_message" runat="server" ForeColor="Red" Style="position: relative"
                                                                Text="The Category you have chosen does not allow funds to be placed in Line Item Indirect Cost."
                                                                Visible="False"></asp:Label>
                                                        </ItemTemplate>
                                                    </radG:GridTemplateColumn>
                                                </Columns>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle Width="20px" />
                                                </ExpandCollapseColumn>
                                                <RowIndicatorColumn>
                                                    <HeaderStyle Width="20px" />
                                                </RowIndicatorColumn>
                                            </MasterTableView>
                                          
                                            
                                        </radG:RadGrid><br />
                                        <span style="font-family: Trebuchet MS">
                        Total Amount Budgeted </span><strong>
                        $&nbsp; 
                                        </strong>
                                        <asp:Label ID="lblTotalBudget" runat="server" Text="0"></asp:Label>
                                        <asp:CustomValidator ID="cvBudgetFunds" runat="server" ClientValidationFunction="cvTotalBudget"
                                            ErrorMessage="* Required"></asp:CustomValidator><asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="cvTotalLineItem"
                                            ErrorMessage="* Total Line Item Exceeds Allowed Amount" SetFocusOnError="True"></asp:CustomValidator>
                                        <asp:HiddenField ID="hfTempTotal" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <hr />
                                    </td>
                                </tr>
                                <tr >
                                    <td colspan="4" style="height: 10px; background-color: gainsboro; text-align: left"
                                        valign="top">
                                        <span style="font-family: Trebuchet MS">Line Item Adjustments</span></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 10px; text-align: left" valign="top">
                                        <radG:RadGrid ID="RadGrid1" runat="server" DataSourceID="SqlDsReimbursements" GridLines="None"
                                            OnItemDataBound="RadGrid1_ItemDataBound" Skin="Default">
                                            <FooterStyle HorizontalAlign="Right" />
                                            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDsReimbursements" ShowFooter="True">
                                                <RowIndicatorColumn>
                                                    <HeaderStyle Width="20px" />
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle Width="20px" />
                                                </ExpandCollapseColumn>
                                                <Columns>
                                                    <radG:GridBoundColumn DataField="Line Item" HeaderText="Line Item" SortExpression="Line Item"
                                                        UniqueName="Line Item">
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="amt_amount" DataFormatString="{0:N2}" DataType="System.Decimal"
                                                        HeaderText="Original Amount" SortExpression="amt_amount" UniqueName="amt_amount">
                                                        <FooterStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="Qtr 1" DataType="System.Decimal" HeaderText="Qtr 1"
                                                        ReadOnly="True" SortExpression="Qtr 1" UniqueName="Qtr 1" DataFormatString="{0:N2}">
                                                        <FooterStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="Qtr 2" DataType="System.Decimal" HeaderText="Qtr 2"
                                                        ReadOnly="True" SortExpression="Qtr 2" UniqueName="Qtr 2" DataFormatString="{0:N2}">
                                                        <FooterStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="Qtr 3" DataType="System.Decimal" HeaderText="Qtr 3"
                                                        ReadOnly="True" SortExpression="Qtr 3" UniqueName="Qtr 3" DataFormatString="{0:N2}">
                                                        <FooterStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="Qtr 4" DataType="System.Decimal" HeaderText="Qtr 4"
                                                        ReadOnly="True" SortExpression="Qtr 4" UniqueName="Qtr 4" DataFormatString="{0:N2}">
                                                        <FooterStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridBoundColumn DataField="nbr_total_adjustments" DataType="System.Decimal"
                                                        HeaderText="Adjustments" ReadOnly="True" SortExpression="nbr_total_adjustments"
                                                        UniqueName="nbr_total_adjustments" DataFormatString="{0:N2}">
                                                        <FooterStyle HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </radG:GridBoundColumn>
                                                    <radG:GridTemplateColumn HeaderText="Total" UniqueName="TemplateColumn" GroupByExpression="{0:N2}">
                                                        <FooterTemplate>
                                                            <asp:Label ID="lblSum" runat="server"></asp:Label>
                                                        </FooterTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <FooterStyle HorizontalAlign="Right" />
                                                        <ItemStyle Width="1in" HorizontalAlign="Right" />
                                                        <HeaderStyle HorizontalAlign="Right" />
                                                    </radG:GridTemplateColumn>
                                                </Columns>
                                                <FooterStyle BackColor="LightSteelBlue" HorizontalAlign="Right" />
                                            </MasterTableView>
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="True" />
                                            </ClientSettings>
                                        </radG:RadGrid></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 7px; text-align: left">
                                        <br />
                                        <asp:SqlDataSource ID="SqlDsReimbursements" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                            SelectCommand="pr_act_reimbursements_qtr_list_get" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:QueryStringParameter DefaultValue="-1" Name="p_key_activity_id" QueryStringField="id"
                                                    Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:Label ID="InjectScript" runat="server"></asp:Label>
                                        <br />
                                        <table style="width: 751px;">
                                            <tr>
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    <strong>Date Updated &nbsp;</strong><asp:Label ID="lblDateUpdated" runat="server"
                                                        Width="93px"></asp:Label>
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <strong>Updated By</strong>
                                                    <asp:Label ID="lblUpdatedBy" runat="server" Width="106px"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 7px; background-color: #92b4e0; text-align: left">
                                                    <strong><span>For System Office Use Only</span></strong></td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    <strong>Approved by System Office&nbsp;</strong>
                                                    <asp:CheckBox ID="cbApproved" runat="server" />
                                                    &nbsp; <strong>Locked by System Office</strong>&nbsp;
                                                    <asp:CheckBox ID="cbLocked" runat="server" /></td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    <strong>Status &nbsp;</strong></td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    <asp:DropDownList ID="ddStatus" runat="server" DataSourceID="SqlDataSource1" DataTextField="txt_level_desc"
                                                        DataValueField="key_level_id" Width="416px">
                                                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                                        SelectCommand="SELECT [key_level_id], [txt_level_desc] FROM [scs_level]"></asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    <strong style="background-color: gainsboro">System Office Notes</strong></td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" style="height: 7px; text-align: left">
                                                    <asp:TextBox ID="txtSystemOfficeNotes" runat="server" Height="120px" TextMode="MultiLine"
                                                        Width="743px"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr >
                                    <td colspan="4" style="height: 7px; text-align: left">
                                        &nbsp; &nbsp; &nbsp;&nbsp;
                                        <asp:HiddenField ID="hfDelete" runat="server" />
                                        <asp:HiddenField ID="hfTotalBudget" runat="server" />
                                        <asp:HiddenField ID="hfItem" runat="server" />
                                        <asp:HiddenField ID="hfLpId" runat="server" />
                                        <asp:HiddenField ID="hfPageInfo" runat="server" />
                                        <asp:HiddenField ID="hfFlgSave" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="height: 7px; text-align: left">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr >
                                    <td colspan="4" style="text-align: left; height: 16px;">
                                        </td>
                                </tr>
                            </table>
                        </radTS:PageView>
                        <radTS:PageView ID="PgViewChangeRequest" runat="server" Width="100%">
                            <table border="0" width="100%">
                                <tr>
                                    <td align="left">
                                        <div id="hlAcr" style="display:inline; text-align: left;"  runat="server">
                                            <asp:HyperLink ID="hlActivityChangeRequest" runat="server" NavigateUrl="#" Font-Bold="True" Font-Names="Trebuchet MS">[New Change Request]</asp:HyperLink>        
                                        </div>
                                    </td>
                                    <td align="right">
                                                                                  
                                        <asp:Button ID="btnClose2" runat="server" CausesValidation="False" OnClick="btnClose_Click"
                                            OnClientClick="confirmClose()" Text="Close" Width="100px" Font-Bold="False" Font-Names="Trebuchet MS"  Height="25px" />
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td align="left" colspan="2">
                                    
                            <asp:SqlDataSource ID="SqlActivitieChanges" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                SelectCommand="SELECT [key_activity_id], [key_act_change_id], [txt_activity_name_new], [txt_activity_desc_new], [txt_activity_core_indicator_desc_new], [flg_approved] FROM [act_change] WHERE ([key_activity_id] = @key_activity_id)" DeleteCommand="pr_act_change_request_del" DeleteCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:QueryStringParameter DefaultValue="" Name="key_activity_id" QueryStringField="id"
                                        Type="Int32" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="key_act_change_id" Type="Int32" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                            <radG:RadGrid ID="RadGrid2" runat="server" DataSourceID="SqlActivitieChanges" GridLines="None"
                                OnDataBound="RadGrid2_DataBound" Skin="Default" AllowAutomaticDeletes="True" OnItemDeleted="RadGrid2_ItemDeleted" EnableAJAX="True">
                               
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_act_change_id" DataSourceID="SqlActivitieChanges" ShowFooter="True">
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn>
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <radG:GridTemplateColumn UniqueName="TemplateColumn">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="hlEdit" runat="server" ImageUrl="~/images/Edit.gif" NavigateUrl="#">Edit</asp:HyperLink>
                                            </ItemTemplate>
                                            <ItemStyle VerticalAlign="Top" />
                                        </radG:GridTemplateColumn>
                                        <radG:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" HeaderText="key_activity_id"
                                            SortExpression="key_activity_id" UniqueName="key_activity_id" Display="False">
                                        </radG:GridBoundColumn>
                                        <radG:GridBoundColumn DataField="key_act_change_id" DataType="System.Int32" HeaderText="key_act_change_id"
                                            ReadOnly="True" SortExpression="key_act_change_id" UniqueName="key_act_change_id" Display="False">
                                        </radG:GridBoundColumn>
                                        <radG:GridBoundColumn DataField="txt_activity_name_new" HeaderText="New Activity Name"
                                            SortExpression="txt_activity_name_new" UniqueName="txt_activity_name_new">
                                            <ItemStyle VerticalAlign="Top" />
                                        </radG:GridBoundColumn>
                                        <radG:GridBoundColumn DataField="txt_activity_desc_new" HeaderText="New Activity Desc"
                                            SortExpression="txt_activity_desc_new" UniqueName="txt_activity_desc_new">
                                            <ItemStyle VerticalAlign="Top" />
                                        </radG:GridBoundColumn>
                                        <radG:GridBoundColumn DataField="txt_activity_core_indicator_desc_new" HeaderText="New Core Indicator Desc"
                                            SortExpression="txt_activity_core_indicator_desc_new" UniqueName="txt_activity_core_indicator_desc_new">
                                            <ItemStyle VerticalAlign="Top" />
                                        </radG:GridBoundColumn>
                                        <radG:GridTemplateColumn DataField="flg_Approved" HeaderText="Approved" SortExpression="flg_Approved"
                                            UniqueName="flg_Approved">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="cbReqApproved" runat="server" Checked='<%# Eval("flg_approved") %>'
                                                    Enabled="False" />
                                            </ItemTemplate>
                                            <ItemStyle VerticalAlign="Top" />
                                        </radG:GridTemplateColumn>
                                        <radG:GridClientDeleteColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this Change Request?"
                                            Text="Delete" UniqueName="DeleteColumn" ImageUrl="~/images/Delete.gif">
                                            <ItemStyle VerticalAlign="Top" />
                                        </radG:GridClientDeleteColumn>

                                    </Columns>
                                </MasterTableView>
                                <ClientSettings>
                                    <ClientEvents OnRowDeleted="forcePostback()" />
                                </ClientSettings>
                               
                                
                                
                            </radG:RadGrid><br />
                            <br />
                                  
                                    </td>
                                </tr>
                            </table>
                          </radTS:PageView>
                        <radTS:PageView ID="pv_History" runat="server" Width="100%">
                            <asp:SqlDataSource ID="ds_History" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                SelectCommand="pr_rpt_act_activity_transactions" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblAvtivityNbr" Name="p_key_activity_id" PropertyName="Text"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                            <telerik:RadGrid ID="rg_History" runat="server" DataSourceID="ds_History" GridLines="None"
                                OnItemDataBound="rg_History_ItemDataBound" Skin="Office2007_SCTCS" EnableEmbeddedSkins="False" ShowStatusBar="True" OnGroupsChanging="rg_History_GroupsChanging">
                                <MasterTableView AutoGenerateColumns="False" DataSourceID="ds_History" ShowFooter="True"
                                    ShowGroupFooter="True">
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" Display="False"
                                            HeaderText="key_activity_id" ReadOnly="True" SortExpression="key_activity_id"
                                            UniqueName="key_activity_id">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="key_activity_line_item_id" DataType="System.Int32"
                                            Display="False" HeaderText="key_activity_line_item_id" ReadOnly="True" SortExpression="key_activity_line_item_id"
                                            UniqueName="key_activity_line_item_id">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="txt_line_item_desc" Display="False" HeaderText="txt_line_item_desc"
                                            ReadOnly="True" SortExpression="txt_line_item_desc" UniqueName="txt_line_item_desc">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="dte_created_date" DataFormatString="{0:d}" DataType="System.DateTime"
                                            HeaderText="Created Date" ReadOnly="True" SortExpression="dte_created_date" UniqueName="dte_created_date">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="nbr_credit_amount" DataFormatString="{0:N2}"
                                            DataType="System.Decimal" HeaderText="Credit Amount" ReadOnly="True" SortExpression="nbr_credit_amount"
                                            UniqueName="nbr_credit_amount">
                                            <FooterStyle HorizontalAlign="Right" />
                                            <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="nbr_debit_amount" DataFormatString="{0:N2}" DataType="System.Decimal"
                                            HeaderText="Debit Amount" ReadOnly="True" SortExpression="nbr_debit_amount" UniqueName="nbr_debit_amount">
                                            <FooterStyle HorizontalAlign="Right" />
                                            <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn HeaderText="Balance" UniqueName="TemplateColumn">
                                            <FooterTemplate>
                                                <asp:Label ID="lbl_Sum" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle HorizontalAlign="Right" />
                                            <HeaderStyle HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="txt_desc" HeaderText="Description" ReadOnly="True"
                                            SortExpression="txt_desc" UniqueName="txt_desc">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                    <GroupByExpressions>
                                        <telerik:GridGroupByExpression>
                                            <SelectFields>
                                                <telerik:GridGroupByField FieldAlias="txt_line_item_desc" FieldName="txt_line_item_desc" HeaderText="Line Item"  />
                                            </SelectFields>
                                            <GroupByFields>
                                                <telerik:GridGroupByField FieldAlias="txt_line_item_desc" FieldName="txt_line_item_desc" />
                                            </GroupByFields>
                                        </telerik:GridGroupByExpression>
                                    </GroupByExpressions>
                                    <GroupHeaderItemStyle HorizontalAlign="Left" />
                                    <EditFormSettings>
                                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                            UpdateImageUrl="Update.gif">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                                <HeaderContextMenu EnableEmbeddedSkins="False">
                                </HeaderContextMenu>
                                <FilterMenu EnableEmbeddedSkins="False">
                                </FilterMenu>
                            </telerik:RadGrid></radTS:PageView>
                                                      
                    </radTS:RadMultiPage>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3" style="width: 788px">
                    <radW:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Vista">
                        <Windows>
                            <radw:RadWindow ID="UserListDialog" runat="server" Title="Task Information"
                               Left="150px" Behavior="Minimize, Maximize, Move, Reload"  BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top=""  />
                        </Windows>
                    </radW:RadWindowManager>
                    <asp:Label ID="lblPrintTrigger" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" runat="server" Height="50px" Style="position: relative" Width="125px">
            <asp:SqlDataSource ID="SqlDS_RLactivityGET" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_act_activity_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="id"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDS_RLActivityLineGet" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_act_activity_line_item_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="id"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <strong></strong>
            <asp:SqlDataSource ID="SqlDS_RLcoreindi_Get" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                SelectCommand="pr_act_activity_core_indicator_get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_id" QueryStringField="id"
                        Type="Int32" />
                    <asp:QueryStringParameter DefaultValue="-1" Name="key_activity_change_id" QueryStringField="acrId"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SQLDS_RLGETBALANCE" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>" SelectCommand="pr_lp_local_plan_balance_get " SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    <asp:ControlParameter ControlID="hfLpId" Name="p_key_local_plan_id" PropertyName="Value"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </asp:Panel>
        <br />
    
    </div>
        <asp:SqlDataSource ID="sqldsAmendmentReason" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_amendment_reason_id], [txt_amendment_reason_desc] FROM [scs_amendment_reason]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDsActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT     TOP (100) PERCENT key_activity_id, txt_activity_name&#13;&#10;FROM         dbo.v_line_item_balance&#13;&#10;GROUP BY key_local_plan_id, key_activity_id, txt_activity_name&#13;&#10;HAVING      (key_local_plan_id = 101) AND (SUM(nbr_line_item_balance) > 0)&#13;&#10;ORDER BY txt_activity_name">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDsUseOfFunds" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_category_type_id], [txt_category_type_desc] FROM [scs_category_type]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_ActivityType" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_activity_type_id], [txt_activity_type_desc] FROM [scs_activity_type]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_CoreIndicators" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT key_core_indicator_id, txt_core_indiciator_code+ ' - ' +  txt_core_indicator_name  FROM scs_core_indicator">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_Category" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            SelectCommand="pr_scs_category_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="101" Name="p_txt_category_type" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_FunctionCODE" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_category_function_assoc_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="DLB_Category" DefaultValue="-1" Name="p_key_category_id"
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_radiostuff" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_fa_activity_type_get" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_ActivityBudgetFunds" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_scs_line_item_type_desc_get" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="-1" Name="p_key_line_item_type_id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hfTotBal" runat="server" />
        &nbsp; &nbsp;<asp:HiddenField ID="hfGridTot" runat="server" />
        &nbsp;<br />
    </form>
   
</body>
</html>
