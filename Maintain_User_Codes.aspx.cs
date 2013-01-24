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
    protected void Page_Load(object sender, EventArgs e)
    {
        
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
}
