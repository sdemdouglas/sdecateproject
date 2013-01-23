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

public partial class Accountability_popup_EditImprovementPlan : System.Web.UI.Page
{
    //query string variable names
    //improvid=145
    //headerid=1046



    protected void Security_LockoutControl_by_LEVELS()
    {
        try
        {
            string levelid = Request.QueryString["levelid"].ToString();

            if (levelid == "100" || levelid == "102")
            {
                if (Session[Session.SessionID + "roleid"].ToString() != "101")
                {
                    try
                    {
                       // btnEditResponse.Visible = false;
                        btnUpdate.Visible = false;
                    }
                    catch(Exception ex)
                    {
                    }
                }
            }
            if (levelid == "104")
            {
                try
                {
                    
                   
                  //  btnEditResponse.Visible = false;
                   btnUpdate.Visible = false;
                }
                catch (Exception ex)
                {
                }
            }
        }
        catch
        {
        }

    }

    protected override void OnPreRenderComplete(EventArgs e)
    {

        Security_LockoutControl_by_LEVELS();
        base.OnPreRenderComplete(e);
    }





    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hf_HeaderID.Value = Request.QueryString["headerid"].ToString();
            hf_ImprovementID.Value = Request.QueryString["improvid"].ToString();
            DataView dv = (DataView)sqlDS_improvmentPlan.Select(DataSourceSelectArguments.Empty);
            DataSet fulldata = dv.Table.DataSet.Copy();
            if (fulldata.Tables[0].Rows.Count > 0)
            {

                foreach (DataRow dr in fulldata.Tables[0].Rows)
                {
                    lblId.Text = dr["key_acc_accountability_imprv_plan_id"].ToString();
                    lblSection.Text = dr["txt_narrative_desc"].ToString();
                    txtResponse.Text = dr["txt_narrative_response"].ToString();
                    txtSystemOfficeNotes.Text = dr["txt_system_office_notes"].ToString();

                }
            }


            txtSystemOfficeNotes.Attributes.Add("readonly", "readonly");
          
            txtResponse.Attributes.Add("onkeyup", "calCharNumber()");
            CountCharRemain1.maxChar = 1500;
            CountCharRemain1.initial(CountCharRemain1.maxChar - txtResponse.Text.Length);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        sqlDS_improvmentPlan.Update();
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {

    }
    protected void btnClose_Click(object sender, EventArgs e)
    {

    }
   
}
