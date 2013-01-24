<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="PerformanceIndicators.aspx.cs" Inherits="Accountability_PerformanceIndicators" Title="Performance Indicators" %>
<%@ Register Assembly="RadAjax.Net2" Namespace="Telerik.WebControls" TagPrefix="radA" %>
<%@ Register Assembly="RadWindow.Net2" Namespace="Telerik.WebControls" TagPrefix="radW" %>
<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<%@ Register Assembly="RadInput.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">

<script language="javascript" type="text/javascript">
function Checked_Applicable()
{
//clear textboxes and disable validation
var chk = document.getElementById('<%= chk_NotApplicable.ClientID %>');
if((chk.checked))
{
	var answer = confirm("Are you sure you want to set this indicator to NA?")
	if (!answer){chk.checked = false;
	}
	else{
	chk.checked = true;
	}
         
   }       
   else
   {
  } 

}

function popup_ImprovementPlanEdit(improvid,headerid,levelnum)
{
    var wObj = window.radopen("popup_EditImprovementPlan.aspx?improvid=" + improvid + "&headerid=" + headerid + "&levelid=" + levelnum, "popupimprov");  

    var wW = Math.round(document.documentElement.clientWidth *95/100);            
    var wH = Math.round(document.documentElement.clientHeight *95/100);

    wObj.SetSize(wW,wH);
    wObj.Center(); 
}


