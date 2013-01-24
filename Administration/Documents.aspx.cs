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
using System.IO;
using System.Web.Configuration;

using System.Text;
public partial class DocumentLibrary_DocumentView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlDataSource1.DataBind();
        }

    }
    protected void gDoc_ItemCreated(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        //if (e.Item is GridItem)
        //{
        //    FileUpload fu = e.Item.FindControl("fuPath") as FileUpload;
        //    HiddenField hf = e.Item.FindControl("hfPath") as HiddenField;
        //    if (fu != null)
        //    {
        //        fu.Attributes.Add("onchange", "GetPathValue()");
        //        gDoc.Controls.Add(new LiteralControl("<script type='text/javascript'>window['fuPath'] ='" + fu.ClientID + "';</script>"));
        //    }

        //    if (hf!= null)
        //        gDoc.Controls.Add(new LiteralControl("<script type='text/javascript'>window['hfPath'] ='" + hf.ClientID + "';</script>"));
       
        
        //   DropDownList ddcat = e.Item.FindControl("DD_category") as DropDownList;
          
            
        //    HiddenField hf1 = e.Item.FindControl("hf_CategoryValue") as HiddenField;

        //    if (ddcat != null)
        //    {
        //        gDoc.Controls.Add(new LiteralControl("<script type='text/javascript'>window['DD_category'] ='" + ddcat.ClientID + "';</script>"));            
        //    }

        //    if (hf1 != null)
        //    {
        //        gDoc.Controls.Add(new LiteralControl("<script type='text/javascript'>window['hf_CategoryValue'] ='" + hf1.ClientID + "';</script>"));
        //        ddcat.SelectedIndex = ddcat.Items.IndexOf(ddcat.Items.FindByValue(hf1.Value));
        //    }

        
        //}
    }
    protected void gDoc_InsertCommand(object source, GridCommandEventArgs e)
    {
        FileUpload fu = e.Item.FindControl("fuPath") as FileUpload;
        HiddenField hf = e.Item.FindControl("hfPath") as HiddenField;

        DropDownList ddcat = e.Item.FindControl("DD_category") as DropDownList;
        HiddenField hfcat = e.Item.FindControl("hf_CategoryValue") as HiddenField;

        if (ddcat != null && hfcat != null)
        {
            hfcat.Value = ddcat.SelectedValue;
        }

        if (fu != null && fu.HasFile)
          
            if (fu.PostedFile != null)
                if (fu.PostedFile.ContentLength != 0)
                {
                    try
                    {
                        String destDir = Server.MapPath("../DocumentLibrary//Docs");
                        String fileName = Path.GetFileName(fu.PostedFile.FileName).Replace(' ', '_');
                        String destPath = Path.Combine(destDir, fileName);
                        //hf.Value = destPath;

                        if (Server.MachineName.ToLower().Equals("hickory"))
                            hf.Value = hf.Value = "https://www.sctechsystem.edu/" + WebConfigurationManager.AppSettings.Get("DocumentsPath").ToString() + "/" + fileName;
                        else
                            hf.Value = "http://" + Server.MachineName + "/" + WebConfigurationManager.AppSettings.Get("DocumentsPath").ToString() + "/" + fileName;
                        fu.PostedFile.SaveAs(destPath);
                        
                    }
                    catch (Exception err)
                    {

                    }
                }
        
    }

    protected void gDoc_EditCommand(object source, GridCommandEventArgs e)
    {
        //        DropDownList ddcat = e.Item.FindControl("DD_category") as DropDownList;
        //HiddenField hf = e.Item.FindControl("hf_CategoryValue") as HiddenField;

        //if (ddcat != null)
        //{
        //    ddcat.SelectedIndex = 6;
        //    Response.Write("hello aowifjaowefimawoefimawoefimawoefimawioefm");
        //}
    }

    protected void gDoc_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridItem)
        {
            DropDownList ddcat = e.Item.FindControl("DD_category") as DropDownList;
            HiddenField hfcat = e.Item.FindControl("hf_CategoryValue") as HiddenField;

            if (ddcat != null && hfcat != null)
            {
                ddcat.DataBind();
                ddcat.SelectedIndex = ddcat.Items.IndexOf(ddcat.Items.FindByValue(hfcat.Value));
            }
        }

        try
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem gridDataItem = e.Item as GridDataItem;
                StringBuilder stb = new StringBuilder();

                HyperLink hp = e.Item.FindControl("HyperLink1") as HyperLink;

                if(hp != null)
                    hp.NavigateUrl = "../renderfile.aspx?intid=" + gridDataItem["key_doc_file_storage_id"].Text;              
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void gDoc_ItemCommand(object source, GridCommandEventArgs e)
    {
        DropDownList ddcat = e.Item.FindControl("DD_category") as DropDownList;
        HiddenField hfcat = e.Item.FindControl("hf_CategoryValue") as HiddenField;

        if (ddcat != null && hfcat != null)
        {
            hfcat.Value = ddcat.SelectedValue;
        }
    }
}
