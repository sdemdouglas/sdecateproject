using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using BLL;

public partial class LocalPlan_Amendments_AmendmentForm : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);

        try
        {
            hfLocal_plan_id.Value = Session[Session.SessionID.ToString() + "PlanID"].ToString();
            //(FormView1.FindControl("lblMsg") as Label ).Text = "";
            Panel1.Visible = true;

           
        }
        catch
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                (FormView1.FindControl("lblMsg") as Label).Text = errObj.Txt_message;
            }
            Panel1.Visible = false;
            //RadTabStrip1.Tabs[1].Visible = false;
        }
        //RadGrid1.DataBind();
        GearBox_Ammendments_Secruity();

    }

    protected void Page_Load(object sender, EventArgs e)
    {

        FireDatasources();

        try
        {
            hfLevel.Value = Request.QueryString.Get("level").ToString();
        }
        catch
        {
            hfLevel.Value = "-1";
        }

        if (Session[Session.SessionID + "roleid"].ToString() != "101")
        {
            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

        }
       
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {

    }
    protected void FireDatasources()
    {

        Label myactfrom = (Label)FormView1.FindControl("lblAcitvityFrom");
        Label mylblCategoryFrom = (Label)FormView1.FindControl("lblCategoryFrom");
        Label mylblFunctionFrom = (Label)FormView1.FindControl("lblFunctionFrom");
        string mystringtest = Request.QueryString["keyid"].ToString();

        DataView DV = (DataView)this.SQLDS_RLMOVEFROM_CAT.Select(DataSourceSelectArguments.Empty);

        try
        {
            
            if (DV.Table.Rows.Count > 0)
            {
                myactfrom.Text = DV.Table.Rows[0][0].ToString();
                mylblCategoryFrom.Text = DV.Table.Rows[0][1].ToString();
                mylblFunctionFrom.Text = DV.Table.Rows[0][2].ToString();

            }
        }
        catch
        {
        }





        Label mylblActivityTo = (Label)FormView1.FindControl("lblActivityTo");
        Label mylblCategoryTo = (Label)FormView1.FindControl("lblCategoryTo");
        Label mylblFunctionTo = (Label)FormView1.FindControl("lblFunctionTo");

        try
        {

         DV = (DataView)this.sqlds_rlmoveto_cat.Select(DataSourceSelectArguments.Empty);
            if (DV.Table.Rows.Count > 0)
            {
                mylblActivityTo.Text = DV.Table.Rows[0][0].ToString();
                mylblCategoryTo.Text = DV.Table.Rows[0][1].ToString();
                mylblFunctionTo.Text = DV.Table.Rows[0][2].ToString();

            }
        }
        catch
        {
        }



    }


    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            SQLRL_AmendDelete.DeleteParameters.Clear();
            SQLRL_AmendDelete.DeleteParameters.Add("key_activity_id", Request.QueryString["keyid"].ToString());
            SQLRL_AmendDelete.Delete();

            InjectScript.Text = "<script>CloseAndRebind()</" + "script>";
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            Save();
        }
    }

    protected void Save()
    {
        if (Page.IsValid)
        {
            try
            {
                //Update current activity
                DataAccess obj = new DataAccess();
                act_activity actObj = new act_activity();
                actObj.ConnectionString = DataAccess.getConnStr();
                int ika = Convert.ToInt32(Request.QueryString.Get("keyid").ToString());

                if (actObj.LoadByPrimaryKey(ika))
                {
                    String sRet = obj.updateActivity(ika,
                                       Convert.ToInt32(Session[Session.SessionID.ToString() + "PlanID"].ToString()),
                                       (FormView1.FindControl("txtActivityName") as TextBox).Text,
                                       (FormView1.FindControl("txtDescActivity") as TextBox).Text,
                                       -1,
                                       (FormView1.FindControl("txtDescCoreInd") as TextBox).Text,
                                       -1,
                                       -1,
                                       actObj.Key_activity_type_id,
                                       (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Text,
                                       Convert.ToInt32((FormView1.FindControl("ddStatus") as DropDownList).SelectedValue),
                                       (FormView1.FindControl("cbLocked") as CheckBox).Checked,
                                       (FormView1.FindControl("cbApproved") as CheckBox).Checked,
                                       true,
                                       (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Text,
                                       102);                  

                    String errCode;

                    if (sRet.Equals("0"))
                        errCode = "200";
                    else
                        errCode = "201";

                    scs_error_dictionary errObj = new scs_error_dictionary();

                    if (errObj.LoadByPrimaryKey(errCode))
                    {
                        (FormView1.FindControl("lblMsg") as Label).Text = errObj.Txt_message; // errObj.Txt_message;
                    }

                }
            }
            catch (Exception ex)
            {
                scs_error_dictionary errObj = new scs_error_dictionary();

                if (errObj.LoadByPrimaryKey("201"))
                {
                    (FormView1.FindControl("lblMsg") as Label).Text = errObj.Txt_message;
                }
            }
        }
    }
    protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
    {

    }

    protected void GearBox_Ammendments_Secruity()
    {
        try
        {
            int aid = Convert.ToInt32(Request.QueryString.Get("keyid").ToString());
            //lp_local_plan lpObj = new lp_local_plan();
            //lpObj.ConnectionString = DataAccess.getConnStr();
            //lpObj.LoadByPrimaryKey(Convert.ToInt32(Session[Session.SessionID + "PlanID"].ToString()));


            string roleid = Session[Session.SessionID + "roleid"].ToString();
            switch (FundingPlan.get_Funding_Plan_Level(aid))
            {
                case "101":
                    //Level 0 Awaiting CO Admin

                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "102":
                            //CAO

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;

                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }

                    break;
                case "102":
                    //Level 1 Awaiting CAO
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;

                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }
                    break;
                case "103":
                    //Review by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin

                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }
                    break;

                case "104":
                    //So 3 Revision Requested by So
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = true;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = true;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = true;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = true;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = true;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;

                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }
                    break;

                case "105":
                    //Level 4 Pending SDE Review
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;


                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;

                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                    }
                    break;

                case "106":
                    //Level 5 Approved
                    switch (roleid)
                    {
                        case "103":
                            //CO Admin
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "102":
                            //CAO
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;
                            break;
                        case "101":
                            //SO Admin
                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            break;
                        case "104":
                            //View Only
                            (FormView1.FindControl("btnSave") as Button).Enabled = false;
                            (FormView1.FindControl("btnDelete") as Button).Enabled = false;
                            // (FormView1.FindControl("btnPrint") as Button).Enabled = false;
                            (FormView1.FindControl("txtDescActivity") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtDescCoreInd") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtAmdReductionDesc") as TextBox).Enabled = false;
                            (FormView1.FindControl("txtActivityName") as TextBox).Enabled = false;

                            (FormView1.FindControl("cbApproved") as CheckBox).Enabled = false;
                            (FormView1.FindControl("cbLocked") as CheckBox).Enabled = false;
                            (FormView1.FindControl("ddStatus") as DropDownList).Enabled = false;
                            (FormView1.FindControl("txtSystemOfficeNotes") as TextBox).Enabled = false;

                            break;
                    }
                    break;
                
                default:
                    // View Only, and anything not covered

                    break;
            }

        }
        catch (Exception ex)
        {
            scs_error_dictionary errObj = new scs_error_dictionary();
            errObj.ConnectionString = DataAccess.getConnStr();

            hfLocal_plan_id.Value = "-1";
            if (errObj.LoadByPrimaryKey("100"))
            {
                //lblMsg.Text = errObj.Txt_message;
            }
            Panel1.Visible = false;
        }

    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {

    }
}
