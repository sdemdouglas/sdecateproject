<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Amendment_Adjustments.aspx.cs" Inherits="LocalPlan_Amendment_Adjustments"  %>

<%@ Register Src="../UserControls/CountCharRemain.ascx" TagName="CountCharRemain"
    TagPrefix="uc1" %>
<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>
<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>
<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Amendment</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
</head>
<body >
    <form id="form1" runat="server" >
    <script type="text/javascript">
  





    var needToConfirm = true;
    var retval;
    var  finishedStatus;;
    window.onbeforeunload = wanttoleave;
    //window.onload = WeareaPopup();
    //window.onunload = wanttoleave;

 
     function confirmCallBackfn(arg)
                            {
            

                            
                            }
 
     function callBackFn(arg)
                            {
                                alert("Confirm returned the following result: " + arg);
     
                            }
      function AmendFinishedAction()
      {
      
      }
  
  
    function Close(keyactiveid)    
     {    
        //wanttoleave();
        GetRadWindow().Close(); 
        var oWnd = GetRadWindow().BrowserWindow;  
        oWnd.location.href = 'Amendments.aspx?keyactiveid=' + keyactiveid + "&notfinished=" + finishedStatus;//oWnd.location.href;             
    }    

    function wanttoleave()
    {   
        try
        {       
            var activityid = document.getElementById('<%= hdn_KeyActivityID.ClientID %>');
            var finishstat = document.getElementById('<%= hdn_finishedStatus.ClientID %>');

            if(finishstat.value == "false")
              finishedStatus = activityid.value;
            
            close(activityid);
             
             // window.opener.__doPostbask('PostBackFromChildWindow', ''); 
              //<%= ClientScript.GetPostBackEventReference(this, "CleanUp") %>;

            //GetRadWindow().BrowserWindow.CleanUP_UnFinished_activities(activityid.value);
        }
        catch (err)
        {
            alert(err.message);
        }

    } 

    function unloadcleanup()
    {
        var nothing = null;

    }
 
 
 
 

    function allowpostback_CancelButton()
    {
        var validation_obj =  document.getElementById('RequiredFieldValidator1');
        ValidatorEnable(document.all(validation_obj), false);
         validation_obj =  document.getElementById('RequiredFieldValidator2');
        ValidatorEnable(document.all(validation_obj), false);
         validation_obj =  document.getElementById('RequiredFieldValidator3');
        ValidatorEnable(document.all(validation_obj), false);
         validation_obj =  document.getElementById('RequiredFieldValidator4');
        ValidatorEnable(document.all(validation_obj), false);
         validation_obj =  document.getElementById('RequiredFieldValidator5');
        ValidatorEnable(document.all(validation_obj), false);
         validation_obj =  document.getElementById('RequiredFieldValidator6');
        ValidatorEnable(document.all(validation_obj), false);
         validation_obj =  document.getElementById('RequiredFieldValidator7');
        ValidatorEnable(document.all(validation_obj), false);
         validation_obj =  document.getElementById('RequiredFieldValidator8');
        ValidatorEnable(document.all(validation_obj), false);

        needToConfirm = false;
    }
 
    function trim(stringToTrim) {
	    return stringToTrim.replace(/^\s+|\s+$/g,"");
    }


    function trackit(gridname,buttonname)
    {

        var tableElement =  document.getElementById('GridView1');
        var a = 1;
        for (var i=2;i<=tableElement.rows.length;i++)
        {
           var currentRow_TextBox = 'GridView1_ctl0' + i + '_TextBox5';
            var txtbox =  document.getElementById(currentRow_TextBox);
            if(txtbox.value != '')
            {
                try
                {
                    if (isNaN(parseFloat(txtbox.value)))
                    { 
                        alert('Invalid Input');
                        txtbox.value = '';                    
                        tot.value =txtbox.value;
                    }
                    else
                    {
                        if (parseFloat(txtbox.value) <= 0)
                        {
                            alert('Transaction with 0 or less amount is not permitted.');
                            txtbox.value = '';                        
                            tot.value =txtbox.value;
                        }
                        else
                        {
                            var rowElem = tableElement.rows[a];
                            var cell = rowElem.cells[3];
                            var tot = document.getElementById('txt_tot2transfer');
                            //alert(removeformatting(txtbox.value));
                            //alert(removeformatting(cell.innerHTML));
                                if(parseFloat(removeformatting(cell.innerHTML)) >= parseFloat(removeformatting(txtbox.value)))
                                        {

                                            On_OneLineItem (gridname, buttonname);
                                            tot.value = removeformatting(txtbox.value);
                                           }
                                else
                                        {
                                            alert('Entered Transfer Larger than Available Amount, Please Correct');
                                            txtbox.value = '';
                                            tot.value =txtbox.value;
                                        }
                         }               
                     }
                 }
                 catch(err)
                 {
                 }

            }
            a++;
        }
    }


    function On_OneLineItem (gridname, buttonname)
    {

        var tableElement =  document.getElementById('GridView1');
        var a = 1;

        for (var i=2;i<=tableElement.rows.length;i++)        
            {
                //GridView1_ctl05_RadioButton1 GridView1$ctl05$TextBox5
                var currentRow_RadioButton = 'GridView1_ctl0' + i + '_RadioButton1';
                var currentRow_TextBox = 'GridView1_ctl0' + i + '_TextBox5';
                var chkbox =  document.getElementById(currentRow_RadioButton);
                var txtbox =  document.getElementById(currentRow_TextBox);


                //alert(chkbox.checked + buttonname);
                var rowElem = tableElement.rows[a];
                var cell = rowElem.cells[1];
                //alert(cell.innerHTML + '____' + buttonname);

         

            
                if(trim(cell.innerHTML) != trim(buttonname))
                    
                    { 
                        
                        chkbox.checked = false;
                        txtbox.value = '';
                        txtbox.disabled = true;
                        
                      var tot = document.getElementById('txt_tot2transfer');
                        tot.value ='';
                     }
                  

                else
                    {

                        chkbox.checked = true;
                        txtbox.disabled = false;


                    }

        a++;

        }

    }




    function allowpostback()
    {

       // needToConfirm = false;
       // MasterMath();

    }