function OpenReports(accountablityid, coreindicatorID)
{

   var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;
            var activitytypeid=0;
 window.open("reports/ViewAccountablity_Reports.aspx?accoutablityID=" + accountablityid + "&coredindicator=" + coreindicatorID ,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);


}


    function  IndicatorNumerator_GroupTotals()
    {

        var malenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl05_rdnum_studtsnumerator_text");
        var femalenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl07_rdnum_studtsnumerator_text");

        var ameriindnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl11_rdnum_studtsnumerator_text");
        var asiannumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl13_rdnum_studtsnumerator_text");
        var blacknumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl15_rdnum_studtsnumerator_text");
        var hispanicnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl17_rdnum_studtsnumerator_text");
        var nativehawpacnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl19_rdnum_studtsnumerator_text");
        var whitenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl21_rdnum_studtsnumerator_text");
        var twomoreracesnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl23_rdnum_studtsnumerator_text");
        var othernumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl25_rdnum_studtsnumerator_text");

        var disspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl29_rdnum_studtsnumerator_text");
        var econspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl31_rdnum_studtsnumerator_text");
        var singlespecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl33_rdnum_studtsnumerator_text");
        var displacedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl35_rdnum_studtsnumerator_text");
        var limitedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl37_rdnum_studtsnumerator_text");
        var nontradspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl39_rdnum_studtsnumerator_text");


        var genderNumTotal = document.getElementById("NumSumTotal0");
        var raceNumTotal = document.getElementById("NumSumTotal1");
        var specialNumTotal = document.getElementById("NumSumTotal2");


        try
        {      
            genderNumTotal.innerHTML = ((parsevalue(malenumber.value)) + (parsevalue(femalenumber.value)));
//may cause problems with older data that doesn't have two or more races in ethnicity indicators, but also shouldn't be changing old data at this point
            raceNumTotal.innerHTML = ((parsevalue(ameriindnumber.value)) + (parsevalue(asiannumber.value)) + (parsevalue(blacknumber.value))+ (parsevalue(hispanicnumber.value))+ (parsevalue(whitenumber.value))+ (parsevalue(othernumber.value))  + (parsevalue(twomoreracesnumber.value))+ (parsevalue(nativehawpacnumber.value))   );


            specialNumTotal.innerHTML = ((parsevalue(disspecialnumber.value)) + (parsevalue(econspecialnumber.value)) + (parsevalue(singlespecialnumber.value))+ (parsevalue(displacedspecialnumber.value))+ (parsevalue(limitedspecialnumber.value))+ (parsevalue(nontradspecialnumber.value)));

        }
        catch(err)
        {
         
        }
        IndicatorValidation();
    }





    function IndicatorDenominator_GroupTotals()
    {

            var malenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl05_rdnum_studtsdenominator_text");
            var femalenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl07_rdnum_studtsdenominator_text");

            var ameriindnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl11_rdnum_studtsdenominator_text");
            var asiannumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl13_rdnum_studtsdenominator_text");
            var blacknumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl15_rdnum_studtsdenominator_text");
            var hispanicnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl17_rdnum_studtsdenominator_text");
            var nativehawpacnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl19_rdnum_studtsdenominator_text");
            var whitenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl21_rdnum_studtsdenominator_text");
            var twomoreracesnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl23_rdnum_studtsdenominator_text");
            var othernumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl25_rdnum_studtsdenominator_text");


            var disspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl29_rdnum_studtsdenominator_text");

            var econspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl31_rdnum_studtsdenominator_text");
            var singlespecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl33_rdnum_studtsdenominator_text");

            var displacedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl35_rdnum_studtsdenominator_text");
            var limitedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl37_rdnum_studtsdenominator_text");
            var nontradspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl39_rdnum_studtsdenominator_text");


            var genderdenTotal = document.getElementById("DenSumTotal0");
            var racedenTotal = document.getElementById("DenSumTotal1");
            var specialdenTotal = document.getElementById("DenSumTotal2");



        try
        {
      
            genderdenTotal.innerHTML = ((parsevalue(malenumber.value)) + (parsevalue(femalenumber.value)));

//may cause problems with older data that doesn't have two or more races in ethnicity indicators, but also shouldn't be changing old data at this point
            racedenTotal.innerHTML = ((parsevalue(ameriindnumber.value)) + (parsevalue(asiannumber.value)) + (parsevalue(blacknumber.value))+ (parsevalue(hispanicnumber.value))+ (parsevalue(whitenumber.value))+ (parsevalue(othernumber.value))  + (parsevalue(twomoreracesnumber.value))+ (parsevalue(nativehawpacnumber.value))   );


            specialdenTotal.innerHTML = ((parsevalue(disspecialnumber.value)) + (parsevalue(econspecialnumber.value)) + (parsevalue(singlespecialnumber.value))+ (parsevalue(displacedspecialnumber.value))+ (parsevalue(limitedspecialnumber.value))+ (parsevalue(nontradspecialnumber.value)));

        }
        catch(err)
        {
         
        }
        
        
        IndicatorValidation();
    }


    function trimAll(sString)
    {
        while (sString.substring(0,1) == ' ')
        {
            sString = sString.substring(1, sString.length);
        }
      while (sString.substring(sString.length-1, sString.length) == ' ')
        {
            sString = sString.substring(0,sString.length-1);
        }
        return sString;
    }

    function  parsevalue(inval)
    {
//        if( isNaN(inval))
//        {
            inval = inval.replace(",","");
            inval = inval.replace(" ** Total exceeds header total","");
            inval = inval.replace(" ** A numerator value exceeds denominator","");
            try
            {
            if(trimAll(inval).length == 0)
            return parseInt(0);
            else
            
              /*return parseInt(inval);*/
              if (Math.round(parseFloat(inval)) < 0)
                return parseInt(0);
              else
                return Math.round(parseFloat(inval));
            }
            catch(err)
            {
               return parseInt(0);
            }

    }


    function IndicatorValidation()
    {
        var saveperbutton = document.getElementById('<%= btn_SavePerfInfo.ClientID  %>');

        //Numerator totals
        var genderNumTotal = document.getElementById("NumSumTotal0").innerHTML;
        var raceNumTotal = document.getElementById("NumSumTotal1").innerHTML;
        var specialNumTotal = document.getElementById("NumSumTotal2").innerHTML;

        //Denomintor Totals
        var genderdenTotal = document.getElementById("DenSumTotal0").innerHTML;
        var racedenTotal = document.getElementById("DenSumTotal1").innerHTML;
        var specialdenTotal = document.getElementById("DenSumTotal2").innerHTML;



        var Numerator_HeaderLimit = document.getElementById('<%= rdNum_StudNum.ClientID %>').value;
        var Denominator_HeaderLimit = document.getElementById('<%= rdNum_StudDen.ClientID %>').value;



        // *Begin*  Race and Gender Numerator Total to Header Limit Vadlidation 

        if((parsevalue(genderNumTotal) != parsevalue(Numerator_HeaderLimit)  
         || parsevalue(raceNumTotal) != parsevalue(Numerator_HeaderLimit)
         || parsevalue(genderdenTotal) != parsevalue(Denominator_HeaderLimit)
         || parsevalue(racedenTotal) != parsevalue(Denominator_HeaderLimit))
         )
        {
                        if(parsevalue(genderNumTotal) == 0 &&  parsevalue(raceNumTotal) == 0 
                        && parsevalue(genderdenTotal) == 0 && parsevalue(racedenTotal) == 0)
                            {
                            }
                        else
                            saveperbutton.disabled = true;

            if(parsevalue(genderNumTotal) != parsevalue(Numerator_HeaderLimit) )
            {

                document.getElementById("NumSumTotal0").innerHTML = (parsevalue(document.getElementById("NumSumTotal0").innerHTML) + "</br> Total in numerator must equal header numerator total");
                document.getElementById("NumSumTotal0").style.color = "RED";
                //saveperbutton.disabled = true;

            }
            else
            {
                document.getElementById("NumSumTotal0").innerHTML = parsevalue(document.getElementById("NumSumTotal0").innerHTML);
                //saveperbutton.disabled = false;
            }

            if(parsevalue(raceNumTotal) != parsevalue(Numerator_HeaderLimit))
            {
                document.getElementById("NumSumTotal1").innerHTML = parsevalue(document.getElementById("NumSumTotal1").innerHTML) + "</br> Total in numerator must equal header numerator total";
                document.getElementById("NumSumTotal1").style.color = "RED";
            }
            else
            {
                document.getElementById("NumSumTotal1").innerHTML = parsevalue(document.getElementById("NumSumTotal1").innerHTML);
            }


            // *End*  Race and Gender Numerator Total to Header Limit Vadlidation 


            // *Begin*  Race and Gender Denominator Total to Header Limit Vadlidation 

            if(parsevalue(genderdenTotal) != parsevalue(Denominator_HeaderLimit))
            {
                document.getElementById("DenSumTotal0").innerHTML = parsevalue(document.getElementById("DenSumTotal0").innerHTML) + " </br> Total in denominator must equal header denominator total";
                document.getElementById("DenSumTotal0").style.color = "RED";
                //saveperbutton.disabled = true;

            }
            else
            {
                document.getElementById("DenSumTotal0").innerHTML = parsevalue(document.getElementById("DenSumTotal0").innerHTML);
                //saveperbutton.disabled = false;
            }
               

            if(parsevalue(racedenTotal) != parsevalue(Denominator_HeaderLimit))
            {
                document.getElementById("DenSumTotal1").innerHTML = parsevalue(document.getElementById("DenSumTotal1").innerHTML) + "</br> Total in denominator must equal header denominator total";
                document.getElementById("DenSumTotal1").style.color = "RED";
                //saveperbutton.disabled = true;

            }
            else
            {
                document.getElementById("DenSumTotal1").innerHTML = parsevalue(document.getElementById("DenSumTotal1").innerHTML);
                //saveperbutton.disabled = false;
            }


            // *End*  Race and Gender Denominator Total to Header Limit Vadlidation 

        }

        else
        {
            saveperbutton.disabled = false;
            document.getElementById("NumSumTotal0").style.color = "Black";
            document.getElementById("NumSumTotal1").style.color = "Black";
            document.getElementById("DenSumTotal0").style.color = "Black";
            document.getElementById("DenSumTotal1").style.color = "Black";

            document.getElementById("NumSumTotal0").innerHTML = parsevalue(document.getElementById("NumSumTotal0").innerHTML);                        
            document.getElementById("NumSumTotal1").innerHTML = parsevalue(document.getElementById("NumSumTotal1").innerHTML);
        }
        indicator_Numerator_MustLessthan_Denomitor_validation();

    }

 

