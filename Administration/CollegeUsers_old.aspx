<%@ Page Language="C#" MasterPageFile="~/AppMaster.master" AutoEventWireup="true" CodeFile="CollegeUsers.aspx.cs" Inherits="Administration_CollegeInformation" Title="College Users" %>

<%@ Register Assembly="RadGrid.Net2" Namespace="Telerik.WebControls" TagPrefix="radG" %>

<%@ Register Assembly="RadTabStrip.Net2" Namespace="Telerik.WebControls" TagPrefix="radTS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" Runat="Server">
<script language="javascript">
function keepListBoxstate()
{

var lb =  document.getElementById('ctl00_mainCopy_LB_SECRoles');


var i;

for(i=0; i<lb.length;i++)
{
//if(lb.options[i].selected)
//{
//alert(lb.options[i].value);
//}
//lb.options[i].selected != lb.options[i].selected;
//alert(lb.options[i].selected)
}
}


function alerttocontinue_sync()
{
return confirm("Are you sure you wish to refresh user list, this could take serveral minutes");
}
</script>



    <div class="container">
        
        <div id="contactForm">
            <div style="margin-top: 1em">
                <table style="width: 722px;">
                    <tr>
                        <td style="width: 134px; height: 21px;">
                            <asp:Label ID="Label1" runat="server" Text="Select College"></asp:Label></td>
                        <td colspan="2" style="height: 21px">
                            <asp:DropDownList ID="DD_CollegeList" runat="server" Width="285px" AutoPostBack="True" OnDataBound="DD_CollegeList_DataBound">
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 134px">
                            <strong>Add User</strong></td>
                        <td style="width: 571px">
                        </td>
                        <td style="width: 185px">
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 24px; width: 134px;">
                            User Name</td>
                        <td colspan="2" style="height: 24px">
                <asp:DropDownList ID="DD_AllUSERS" runat="server" Width="202px" AutoPostBack="True" OnSelectedIndexChanged="DD_AllUSERS_SelectedIndexChanged"  OnDataBound="DD_AllUSERS_DataBound" DataSourceID="SqlDS_ALLADSTAFF" DataTextField="displayname" DataValueField="quid">
                </asp:DropDownList>
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Style="position: relative"
                                Text="Refresh User List" OnClientClick="return alerttocontinue_sync();"/></td>
                    </tr>
                    <tr>
                        <td valign = "top" style="width: 134px">
                            Roles</td>
                        <td colspan="2">
                            <asp:ListBox ID="LB_SECRoles" runat="server"
                    DataSourceID="SQLDS_Roles" DataTextField="txt_role" DataValueField="key_role_id" onmousedown="javascript:keepListBoxstate();" Width="202px" ></asp:ListBox>
                            </td>
                    </tr>
                    <tr>
                        <td style="width: 134px">
                        Enabled</td>
                        <td style="width: 571px">
                        <asp:CheckBox ID="CB_UserEnabled"
                        runat="server" Width="186px"  />&nbsp;
                            <asp:Label ID="Label3" runat="server" Text="Contact Number"></asp:Label>
                            <asp:TextBox ID="TXT_contactNumber" runat="server"></asp:TextBox></td>
                        <td style="width: 185px">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <hr />
                            &nbsp;<asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save New User" />
                            <asp:Label ID="Label2" runat="server" ForeColor="Red" Style="position: relative"
                                Text="Error: User Already Assigned to another College" Visible="False"></asp:Label>
                            <hr /></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3">
                <radg:radgrid id="RadGrid1" runat="server" allowautomaticupdates="True"
                    allowpaging="True" allowsorting="True" datasourceid="sqlDS_GetAllUsers_nRoles"
                    gridlines="None" oneditcommand="RadGrid1_EditCommand" skin="Default" OnDeleteCommand="RadGrid1_DeleteCommand" ShowFooter="True" OnItemDataBound="RadGrid1_ItemDataBound">
<MasterTableView DataSourceID="sqlDS_GetAllUsers_nRoles" AutoGenerateColumns="False" DataKeyNames="key_user_id">
<EditFormSettings EditFormType="Template"><FormTemplate>
<radG:RadGrid style="POSITION: relative" id="RD_GD_UserRoleDetail" runat="server" Width="216px" DataSourceID="sqlDS_userroleDetail" GridLines="None" AllowAutomaticDeletes="True" AutoGenerateColumns="False" OnDeleteCommand="RD_GD_UserRoleDetail_DeleteCommand">
<MasterTableView DataSourceID="sqlDS_userroleDetail" Width="100%" DataKeyNames="txt_user_role_id">
<ExpandCollapseColumn Visible="False">
<HeaderStyle Width="19px"></HeaderStyle>
</ExpandCollapseColumn>