function MasterMath()
{
    try
    {

        var tableElement =  document.getElementById('GridView2');

        var tot = document.getElementById('txt_tot2transfer');
        var transbutton = document.getElementById('Button1');
        var a = 1;
        var total = 0;

        for (var i=2;i<=tableElement.rows.length;i++)
        {
            var currentRow_TextBox = 'GridView2_ctl0' + i +'_TextBox5';
            var txtbox =  document.getElementById(currentRow_TextBox);
           // var rowElem = tableElement.rows[a];alert(rowElem);
            var input = parseFloat(removeformatting(txtbox.value)); 
            if (trim(txtbox.value) != '')
            {
            if(isNaN(parseFloat(input)))
            {
                alert('Invalid input for Destination Fund.');
                txtbox.value = '';                    
               // tot.value =txtbox.value;   
            }
            else
            {
                if(parseFloat(input) <= 0)
                {
                    alert('Transaction with 0 or less amount is not permitted.');
                    txtbox.value = '';                    
                   // tot.value =txtbox.value;   
                }
                else
                {
                    total = (parseFloat(total)) + (parseFloat(removeformatting(txtbox.value)));
                    if(parseFloat(total) > parseFloat(tot.value))
                    {
                        alert('Your total of ' + total + ' has surpassed the Transfer Ammount of ' + tot.value);

                    }
                    else
                    {
                        if(parseFloat(total) == parseFloat(tot.value))
                        {
                            var junkfiller = "ho";
                        }
                        else
                        {
                            window.event.cancelBubble = true;
                            window.event.returnValue = false;
                        }
                        transbutton.onclick = function allowpostback()
                        {
                            needToConfirm = false;
                        }

                    }
               }
            }
            }
            a++;
        }//end for
    }
    catch (err)
    {

    }
}

function IsNumeric(sText)
{
   var ValidChars = "0123456789.";
   var IsNumber=true;
   var Char;

 
   for (i = 0; i < sText.length && IsNumber == true; i++) 
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   return IsNumber;
   
   }

function removeformatting(inputvalue)
{
    var newstring = replaceAll(inputvalue,",","");
    newstring =replaceAll(newstring,"$","");

    if(IsNumeric(newstring))
    {
    }
    else
    {
        alert('Only Currency Allowed for Source and Destination Amounts');
        window.event.cancelBubble = true;
        window.event.returnValue = false;
    }

    return (newstring);
}

function replaceAll(OldString,FindString,ReplaceString) {
   var SearchIndex = 0;
   var NewString = "";
   while (OldString.indexOf(FindString,SearchIndex) != -1) {
   NewString += OldString.substring(SearchIndex,OldString.indexOf(FindString,SearchIndex));
   NewString += ReplaceString;
   SearchIndex = (OldString.indexOf(FindString,SearchIndex) + FindString.length);
   }
   NewString += OldString.substring(SearchIndex,OldString.length);
   return NewString;
}


function GetRadWindow()    
        {    
            var oWindow = null;    
            if (window.radWindow) oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog    
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;//IE (and Moz az well)    
            return oWindow;              
        }    
   
  
  
  
    function showerrors(errorid)
    {
     var winobj = window.radopen("Transfer_ValidationErrors.aspx?id=" + errorid, "MainPop");
    }

        function calCharNumber1()
        {
            var remCharlength = 1000;                        
            var des = document.getElementById("<%= txtActivityDesc.ClientID %>").value;
            document.getElementById("CountCharRemain1_txtCharCount").value = (remCharlength - des.length);           
        }


        function calCharNumber_txtCoreIndicatorsDesc()
        {
            var remCharlength = 1000;                        
            var des = document.getElementById("<%= txtCoreIndicatorsDesc.ClientID %>").value;
            document.getElementById("CountCharRemain2_txtCharCount").value = (remCharlength - des.length);           
        }
        
        function calCharNumber_txtReductionFundsDesc()
        {
            var remCharlength = 1000;                        
            var des = document.getElementById("<%= txtReductionFundsDesc.ClientID %>").value;
            document.getElementById("CountCharRemain3_txtCharCount").value = (remCharlength - des.length);           
        }
        
        function calCharNumber_txtAmdChangeInFundsDesc()
        {
            var remCharlength = 1000;                        
            var des = document.getElementById("<%= txtAmdChangeInFundsDesc.ClientID %>").value;
            document.getElementById("CountCharRemain4_txtCharCount").value = (remCharlength - des.length);           
        }
        
        function calCharNumber_txtAmdCoreIndicatorsDesc()
        {
            var remCharlength = 1000;                        
            var des = document.getElementById("<%= txtAmdCoreIndicatorsDesc.ClientID %>").value;
            document.getElementById("CountCharRemain5_txtCharCount").value = (remCharlength - des.length);           
        }
        
        function calCharNumber_txtAmdReductionDesc()
        {
            var remCharlength = 1000;                        
            var des = document.getElementById("<%= txtAmdReductionDesc.ClientID %>").value;
            document.getElementById("CountCharRemain6_txtCharCount").value = (remCharlength - des.length);           
        }
    
        function cvcCoreIndicator(source, args)
        {
            //alert("Run cvc");
            var cblCoreInd = document.getElementById("<%= chkCoreIndicators.ClientID %>").getElementsByTagName('input');                                  
            //alert(cblCoreInd.length);                 
            args.IsValid = false;
            for (var i=0; i < cblCoreInd.length; i++)
            {
                if(cblCoreInd[i].checked)
                    args.IsValid = true;
            }
        }

</script>


    
    <div id="wz_adminDIV" style="vertical-align:top;"> 
        <span style="font-size: 11pt"><strong>Amendment Process</strong></span><br />
        
        <!-- Keep track of activityid and headerTrans --> 
        <div style="visibility: hidden;">
        <asp:TextBox ID="txtActid"
            runat="server"></asp:TextBox>
            <asp:TextBox ID="txtHeaderTrans" runat="server"></asp:TextBox>
        </div>
<table width="100%">
    <tr>
        <td style="width: 918px">
                
    <radts:radtabstrip id="tabWizard" runat="server" multipageid="multipageWizard"
        skin="ClassicBlue" width="730px" Font-Bold="False" ForeColor="#FF3399" SelectedIndex="0" style="border-bottom: black 1px double" OnTabClick="tabWizard_TabClick"><Tabs>
<radTS:Tab runat="server" Text="Amendment Type" PageViewID="Page0" ID="tabAmendmentType" Value="tabAmendmentType"></radTS:Tab>
<radTS:Tab runat="server" Text="Description" Enabled="False" PageViewID="Page1" ID="newDescription" Visible="False" Value="newDescription"></radTS:Tab>
            <radTS:Tab ID="tabChangeDescription" runat="server" Text="Description" Visible="False" PageViewID="PgChangeInFunds" Value="tabChangeDescription">
            </radTS:Tab>
