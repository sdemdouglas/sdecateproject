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


public partial class Maintain_User_Codes : System.Web.UI.Page
{

    protected override void OnPreRenderComplete(EventArgs e)
    {
        base.OnPreRenderComplete(e);
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

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        DropDownList mydd = (DropDownList)Master.FindControl("DropDownList2");
        if (mydd.SelectedValue != "" && mydd.SelectedValue != "-1")
        {
            string mestring = mydd.SelectedItem.Text;

            SQLDSRL_GETYEARID.SelectParameters.Clear();
            SQLDSRL_GETYEARID.SelectParameters.Add("yearI", mestring);
            SQLDSRL_GETYEARID.Select(DataSourceSelectArguments.Empty);
            DataView dv = (DataView)SQLDSRL_GETYEARID.Select(DataSourceSelectArguments.Empty);
            string mest1 = dv.Table.Rows[0][0].ToString();
            hdF_yearID.Value = mest1.ToString();
            //
            //SQLDS_RLFISCALYEARSCHEDULE.SelectParameters.Clear();
            //string mest1 = dv.Table.Rows[0][0].ToString();
            //SQLDS_RLFISCALYEARSCHEDULE.SelectParameters.Add("p_key_fiscal_year_id", mest1);
            //SQLDS_RLFISCALYEARSCHEDULE.Select(DataSourceSelectArguments.Empty);
            //RD_FISCALSCHEDULE.DataBind();
        }
        


   
    }
    protected void ddIndicator_DataBound(object sender, EventArgs e)
    {
        ListItem li = new ListItem("", "-1");
        if (ddIndicator.Items.IndexOf(li) < 0)
            ddIndicator.Items.Insert(0, li);
    }
    protected void ddIndicator_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToInt32(ddIndicator.SelectedItem.Value) > 0)
        {
            
            mvMultiView1.ActiveViewIndex = Convert.ToInt32(ddIndicator.SelectedItem.Value) - 1;
        }
    }
    protected void SqlDataSourceInd_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
    }
    protected void gCategories_NeedDataSource(object source, Telerik.WebControls.GridNeedDataSourceEventArgs e)
    {

    }
    protected void gCategories_ItemDataBound(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        if ((e.Item is GridEditFormItem) && e.Item.IsInEditMode)
        {
            GridEditFormItem gridEditFormItem = (GridEditFormItem)e.Item;
            DropDownList dd = (DropDownList)e.Item.FindControl("ddCatType");
            HiddenField hf = (HiddenField)e.Item.FindControl("hfKeyValue");

            if (dd != null)
            {
                if (dd.Items.IndexOf(new ListItem("", "-1")) < 0)
                    dd.Items.Insert(0, new ListItem("", "-1"));

                if (hf != null)
                    dd.SelectedIndex = dd.Items.IndexOf(dd.Items.FindByValue(hf.Value));
            }
        }  

    }
    protected void gCategories_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
        {
            DropDownList dd = (DropDownList)e.Item.FindControl("ddCatType");
            HiddenField hf = (HiddenField)e.Item.FindControl("hfKeyValue");
            if (dd != null)
            {
                dd.Attributes.Add("onchange", "copyCatTypeValue()");
                gCategories.Controls.Add(new LiteralControl("<script type='text/javascript'>window['ddCatType'] ='" + dd.ClientID + "';</script>"));
            }
            if (hf != null)
                gCategories.Controls.Add(new LiteralControl("<script type='text/javascript'>window['hfKeyValue'] ='" + hf.ClientID + "';</script>"));
        }
    }
    protected void RadGrid3_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
    {

    }
    protected void SQLDS_RLFISCALYEARSCHEDULE_DataBinding(object sender, EventArgs e)
    {
       

    }
  
    protected void RD_FISCALSCHEDULE_DataBinding(object sender, EventArgs e)
    {
       
    }
    protected void FiscalYearSchedule_PreRender(object sender, EventArgs e)
    {
        //   if (Session[Session.SessionID + "FiscalDDvalue"] != null)
       
    }
    protected void SQLDSRL_GETYEARID_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
      
    }

    protected void RD_FISCALSCHEDULE_ItemCommand(object source, GridCommandEventArgs e)
    {

        if (e.CommandName.ToString() == "Edit")
        {
            //GridEditableItem editedItem = e.Item as GridEditableItem;

            //DataRow[] changedRows = this.RD_FISCALSCHEDULE.Select("key_fiscal_year_id = " + editedItem["key_fiscal_year_id"].Text);


        }


        if (e.CommandName.ToString() == "InitInsert")
        {

            //GridDataItem myitem = RD_FISCALSCHEDULE.Items[Convert.ToInt32(e.CommandArgument)];
            //DropDownList ddl = (DropDownList)myitem.FindControl("DropDownList1");


            //ListItem myitem1 = new ListItem("Select Year", null);
            //ddl.Items.Insert(0, myitem1);

        }
    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        //ListItem myitem = new ListItem("Select Year", " ");
        //DropDownList mydl = (DropDownList)sender;
        //mydl.Items.Insert(0, myitem);
    }
    protected void gNarrative_ItemCommand(object source, GridCommandEventArgs e)
    {
        //HiddenField hfDescText = e.Item.FindControl("hfDesctext") as HiddenField;
        //RadEditor Editor = e.Item.FindControl("txt_narrative_descTextBox") as RadEditor;

        //if (hfDescText != null && Editor != null)
        //{
        //    Utility uObj = new Utility();

        //    hfDescText.Value = Editor. uObj.StripTags(Editor.Html);
        //}
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        mvMultiView1.ActiveViewIndex = 9;
    }
}
