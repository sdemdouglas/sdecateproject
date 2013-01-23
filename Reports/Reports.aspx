<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports" Title="Reports" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="rad" %>
<asp:Content ID="CntReports" ContentPlaceHolderID="mainCopy" Runat="Server">
    <script type="text/javascript">
        function showReport()
        {
   
   
            var report_list = document.getElementById("<%= ddl_Reports.ClientID %>");
            var report_name = report_list.options[report_list.selectedIndex].value;

            var college_list = document.getElementById("<%= ddl_College.ClientID %>");
            var college_id;
            
            try
            {
                college_id = college_list.options[college_list.selectedIndex].value;
            }
            catch(err)
            {
            }
   
   
      var format_list = document.getElementById("<%= rbl_Format.ClientID %>").getElementsByTagName('input');
            var format;
            
            for(i=0;i<format_list.length;i++)    
            {        	          	                     
                if(format_list[i].checked)            
                {                
	                format = format_list[i].value;
                }        
	           
            }
   
   
   
   //alert(report_name);
   
   
  
   var category = "-1";
   var funcationcode = "-1";
   var activityORlineitemNumber = "-1";
   
  
   
   
    var category_list; //= document.getElementById("<%= ddl_Reports.ClientID %>");
     var function_list; //= document.getElementById("<%= ddl_Reports.ClientID %>");
      var activityORlineitemNumber_text; //= document.getElementById("<%= ddl_Reports.ClientID %>");
   if(report_name == "Activities_By_CATandFUNDcode")
   {
        category_list= document.getElementById("<%= ddL_FunctionCode.ClientID %>");
        function_list= document.getElementById("<%= DDL_CategoryCode.ClientID %>");
        activityORlineitemNumber_text= document.getElementById("<%= txt_ActivityNumber.ClientID %>");
   
  
        category = category_list.options[category_list.selectedIndex].value;
        funcationcode = function_list.options[function_list.selectedIndex].value;
        activityORlineitemNumber = activityORlineitemNumber_text.value;
  
   }
   if(report_name == "ActivitybyLineItem_FunctionCode_CategoryCode")
   {
        category_list= document.getElementById("<%= ddL_FunctionCode2.ClientID %>");
        function_list= document.getElementById("<%= DDL_CategoryCode2.ClientID %>");
        activityORlineitemNumber_text= document.getElementById("<%= txt_lineItemnumber.ClientID %>");   
   
        category = category_list.options[category_list.selectedIndex].value;
        funcationcode = function_list.options[function_list.selectedIndex].value;
        activityORlineitemNumber = activityORlineitemNumber_text.value;
   
   
   
   }
   
   
   if(activityORlineitemNumber.length < 1) activityORlineitemNumber = "-1";
   
   
       window.open("../reports/ViewReport.aspx?format=" + format + "&type=" + report_name + "&category=" + category + "&functioncode=" + funcationcode + "&activityORlinetimenumber=" + activityORlineitemNumber + "&college_id=" + college_id);
   
   
   
        }
    </script>
    <table width="800">
        <tr>
            <td colspan="2" style="width: 70px">
                Reports: &nbsp;
            </td>
            <td style="width: 701px">
                <asp:DropDownList ID="ddl_Reports" runat="server" Width="529px" DataSourceID="ds_Reports" DataTextField="txt_description" DataValueField="txt_rdl_name" OnDataBound="ddl_DataBound_INSERTBLACK" AutoPostBack="True" OnSelectedIndexChanged="ddl_Reports_SelectedIndexChanged">
                    <asp:ListItem>Expenditure 1</asp:ListItem>
                </asp:DropDownList><asp:SqlDataSource ID="ds_Reports" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT [txt_description], [txt_rdl_name] FROM [scs_reports] ">
                </asp:SqlDataSource>
            &nbsp; &nbsp; &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 70px">
                <asp:Label ID="lbl_collegeddl" runat="server" Text="College"></asp:Label></td>
            <td style="width: 701px">
                        <asp:DropDownList ID="ddl_College" runat="server" DataSourceID="ds_College" DataTextField="txt_college_name"
                    DataValueField="key_college_id" Width="450px" OnDataBound="ddl_DataBound_INSERTBLACK" AutoPostBack="True" OnSelectedIndexChanged="ddl_College_SelectedIndexChanged" >
                        </asp:DropDownList><br />
                <asp:SqlDataSource ID="ds_College" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    SelectCommand="SELECT -1 as key_college_id, 'College System Total' as txt_college_name&#13;&#10;UNION&#13;&#10;Select key_college_id, txt_college_name from scs_College&#13;&#10;WHERE key_college_id <=18&#13;&#10;ORDER BY txt_college_name&#13;&#10;">
                        </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 70px">
                Format:</td>
            <td style="width: 701px">
                <asp:RadioButtonList ID="rbl_Format" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True" Value="pdf">PDF</asp:ListItem>
                    <asp:ListItem>Excel</asp:ListItem>
                </asp:RadioButtonList></td>
        </tr>
    </table>
    &nbsp;
                <rad:RadMultiPage ID="RadMultiPage1" runat="server" Width="100%">
                    <rad:PageView ID="PageView1" runat="server" Width="100%">
                        <asp:Label ID="Label1" runat="server" Text="Function Code:"></asp:Label>
                        &nbsp;
                        <asp:DropDownList ID="ddL_FunctionCode" runat="server" Width="215px" DataSourceID="sqlds_functioncode" DataTextField="ViewedValue" DataValueField="key_function_code_id" OnDataBound="ddl_DataBound_INSERTBLACK">
                        </asp:DropDownList>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                        <asp:Label ID="Label2" runat="server" Text="Category Code:"></asp:Label>&nbsp;<asp:DropDownList ID="DDL_CategoryCode" runat="server"
                            Width="215px" DataSourceID="sqlds_categorycode" DataTextField="ListDataField" DataValueField="key_category_id" OnDataBound="ddl_DataBound_INSERTBLACK">
                        </asp:DropDownList>
                        &nbsp; &nbsp;&nbsp; 
                        <br />
                        <asp:Label ID="lbl_activityNumber" runat="server" Text="Activity Number:"></asp:Label>
                        <asp:TextBox ID="txt_ActivityNumber" runat="server"></asp:TextBox>
                        <br />
                        <asp:Button ID="ib_Print" runat="server" OnClick="ib_Print_Click" OnClientClick="showReport();"
                                        Text="Print" ValidationGroup="p" Width="80px" />
                        <asp:SqlDataSource ID="sqlds_functioncode" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT     key_function_code_id, txt_function_code + ' - ' +  txt_function_code_desc as ViewedValue&#13;&#10;FROM         scs_function_code">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sqlds_categorycode" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT     key_category_id, txt_category_code + ' - ' + txt_category_title as ListDataField, txt_category_desc&#13;&#10;FROM         scs_category">
                        </asp:SqlDataSource>
                        &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                    </rad:PageView>
                    <rad:PageView ID="PageView2" runat="server" Width="100%">
                        <asp:Label ID="Label4" runat="server" Text="Function Code:"></asp:Label>
                        &nbsp;&nbsp;
                        <asp:DropDownList ID="ddL_FunctionCode2" runat="server" Width="215px" DataSourceID="sqlds_functioncode2" DataTextField="ViewedValue" DataValueField="key_function_code_id" OnDataBound="ddl_DataBound_INSERTBLACK">
                        </asp:DropDownList>
                        &nbsp; &nbsp; &nbsp;
                        <asp:Label ID="Label5" runat="server" Text="Category Code:"></asp:Label><asp:DropDownList ID="DDL_CategoryCode2" runat="server"
                            Width="215px" DataSourceID="sqlds_categorycode2" DataTextField="ListDataField" DataValueField="key_category_id" OnDataBound="ddl_DataBound_INSERTBLACK">
                        </asp:DropDownList>
                        &nbsp; &nbsp;
                        <br />
                        <asp:Label ID="Label6" runat="server" Text="Line Item Number:"></asp:Label><asp:TextBox
                            ID="txt_lineItemnumber" runat="server"></asp:TextBox>
                        <br />
                        <asp:Button ID="Button1" runat="server" OnClick="ib_Print_Click" OnClientClick="showReport();"
                                        Text="Print" ValidationGroup="p" Width="80px" />
                        <asp:SqlDataSource ID="sqlds_functioncode2" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT     key_function_code_id, txt_function_code + ' - ' +  txt_function_code_desc as ViewedValue&#13;&#10;FROM         scs_function_code">
                            </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sqlds_categorycode2" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" SelectCommand="SELECT     key_category_id, txt_category_code + ' - ' + txt_category_title as ListDataField, txt_category_desc&#13;&#10;FROM         scs_category">
                        </asp:SqlDataSource>
                        </rad:PageView>
                   
                
                </rad:RadMultiPage>
</asp:Content>

