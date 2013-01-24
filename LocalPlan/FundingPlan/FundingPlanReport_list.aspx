<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FundingPlanReport_list.aspx.cs" Inherits="LocalPlan_FundingPlan_FundingPlanReport_list" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Funding Plan Reports</title>
</head>
<body>
    <form id="form1" runat="server" >
    <center>
    <div style="text-align:left; width:50%;">
    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
        <asp:ListItem Value="fundingplan">Funding Plan</asp:ListItem>
        <asp:ListItem Value="fundingplanitems">Funding Plan Items</asp:ListItem>
        </asp:RadioButtonList>
        <br />
        <asp:HyperLink ID="HL_Print" runat="server" Style="position: relative">Print Report</asp:HyperLink></div>
       </center> 
    </form>
    
    <script language="javascript" type="text/javascript">
    
      function OpenReport(planid, fiscalyear, versionid)
        {       
       
       var list =  document.getElementById("<%= RadioButtonList1.ClientID %>");
   var radio = list.getElementsByTagName("input");
   var reportname;   
  // alert(radio.length);
    for( x = 0; x < radio.length; x++ )
  {
  if(radio[x].checked)
   reportname =radio[x].value; 
  }
   
   
   
     
          
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;
            var activitytypeid=0;
         //   alert(reportname);


            if(reportname == "fundingplanitems")
            {
            if(versionid == "1")
            {
              window.open("../../Reports/ViewReport.aspx?type=" + "rpt_funding_plan_item_v1_org_budget" +"&Keyid=" + planid +"&planid=" + planid + "&activitytypeid=" + activitytypeid + "&fiscalyear=" + fiscalyear+ "&reportformat=pdf",null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);

            }
            else
            {
          
                window.open("../../Reports/ViewReport.aspx?type=" + reportname +"&Keyid=" + planid +"&planid=" + planid + "&activitytypeid=" + activitytypeid + "&fiscalyear=" + fiscalyear+ "&reportformat=pdf",null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
         }
            }
            if(reportname == "fundingplan")
            {
                window.open("../../Reports/ViewReport.aspx?type=" + reportname +"&Keyid=" + planid +"&planid=" + planid + "&activitytypeid=" + activitytypeid + "&fiscalyear=" + fiscalyear + "&reportformat=pdf",null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
            }
           
      
        }
    
    
    
    </script>
</body>
</html>