function indicator_Numerator_MustLessthan_Denomitor_validation()
{
    var saveperbutton = document.getElementById('<%= btn_SavePerfInfo.ClientID  %>');
    var NUMER_malenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl05_rdnum_studtsnumerator_text");
    var NUMER_femalenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl07_rdnum_studtsnumerator_text");

    var NUMER_ameriindnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl11_rdnum_studtsnumerator_text");
    var NUMER_asiannumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl13_rdnum_studtsnumerator_text");
    var NUMER_blacknumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl15_rdnum_studtsnumerator_text");
    var NUMER_hispanicnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl17_rdnum_studtsnumerator_text");
    var NUMER_nativehawpacnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl19_rdnum_studtsnumerator_text");
    var NUMER_whitenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl21_rdnum_studtsnumerator_text");
    var NUMER_twomoreracesnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl23_rdnum_studtsnumerator_text");
    var NUMER_othernumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl25_rdnum_studtsnumerator_text");


    var NUMER_disspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl29_rdnum_studtsnumerator_text");
    var NUMER_econspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl31_rdnum_studtsnumerator_text");
    var NUMER_singlespecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl33_rdnum_studtsnumerator_text");
    var NUMER_displacedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl35_rdnum_studtsnumerator_text");
    var NUMER_limitedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl37_rdnum_studtsnumerator_text");
    var NUMER_nontradspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl39_rdnum_studtsnumerator_text");


////////////////


    var DEN_malenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl05_rdnum_studtsdenominator_text");
    var DEN_femalenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl07_rdnum_studtsdenominator_text");

    var DEN_ameriindnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl11_rdnum_studtsdenominator_text");
    var DEN_asiannumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl13_rdnum_studtsdenominator_text");
    var DEN_blacknumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl15_rdnum_studtsdenominator_text");
    var DEN_hispanicnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl17_rdnum_studtsdenominator_text");
    var DEN_nativehawpacnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl19_rdnum_studtsdenominator_text");
    var DEN_whitenumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl21_rdnum_studtsdenominator_text");
    var DEN_twomoreracesnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl23_rdnum_studtsdenominator_text");
    var DEN_othernumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl25_rdnum_studtsdenominator_text");


    var DEN_disspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl29_rdnum_studtsdenominator_text");

    var DEN_econspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl31_rdnum_studtsdenominator_text");
    var DEN_singlespecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl33_rdnum_studtsdenominator_text");

    var DEN_displacedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl35_rdnum_studtsdenominator_text");
    var DEN_limitedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl37_rdnum_studtsdenominator_text");
    var DEN_nontradspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl39_rdnum_studtsdenominator_text");




    if((parsevalue(NUMER_malenumber.value) > parsevalue(DEN_malenumber.value)) || (parsevalue(NUMER_femalenumber.value) > parsevalue(DEN_femalenumber.value)))
    {

        document.getElementById("NumSumTotal0").innerHTML = parsevalue(document.getElementById("NumSumTotal0").innerHTML) + " ** A numerator value exceeds denominator";
        document.getElementById("NumSumTotal0").style.color = "Red";
        saveperbutton.disabled = true;

    }


    if(parsevalue(NUMER_ameriindnumber.value) > parsevalue(DEN_ameriindnumber.value)  ||
        parsevalue(NUMER_asiannumber.value) > parsevalue(DEN_asiannumber.value) ||
        parsevalue(NUMER_blacknumber.value) > parsevalue(DEN_blacknumber.value) ||
        parsevalue(NUMER_hispanicnumber.value) > parsevalue(DEN_hispanicnumber.value) ||
        parsevalue(NUMER_whitenumber.value) > parsevalue(DEN_whitenumber.value) ||
        parsevalue(NUMER_othernumber.value) > parsevalue(DEN_othernumber.value) ||
        parsevalue(NUMER_nativehawpacnumber.value) > parsevalue(DEN_nativehawpacnumber.value) ||
        parsevalue(NUMER_twomoreracesnumber.value) > parsevalue(DEN_twomoreracesnumber.value))
    {
        document.getElementById("NumSumTotal1").innerHTML = parsevalue(document.getElementById("NumSumTotal1").innerHTML) + " ** A numerator value exceeds denominator";
        document.getElementById("NumSumTotal1").style.color = "Red";
        saveperbutton.disabled = true;

    }





var NUMER_disspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl29_rdnum_studtsnumerator_text");

var NUMER_econspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl31_rdnum_studtsnumerator_text");
var NUMER_singlespecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl33_rdnum_studtsnumerator_text");

var NUMER_displacedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl35_rdnum_studtsnumerator_text");
var NUMER_limitedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl37_rdnum_studtsnumerator_text");
var NUMER_nontradspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl39_rdnum_studtsnumerator_text");

var DEN_disspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl29_rdnum_studtsdenominator_text");

var DEN_econspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl31_rdnum_studtsdenominator_text");
var DEN_singlespecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl33_rdnum_studtsdenominator_text");

var DEN_displacedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl35_rdnum_studtsdenominator_text");
var DEN_limitedspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl37_rdnum_studtsdenominator_text");
var DEN_nontradspecialnumber = document.getElementById("ctl00_mainCopy_rdg_perfDetailInfo_ctl00_ctl39_rdnum_studtsdenominator_text");


 if(parsevalue(NUMER_disspecialnumber.value) > parsevalue(DEN_disspecialnumber.value) ||
 parsevalue(NUMER_econspecialnumber.value)  >  parsevalue(DEN_econspecialnumber.value) ||
 parsevalue(NUMER_singlespecialnumber.value)  >  parsevalue(DEN_singlespecialnumber.value) ||
 parsevalue(NUMER_displacedspecialnumber.value)  > parsevalue(DEN_displacedspecialnumber.value) ||
 parsevalue(NUMER_limitedspecialnumber.value)   > parsevalue(DEN_limitedspecialnumber.value) ||
 parsevalue(NUMER_nontradspecialnumber.value)  > parsevalue(DEN_nontradspecialnumber.value) )
 {
document.getElementById("NumSumTotal2").innerHTML = parsevalue(document.getElementById("NumSumTotal2").innerHTML) + " ** A numerator value exceeds denominator";
document.getElementById("NumSumTotal2").style.color = "Red";
saveperbutton.disabled = true;

}
else
{
document.getElementById("NumSumTotal2").innerHTML = parsevalue(document.getElementById("NumSumTotal2").innerHTML) ;
document.getElementById("NumSumTotal2").style.color = "Black";
}

 

 


}


