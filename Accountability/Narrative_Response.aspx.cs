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
using System.Data.SqlClient;
using BLL;
using Telerik.WebControls;


public partial class LocalPlan_NarrativeDetails : System.Web.UI.Page
{

    protected void Security_LockoutControl_by_LEVELS()
    {
        try
        {
            string levelid = Request.QueryString["level"].ToString();

            if (levelid == "100" || levelid == "102")
            {
                if (Session[Session.SessionID + "roleid"].ToString() != "101")
                {
                    btnEditResponse.Visible = false;
                    btnUpdate.Visible = false;
                }
            }
            if (levelid == "104")
            {
                btnEditResponse.Visible = false;
                btnUpdate.Visible = false;
            }
        }
        catch
        {
        }

    }



    protected override void OnPreRenderComplete(EventArgs e)
    {
        if (!IsPostBack)
        {
            DecipherSession myacc = new DecipherSession(Session[Session.SessionID + HttpContext.Current.User.Identity + "accountiblityids"].ToString());
            hf_Accountability_Id.Value = myacc.AcctID.ToString();

            Security_LockoutControl_by_LEVELS();
        }

        base.OnPreRenderComplete(e);       
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //ddStatus.DataBind();

            ////Add attributes
            ////btnEditResponse.Attributes.Add("onclick", "TextEdit()");

            lblId.Text = Request.QueryString.Get("nid").ToString();
            //String ssId = "TextEditor" + Request.QueryString["nid"].ToString();

            DataAccess obj = new DataAccess();
            SqlDataReader dr = obj.getAccountabilityNarrativeDetails(Convert.ToInt32(Request.QueryString["nid"].ToString()));


            if (dr.HasRows)
                while (dr.Read())
                {
                    hfNid.Value = Request.QueryString.Get("nid").ToString();
                    lblSection.Text = dr["txt_narrative_section_title"].ToString();
                    lblDescription.Text = dr["txt_narrative_desc"].ToString();
                    txtResponse.Text = dr["txt_narrative_response"].ToString();
                    lblUpdatedBy.Text = dr["txt_updated_user"].ToString();
                    txtSystemOfficeNotes.Text = dr["txt_system_office_notes"].ToString();
                }    
        

           txtResponse.Attributes.Add("onkeyup", "calCharNumber()");
           CountCharRemain1.maxChar = 1500;
           CountCharRemain1.initial(CountCharRemain1.maxChar - txtResponse.Text.Length);
        }
        
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        bool res;
        if (Page.IsValid)
            res = Save(true);      
    }

    protected bool Save(bool displayMsg)
    {     
        String res = String.Empty;
        try
        {
            DataAccess da = new DataAccess();
            res = da.updateAccountabilityNarrative(Convert.ToInt32(lblId.Text),
                                                   txtResponse.Text,
                                                   HttpContext.Current.User.Identity.Name.ToString(),
                                                   txtSystemOfficeNotes.Text);
            if (res == "1")
                lblErr.Text = "Save successful.";
            else
            {
                lblErr.Text = "Save failed.";
                return false;
            }
            
        }
        catch (Exception ex)
        {
            lblErr.Text = ex.ToString();
            return false;
        }
        return true;
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnEditResponse_Click(object sender, EventArgs e)
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }

    protected void Lock_SO()
    {
        //cbApproved.Enabled = false;
        //cbLocked.Enabled = false;
        //ddStatus.Enabled = false;
        //disable_textBoxes(txtSystemOfficeNotes);
    }

    protected void UnLock_SO()
    {
    //    cbApproved.Enabled = true;
    //    cbLocked.Enabled = true;
    //    ddStatus.Enabled = true;
    //    txtSystemOfficeNotes.Enabled = true;
    }

    protected void Lock_Page()
    {
        //LinkButton1.Visible= false;
        //Lock_SO();
    }

    protected void UnLock_Page()
    {
        //LinkButton1.Visible = true;
        //UnLock_SO();
    }




    protected void btnPrint_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if(Save(false))
                lblPrintTrigger.Text = "<script>Print('pdf')</" + "script>";
        }
    }

    protected void disable_textBoxes(TextBox mybox)
    {
        if (mybox.TextMode == TextBoxMode.MultiLine)
        {
            mybox.ReadOnly = true;
            mybox.ForeColor = System.Drawing.Color.Gray;
        }
        else
            mybox.Attributes.Add("ReadOnly", "ReadOnly");
    }

    
    protected void  btnPrintWord_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if(Save(false))
                lblPrintTrigger.Text = "<script>Print('AWDOCX')</" + "script>";
        }
    }
}