<RowIndicatorColumn Visible="False">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>
    <Columns>
        <radG:GridBoundColumn DataField="Key_User_id" UniqueName="column" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_security_quid" UniqueName="column1" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="key_role_id" UniqueName="column2" Visible="False">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_role" HeaderText="Role" UniqueName="column3">
        </radG:GridBoundColumn>
        <radG:GridBoundColumn DataField="txt_college_name" HeaderText="College" UniqueName="column4" Visible="False">
            <ItemStyle Wrap="False" />
        </radG:GridBoundColumn>
        <radG:GridButtonColumn CommandName="delete" Text="Delete" UniqueName="column5">
        </radG:GridButtonColumn>
    </Columns>
</MasterTableView>
</radG:RadGrid> 
</FormTemplate>
    <EditColumn UniqueName="EditCommandColumn1">
    </EditColumn>
</EditFormSettings>
<Columns>
    <radG:GridBoundColumn DataField="key_user_id" DataType="System.Int32" HeaderText="key_user_id"
        ReadOnly="True" SortExpression="key_user_id" UniqueName="key_user_id" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_security_quid" HeaderText="txt_security_quid"
        SortExpression="txt_security_quid" UniqueName="txt_security_quid" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_user_name" HeaderText="txt_user_name" SortExpression="txt_user_name"
        UniqueName="txt_user_name" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="key_college_id" DataType="System.Int32" HeaderText="key_college_id"
        SortExpression="key_college_id" UniqueName="key_college_id" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_email" HeaderText="Email" SortExpression="txt_email"
        UniqueName="txt_email">
    </radG:GridBoundColumn>
    <radG:GridCheckBoxColumn DataField="flg_enabled" DataType="System.Boolean" HeaderText="Enabled"
        SortExpression="flg_enabled" UniqueName="flg_enabled">
    </radG:GridCheckBoxColumn>
    <radG:GridBoundColumn DataField="txt_display_name" HeaderText="Display Name"
        SortExpression="txt_display_name" UniqueName="txt_display_name">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_description" HeaderText="txt_description" SortExpression="txt_description"
        UniqueName="txt_description" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_role" HeaderText="Role" SortExpression="txt_role"
        UniqueName="txt_role">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_college_code" HeaderText="College"
        SortExpression="txt_college_code" UniqueName="txt_college_code" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_college_name" HeaderText="College"
        SortExpression="txt_college_name" UniqueName="txt_college_name">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_desc" HeaderText="txt_desc" SortExpression="txt_desc"
        UniqueName="txt_desc" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_college_type" HeaderText="txt_college_type"
        SortExpression="txt_college_type" UniqueName="txt_college_type" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridCheckBoxColumn DataField="flg_inactive" DataType="System.Boolean" HeaderText="flg_inactive"
        SortExpression="flg_inactive" UniqueName="flg_inactive" Visible="False">
    </radG:GridCheckBoxColumn>
    <radG:GridCheckBoxColumn DataField="flg_user_defined" DataType="System.Boolean" HeaderText="flg_user_defined"
        SortExpression="flg_user_defined" UniqueName="flg_user_defined" Visible="False">
    </radG:GridCheckBoxColumn>
    <radG:GridBoundColumn DataField="phn_phone_nbr" HeaderText="phn_phone_nbr" SortExpression="phn_phone_nbr"
        UniqueName="phn_phone_nbr" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="dte_updated_date" DataType="System.DateTime" HeaderText="dte_updated_date"
        SortExpression="dte_updated_date" UniqueName="dte_updated_date" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_address_line_1" HeaderText="txt_address_line_1"
        SortExpression="txt_address_line_1" UniqueName="txt_address_line_1" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_address_line_2" HeaderText="txt_address_line_2"
        SortExpression="txt_address_line_2" UniqueName="txt_address_line_2" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_city" HeaderText="txt_city" SortExpression="txt_city"
        UniqueName="txt_city" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_state" HeaderText="txt_state" SortExpression="txt_state"
        UniqueName="txt_state" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_zip" HeaderText="txt_zip" SortExpression="txt_zip"
        UniqueName="txt_zip" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_domain_sid" HeaderText="txt_domain_sid" SortExpression="txt_domain_sid"
        UniqueName="txt_domain_sid" Visible="False">
    </radG:GridBoundColumn>
    <radG:GridBoundColumn DataField="txt_phone_number" HeaderText="Contact Number" SortExpression="txt_phone_number"
        UniqueName="txt_phone_number">
    </radG:GridBoundColumn>
    <radG:GridButtonColumn CommandName="Delete" Text="Delete" UniqueName="deletecolumn" >
    </radG:GridButtonColumn>