<radTS:Tab runat="server" Text="Source of Funds" Enabled="False" PageViewID="Page2" ID="tabFundSource" Value="tabFundSource"></radTS:Tab>
<radTS:Tab runat="server" Text="Destination" Enabled="False" PageViewID="Page3" ID="tabDestination" Visible="False" Value="tabDestination"></radTS:Tab>
<radTS:Tab runat="server" Text="Line Item Transfer" PageViewID="Page4" ID="tabLineItems" Enabled="False" Value="Page4"></radTS:Tab>
</Tabs>
</radts:radtabstrip>
    <radTS:RadMultiPage ID="multipageWizard" runat="server" SelectedIndex="0" Width="92%">
        <radTS:PageView ID="Page0" runat="server"><table style="width: 675px; text-align: left;">
            <tr>
                <td colspan="1" style="width: 137px; height: 33px">
                </td>
                <td colspan="3" style="height: 33px">
                </td>
            </tr>
            <tr>
                <td colspan="1" style="width: 137px; text-align: left">
                    &nbsp;Amendment Type
                </td>
                <td colspan="3">
                    <asp:DropDownList ID="ddAmendmentReason" runat="server" DataSourceID="sqlDsAmendmentReason"
                        DataTextField="txt_amendment_reason_desc" DataValueField="key_amendment_reason_id"
                        Width="430px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" onChange="allowpostback();">
                    </asp:DropDownList></td>
    </tr><tr >
        <td colspan="1" style="width: 137px">
        </td>
        <td colspan="3">
        </td>
    </tr>
            <tr >
                <td colspan="1" style="width: 137px; text-align: right">
                    <span></span>
                </td>
                <td colspan="3">
                    </td>
            </tr>
            <tr>
                <td colspan="1" style="width: 137px; height: 18px;">
                </td>
                <td colspan="3" style="height: 18px">
                </td>
            </tr>
            <tr>
                <td colspan="1" style="width: 137px">
                </td>
                <td colspan="3">
                </td>
            </tr>
            <tr>
                <td colspan="1" style="width: 137px">
                </td>
                <td colspan="3">
                </td>
            </tr>
        </table>
        </radTS:PageView>
        <radTS:PageView ID="Page1" runat="server"><table style="width: 720px; text-align: left;">
    <tr >
        <td colspan="4" style="background-color: #3366cc; background-repeat: repeat-x;">
            <span style="color: #ffffff"><strong>Provide Description of New Activity</strong></span></td>
    </tr>
            <tr>
                <td style="width: 136px">
                    Activity Type</td>
                <td colspan="3">
            <asp:DropDownList DataSourceID="SDS_ActivityType" DataTextField="txt_activity_type_desc" DataValueField="key_activity_type_id" ID="DLB_ActType" OnSelectedIndexChanged="DLB_ActType_SelectedIndexChanged" runat="server" Width="142px" onChange="allowpostback();" AutoPostBack="True">
            </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="DLB_ActType"
                        Enabled="False" ErrorMessage="*Activity Type Required" InitialValue="-1" Style="position: relative"></asp:RequiredFieldValidator></td>
            </tr>
            <tr >
                <td style="width: 136px">
                    <asp:Label ID="Label16" runat="server" Style="position: relative" Text="Activity Name"
                        Width="101px" Font-Names="Trebuchet MS"></asp:Label></td>
                <td colspan="3">
                    <asp:TextBox ID="TextBox2" runat="server" Width="490px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="TextBox2"
                        Enabled="False" ErrorMessage="RequiredFieldValidator">*Required</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 136px">
                    Category</td>
                <td style="width: 152px">
                    <asp:DropDownList ID="DLB_Category" runat="server" DataSourceID="SDS_Category" DataTextField="txt_category_title"
                        DataValueField="key_category_id" Width="398px" onChange="allowpostback();" AutoPostBack="True" OnSelectedIndexChanged="DLB_Category_SelectedIndexChanged" OnDataBound="DLB_Category_DataBound1">
                    </asp:DropDownList></td>
                <td>
                    </td>
                <td style="width: 24px">
                    </td>
            </tr>
            <tr>
                <td style="width: 136px; height: 22px;">
                    <asp:Label ID="Label1" runat="server" Text="Function Code" Width="84px"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="DLB_FunCode" runat="server" DataSourceID="SDS_FunctionCODE"
                        DataTextField="txt_function_code_desc" DataValueField="key_function_code_id"
                        Width="256px" onChange="allowpostback();" OnDataBound="DLB_FunCode_DataBound">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="DLB_FunCode"
                        Enabled="False" ErrorMessage="* Required" InitialValue="-1"></asp:RequiredFieldValidator></td>
                <td style="height: 22px">
                </td>
                <td style="width: 24px; height: 22px;">
                </td>
            </tr>
            <tr>
                <td style="width: 136px">
                    <asp:Label ID="Label7" runat="server" Text="Use of Funds"></asp:Label></td>
                <td colspan="3">
                   <asp:TextBox ID="txt_lbl_UseofFunds" runat="server" Style="left: 0px; position: relative"
                        Width="139px"></asp:TextBox>
                    &nbsp; &nbsp;&nbsp;
                    <asp:Label ID="Label2" runat="server" Text="Program Type"></asp:Label>
                    &nbsp;&nbsp;
                    <asp:DropDownList ID="ddlProgramType" runat="server" DataSourceID="SDS_radiostuff"
                        DataTextField="txt_fa_activity_desc" DataValueField="key_fa_activity_type_id"
                        Width="203px" onChange="allowpostback();">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlUseOfFunds" runat="server" DataSourceID="sqlDsUseOfFunds"
                        DataTextField="txt_category_type_desc" DataValueField="key_category_type_id"
                        Width="1px" onChange="allowpostback();" style="position: relative" Visible="False">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="ddlProgramType"
                        Enabled="False" ErrorMessage="* Required" InitialValue="-1"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 136px; height: 9px" valign="top">
                    <asp:Label ID="Label3" runat="server" Font-Bold="False" Text="Core Indicators"></asp:Label></td>
                <td colspan="3" style="height: 9px" valign="top">
                    <asp:CheckBoxList ID="chkCoreIndicators" runat="server" DataSourceID="SDS_CoreIndicators"
                        DataTextField="Column1" DataValueField="key_core_indicator_id">
                    </asp:CheckBoxList>
                    <asp:Label ID="Label17" runat="server" ForeColor="Red" Style="position: relative"
                        Text="*At least 1 Core Indicator Required" Visible="False"></asp:Label>&nbsp;
                    <asp:CustomValidator ID="cvCoreIndicator" runat="server" ClientValidationFunction="cvcCoreIndicator" OnServerValidate="cvsCoreIndicator"
                        ErrorMessage="* Required" Enabled="False"></asp:CustomValidator></td>
            </tr>
            <tr>
                <td colspan="4">
                    Describe the proposed new activity.
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtActivityDesc"
                        Enabled="False" ErrorMessage="RequiredFieldValidator">*Required</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="height: 85px" colspan="4">
                    <asp:TextBox ID="txtActivityDesc" runat="server" Height="114px" Width="708px" Font-Names="Trebuchet MS" Font-Size="9pt" TextMode="MultiLine"></asp:TextBox><br />
                    </td>
            </tr>
            <tr>
                <td colspan="4">
                    <uc1:CountCharRemain ID="CountCharRemain1" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="height: 7px" colspan="4">
                    Describe how the proposed new actvity will help meet the
                    core
                    indicators(s):
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCoreIndicatorsDesc"
                        Enabled="False" ErrorMessage="RequiredFieldValidator">*Required</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="height: 5px" colspan="4">
                    <asp:TextBox ID="txtCoreIndicatorsDesc" runat="server" Height="114px" Width="708px" Font-Names="Trebuchet MS" Font-Size="9pt" TextMode="MultiLine"></asp:TextBox><br />
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 5px">
                    <uc1:CountCharRemain ID="CountCharRemain2" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="height: 7px" colspan="4">
                    Explain how the reduction of funds will impact the original activity.
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtReductionFundsDesc"
                        Enabled="False" ErrorMessage="RequiredFieldValidator">*Required</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="height: 8px" colspan="4">
                    <asp:TextBox ID="txtReductionFundsDesc" runat="server" Height="114px" Width="708px" Font-Names="Trebuchet MS" Font-Size="9pt" TextMode="MultiLine"></asp:TextBox><br />
                    </td>
            </tr>
             <tr>
                    <td colspan="4" style="height: 8px">
                        <uc1:CountCharRemain ID="CountCharRemain3" runat="server" />
                    </td>
                </tr>
        </table>
            <asp:HiddenField ID="hdn_newDescription" runat="server" />
        </radTS:PageView>
        &nbsp;&nbsp;
        <radTS:PageView ID="PgChangeInFunds" runat="server">
            <table style="width: 722px; text-align: left;">
                
             
                
               
                <tr >
                    <td colspan="4" style="background-color: #0066cc; color: white; width: 724px;">
                        <strong>Provide Amendment Information</strong></td>
                </tr>
                <tr>
                    <td colspan="4" style="width: 724px">
                        Amendment Name&nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="width: 724px; height: 22px;">
                        <asp:TextBox ID="txtAmendmentName" runat="server" Width="610px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAmendmentName"
                            ErrorMessage="RequiredFieldValidator" Style="position: relative" Enabled="False">*Required</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td colspan="4" style="width: 724px">
                        Describe the reason for the proposed change in funds.
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAmdChangeInFundsDesc"
                            ErrorMessage="RequiredFieldValidator"  Enabled="False">*Required</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="height: 85px; width: 724px;" colspan="4">
                        <asp:TextBox ID="txtAmdChangeInFundsDesc" runat="server" Height="114px" Width="714px" TextMode="MultiLine" Font-Names="Trebuchet MS"></asp:TextBox><br />
                        </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <uc1:CountCharRemain ID="CountCharRemain4" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 7px; width: 724px;" colspan="4">
                        Describe how the proposed change in funds and/or new actvity will help meet the
                        core indicators(s) on the target activity.
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAmdCoreIndicatorsDesc"
                            ErrorMessage="RequiredFieldValidator"  Enabled="False">*Required</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="height: 5px; width: 724px;" colspan="4">
                        <asp:TextBox ID="txtAmdCoreIndicatorsDesc" runat="server" Height="114px" Width="705px" TextMode="MultiLine" Font-Names="Trebuchet MS"></asp:TextBox><br />
                        </td>
                </tr>
                <tr>
                    <td colspan="4" style="width: 724px; height: 5px">
                        <uc1:CountCharRemain ID="CountCharRemain5" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 7px; width: 724px;" colspan="4">
                        Explain how the reduction of funds will impact the original activity.
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAmdReductionDesc"
                            ErrorMessage="RequiredFieldValidator" Enabled="False">*Required</asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td style="height: 7px; width: 724px;" colspan="4">
                        <asp:TextBox ID="txtAmdReductionDesc" runat="server" Height="114px" Width="711px" TextMode="MultiLine" Font-Names="Trebuchet MS"></asp:TextBox><br />
                        </td>
                </tr>
                <tr>
                    <td colspan="4" style="width: 724px; height: 7px">
                        <uc1:CountCharRemain ID="CountCharRemain6" runat="server" />
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdn_tabChangeDescription" runat="server" />
        </radTS:PageView>
        <radTS:PageView ID="Page2" runat="server">
            <table style="width: 724px; text-align: left;">
                <tr>
                    <td colspan="4" style="background-color: #0066cc; color: white;">
                        <strong>Source of Funds</strong></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px; height: 22px;" valign="top">
                        <asp:Label ID="Label19" runat="server" Style="position: relative" Text="Select Source"></asp:Label></td>
                    <td colspan="3" style="height: 22px; text-align: left;">
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="sqlDsActivities"
                            DataTextField="txt_activity_name" DataValueField="key_activity_id" Width="467px" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged" AutoPostBack="True" onChange="allowpostback();" OnDataBound="DropDownList4_DataBound">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="DropDownList4"
                            Enabled="False" ErrorMessage="* Required" InitialValue="-1" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:Label ID="lbl_MustPickSource" runat="server" ForeColor="Red" Text="** Source of Funds Required"
                            Visible="False"></asp:Label></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label22" runat="server" Style="position: relative" Text="Activity #"
                            Visible="False"></asp:Label></td>
                    <td colspan="3">
                        <asp:Label ID="Label10" runat="server"></asp:Label></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label23" runat="server" Style="position: relative" Text="Activity Type"
                            Visible="False"></asp:Label></td>
                    <td colspan="3">
                        <asp:Label ID="Label12" runat="server" Width="159px"></asp:Label></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label24" runat="server" Style="position: relative" Text="Activity Description"
                            Visible="False"></asp:Label></td>
                    <td colspan="3">
                        <asp:Label ID="Label14" runat="server"
                            Width="558px"></asp:Label></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px; height: 16px;" valign="top">
                        <asp:Label ID="Label8" runat="server" Text="Use of Funds" Width="105px" Visible="False"></asp:Label></td>
                    <td style="width: 128px; height: 16px;">
                        <asp:Label ID="Label9" runat="server" Width="105px"></asp:Label></td>
                    <td style="height: 16px">
                    </td>
                    <td style="width: 120px; height: 16px;">
                    </td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label25" runat="server" Style="position: relative" Text="Function Code"
                            Visible="False"></asp:Label></td>
                    <td style="width: 128px">
                        <asp:Label ID="Label18" runat="server" Style="position: relative" Width="359px"></asp:Label></td>
                    <td>
                    </td>
                    <td style="width: 120px">
                    </td>
                </tr>
                
                
                
                 <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label36" runat="server" Style="position: relative" Text="Category"
                            Visible="False"></asp:Label></td>
                    <td style="width: 128px">
                        <asp:Label ID="Label37" runat="server" Style="position: relative" Width="526px"></asp:Label></td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                
                
                
                
                
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign = "top" >
                        <asp:Label ID="Label26" runat="server" Style="position: relative" Text="Core Indicators"
                            Visible="False"></asp:Label></td>
                    <td colspan="3">
                        &nbsp;<radG:RadGrid ID="RadGrid3" runat="server" DataSourceID="SqlDataSource3" OnDataBound="RadGrid3_DataBound" Skin="Default" Visible="False">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_core_indicator_id"
                                DataSourceID="SqlDataSource3">
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <radG:GridBoundColumn DataField="key_core_indicator_id" DataType="System.Int32" HeaderText="key_core_indicator_id"
                                        ReadOnly="True" SortExpression="key_core_indicator_id" UniqueName="key_core_indicator_id"
                                        Visible="False">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_core_indicator_name" HeaderText="Core Indicator"
                                        ReadOnly="True" SortExpression="txt_core_indicator_name" UniqueName="txt_core_indicator_name">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" HeaderText="key_activity_id"
                                        SortExpression="key_activity_id" UniqueName="key_activity_id" Visible="False">
                                    </radG:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        
                        
                        </radG:RadGrid>
                        
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT     c.key_core_indicator_id, c.txt_core_indiciator_code + ' - ' + c.txt_core_indicator_name AS txt_core_indicator_name, i.key_activity_id&#13;&#10;FROM         dbo.scs_core_indicator AS c INNER JOIN&#13;&#10;                      dbo.act_activity_core_indicator AS i ON c.key_core_indicator_id = i.key_core_indicator_id&#13;&#10;WHERE i.key_activity_id = @p_key_activity_id">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList4" DefaultValue="-1" Name="p_key_activity_id"
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                    </td>
                </tr>
                <tr style="font-size: 9pt">
                    <td  valign = "top" style="width: 142px; height: 22px;">
                        <asp:Label ID="Label27" runat="server" Style="position: relative" Text="Line Item(s)"
                            Visible="False"></asp:Label></td>
                    <td colspan="3" style="height: 22px">
                        <radG:RadGrid ID="RadGrid1" runat="server" DataSourceID="sqlDSSourceLineitems" GridLines="None"
                            Skin="Default" OnDataBound="RadGrid1_DataBound" Visible="False">