</script>

<asp:Panel ID="pan_TopInfo" runat="server"  Width="100%" >
<table style="width:100%;">
    <tr>
        <td colspan="1">
   
   
   
    
    <asp:Label ID="lbl_CurrfiscalYear" runat="server" Font-Bold="True"></asp:Label></td>
        <td>
        </td>
        <td style="text-align: right">
  <asp:Button ID="btn_SavePerfInfo" runat="server" OnClick="btn_SavePerfInfo_Click"
        Text="Save" Font-Bold="True" Visible="False" /> <asp:Button ID="btn_print" runat="server" Font-Bold="True" Text="Print Report" Enabled="False" />
            <asp:Button ID="btn_Export_Excel" runat="server" Font-Bold="True" Text="Export Excel" Enabled="False" OnClick="btn_Export_Excel_Click" /></td>
    </tr>
<tr >
    <td colspan=""   >
    <asp:Label ID="Label7" runat="server" Text="Core Indicator:"></asp:Label>
    <asp:DropDownList ID="dd_CoreIndicator" runat="server" AutoPostBack="True" DataSourceID="sqlds_CoreIndicators" DataTextField="txt_core_indicator_name" DataValueField="key_core_indicator_id" OnSelectedIndexChanged="dd_CoreIndicator_SelectedIndexChanged" Width="349px">
    </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="dd_CoreIndicator"
            ErrorMessage="* " InitialValue="-1"></asp:RequiredFieldValidator></td><td>
        &nbsp;</td><td style="text-align: right">
        &nbsp;<asp:ImageButton ID="imgb_Excel" runat="server" AlternateText="Export to Excel" OnClick="imgb_Excel_Click" ImageUrl="~/images/Excel_Icon_SMALL.gif" Height="18px" Width="22px" Visible="False" />&nbsp;
        <asp:Label ID="lbl_numden_ValidationError" runat="server" ForeColor="Red" Text="Changes Not Updated Check Numerator and Denomator Values"
            Visible="False"></asp:Label>
    </td>
    </tr>   
</table>

<table width="100%">

