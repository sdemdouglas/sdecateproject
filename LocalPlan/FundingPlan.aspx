<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FundingPlan.aspx.cs" Inherits="LocalPlan_FundingPlan" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Funding Plan</title>
    <link href="../../App_Themes/Granite/Default.css" rel="stylesheet" type="text/css" />
</head> 
<body>
    <form id="form1" runat="server">
    <script language="javascript">
    function OpenReportRDL(planid)
    {
        var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;


            window.open("~/Reports/ViewReport.aspx?type=rpt_college_funding_plan&planid=" + planid + "&reportformat=rdl",null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
 
    }
     function OpenReport(planid)
        {       
           
       
          
            var wide = window.screen.availWidth-30;
            var high = window.screen.availHeight-30;


            window.open("../Reports/ViewReport.aspx?type=rpt_college_funding_plan&planid=" + planid,null,"resizable=yes,status=no,top=0,left=0,toolbar=no,menubar=no,location=no,target=_top" + ",height = " + high +",width = " + wide);
 
           // window.open("../../Reports/ViewReport.aspx?type='activities'");
        }
    
    </script>
    <div>
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="14pt" Text="SOUTH CAROLINA TECHNICAL COLLEGE FUNDING PLAN"></asp:Label>&nbsp;<br />
          <asp:HyperLink ID="HL_Print_RDL" runat="server" Style="position: relative" ImageUrl="~/images/48folderopen.jpg" Visible="False"> Print Report as RDL</asp:HyperLink>
        <asp:HyperLink ID="HL_Print" runat="server" Style="position: relative" ImageUrl="~/images/Reader-32.gif">Print Report in PDF</asp:HyperLink>
        &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:ImageButton ID="ImageButton1" runat="server" AlternateText="Export to Excel"
            ImageUrl="~/images/Excel_Icon_SMALL.gif" OnClick="ImageButton1_Click" Style="position: relative" /><br />
        <radg:radgrid id="GridFundingPlan" runat="server" datasourceid="SqlDsFundingPlan"
            gridlines="None" skin="Default" OnItemDataBound="GridFundingPlan_ItemDataBound" Width="99%">
<MasterTableView DataSourceID="SqlDsFundingPlan" AutoGenerateColumns="False" DataKeyNames="key_category_function_id" ShowFooter="True">
<RowIndicatorColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>

<ExpandCollapseColumn>
<HeaderStyle Width="20px"></HeaderStyle>
</ExpandCollapseColumn>
    <Columns>
        <radG:GridBoundColumn DataField="key_category_function_id" DataType="System.Int32"
            HeaderText="key_category_function_id" ReadOnly="True" SortExpression="key_category_function_id"
            UniqueName="key_category_function_id" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_category_code" HeaderText="Category" SortExpression="txt_category_code"
            UniqueName="txt_category_code">
            <ItemStyle Width="0.8in" />
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_function_code" HeaderText="Function" SortExpression="txt_function_code"
            UniqueName="txt_function_code">
            <ItemStyle Width="0.8in" />
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_category_title" HeaderText="Technical Program Service Activity"
            SortExpression="txt_category_title" UniqueName="txt_category_title">
            <ItemStyle Width="2.5in" />
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_function_code_desc" HeaderText="txt_function_code_desc"
            SortExpression="txt_function_code_desc" UniqueName="txt_function_code_desc" Visible="False">
        </radG:GridBoundColumn>
        
            <radG:GridBoundColumn DataField="nbr_salary" HeaderText="(100)  Salary"
            SortExpression="nbr_salary" UniqueName="nbr_salary" DataFormatString="{0:c}">
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
                <FooterStyle HorizontalAlign="Right" />
        </radG:GridBoundColumn>
        
                <radG:GridBoundColumn DataField="nbr_fixed_charges" HeaderText="(200) Fixed Charges"
            SortExpression="nbr_fixed_charges" UniqueName="nbr_fixed_charges" DataFormatString="{0:c}">
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle HorizontalAlign="Right" />
                    <FooterStyle HorizontalAlign="Right" />
        </radG:GridBoundColumn>
        
                        <radG:GridBoundColumn DataField="nbr_purchased_services" HeaderText="(300) Purchased Services"
            SortExpression="nbr_purchased_services" UniqueName="nbr_purchased_services" DataFormatString="{0:c}">
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
        </radG:GridBoundColumn>
        
              
                        <radG:GridBoundColumn DataField="nbr_instructional_supplies" HeaderText="(400) Instructional Supplies"
            SortExpression="nbr_instructional_supplies" UniqueName="nbr_instructional_supplies" DataFormatString="{0:c}">
                            <ItemStyle HorizontalAlign="Right" />
                            <HeaderStyle HorizontalAlign="Right" />
                            <FooterStyle HorizontalAlign="Right" />
        </radG:GridBoundColumn>
        
  <radG:GridBoundColumn DataField="nbr_equipment_cost" HeaderText="(500) Equipment "
            SortExpression="nbr_equipment_cost" UniqueName="nbr_equipment_cost" DataFormatString="{0:c}">
      <ItemStyle HorizontalAlign="Right" />
      <HeaderStyle HorizontalAlign="Right" />
      <FooterStyle HorizontalAlign="Right" />
 </radG:GridBoundColumn>
 
  <radG:GridBoundColumn DataField="nbr_indirect_costs" HeaderText="(700) Indirect Cost"
            SortExpression="nbr_indirect_costs" UniqueName="nbr_indirect_costs" DataFormatString="{0:c}">
      <ItemStyle HorizontalAlign="Right" />
      <HeaderStyle HorizontalAlign="Right" />
      <FooterStyle HorizontalAlign="Right" />
 </radG:GridBoundColumn>
 
      <radG:GridTemplateColumn UniqueName="Total" HeaderText="Total" >
                            <ItemTemplate>
                                <asp:Label ID="lblTotal" runat="server" />
                            </ItemTemplate>
          <ItemStyle HorizontalAlign="Right" />
          <HeaderStyle HorizontalAlign="Right" />
          <FooterStyle HorizontalAlign="Right" />
                        </radG:GridTemplateColumn>
                        
    </Columns>
</MasterTableView>
</radg:radgrid>
        <asp:SqlDataSource ID="SqlDsFundingPlan" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_lp_college_funding_plan" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="p_key_local_plan_id" QueryStringField="id"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