<MasterTableView DataSourceID="sqlDSSourceLineitems" AutoGenerateColumns="False">
<RowIndicatorColumn Visible="False">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="False">
<HeaderStyle Width="19px"></HeaderStyle>
</ExpandCollapseColumn>
<Columns>
<radG:GridBoundColumn DataField="txt_line_item_desc" HeaderText="Line item" SortExpression="txt_line_item_desc" UniqueName="txt_line_item_desc">
<ItemStyle Width="2in"></ItemStyle>
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="nbr_line_item_balance" ReadOnly="True" HeaderText="Balance" SortExpression="nbr_line_item_balance" UniqueName="nbr_line_item_balance" DataType="System.Decimal" DataFormatString="{0:c}">
<ItemStyle Width="0.8in"></ItemStyle>
</radG:GridBoundColumn>
</Columns>
</MasterTableView>
</radG:RadGrid><asp:SqlDataSource ID="sqlDSSourceLineitems" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="SELECT     b.txt_line_item_desc, b.nbr_line_item_balance&#13;&#10;FROM         dbo.act_activity AS a INNER JOIN&#13;&#10;                      dbo.v_line_item_balance AS b ON a.key_activity_id = b.key_activity_id&#13;&#10;WHERE     (b.key_activity_id = @p_key_activity_id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList4" Name="p_key_activity_id" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdn_tabFundSource" runat="server" />
        </radTS:PageView>
        <radTS:PageView ID="Page3" runat="server">
            <table style="width: 724px; text-align: left;">
                <tr>
                    <td colspan="4" style="background-color: #3366cc; color: white;">
                        <strong>Destination</strong></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        Select Destination</td>
                    <td colspan="3">
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDSDestination"
                            DataTextField="txt_activity_name" DataValueField="key_activity_id" Width="476px" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" AutoPostBack="True" onChange="allowpostback();" OnDataBound="DropDownList3_DataBound">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="DropDownList3"
                            Enabled="False" ErrorMessage="* Required" InitialValue="-1"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="SqlDSDestination" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_amd_transfer_funds_to" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:ControlParameter ControlID="HDN_PlanID" Name="planid" PropertyName="Value" Type="Int32" />
                                <asp:ControlParameter ControlID="DLB_ActType" Name="activitytypeid" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label ID="lbl_MustPickDestination" runat="server" ForeColor="Red" Text="** Fund Destination Required"></asp:Label></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px; height: 18px;" valign="top">
                        <asp:Label ID="Label28" runat="server" Style="position: relative" Text="Activity #"
                            Visible="False"></asp:Label></td>
                    <td colspan="3" style="height: 18px">
                        <asp:Label ID="Label4" runat="server" Font-Bold="False" ></asp:Label></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label29" runat="server" Style="position: relative" Text="Activity Type"
                            Visible="False"></asp:Label></td>
                    <td colspan="3" style="font-weight: bold">
                        <asp:Label ID="Label5" runat="server" Width="159px" Font-Bold="False"></asp:Label></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label30" runat="server" Style="position: relative" Text="Activity Description"
                            Visible="False"></asp:Label></td>
                    <td colspan="3">
                        <asp:Label ID="Label6" runat="server"
                            Width="100%"></asp:Label></td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px; height: 18px;" valign="top">
                        <asp:Label ID="Label20" runat="server" Text="Use of Funds" Width="105px" Visible="False"></asp:Label></td>
                    <td style="width: 128px; height: 18px;">
                        <asp:Label ID="Label21" runat="server" Width="105px"></asp:Label></td>
                    <td style="height: 18px">
                    </td>
                    <td style="height: 18px">
                    </td>
                </tr>
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label31" runat="server" Style="position: relative" Text="Function Code"
                            Visible="False"></asp:Label></td>
                    <td style="width: 128px">
                        <asp:Label ID="Label11" runat="server" Style="position: relative" Width="359px"></asp:Label></td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                
                 <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label34" runat="server" Style="position: relative" Text="Category"
                            Visible="False"></asp:Label></td>
                    <td style="width: 128px">
                        <asp:Label ID="Label35" runat="server" Style="position: relative" Width="526px"></asp:Label></td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                
                
                
                
                <tr style="font-size: 9pt">
                    <td style="width: 142px" valign="top">
                        <asp:Label ID="Label32" runat="server" Style="position: relative" Text="Core Indicators"
                            Visible="False"></asp:Label></td>
                    <td colspan="3">
                        &nbsp;<radG:RadGrid ID="RadGrid4" runat="server" DataSourceID="sqlDSDestCoreIndicator"
                            GridLines="None" Visible="False" Skin="Default">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_core_indicator_id"
                                DataSourceID="sqlDSDestCoreIndicator">
                                <RowIndicatorColumn>
                                    <HeaderStyle Width="20px" />
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn>
                                    <HeaderStyle Width="20px" />
                                </ExpandCollapseColumn>
                                <Columns>
                                    <radG:GridBoundColumn DataField="key_core_indicator_id" DataType="System.Int32" HeaderText="key_core_indicator_id"
                                        ReadOnly="True" SortExpression="key_core_indicator_id" UniqueName="key_core_indicator_id"
                                        Visible="False">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="txt_core_indicator_name" HeaderText="Core Indicator"
                                        ReadOnly="True" SortExpression="txt_core_indicator_name" UniqueName="txt_core_indicator_name">
                                    </radG:GridBoundColumn>
                                    <radG:GridBoundColumn DataField="key_activity_id" DataType="System.Int32" HeaderText="key_activity_id"
                                        SortExpression="key_activity_id" UniqueName="key_activity_id" Visible="False">
                                    </radG:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                        </radG:RadGrid>
                        <asp:SqlDataSource ID="sqlDSDestCoreIndicator" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT     c.key_core_indicator_id, c.txt_core_indiciator_code + ' - ' + c.txt_core_indicator_name AS txt_core_indicator_name, i.key_activity_id&#13;&#10;FROM         dbo.scs_core_indicator AS c INNER JOIN&#13;&#10;                      dbo.act_activity_core_indicator AS i ON c.key_core_indicator_id = i.key_core_indicator_id&#13;&#10;WHERE i.key_activity_id = @p_key_activity_id">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList3" DefaultValue="-1" Name="p_key_activity_id"
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr style="font-size: 9pt">
                    <td  valign = "top" style="width: 142px">
                        <asp:Label ID="Label33" runat="server" Style="position: relative" Text="Line Item(s)"
                            Visible="False"></asp:Label></td>
                    <td colspan="3">
                        <radG:RadGrid ID="RadGrid2" runat="server" DataSourceID="SqlDataSource4" GridLines="None"
                            Skin="Default" Visible="False">