<tr>
<td colspan="2">
    <asp:Panel ID="pan_bottom_Provided" runat="server" Visible="false" Width="100%" >
 
    <rad:RadTabStrip ID="rtb_indicator_plan" runat="server" MultiPageID="RadMultiPage1"
        Skin="ClassicBlue" SelectedIndex="0" Width="932px">
        <Tabs>
            <rad:Tab runat="server" PageViewID="pg_Header" Text="Header">
            </rad:Tab>
            <rad:Tab runat="server" PageViewID="pgv_coreIndicator" Text="Core Indicators">
            </rad:Tab>
            <rad:Tab runat="server" PageViewID="pgv_ImprovementPlan" Text="Improvement Plan">
            </rad:Tab>
        </Tabs>
    </rad:RadTabStrip>
    

    <rad:RadMultiPage ID="RadMultiPage1" runat="server" Width="100%" SelectedIndex="2">
        <rad:PageView ID="pgv_coreIndicator" runat="server">
 
 
 
 
 
 
    <telerik:RadGrid ID="rdg_perfDetailInfo" runat="server" DataSourceID="sqlDS_perfDetailInfo"
        GridLines="None" OnItemDataBound="rdg_perfDetailInfo_ItemDataBound1" OnPreRender="rdg_perfDetailInfo_PreRender" OnDataBound="rdg_perfDetailInfo_DataBound" OnExcelMLExportRowCreated="rdg_perfDetailInfo_ExcelMLExportRowCreated" OnExcelMLExportStylesCreated="rdg_perfDetailInfo_ExcelMLExportStylesCreated" Skin="Office2007_SCTCS" Width="100%" EnableHeaderContextMenu="True" EnableEmbeddedSkins="False">
        <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlDS_perfDetailInfo" ShowGroupFooter="True" >
            <Columns>
                <telerik:GridBoundColumn DataField="key_accountability_perf_detail_id" DataType="System.Int32"
                    HeaderText="key_accountability_perf_detail_id" ReadOnly="True" SortExpression="key_accountability_perf_detail_id"
                    UniqueName="key_accountability_perf_detail_id" Visible="False">
                
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="key_population_category_id" DataType="System.Int32"
                    HeaderText="key_population_category_id" SortExpression="key_population_category_id"
                    UniqueName="key_population_category_id" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="txt_category_desc" HeaderText="txt_category_desc"
                    SortExpression="txt_category_desc" UniqueName="txt_category_desc" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="txt_desc"
                    UniqueName="txt_desc"   >
                    <ItemStyle Width="2.5in" Font-Size="10pt" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="key_perf_report_hdr_id" DataType="System.Int32"
                    HeaderText="key_perf_report_hdr_id" SortExpression="key_perf_report_hdr_id" UniqueName="key_perf_report_hdr_id" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn  DataField="nbr_students_numerator" DataType="System.Decimal"
                    HeaderText="# Students-Numerator" SortExpression="nbr_students_numerator" UniqueName="nbr_students_numerator">
                    <EditItemTemplate>
                        <asp:TextBox ID="nbr_students_numeratorTextBox" runat="server" Text='<%# Bind("nbr_students_numerator") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <rad:RadNumericTextBox ID="rdnum_studtsnumerator" runat="server" Culture="English (United States)"
                            DbValue='<%# Bind("nbr_students_numerator") %>' LabelCssClass="radLabelCss_Default2006"
                            Skin="Vista" Width="80px" Value="0" OnTextChanged="rdnum_inGridInfo_TextChanged" MinValue="0" Text="0" Font-Names="Trebuchet MS" Font-Size="10pt" style="text-align: right">
                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
<FocusedStyle CssClass="radLabelCss_VistaBlink" />
                        </rad:RadNumericTextBox>
                        
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="nbr_student_denominator" DataType="System.Decimal"
                    HeaderText="# Students-Denominator" SortExpression="nbr_student_denominator"
                    UniqueName="nbr_student_denominator">
                    <EditItemTemplate>
                        <asp:TextBox ID="nbr_student_denominatorTextBox" runat="server" Text='<%# Bind("nbr_student_denominator") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        &nbsp;<rad:RadNumericTextBox ID="rdnum_studtsdenominator" runat="server" Culture="English (United States)"
                            DbValue='<%# Bind("nbr_student_denominator") %>' LabelCssClass="radLabelCss_Default2006"
                            Skin="Vista" Width="80px" Value="0" OnTextChanged="rdnum_inGridInfo_TextChanged" MinValue="0" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="10pt" style="text-align: right" Text="0">
                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