</Columns>

<ExpandCollapseColumn Visible="False">
<HeaderStyle Width="19px"></HeaderStyle>
</ExpandCollapseColumn>

<RowIndicatorColumn Visible="False">
<HeaderStyle Width="20px"></HeaderStyle>
</RowIndicatorColumn>
</MasterTableView>
</radg:radgrid></td>
                    </tr>
                </table>
                <br />
                &nbsp;<br />
                <br />
                <asp:HiddenField ID="hdn_username" runat="server" />
                <br />
                <asp:HiddenField ID="hdn_email" runat="server" />
                <br />
                <asp:HiddenField ID="hdn_display" runat="server" />
                <br />
                  <asp:HiddenField ID="hdn_strid" runat="server" />
                <asp:SqlDataSource ID="sqlDS_userroleDetail" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
                    SelectCommand="SELECT [key_user_id], [txt_security_quid], [key_role_id], [txt_role], [txt_college_name],[txt_user_role_id] ,[key_college_id],[flg_enabled],[txt_phone_number] FROM [vw_perkins_sec_user] where key_user_id= @keyuserid" DeleteCommand="pr_sec_user_roles_del" DeleteCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="RadGrid1" Name="keyuserid" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="txt_user_role_id" Type="Int32" />
                    </DeleteParameters>
                </asp:SqlDataSource>
                <br />
                <asp:SqlDataSource ID="SqlDS_ALLADSTAFF" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>" SelectCommand="SELECT quid, DisplayName FROM GK_ADLIST order by displayname"></asp:SqlDataSource>
                <br />
            </div>
        </div>
        <asp:SqlDataSource ID="sqlCollegeDs" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="SELECT [key_college_id], [txt_college_name] FROM [scs_college] WHERE key_college_id NOT IN(18, 20) ORDER BY txt_college_name"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SQLDS_Roles" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            SelectCommand="pr_Role_ByCollege" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:ControlParameter ControlID="DD_CollegeList" Name="collegeID" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SQLDS_INSUSR" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            InsertCommand="pr_scs_college_users_ins" InsertCommandType="StoredProcedure"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            SelectCommand="select * from scs_college_users">
            <InsertParameters>
                <asp:ControlParameter ControlID="DD_AllUSERS" Name="txt_security_quid" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="hdn_username" Name="txt_user_name" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="DD_CollegeList" Name="key_college_id" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="hdn_email" Name="txt_email" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="CB_UserEnabled" Name="flg_enabled" PropertyName="Checked"
                    Type="Boolean" />
                <asp:ControlParameter ControlID="hdn_display" Name="txt_display_name" PropertyName="Value"
                    Type="String" />
                <asp:ControlParameter ControlID="TXT_contactNumber" Name="txt_phone_number" PropertyName="Text"
                    Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SQLDS_USR_Role_EDIT" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            InsertCommand="pr_sec_user_roles_ins" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            SelectCommand="SELECT [txt_user_role_id], [key_user_id], [key_role_id] FROM [sec_user_roles]">
            <InsertParameters>
                <asp:ControlParameter ControlID="hdn_strid" Name="key_user_id" PropertyName="Value"
                    Type="Int32" />
                <asp:ControlParameter ControlID="LB_SECRoles" Name="key_role_id" PropertyName="SelectedValue"
                    Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlDS_GetAllUsers_nRoles" runat="server" ConnectionString="<%$ ConnectionStrings:sctcs_perkinsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:sctcs_perkinsConnectionString.ProviderName %>"
            SelectCommand="SELECT DISTINCT &#13;&#10;                      key_user_id, txt_security_quid, txt_user_name, key_college_id, txt_email, flg_enabled, txt_display_name, txt_description, txt_role, txt_college_code, &#13;&#10;                      txt_college_name, txt_desc, txt_college_type, flg_inactive, flg_user_defined, dte_updated_date, txt_address_line_1, txt_address_line_2, txt_city, &#13;&#10;                      txt_state, txt_zip, phn_phone_nbr, txt_domain_sid,txt_phone_number&#13;&#10;FROM         vw_perkins_sec_user&#13;&#10;WHERE key_college_id = @p_key_college_id" DeleteCommand="pr_delUserfromSecurity" DeleteCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="DD_CollegeList" Name="p_key_college_id" PropertyName="SelectedValue" />
            </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="userid" />
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>