<MasterTableView DataSourceID="SqlDataSource4" AutoGenerateColumns="False">
<RowIndicatorColumn Visible="False">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn Visible="False">
<HeaderStyle Width="19px"></HeaderStyle>
</ExpandCollapseColumn>
<Columns>
<radG:GridBoundColumn DataField="txt_line_item_desc" HeaderText="Line item" SortExpression="txt_line_item_desc" UniqueName="txt_line_item_desc">
<ItemStyle Width="2in"></ItemStyle>
</radG:GridBoundColumn>
<radG:GridBoundColumn DataField="nbr_line_item_balance" ReadOnly="True" HeaderText="Balance" SortExpression="nbr_line_item_balance" UniqueName="nbr_line_item_balance" DataType="System.Decimal" DataFormatString="{0:c}">
<ItemStyle Width="0.8in"></ItemStyle>
</radG:GridBoundColumn>
</Columns>
</MasterTableView>
</radG:RadGrid><asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="SELECT     b.txt_line_item_desc, b.nbr_line_item_balance&#13;&#10;FROM         dbo.act_activity AS a INNER JOIN&#13;&#10;                      dbo.v_line_item_balance AS b ON a.key_activity_id = b.key_activity_id&#13;&#10;WHERE     (b.key_activity_id = @p_key_activity_id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList3" Name="p_key_activity_id" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
            <asp:HiddenField ID="hdn_tabDestination" runat="server" />
        </radTS:PageView>
        <radTS:PageView ID="Page4" runat="server">
            <table style="width: 723px">
                <tr>
                    <td rowspan="3" style="height: 13px; text-align: left;">
                        &nbsp;
                        <table>
                            <tr>
                                <td colspan="3" rowspan="1" style="height: 9px; text-align: left">
                                    <strong>Source of Funds </strong><asp:Label ID="Label13" runat="server" Text="Label" Width="483px" Font-Bold="True"></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="3" rowspan="1" style="height: 9px; text-align: left">
                                    &nbsp; &nbsp; &nbsp;&nbsp;<strong> Destination </strong>&nbsp;<asp:Label ID="Label15" runat="server"
                                        Text="Label" Width="483px" Font-Bold="True"></asp:Label></td>
                            </tr>
                            <tr>
                                <td rowspan="1" style="height: 9px; text-align: left">
                                    Source
                                </td>
                                <td colspan="2" rowspan="1" style="height: 9px; width: 315px;">
                                    Destination</td>
                            </tr>
                            <tr>
                                <td rowspan="3" style="height: 157px" valign = "top" >
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="key_activity_line_item_id"
                                        DataSourceID="SqlDataSource1" Font-Names="Trebuchet MS" Font-Size="9pt" OnRowDataBound="GridView1_RowDataBound" SkinID="booksSkin" Width="372px" Font-Bold="False" OnDataBound="GridView1_DataBound" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="RadioButton1" runat="server" />&nbsp;&nbsp;
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="key_activity_line_item_id" HeaderText="Line" InsertVisible="False"
                                                ReadOnly="True" SortExpression="key_activity_line_item_id" />
                                            <asp:BoundField DataField="txt_line_item_desc" HeaderText="Description" SortExpression="txt_line_item_desc" />
                                            <asp:BoundField DataField="nbr_line_item_balance" HeaderText="Balance" SortExpression="amt_amount" DataFormatString="{0:c}" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Amount
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBox5" runat="server" Width="64px"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle BackColor="#1C59A4" Font-Bold="True" ForeColor="White" Height="10px" VerticalAlign="Top" />
                                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                    </asp:GridView>
                                </td>
                                <td  valign = "top" colspan="2" rowspan="3" style="height: 157px; width: 315px;">
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="key_activity_line_item_id"
                                        DataSourceID="SqlDataSource2" Font-Names="Trebuchet MS" Font-Size="9pt" OnRowDataBound="GridView2_RowDataBound" SkinID="booksSkin" Width="338px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                                        <Columns>
                                            <asp:TemplateField Visible="False">
                                                <ItemTemplate>
                                                    &nbsp;<asp:CheckBox ID="CheckBox1" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="key_activity_line_item_id" HeaderText="Line" InsertVisible="False"
                                                ReadOnly="True" SortExpression="key_activity_line_item_id" />
                                            <asp:BoundField DataField="txt_line_item_desc" HeaderText="Description" SortExpression="txt_line_item_desc" />
                                            <asp:BoundField DataField="amt_amount" HeaderText="Balance" SortExpression="amt_amount" DataFormatString="{0:c}" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    Amount
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBox5" runat="server" Width="57px"></asp:TextBox>
                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="key_category_id" HeaderText="key_category_id" SortExpression="key_category_id" />
                                        </Columns>
                                        <HeaderStyle BackColor="#1C59A4" Font-Bold="True" ForeColor="White" Height="3px" VerticalAlign="Top" Wrap="False" />
                                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                        <AlternatingRowStyle BackColor="Gainsboro" />
                                    </asp:GridView>
                                    <br />
                                    <asp:Label ID="lbl_noIndirectCOST" runat="server" Text="The Category you have chosen does not allow funds to be placed in Line Item Indirect Cost." ForeColor="Red" Visible="False"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                            </tr>
                            <tr>
                            </tr>
                            <tr>
                                <td colspan="3" rowspan="1" style="text-align: center; height: 26px;">
                        <asp:Button ID="Button1" runat="server" Text="Transfer Funds >>>>" Enabled="True" OnClick="Button1_Click" OnClientClick="MasterMath();"/>&nbsp;
                                    <asp:HyperLink ID="HL_TransErrors" runat="server" Visible="False">[HL_TransErrors]</asp:HyperLink></td>
                            </tr>
                            <tr>
                                <td colspan="3" rowspan="1" style="height: 3px; text-align: center"><asp:Button ID="Button2" runat="server" Text="Finish" Enabled="False" OnClick="Button2_Click" style="position: relative" OnClientClick="AmendFinishedAction();" />
                                    <asp:Button ID="Button3" runat="server" Text="Cancel" OnClick="Button3_Click1" style="position: relative" /></td>
                            </tr>
                            <tr>
                                <td rowspan="1" colspan="3">
                                    <radG:RadGrid ID="radgridTransactions" runat="server" DataSourceID="sqlDSTransactions" GridLines="None" OnDeleteCommand="radgridTransactions_DeleteCommand" OnItemDeleted="radgridTransactions_ItemDeleted" Skin="Default" OnItemDataBound="radgridTransactions_ItemDataBound" >
                                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_amendment_transfer_dtl_id"
                                            DataSourceID="sqlDSTransactions">
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <radG:GridBoundColumn DataField="key_amendment_transfer_dtl_id" DataType="System.Int32"
                                                    HeaderText="key_amendment_transfer_dtl_id" ReadOnly="True" SortExpression="key_amendment_transfer_dtl_id"
                                                    UniqueName="key_amendment_transfer_dtl_id" Visible="False">
                                                </radG:GridBoundColumn>
                                                <radG:GridBoundColumn DataField="txt_line_item_desc_from" HeaderText="Transferred From"
                                                    SortExpression="txt_line_item_desc_from" UniqueName="txt_line_item_desc_from">
                                                </radG:GridBoundColumn>
                                                <radG:GridBoundColumn DataField="amt_debit_amount" DataType="System.Decimal" HeaderText="Amount"
                                                    SortExpression="amt_debit_amount" UniqueName="amt_debit_amount" DataFormatString="{0:c}">
                                                </radG:GridBoundColumn>
                                                <radG:GridBoundColumn DataField="txt_line_item_desc_to" HeaderText="Transferred to"
                                                    SortExpression="txt_line_item_desc_to" UniqueName="txt_line_item_desc_to">
                                                </radG:GridBoundColumn>
                                                <radG:GridBoundColumn DataField="key_amendment_transfer_hdr_id" DataType="System.Int32"
                                                    HeaderText="key_amendment_transfer_hdr_id" SortExpression="key_amendment_transfer_hdr_id"
                                                    UniqueName="key_amendment_transfer_hdr_id" Visible="False">
                                                </radG:GridBoundColumn>
                                                <radG:GridTemplateColumn UniqueName="TemplateColumn" Display="False">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Delete.gif" CommandName="Delete"  OnClientClick="allowpostback();" />
                                                    </ItemTemplate>
                                                </radG:GridTemplateColumn>
                                                <radG:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete this record?"
                                                    ImageUrl="~/images/Delete.gif" Text="Delete" UniqueName="column">
                                                </radG:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="True" />
                                    </radG:RadGrid><asp:SqlDataSource ID="sqlDSTransactions" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                                        SelectCommand="pr_at_amendment_transfer_detail_Get" SelectCommandType="StoredProcedure" DeleteCommand="delete from at_amendment_transfer_detail where key_amendment_transfer_dtl_id = @delid" OnDeleted="sqlDSTransactions_Deleted">
                                        <SelectParameters>
                                            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                            <asp:ControlParameter ControlID="HDN_HEADER_KEY" Name="p_key_amendment_transfer_hdr_id"
                                                PropertyName="Value" Type="Int32" />
                                        </SelectParameters>
                                        <DeleteParameters>
                                            <asp:ControlParameter ControlID="radgridTransactions" Name="delid" PropertyName="SelectedValue" />
                                        </DeleteParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                        &nbsp;<br />
                        &nbsp;
                        <div style="visibility:hidden">
                        <asp:TextBox ID="txt_tot2transfer" runat="server" ></asp:TextBox><br />
                            <asp:TextBox ID="totaltransfered" runat="server">0</asp:TextBox><br />
                             <asp:TextBox ID="CategoryID" runat="server">0</asp:TextBox>
                        </div>
                        &nbsp;
                    </td>
                    <td colspan="2" rowspan="3" style="height: 13px">
                    </td>
                </tr>
                <tr>
                </tr>
                <tr>
                </tr>
                <tr>
                    <td rowspan="1" style="height: 18px; text-align: center">
                        <asp:HiddenField ID="hdn_Page4" runat="server" />
                        <asp:HiddenField ID="hdn_KeyActivityID" runat="server" Value="-1" /><asp:HiddenField ID="hdn_finishedStatus" runat="server" Value="false" />
                        </td>
                    <td colspan="2" rowspan="1" style="height: 18px">
                    </td>
                </tr>
            </table>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_act_get_line_item_balance" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList4" Name="activityID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                            SelectCommand="pr_act_get_line_item_balance" OnSelecting="SqlDataSource2_Selecting" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="-1" Name="activityID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
        </radTS:PageView>
        &nbsp;
        <radTS:PageView ID="Page5" runat="server">
        </radTS:PageView>
    </radTS:RadMultiPage>
    
            </td>
        </tr>
        <tr>
            <td style="text-align: center; width: 918px;" align="center">
                <asp:Button ID="btnContinue" runat="server" Font-Bold="True" Font-Size="9pt" OnClick="btnContinue_Click" Text="Continue >>" OnClientClick="allowpostback();" Width="100px" />
                <asp:Button ID="Button4" runat="server" Text="Cancel" OnClick="Button3_Click1" style="position: relative" OnClientClick="allowpostback_CancelButton();" Width="100px" /></td>
        </tr>
        <tr>
            <td style="width: 918px">
            </td>
        </tr>
        <tr>