<FocusedStyle CssClass="radLabelCss_VistaBlink" />
                        </rad:RadNumericTextBox>
                    </ItemTemplate>
                   
                    <ItemStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="nbr_adjusted_level_of_performance" DataType="System.Decimal"
                    HeaderText="State Adjusted Level of Performance" SortExpression="nbr_adjusted_level_of_performance"
                    UniqueName="nbr_adjusted_level_of_performance" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="nbr_adjusted_level_of_performanceTextBox" runat="server" Text='<%# Bind("nbr_adjusted_level_of_performance") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        &nbsp;<rad:RadNumericTextBox ID="rdnum_adjustLevelPerf" runat="server" Culture="English (United States)"
                            DbValue='<%# rdNum_AdjustPerf.Text %>' LabelCssClass="radLabelCss_Default"
                            Skin="" Width="87px" ReadOnly="True" Font-Names="Trebuchet MS" Font-Size="10pt">
                            <NumberFormat AllowRounding="True" DecimalDigits="0" />
                        </rad:RadNumericTextBox>
                    </ItemTemplate>
                   
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="nbr_actual_level_of_performance" DataType="System.Decimal"
                    HeaderText="Level of Performance" SortExpression="nbr_actual_level_of_performance"
                    UniqueName="nbr_actual_level_of_performance">
                    <ItemTemplate>  
                        <asp:Label ID="nbr_actual_level_of_performanceLabel" runat="server" Text='<%# Eval("nbr_actual_level_of_performance") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="nbr_perfomance_variance" DataType="System.Decimal"
                    HeaderText="Adjusted vs. Actual Level of Perfromance" SortExpression="nbr_perfomance_variance"
                    UniqueName="nbr_perfomance_variance">
                    <ItemTemplate>
                        <asp:Label ID="nbr_perfomance_varianceLabel" runat="server" Text='<%# Eval("nbr_perfomance_variance") %>' Font-Size="10pt"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Met 90% Performance" UniqueName="TemplateColumn">
                    <ItemTemplate>
                        <asp:Label ID="lbl_PerfYN" runat="server" Text='<%# Eval("flg_performance_level_pass") %>' Visible="False" Font-Size="9pt" ></asp:Label>
                        <asp:Label ID="lbl_VisibleYN_response" runat="server" Text="Label"></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
            <GroupByExpressions>
                <telerik:GridGroupByExpression>
                <GroupByFields>
                <telerik:GridGroupByField  FieldAlias="key_population_category_id" FieldName="key_population_category_id" FormatString=""/>
                </GroupByFields>
                <SelectFields>
                        <telerik:GridGroupByField FieldAlias="txt_category_desc" FieldName="txt_category_desc" FormatString="&lt;font color=Red&gt;{0}&lt;/font&gt;" HeaderText=" " HeaderValueSeparator="" />
                
                </SelectFields>
                </telerik:GridGroupByExpression>
            </GroupByExpressions>
            <EditFormSettings>
                <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                    UpdateImageUrl="Update.gif">
                </EditColumn>
            </EditFormSettings>
            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" Wrap="True" />
           
        </MasterTableView>
        <GroupPanel>
            <PanelStyle BackColor="Red" />
            <PanelItemsStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
        </GroupPanel>
        <HeaderStyle BackColor="White" />
        <GroupHeaderItemStyle Font-Bold="True" Font-Italic="False" ForeColor="Black" />
        <HeaderContextMenu EnableEmbeddedSkins="False">
        </HeaderContextMenu>
        <FilterMenu EnableEmbeddedSkins="False">
        </FilterMenu>
    </telerik:RadGrid>
 
 
 
 
 
 
 
 
 
          
   </rad:PageView>
        <rad:PageView ID="pgv_ImprovementPlan" runat="server" Width="100%">
            <telerik:RadGrid ID="rdg_ImprovementPlan" runat="server" DataSourceID="sqlDS_ImprovementPlan" GridLines="None" Skin="Office2007_SCTCS" OnItemDataBound="rdg_ImprovementPlan_ItemDataBound" EnableEmbeddedSkins="False">
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="key_acc_accountability_imprv_plan_id"
                    DataSourceID="sqlDS_ImprovementPlan">
                    <Columns>
                        <telerik:GridTemplateColumn UniqueName="PopUpEditColumn">
                            <ItemTemplate>
                                <asp:ImageButton ID="img_edit" runat="server" ImageUrl="~/images/Edit.gif" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn DataField="key_acc_accountability_imprv_plan_id" DataType="System.Int32"
                            HeaderText="Record #" ReadOnly="True" SortExpression="key_acc_accountability_imprv_plan_id"
                            UniqueName="key_acc_accountability_imprv_plan_id">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="key_perf_report_hdr_id" DataType="System.Int32"
                            HeaderText="key_perf_report_hdr_id" SortExpression="key_perf_report_hdr_id" UniqueName="key_perf_report_hdr_id" Visible="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="txt_narrative_desc" HeaderText="Description"
                            SortExpression="txt_narrative_desc" UniqueName="txt_narrative_desc">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn DataField="flg_narrative_response" DataType="System.Boolean"
                            UniqueName="flg_narrative_response">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_narrative_response" runat="server" />
                                <asp:Label ID="lbl_narrative_response" runat="server" Text='<%# Eval("flg_narrative_response") %>'
                                    Visible="False"></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <EditFormSettings>
                        <FormTemplate>
                            <asp:ImageButton ID="img_edit" runat="server" ImageUrl="~/images/Edit.gif" Enabled="False" />
                        </FormTemplate>
                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                            UpdateImageUrl="Update.gif">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid></rad:PageView>
        &nbsp;
      
      
        <rad:PageView ID="pg_Header" runat="server" Width="100%" style="border-top: royalblue 1px solid">
            <table style="width: 385px; padding-left: 2px; margin-left: 0px;">
                <tr>
                    <td colspan="2" style="height: 20px">
                        <asp:Label ID="lbl_notApplicableMSG" runat="server" Font-Bold="True" ForeColor="Red"
                            Text="Indicator is not applicable" Width="248px"></asp:Label></td>
                    <td style="width: 200px; height: 20px;">
                        <asp:CheckBox ID="chk_NotApplicable" runat="server" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                    <td>
                        <asp:Label ID="Label10" runat="server" Width="445px"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="2">
            
            <asp:Label ID="Label1" runat="server" Text="# of Students in the Numerator" Width="248px" Font-Bold="True"></asp:Label>
                    </td>
                    <td >
    <rad:RadNumericTextBox ID="rdNum_StudNum" runat="server" Width="80px" CausesValidation="True" Font-Names="Trebuchet MS" Font-Size="10pt" Culture="English (United States)" LabelCssClass="radLabelCss_Default2006" Skin="Vista" MinValue="0">
        <NumberFormat AllowRounding="True" DecimalDigits="0" />
    </rad:RadNumericTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rdNum_StudNum"
                            ErrorMessage="Numerator required" Width="269px"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td colspan="2">
            <asp:Label ID="Label2" runat="server" Text="# of Students in the Denominator" Width="248px" Font-Bold="True"></asp:Label></td>
                    <td >
                        <rad:RadNumericTextBox
        ID="rdNum_StudDen" runat="server" Width="80px" CausesValidation="True" Culture="English (United States)" Font-Names="Trebuchet MS" Font-Size="10pt" LabelCssClass="radLabelCss_Default2006" Skin="Vista" MinValue="0">
        <NumberFormat AllowRounding="True" DecimalDigits="0" />
    </rad:RadNumericTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="rdNum_StudDen"
                            ErrorMessage="Denominator required" Width="281px"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td colspan="2">
            <asp:Label ID="Label3" runat="server" Text="State Adjusted Level of Performance" Font-Bold="True"></asp:Label></td>
                    <td><rad:RadNumericTextBox
        ID="rdNum_AdjustPerf" runat="server" Width="80px" CausesValidation="True" Culture="English (United States)" Font-Names="Trebuchet MS" Font-Size="10pt" LabelCssClass="radLabelCss_Default2006" Skin="Vista" MinValue="0">
                        <NumberFormat AllowRounding="True" DecimalDigits="2" PositivePattern="n%" />
                    </rad:RadNumericTextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rdNum_AdjustPerf"
                            ErrorMessage="Performance level required" Width="203px"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 27px">
                        <strong>
                            <asp:Label ID="Label12" runat="server" Font-Bold="True" Text="Actual Level of Performance"
                                Width="243px"></asp:Label></strong></td>
                    <td style="width: 113px; height: 27px;">
                        <asp:TextBox ID="rdn_ActualLvePerf" runat="server" ReadOnly="True" Width="80px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong>
                            <asp:Label ID="Label13" runat="server" Font-Bold="True" Text="Adjusted vs. Actual Level of Performance"
                                Width="243px"></asp:Label></strong></td>
                    <td style="width: 113px">
                        <asp:TextBox ID="rdn_adj_vs_act" runat="server" ReadOnly="True" Width="80px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <strong>
                            <asp:Label ID="Label14" runat="server" Font-Bold="True" Text="Met 90% of adjusted Level of Performance (Y,N)"
                                Width="243px"></asp:Label></strong></td>
                    <td style="width: 113px">
                        <asp:TextBox ID="rdn_90adj" runat="server" Width="80px" Font-Names="Trebuchet MS" Font-Size="10pt" ReadOnly="True"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="rdNum_StudNum"
                            ControlToValidate="rdNum_StudDen" ErrorMessage="Denominator must be greater than or equal to Numerator"
                            Operator="GreaterThanEqual" Width="290px" Type="Double"></asp:CompareValidator></td>
                    <td>
                        </td>
                    <td style="width: 113px; text-align: right">
    <asp:Button ID="btn_SaveHeaderInfo" runat="server" Text="Save" OnClick="btn_SaveHeaderInfo_Click" Font-Bold="True" Width="61px" Visible="False" /></td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td style="width: 113px">
                    </td>
                </tr>
            </table>
            &nbsp; &nbsp;&nbsp;&nbsp;
        </rad:PageView>
     
    </rad:RadMultiPage>
      </asp:Panel>
    <br />
    <radW:RadWindowManager ID="RadWindowManager1" runat="server" Skin="Vista">
    
     <Windows>
            <radw:RadWindow ID="popupimprov" runat="server" Title="Improvement Plan"  
               Left="150px" BorderStyle="None" ReloadOnShow="True" Modal="True" NavigateUrl="" SkinsPath="~/RadControls/Window/Skins" Height="600px" Width="800px" Top="" />
        </Windows>
    
    </radW:RadWindowManager>
    <br />
