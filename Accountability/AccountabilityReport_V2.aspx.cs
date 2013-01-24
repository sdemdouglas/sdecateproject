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
using Telerik.WebControls;

public partial class Accountability_AccountabilityReport_V2 : System.Web.UI.Page
{
    protected override void OnPreRenderComplete(EventArgs e)
    {
        Panel panControl = (Panel)Master.FindControl("panControl");
        if (panControl != null)
            panControl.Visible = false;


        Label lblCollege = (Label)Master.FindControl("lblCollege");
        if (lblCollege != null)
            lblCollege.Visible = false;

        DropDownList DropDownList1 = (DropDownList)Master.FindControl("DropDownList1");
        if (DropDownList1 != null)
            DropDownList1.Visible = false;

        Label Label2 = (Label)Master.FindControl("Label2");
        if (Label2 != null)
            Label2.Visible = false;

        DropDownList DropDownList2 = (DropDownList)Master.FindControl("DropDownList2");
        if (DropDownList2 != null)
            DropDownList2.Visible = false;

        base.OnPreRenderComplete(e);
    }

   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ds_Acc_Menu.DataBind();
            rts_Acc_Menu.SelectedIndex = 0;

            try
            {

            }
            catch
            {
            }
            rdt_PerfIndcat.SelectedIndex = 0;
            RadMultiPage1.SelectedIndex = 0;
            
        }
    }
    protected void ddl_College_FiscalYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_fiscalyear.SelectedIndex > 0 && ddl_College.SelectedIndex > 0)
        {
            pan_Acc.Visible = true;
            DataSourceSelectArguments dssa = new DataSourceSelectArguments();
            dssa.AddSupportedCapabilities(DataSourceCapabilities.RetrieveTotalRowCount);
            dssa.RetrieveTotalRowCount = true;
            DataView dv = (DataView)SQLDS_Accountablity.Select(dssa);

            Label1.Text = dv.Table.Rows[0][0].ToString();
            hf_Accountability_Id.Value = dv.Table.Rows[0][0].ToString();
            lbl_Acc_Id.Text = dv.Table.Rows[0][0].ToString();
            txt_Note.Text = dv.Table.Rows[0][4].ToString();

            //ds_Level.DataBind();
            dv = (DataView)ds_Level.Select(dssa);
            lbl_Level.Text = dv.Table.Rows[0][1].ToString();
            hf_Level_Id.Value = dv.Table.Rows[0][0].ToString();

            ddl_Acct_Next_Level.DataBind();

            //ds_Acc_Narr.DataBind();
            //SqlDS_Gender.DataBind();
            //SqlDS_Race.DataBind();
            //ds_2p1_Spec_Pop.DataBind();
            //ds_3p1_Spec_Pop.DataBind();
            //ds_4p1_Spec_Pop.DataBind();
            //ds_5p1_Spec_Pop.DataBind();
            //ds_5p2_Spec_Pop.DataBind();
            //ds_Enrollment.DataBind();

            rg_Narratives.DataBind();
            rg_Enrollment.DataBind();
        }
        else
            pan_Acc.Visible = false;
    }

    protected void nbr_studentsTextBox_TextChanged(object sender, EventArgs e)
    {
        GridDataItem gd_item = (GridDataItem)(sender as RadNumericTextBox).NamingContainer;
        HiddenField hf_kp_id = (HiddenField)gd_item.FindControl("hf_kp_id");

        int value;
        if ((sender as RadNumericTextBox).Text.Trim() == "") value = 0; else value = Convert.ToInt32((sender as RadNumericTextBox).Text);
        if (hf_kp_id != null)
        {
            DataAccess da = new DataAccess();
            String res = da.updateAccountabilityEnrollment(Convert.ToInt32(hf_kp_id.Value),
                                                           value,
                                                           HttpContext.Current.User.Identity.Name.ToString());
        }
    }

    protected void btn_SAVEacct_Click(object sender, EventArgs e)
    {

    }
    protected void rts_Acc_Menu_TabClick(object sender, TabStripEventArgs e)
    {
        mv_Acc.ActiveViewIndex = rts_Acc_Menu.SelectedTab.Index;
    }
    protected void ds_Acc_Narr_DataBinding(object sender, EventArgs e)
    {

    }
    protected void rg_Narratives_ItemDataBound(object sender, GridItemEventArgs e)
    {
        HiddenField hf_Nid = (HiddenField)e.Item.FindControl("hf_Nid");
        HyperLink lbView = e.Item.FindControl("lbView") as HyperLink;
        if (lbView != null && hf_Nid != null)
        {
            lbView.Attributes.Add("onClick", "ShowNarrativeDetails(" + hf_Nid.Value + ")");
        }
    }
    protected void rdg_Gender_UpdateCommand(object source, GridCommandEventArgs e)
    {

    }


    protected void btn_Save_Click(object sender, EventArgs e)
    {
        switch (Convert.ToInt16(hdn_tabselectedValue.Value))
        {
            case 101:
                updateGenderData(rdg_Gender);
                updateRaceData(rdg_Race);
                updateSpecialPOPsData(rdg_SpecPOPs);
                break;
            case 102:
                updateSpecialPOPsData(rdg_SpecPOPs2p1);
                break;
            case 103:
                updateSpecialPOPsData(rdg_SpecPOPs3p1);
                break;
            case 104:
                updateSpecialPOPsData(rdg_SpecPOPs4p1);
                break;
            case 105:
                updateSpecialPOPsData(rdg_SpecPOPs5p1);
                break;
            case 106:
                updateSpecialPOPsData(rdg_SpecPOPs5p2);
                break;
        }
    }

    private void updateGenderData(RadGrid VARrdg_Gender)
    {
        foreach (GridDataItem item in VARrdg_Gender.Items)
        {
            SqlDS_Gender.UpdateParameters.Clear();
            SqlDS_Gender.UpdateParameters.Add("p_key_acct_gender_id", item["key_acct_gender_id"].Text);
            SqlDS_Gender.UpdateParameters.Add("p_nbr_students_numerator", ((RadNumericTextBox)item["nbr_students_numerator"].FindControl("nbr_students_numeratorTextBox")).Text);
            SqlDS_Gender.UpdateParameters.Add("p_nbr_student_denominator", ((RadNumericTextBox)item["nbr_student_denominator"].FindControl("nbr_student_denominatorTextBox")).Text);
            SqlDS_Gender.UpdateParameters.Add("p_txt_updated_by", HttpContext.Current.User.Identity.Name.ToString());
            SqlDS_Gender.Update();

        }
    }


    private void updateRaceData(RadGrid VARrdg_Race)
    {
        foreach (GridDataItem item in VARrdg_Race.Items)
        {
            SqlDS_Race.UpdateParameters.Clear();
            SqlDS_Race.UpdateParameters.Add("p_key_acct_race_id", item["key_acct_race_id"].Text);
            SqlDS_Race.UpdateParameters.Add("p_nbr_students_numerator", ((RadNumericTextBox)item["nbr_students_numerator"].FindControl("nbr_students_numeratorTextBox")).Text);
            SqlDS_Race.UpdateParameters.Add("p_nbr_student_denominator", ((RadNumericTextBox)item["nbr_student_denominator"].FindControl("nbr_student_denominatorTextBox")).Text);
            SqlDS_Race.UpdateParameters.Add("p_txt_updated_by", HttpContext.Current.User.Identity.Name.ToString());
            SqlDS_Race.Update();

        }




    }



    private void updateSpecialPOPsData(RadGrid VARrdg_SpecPOPs)
    {
        foreach (GridDataItem item in VARrdg_SpecPOPs.Items)
        {
            SqlDS_SpecPop.UpdateParameters.Clear();
            SqlDS_SpecPop.UpdateParameters.Add("p_key_acct_spec_population_id", item["key_acct_spec_population_id"].Text);
            SqlDS_SpecPop.UpdateParameters.Add("p_nbr_students_numerator", ((RadNumericTextBox)item["nbr_students_numerator"].FindControl("nbr_students_numeratorTextBox")).Text);
            SqlDS_SpecPop.UpdateParameters.Add("p_nbr_student_denominator", ((RadNumericTextBox)item["nbr_student_denominator"].FindControl("nbr_student_denominatorTextBox")).Text);
            SqlDS_SpecPop.UpdateParameters.Add("p_txt_updated_by", HttpContext.Current.User.Identity.Name.ToString());
            SqlDS_SpecPop.Update();

        }
    }
    protected void ddl_College_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("Select", "-1");
        if (ddl_College.Items.IndexOf(li) < 0)
            ddl_College.Items.Insert(0, li);
    }
    protected void ddl_fiscalyear_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("Select", "-1");
        if (ddl_fiscalyear.Items.IndexOf(li) < 0)
            ddl_fiscalyear.Items.Insert(0, li);
    }
    protected void btn_Save_Click1(object sender, EventArgs e)
    {
        DataAccess da = new DataAccess();
        String res = da.updateAccountabilityInfo(Convert.ToInt32(hf_Accountability_Id.Value),
                                                Convert.ToInt32(ddl_Acct_Next_Level.SelectedValue),
                                                txt_Note.Text);
    }
}