<td style="width: 918px">


<asp:Label ID="InjectScript" Runat="server" Width="410px"></asp:Label><radw:radwindowmanager id="RadWindowManager1" runat="server" style="position: relative">
<Windows>
            <radw:RadWindow ID="MainPop"  runat="server" Title="Error Report" Height="600px"
                          Width="800px" ReloadOnShow="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Top="10px" Left="" />
              

</Windows>

</radw:radwindowmanager>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
        <asp:SqlDataSource ID="SQLDS_DeleteUnfinishedActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            DeleteCommand="pr_at_amendment_incomplete_amd_del" DeleteCommandType="StoredProcedure"
            SelectCommand="select * from sec_roles">
            <DeleteParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:Parameter Name="p_key_activity_id" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
    &nbsp;
<p />
    <asp:SqlDataSource ID="sqldsAmendmentReason" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT [key_amendment_reason_id], [txt_amendment_reason_desc] FROM [scs_amendment_reason]">
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="sqlDsActivities" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_amd_transfer_funds_from" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HDN_PlanID" Name="p_key_local_plan_id" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDsUseOfFunds" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT [key_category_type_id], [txt_category_type_desc] FROM [scs_category_type]">
    </asp:SqlDataSource><asp:SqlDataSource ID="SDS_ActivityType" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT [key_activity_type_id], [txt_activity_type_desc] FROM [scs_activity_type] WHERE     (key_activity_type_id <> 103)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_CoreIndicators" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="SELECT key_core_indicator_id, txt_core_indiciator_code+ ' - ' +  txt_core_indicator_name  FROM scs_core_indicator">
    </asp:SqlDataSource>
    &nbsp;
    <asp:SqlDataSource ID="SDS_Category" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
        SelectCommand="pr_scs_category_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DLB_ActType" DefaultValue="1" Name="p_txt_category_type"
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
        &nbsp;<asp:SqlDataSource ID="SDS_FunctionCODE" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
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
    <br />
    <asp:SqlDataSource ID="SQLDS_SOURCEDESCRIPTION" runat="server" SelectCommand="pr_act_activity_get" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList4" Name="key_activity_id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp; &nbsp;&nbsp;&nbsp;
    <asp:Panel ID="Panel1" runat="server" Height="50px" Style="position: relative" Width="125px">
        <asp:SqlDataSource ID="SqlDSRL_pr_activitiy_stuff" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            InsertCommand="pr_act_activity_ins" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>" OnInserted="SqlDSRL_pr_activitiy_stuff_Inserted" UpdateCommand="pr_act_activity_upd" UpdateCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:ControlParameter ControlID="HDN_PlanID" Name="key_local_plan_id" PropertyName="Value"
                    Type="Int32" />
                <asp:Parameter Name="txt_activity_name" Type="String" />
                <asp:Parameter Name="txt_activity_desc" Type="String" />
                <asp:Parameter Name="key_fa_activity_type_id" Type="Int32" />
                <asp:Parameter Name="txt_activity_core_indicator_desc" Type="String" />
                <asp:Parameter Name="key_category_id" Type="Int32" />
                <asp:Parameter Name="key_function_code_id" Type="Int32" />
                <asp:Parameter Name="txt_funds_reduction_impact_desc" Type="String" />
                <asp:Parameter Name="flg_is_amendment" Type="Boolean" />
                <asp:Parameter Name="key_fund_source_id" Type="Byte" DefaultValue="102" />
                <asp:ControlParameter ControlID="DLB_ActType" Name="key_activity_type_id" PropertyName="SelectedValue"
                    Type="Byte" />
                <asp:Parameter Name="key_transaction_status_id" Type="Byte" DefaultValue="0" />
                <asp:ControlParameter ControlID="ddAmendmentReason" Name="key_amendment_reason_id"
                    PropertyName="SelectedValue" Type="Byte" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:Parameter Name="key_activity_id" Type="Int32" />
                <asp:ControlParameter ControlID="HDN_PlanID" Name="key_local_plan_id" PropertyName="Value"
                    Type="Int32" />
                <asp:Parameter Name="txt_activity_name" Type="String" />
                <asp:Parameter Name="txt_activity_desc" Type="String" />
                <asp:ControlParameter ControlID="DLB_ActType" Name="key_activity_type_id" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:Parameter Name="key_fa_activity_type_id" Type="Int32" />
                <asp:Parameter Name="key_category_id" Type="Int32" />
                <asp:Parameter Name="key_function_code_id" Type="Int32" />
                <asp:Parameter Name="key_level_id" Type="Int32" />
                <asp:Parameter DefaultValue="102" Name="key_fund_source_id" Type="Int32" />
                <asp:Parameter Name="txt_activity_core_indicator_desc" Type="String" />
                <asp:Parameter DefaultValue="" Name="txt_funds_reduction_impact_desc" Type="String" />
                <asp:Parameter Name="flg_locked" Type="Boolean" />
                <asp:Parameter Name="flg_approved" Type="Boolean" />
                <asp:Parameter Name="flg_is_amendment" Type="Boolean" />
                <asp:ControlParameter ControlID="ddAmendmentReason" Name="key_amendment_reason_id"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:Parameter Name="txt_system_office_notes" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HDN_PlanID" runat="server" />
        <asp:HiddenField ID="HDN_CollegeID" runat="server" />
        <asp:HiddenField ID="HDN_FSYR" runat="server" />
        <asp:HiddenField ID="hdFLD_toUpdate" runat="server" />
        <asp:HiddenField ID="hdFLD_currenttab" runat="server" />
        <br />
        <asp:HiddenField ID="HDN_HEADER_KEY" runat="server" />
        <asp:SqlDataSource ID="SqlDSRL_pr_activitiy_SRC_OF_Fun" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            UpdateCommand="pr_act_activity_upd" UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:Parameter Name="key_activity_id" Type="Int32" />
                <asp:Parameter Name="key_local_plan_id" Type="Int32" />
                <asp:Parameter Name="txt_activity_name" Type="String" />
                <asp:Parameter Name="txt_activity_desc" Type="String" />
                <asp:Parameter Name="key_activity_type_id" Type="Int32" />
                <asp:Parameter Name="key_fa_activity_type_id" Type="Int32" />
                <asp:Parameter Name="key_category_id" Type="Int32" />
                <asp:Parameter Name="key_function_code_id" Type="Int32" />
                <asp:Parameter Name="key_level_id" Type="Int32" />
                <asp:Parameter Name="key_fund_source_id" Type="Int32" />
                <asp:Parameter Name="txt_activity_core_indicator_desc" Type="String" />
                <asp:Parameter Name="txt_funds_reduction_impact_desc" Type="String" DefaultValue="" />
                <asp:Parameter Name="flg_locked" Type="Boolean" DefaultValue="False" />
                <asp:Parameter Name="flg_approved" Type="Boolean" DefaultValue="False" />
                <asp:Parameter Name="flg_is_amendment" Type="Boolean" />
                <asp:ControlParameter ControlID="ddAmendmentReason" Name="key_amendment_reason_id"
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:Parameter Name="txt_system_office_notes" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlRL_pr_at_transfer_Header_ins" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            InsertCommand="pr_at_amendment_transfer_header_ins" InsertCommandType="StoredProcedure"
            OnInserted="SqlRL_pr_at_transfer_Header_ins_Inserted" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:Parameter Name="key_activity_id" Type="Int32" />
                <asp:Parameter Name="key_activity_from_id" Type="Int32" />
                <asp:Parameter Name="key_activity_to_id" Type="Int32" />
                <asp:Parameter Name="p_key_local_plan_id" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlRL_attransferdetail" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            InsertCommand="pr_at_amendment_transfer_detail_ins" InsertCommandType="StoredProcedure"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:Parameter Name="key_amendment_transfer_hdr_id" Type="Int32" />
                <asp:Parameter Name="key_act_line_item_from_id" Type="Int32" />
                <asp:Parameter Name="amt_debit_amount" Type="Decimal" />
                <asp:Parameter Name="key_act_line_item_to_id" Type="Int32" />
                <asp:Parameter Name="amt_credit_amount" Type="Decimal" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SQLRL_act_transtatusupdate" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            DeleteCommand="pr_act_activity_del" DeleteCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            UpdateCommand="pr_act_transaction_status_upd" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:Parameter Name="key_activity_id" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:Parameter Name="key_activity_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlRl_act_core_indicat_ins" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            InsertCommand="pr_act_activity_core_indicator_ins" InsertCommandType="StoredProcedure"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:Parameter Name="key_activity_id" Type="Int32" />
                <asp:Parameter Name="key_core_indicator_id" Type="Int32" />
            </InsertParameters>
        
        </asp:SqlDataSource>
   
    </asp:Panel>
  
</div> 

    </form>
    
</body>
</html>