</td>

</tr>

</table>
</asp:Panel> 
  
    <asp:Panel ID="pan_noNarrative" runat="server" HorizontalAlign="Center">
        <asp:Label ID="lbl_errortext" runat="server"></asp:Label></asp:Panel>
    <br />
    <br />
    <br />
    <asp:SqlDataSource ID="SQLDS_Accountablity" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_acc_accountability_get" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txt_CollegeID" Name="p_key_college_id" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="txt_FiscalYear" Name="p_nbr_fiscal_year" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDS_ImprovementPlan" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_accountability_imprv_plan_list_get" SelectCommandType="StoredProcedure" InsertCommand="pr_acc_acountability_cte_enrollment_ins " InsertCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:ControlParameter ControlID="txt_HeaderID" Name="p_key_perf_report_hdr_id" PropertyName="Text"
                    Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:ControlParameter ControlID="txt_AcctID" Name="p_key_accountability_id" PropertyName="Text"
                    Type="Int32" />
                <asp:ControlParameter ControlID="txt_LoggedPerson" Name="p_txt_created_by" PropertyName="Text"
                    Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
    <br />
    
    
    
    
    
    
    
    
    
    
    
    <asp:Panel ID="pan_TopProvided" runat="server" Visible="false">
        </asp:Panel>
    
    
    
    
    <asp:SqlDataSource ID="sqlds_CoreIndicators" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        SelectCommand="pr_scs_core_indicator_get" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDS_PerfHeaderInfo" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
        InsertCommand="pr_acc_accountability_perf_header_ins" InsertCommandType="StoredProcedure"
        SelectCommand="pr_acc_accountability_perf_header_get" SelectCommandType="StoredProcedure"
        UpdateCommand="pr_acc_accountability_perf_header_upd" UpdateCommandType="StoredProcedure" OnInserted="sqlDS_PerfHeaderInfo_Inserted">
        <SelectParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="dd_CoreIndicator" Name="p_key_core_idicator_id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txt_AcctID" Name="p_key_accountability_id" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="txt_HeaderID" Name="p_key_perf_report_hdr_id" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="rdNum_StudNum" Name="p_nbr_students_numerator" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="rdNum_StudDen" Name="p_nbr_student_denominator"
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="rdNum_AdjustPerf" Name="p_nbr_adjusted_lvl_perf"
                PropertyName="Text" Type="Decimal" />
            <asp:ControlParameter ControlID="txt_LoggedPerson" Name="p_txt_updated_by" PropertyName="Text"
                Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="chk_NotApplicable" Name="flg_not_required" PropertyName="Checked"
                Type="Boolean" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="dd_CoreIndicator" Name="p_key_core_idicator_id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txt_AcctID" Name="p_key_accountability_id" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="rdNum_StudNum" Name="p_nbr_students_numerator" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="rdNum_StudDen" Name="p_nbr_student_denominator"
                PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="rdNum_AdjustPerf" Name="p_nbr_adjusted_lvl_perf"
                PropertyName="Text" Type="Decimal" />
            <asp:ControlParameter ControlID="txt_LoggedPerson" Name="p_txt_created_by" PropertyName="Text"
                Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="chk_NotApplicable" Name="flg_not_required" PropertyName="Checked"
                Type="Boolean" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDS_perfDetailInfo" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="pr_acc_accountability_perf_detail_get" SelectCommandType="StoredProcedure" UpdateCommand="pr_acc_accountability_perf_detail_upd" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txt_HeaderID" Name="p_key_perf_report_hdr_id" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="dd_CoreIndicator" Name="p_key_core_idicator_id"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txt_LoggedPerson" Name="p_txt_created_by" PropertyName="Text"
                Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="p_key_accountability_perf_detail_id" Type="Int32" />
            <asp:Parameter Name="p_nbr_students_numerator" Type="Decimal" />
            <asp:Parameter Name="p_nbr_student_denominator" Type="Decimal" />
            <asp:Parameter Name="p_dte_date_created" Type="dateTime"/>
            <asp:Parameter Name="p_txt_updated_by" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    &nbsp;
    <br />
    
    
     <div style="visibility:hidden;">
        <asp:Label ID="Label4" runat="server" Text="Accountablity ID:"></asp:Label>
    <asp:TextBox ID="txt_AcctID" runat="server" ReadOnly="True"></asp:TextBox>
        <br />
    <asp:Label ID="Label5" runat="server" Text="College ID:"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp;
    <asp:TextBox ID="txt_CollegeID" runat="server" ReadOnly="True"></asp:TextBox>
        <br />
    <asp:Label ID="Label6" runat="server" Text="Fiscal Year:"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp;<asp:TextBox ID="txt_FiscalYear" runat="server" ReadOnly="True"></asp:TextBox>
         <asp:Label ID="lbl_Level" runat="server"></asp:Label><br />
    <asp:Label ID="Label8" runat="server" Text="Header ID:"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp;<asp:TextBox ID="txt_HeaderID" runat="server" ReadOnly="True"></asp:TextBox>
         &nbsp;
        
           <br />
    <asp:Label ID="Label9" runat="server" Text="Update Mode (0=new 1= edit:"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp;<asp:TextBox ID="txt_updateMode" runat="server" ReadOnly="True">0</asp:TextBox>
        <br />
    <asp:Label ID="Label11" runat="server" Text="Logged in Person:"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp;<asp:TextBox ID="txt_LoggedPerson" runat="server" ReadOnly="True">1</asp:TextBox><br />
         
       
        </div>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" EnablePageHeadUpdate="False" EnableAJAX="False">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdg_perfDetailInfo">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btn_SavePerfInfo" />
                    <telerik:AjaxUpdatedControl ControlID="rdg_perfDetailInfo" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

